<div style="padding-top:20px; padding-bottom:20px;">
	<form action="" method="post" enctype="multipart/form-data">
		<div>
			Название книги: <input type="text" name="title" value ="<?php if(isset($_POST['title'])){echo htmlspecialchars($_POST['title']);}?>">
		</div>
        <div class="red"><?php if(isset($errors['title'])){echo $errors['title'];}?></div>
		<div>
			<p>Авторы</p>
			<?php
			while ($row2 = $books_cat->fetch_assoc()){
				if(isset($_POST['add']) && !empty($_POST['ids_books'])){
					foreach($_POST['ids_books'] as $k => $v) {
						if($v == $row2['id']) {
							$check = 'checked';
							break 1;
						}else{
							$check = '';
						}
					}
					echo '<div><label><input type="checkbox" name="ids_books[]" value="'.$row2['id'].'" '.$check.'>'.hc($row2['name']).'</label></div>';
				}else{
					echo '<div><label><input type="checkbox" name="ids_books[]" value="'.$row2['id'].'">'.hc($row2['name']).'</label></div>';
				}
			}
			?>
		</div>

        <div class="red"><?php if(isset($errors['ids_books'])){echo $errors['ids_books'];}?></div>
		<div>
			Фотография книги: <input type="file" name="photo" accept="image/jpg,image/jpeg,image/png,image/gif">
		</div>
		<div class="red"><?php if(isset($errors['photo'])){echo hc($errors['photo']);}?></div>
		<div>
			Описание книги: <br>
			<textarea name="text" ><?php if(isset($_POST['text'])){echo hc($_POST['text']);}?></textarea>
		</div>
        <div class="red"><?php if(isset($errors['text'])){echo $errors['text'];}?></div>
		<div>
			Стоимость книги: <br>
            <input type="text" name="price" value ="<?php if(isset($_POST['price']) || !empty($_POST['price'])){echo (int)$_POST['price'];}?>">
		</div>
        <div class="red"><?php if(isset($errors['price'])){echo $errors['price'];}?></div>
		<p><input type="submit" name="add" value="Добавить товар"></p>
	</form>
</div>
