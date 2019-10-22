<?php if(isset($info)){?>
    <h1><?php echo $info;?></h1>
<?php } ?>
<?php
if(idate("m")== 1 && idate("d")==1){echo 'С новым годом';}
?>
<div class="col-1 clearfix line-botoom">
	<?php if (isset($_SESSION['users'],$_SESSION['users']['access'])&& $_SESSION['users']['access'] == 5){?>
		<form action="" method="post">
			<div class="col-1-1">
				<a href="/books/add">Добавить новую новость</a><br>
				<a href="/books/add_author">Добавить нового автора</a>
    		</div>
		</form>
	<?php }?>
</div>
<div class="col-1 clearfix">
</div>
<form action="" method="post">
	<div class="clearfix col-1">
		<?php if (isset($_SESSION['users'],$_SESSION['users']['access'])&& $_SESSION['users']['access'] == 5){?><input type="submit" name="delete" value="Удалить отмеченные записи"><?php } ?>
	</div>
	<div class="clearfix line-botoom col-3">
		<?php while($row = $books -> fetch_assoc()) {?>
			<div class="col-3-1 goods">
				<?php if (isset($_SESSION['users'],$_SESSION['users']['access'])&& $_SESSION['users']['access'] == 5){?>
					<a href="/books/edit/<?php echo $row['id'];?>" class="size14">Отредактировать</a><br>
				<?php }?>
				<div class="phone_img"><img  <?php echo 'src="'.hc($row['photo']).'"';?> alt="id"></div>
				<a href="/books/main/art/<?php echo $row['id'];?>" class="size14"><?php echo hc($row['title']);?></a><br>
				<?php
				if(isset($_GET['key1']) && $_GET['key1'] == 'art'){
					echo 'Авторы: <br>';
					while($auth11 = $auth_found ->fetch_assoc()) { ?>
						<a href="/books/main/aut/<?php echo hc($auth11['name']);?>/1" class="size14"><?php echo hc($auth11['name']);?></a><br>
					<?php } ?>
				<div class="size12"><?php echo 'Описание: <br>'.nl2br(hc($row['text']));?></div>
				<div class="size16">Цена: <?php echo (int)$row['price'];?></div>
				<a href="#" class="size12">Купить</a><br>
				<?php
				}else{ ?>
					<div class="size12"><?php echo 'Описание: <br>'.nl2br(hc($row['text']));?></div>
				<?php }
				 if (isset($_SESSION['users'],$_SESSION['users']['access'])&& $_SESSION['users']['access'] == 5){?>
					<a href="/admin/books/main/delete/<?php echo $row['id'];?>" class="size12">Удалить</a>
					<div><input type="checkbox" name="ids[]" value="<?php echo $row['id'];?>"></div>
				<?php }?>
			</div>
		<?php }?>
	</div>
</form>
<div>
	<?php
	if(isset($_GET['key2']) && is_numeric($_GET['key1'])){
		$x_choose = $_GET['key2'];
	}elseif(isset($_GET['key1']) && is_numeric($_GET['key1']) && !isset($_GET['key2'])){
		$x_choose = $_GET['key1'];
	}elseif(isset($_GET['key3']) && is_numeric($_GET['key3'])){
		$x_choose = $_GET['key3'];
	}else{
		$x_choose = 1;
	}
	if(!isset($_GET['key1']) || isset($_GET['key1']) && $_GET['key1'] != 'art'){
		if($x_limit > 1 && $x_limit < 8) {
				for($x = 1; $x < $x_limit; ++$x) { ?>
					<a href="/books/main/<?php echo $aut.$x; ?>"><?php echo $x; ?></a>,
				<?php } ?>
				<a href="/books/main/<?php echo $aut.$x_limit; ?>"><?php echo $x_limit; ?></a> <?php
			}elseif($x_limit >= 8){
				$point2 = $x_choose + 2;
				$point1 = $x_choose - 2;
				if($x_choose < 5){
				for($x = 1; $x < $point2; ++$x) { ?>
					<a href="/books/main/<?php echo $aut.$x; ?>"><?php echo $x; ?></a>,
				<?php } ?>
				<a href="/books/main/<?php echo $aut.$point2; ?>"><?php echo $point2; ?></a>...
				<a href="/books/main/<?php echo $aut.$x_limit; ?>"><?php echo $x_limit; ?></a>
				<?php }elseif($x_choose > $x_limit - 4) { ?>
					<a href="/books/main/<?php echo $aut;?>1">1</a>...<?php
					for($x = $point1; $x < $x_limit; ++$x) { ?>
						<a href="/books/main/<?php echo $aut.$x; ?>"><?php echo $x; ?></a>,
					<?php } ?>
					<a href="/books/main/<?php echo $aut.$x_limit; ?>"><?php echo $x_limit; ?></a> <?php
				}elseif($x_choose < $x_limit - 3 && $x_choose >= 5){
					?>
					<a href="/books/main/<?php echo $aut;?>1">1</a>...<?php
					for($x = $point1;	$x < $point2;	++$x) { ?>
						<a href="/books/main/<?php echo $aut.$x; ?>"><?php echo $x; ?></a>,
					<?php }?>
					<a href="/books/main/<?php echo $aut.$point2; ?>"><?php echo $point2; ?></a>...
					<a href="/books/main/<?php echo $aut.$x_limit; ?>"><?php echo $x_limit; ?></a> <?php
				}
		}
	}?>
</div>
