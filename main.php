if(isset($_POST['delete'])) {
    foreach($_POST['ids'] as $k=>$v) {
        $_POST['ids'] [$k] = (int)$v;
    }

    $ids = implode(',',$_POST['ids']);
   q("
		DELETE FROM `goods`
		WHERE `id` IN (".$ids.")
	");
    $_SESSION['info'] = 'Новости была удалена';
    header("Location: /modules/goods");
    exit();
}

if(isset($_GET['key1']) && $_GET['key1'] == 'delete'){
    q("
		DELETE FROM `goods`
		WHERE `id` = ".(int)$_GET['key2']."
	");
    $_SESSION['info'] = 'Новость была удалена';
    header("Location: /modules/goods");
    exit();
}

if(isset($_POST['model'])){
    $goods = q("
		SELECT *
		FROM `goods`
		WHERE `cat` = '".$_POST['model']."'
		ORDER BY `id` DESC
    ");
}else{
    $goods = q("
		SELECT *
		FROM `goods`
		ORDER BY `id` DESC
    ");
}

if (isset($_SESSION['info'])) {
    $info = $_SESSION['info'];
    unset($_SESSION['info']);
}
