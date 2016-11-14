  <div id="tabs-<?php echo $module; ?>" class="htabs">
	<?php if($latest_products){ ?>
	<a href="#tab-latest-<?php echo $module; ?>"><?php echo $tab_latest; ?></a>
	<?php } ?>
	<?php if($featured_products){ ?>
	<a href="#tab-featured-<?php echo $module; ?>"><?php echo $tab_featured; ?></a>
	<?php } ?>
	<?php if($bestseller_products){ ?>
	<a href="#tab-bestseller-<?php echo $module; ?>"><?php echo $tab_bestseller; ?></a>
	<?php } ?>
	<?php if($special_products){ ?>
	<a href="#tab-special-<?php echo $module; ?>"><?php echo $tab_special; ?></a>
	<?php } ?>
 </div>
<?php if($latest_products){ ?>
 <div id="tab-latest-<?php echo $module; ?>" class="tab-content">
    <div class="box-product">
      <?php foreach ($latest_products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']!=0) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
		 <?php if ($product['price']!=0) { ?>
		 <?php if ($product['CH'] != 0) { ?>
		  
		  <div><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
		   <?php } else { ?>
		   <div><font color="#666666" style="padding:6px 12px; font-weight:bold"><?php echo $text_endstock; ?></font></div>
		  <?php } ?>
		<?php } else { ?>
		<div><a href="<?php echo $product['href']; ?>" class="button">Chi tiet</a></div>
	
		<?php } ?>
       
      </div>
      <?php } ?>
    </div>
 </div>
<?php } ?>




<?php if($featured_products){ ?>
  <div id="tab-featured-<?php echo $module; ?>" class="tab-content">
    <div class="box-product">
      <?php foreach ($featured_products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
         <?php if ($product['price']!=0) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
		 <?php if ($product['price']!=0) { ?>
		 <?php if ($product['CH'] != 0) { ?>
		  
		  <div><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
		   <?php } else { ?>
		   <div><font color="#666666" style="padding:6px 12px; font-weight:bold"><?php echo $text_endstock; ?></font></div>
		  <?php } ?>
		<?php } else { ?>
		<div><a href="<?php echo $product['href']; ?>" class="button">Chi tiet</a></div>
	
		<?php } ?>
       
		  
	  
      </div>
      <?php } ?>
    </div>
 </div>
<?php } ?>

<?php if($bestseller_products){ ?>
 <div id="tab-bestseller-<?php echo $module; ?>" class="tab-content">
    <div class="box-product">
      <?php foreach ($bestseller_products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']!=0) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
		 <?php if ($product['price']!=0) { ?>
		 <?php if ($product['CH'] != 0) { ?>
		  
		  <div><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
		   <?php } else { ?>
		   <div><font color="#666666" style="padding:6px 12px; font-weight:bold"><?php echo $text_endstock; ?></font></div>
		  <?php } ?>
		<?php } else { ?>
		<div><a href="<?php echo $product['href']; ?>" class="button">Chi tiet</a></div>
	
		<?php } ?>
       
		
        
      </div>
      <?php } ?>
    </div>
 </div>
<?php } ?>

<?php if($special_products){ ?>
 <div id="tab-special-<?php echo $module; ?>" class="tab-content">
    <div class="box-product">
      <?php foreach ($special_products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
       <?php if ($product['price']!=0) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
		 <?php if ($product['price']!=0) { ?>
		 <?php if ($product['CH'] != 0) { ?>
		  
		  <div><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
		   <?php } else { ?>
		   <div><font color="#666666" style="padding:6px 12px; font-weight:bold"><?php echo $text_endstock; ?></font></div>
		  <?php } ?>
		<?php } else { ?>
		<div><a href="<?php echo $product['href']; ?>" class="button">Chi tiet</a></div>
	
		<?php } ?>
       
      </div>
      <?php } ?>
    </div>
 </div>
<?php } ?>

<script type="text/javascript">
$('#tabs-<?php echo $module; ?> a').tabs();
</script> 