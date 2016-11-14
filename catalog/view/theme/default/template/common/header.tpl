<?php if (isset($_SERVER['HTTP_USER_AGENT']) && !strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6')) echo '<?xml version="1.0" encoding="UTF-8"?>'. "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css" />
<link href="catalog/view/theme/default/stylesheet/cloud-zoom.css" rel="stylesheet" type="text/css" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<script type="text/JavaScript" src="catalog/view/javascript/cloud-zoom.1.0.2.min.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
<script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
<script type="text/javascript">
DD_belatedPNG.fix('#logo img');
</script>
<![endif]-->
<?php echo $google_analytics; ?>
</head>
 	
<body style="background-image: url(<?php echo $background; ?>)" >




<div id="floating_banner_left" style="text-align:right; position:fixed; overflow:hidden; top: 0px; left: 0px; width: 120px; border: 0px solid #000; background-position: top center;
  background-repeat: repeat-y;
  background-attachment: fixed;">

<a href="http://hondabac.com/3844-quy-trinh-lam-ho-so-du-hoc.html" target="_blank" style="height:100%; "><img src="image/ad.png" border="0" width="120px" alt="" style="position:top center; " /></a><br />

</div>

<div id="floating_banner_right" style="text-align:left; position:fixed; overflow:hidden; top: 0px; right: 0px; width: 120px; border: 0px solid #000; background-position: top center;
  background-repeat: repeat-y;
  background-attachment: fixed;">

<a href="http://hondabac.com/thong-tin/ho-tro-du-hoc-sinh/3969-huong-dan-xin-hoan-tien-nenkin.html" target="_blank"><img src="image/ad.png" border="0" width="120px" alt="" /></a><br />

</div>














<div id="container">
<div style="height:25px;background-color:#464646;"></div>

<div id="header">
  <?php if ($logo) { ?>
  <div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
  <?php } ?>
  <?php echo $language; ?>
  <?php echo $currency; ?>
  <?php echo $cart; ?>
  
  <div id="welcome">
    <?php if (!$logged) { ?>
    <?php echo $text_welcome; ?>
    <?php } else { ?>
    <?php echo $text_logged; ?>
    <?php } ?>
  </div>
  <div class="links"><a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a><a href="http://demo.hondabac.com/index.php?route=information/contact"><?php echo $text_contact; ?></a></div>
</div>
<div id="menu">
  <ul>
  <?php if($home_active == 1){ ?>
   <li class="active"><a href="/"><?php echo $text_home; ?></a></li>
   <?php } else { ?>
  <li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
  <?php } ?>
  <?php if($informations){ ?>
  <?php foreach ($informations as $information) { ?>
  	<?php if($information['id'] == $information_id){?>
  	  <li><a class="active" href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
  	<?php }else{?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
    <?php } ?>
  <?php } ?>
  <?php } ?>
 <!--  <li><a href="index.php?route=product/new"><?php echo $text_product;?></a></li> -->
	
  <?php if ($categories) { ?>
    <?php foreach ($categories as $category) { ?>
	<?php if($category['category_id'] == $category_id){ ?>
     <li><a class="active" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
	<?php }else{ ?>
	 <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
	<?php } ?> 
      <?php if ($category['children']) { ?>
      <div>
        <?php for ($i = 0; $i < count($category['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($category['children'][$i])) { ?>
          <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
      <?php } ?>
    </li>
    <?php } ?>
	<?php } ?>
	
	<?php if ($categoriesnews) { ?>
    <?php foreach ($categoriesnews as $cat) { ?>
	 <?php if($cat['cat_id'] == $cat_id){ ?>
		<li><a class="active" href="<?php echo $cat['href']; ?>"><?php echo $cat['name']; ?></a>
	 <?php }else{ ?>
	 	<li><a href="<?php echo $cat['href']; ?>"><?php echo $cat['name']; ?></a>
	<?php } ?>	
      <?php if ($cat['children']) { ?>
      <div>
        <?php for ($i = 0; $i < count($cat['children']);) { ?>
        <ul>
          <?php $j = $i + ceil(count($cat['children']) / $cat['column']); ?>
          <?php for (; $i < $j; $i++) { ?>
          <?php if (isset($cat['children'][$i])) { ?>
          <li><a href="<?php echo $cat['children'][$i]['href']; ?>"><?php echo $cat['children'][$i]['name']; ?></a></li>
          <?php } ?>
          <?php } ?>
        </ul>
        <?php } ?>
      </div>
      <?php } ?>
    </li>
    <?php } ?>
	<?php } ?>
	

  </ul>
  <br />
 <ul style="
   background-color: #e9fdd3;
    border-bottom: 1px solid #D2D2D2;
    border-bottom-left-radius: 3px;
    border-left: 1px solid #D2D2D2;
	 border-bottom-right-radius: 3px;
    border-right: 1px solid #D2D2D2;
    height: 30px;
	position:relative;
	z-index:0;
	left:-2px;
    list-style: none outside none;
    overflow: hidden;
    width: 99.9%;">
	
	<li style="text-align:center; padding-left:20px; width:100%" >
	
	<p align="center" style="text-align:center; overflow:hidden; height:27px;">
	<img src="http://hondabac.com/catalog/view/theme/default/image/icon_tuvan.png" align="middle"  style="float:left"   />
	<a href="ymsgr:sendim?hoanghuyts" height="27px" style="float:right"><img src="http://hondabac.com/catalog/view/theme/default/image/yahoanhuy.png" align="middle"/></a>
	<a href="ymsgr:sendim?hoangduy0101" height="27px" style="float:right"><img src="http://hondabac.com/catalog/view/theme/default/image/yahoanduy.png" align="middle" /></a>
	<script type="text/javascript" src="http://download.skype.com/share/skypebuttons/js/skypeCheck.js"></script>
<a href="skype:hoangduy0101?call" height="27px" style="float:right"><img src="http://hondabac.com/catalog/view/theme/default/image/skyduy.png" align="middle"/></a>
	</p>
	<p></p>
	</li>
	
  </ul>
</div>
 <div style="height: 42px;">

  </div>
<div id="notification"></div>
