<?php
Core::$META['title'] = 'Новый параметр';
Core::$CSS[] = '<link href="/css/normalize.css" rel="stylesheet">';

$limit = 2;
$books = q("
	SELECT COUNT(*)
	FROM `books`
	ORDER BY `id`
");
$result = $books->fetch_array();
$x_limit = ceil($result[0]/$limit);
$books->close();
$aut ='';
if(isset($_GET['key1']) && !empty($_GET['key1'])){
	if(is_numeric($_GET['key1'])){
		$limit_start = $_GET['key1']*$limit-$limit;
		$books = q("
		SELECT *
		FROM `books`
		ORDER BY `id`
		LIMIT $limit_start,$limit
	");
	}elseif($_GET['key1'] == 'aut'){
		if(!isset($_GET['key2']) || empty($_GET['key2']) || !isset($_GET['key3']) || empty($_GET['key3']) || !is_numeric($_GET['key3'])){
			header("Location: /books");
			exit();
		}else{
			$aut ='aut/'.$_GET['key2'].'/';
			$auth = q("
				SELECT *
				FROM `books_cat`
				WHERE `name` = '".($_GET['key2'])."'
				ORDER BY `id`
			");
			while($auth_search = $auth -> fetch_assoc()) {
				$_author = q("
					SELECT *
					FROM `books2books_cat`
					WHERE `auth_id` = ".$auth_search['id']."
					ORDER BY `id`
				");
			}
			$books_search = array();
			while($books1 = $_author -> fetch_assoc()){
				array_push($books_search, $books1['books_id']);
			}

			foreach($books_search as $k => $v) {
				$books_search [$k] = $v;
			}
			$id_books = implode(',', $books_search);
			$books = q("
				SELECT COUNT(*)
				FROM `books`
				WHERE `id` IN (".$id_books.")
				ORDER BY `id`
			");
			$result = $books->fetch_array();
			$x_limit = ceil($result[0]/$limit);
			$books->close();
			$limit_start = $_GET['key3']*$limit-$limit;
			$books = q("
				SELECT *
				FROM `books`
				WHERE `id` IN (".$id_books.")
				ORDER BY `id`
				LIMIT $limit_start,$limit
			");
		}
	}elseif($_GET['key1'] == 'art'){
		if(!isset($_GET['key2']) || empty($_GET['key2'])){
			header("Location: /books");
			exit();
		}else{
			$books = q("
				SELECT *
				FROM `books`
				WHERE `id` = '".$_GET['key2']."';
			");
			$auth = q("
				SELECT *
				FROM `books2books_cat`
				WHERE `books_id` = '".$_GET['key2']."';
			");
			$auth_id = array();
			while($auth_search = $auth ->fetch_assoc()) {
				array_push($auth_id, $auth_search['auth_id']);
			}
			foreach($auth_id as $k => $v) {
				$auth_id [$k] = $v;
			}
			$id_auth = implode(',', $auth_id);
			$auth_found = q("
				SELECT *
				FROM `books_cat`
				WHERE `id` IN (".$id_auth.")
				ORDER BY `id`
			");
		}
	}
}else{
	$books = q("
		SELECT *
		FROM `books`
		ORDER BY `id`
		LIMIT 0,$limit
	");
}

if(isset($_SESSION['users']['access']) && $_SESSION['users']['access']== 5) {
	$auth_news = 1;
	if(isset($_POST['delete'])) {
		foreach($_POST['ids'] as $k => $v) {
			$_POST['ids'] [$k] = (int)$v;
		}

		$ids = implode(',', $_POST['ids']);
		q("
			DELETE FROM `books`
			WHERE `id` IN (".$ids.")
		");
		$_SESSION['info'] = 'Новости были удалены';
		header("Location: /books");
		exit();
		// IN = ($ids = 1) OR $ids = 1) OR и т.д.
	}
	if(isset($_GET['key1']) && $_GET['key1'] == 'delete') {
		q("
			DELETE FROM `books`
			WHERE `id` = ".(int)$_GET['key2']."
		");
		$_SESSION['info'] = 'Новость была удалена';
		header("Location: /books");
		exit();
	}
	if(isset($_SESSION['info'])) {
		$info = $_SESSION['info'];
		unset($_SESSION['info']);
	}
}
