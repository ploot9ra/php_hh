<?php
if(isset($_POST['title'],$_POST['text'],$_POST['price'])) {
	$errors = [];
	if(empty($_POST['title'])) {
		$errors['title'] = 'Укажите название';
	}
	if(empty($_POST['price'])) {
		$errors['price'] = 'Укажите цену';
	}
	if(empty($_POST['ids_auth'])) {
		$errors['ids_books'] = 'Выберите автора';
	}
	if(empty($_POST['text'])) {
		$errors['text'] = 'Заполните описание';
	}
	if(empty($_FILES['photo'])) {
		$errors['text'] = 'Загрузите изображение';
	}
	if($_FILES['photo']['error'] == 0) {
		uploader::upload();
		uploader::resize(250, 250);
		if(!count($errors)) {
			q("
				INSERT INTO `books` SET
				`title`         = '".es($_POST['title'])."',
				`text`        = '".es($_POST['text'])."',
				`price`       = '".(int)$_POST['price']."',
				`photo`    = '".es($_POST['photo'])."'
			");
			$id_author = DB::_() ->insert_id;
			foreach($_POST['ids_auth'] as $k => $v){
				q("
					INSERT INTO `books2books_cat` SET
					`books_id` = '".$id_author."',
					`auth_id`  = '".$v."'
				");
			}
			$_SESSION['info'] = 'Запись была добавлена';
			header('Location: /books');
			exit();
		}
	}else{
		$errors['photo'] = 'Загрузите изображение';
	}
}
$books_cat = q("
	SELECT *
	FROM `books_cat`
	ORDER BY `id` DESC
");
