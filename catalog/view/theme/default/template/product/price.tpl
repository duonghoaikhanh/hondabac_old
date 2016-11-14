<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php if ($v14x) { ?>
	
	<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
	<div id="content">
		<div class="top">
			<div class="left"></div>
			<div class="right"></div>
			<div class="center">
				<h1><?php echo $heading_title; ?></h1>
			</div>
		</div>
		<div class="middle">
			<div class="sort">
				<div class="div1">
					<?php echo $text_sort; ?>
					<select name="sort" onchange="location = this.value">
						<?php foreach ($sorts as $sort) { ?>
							<option value="<?php echo str_replace('&', '&amp;', $sort['href']); ?>" <?php if ($filters['sort'].'-'.$filters['order'] == $sort['value']) echo 'selected="selected"'; ?>><?php echo $sort['text']; ?></option>
						<?php } ?>
					</select>
					&nbsp; &nbsp; &nbsp;
					<?php echo $text_limit; ?>
					<select onchange="location = this.value;">
						<?php foreach ($limits as $limit) { ?>
							<option value="<?php echo $limit['href']; ?>" <?php if ($limit['value'] == $filters['limit']) echo 'selected="selected"'; ?>><?php echo $limit['text']; ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
			<table class="list">
			<?php for ($i = 0; $i < sizeof($products); $i = $i + 4) { ?>
				<tr>
				<?php for ($j = $i; $j < ($i + 4); $j++) { ?>
					<td width="25%">
					<?php if (isset($products[$j])) { ?>
						<a href="<?php echo str_replace('&', '&amp;', $products[$j]['href']); ?>"><img src="<?php echo $products[$j]['thumb']; ?>" title="<?php echo $products[$j]['name']; ?>" alt="<?php echo $products[$j]['name']; ?>" /></a><br />
						<a href="<?php echo str_replace('&', '&amp;', $products[$j]['href']); ?>"><?php echo $products[$j]['name']; ?></a><br />
						<span style="color: #999; font-size: 11px;"><?php echo $products[$j]['model']; ?></span><br />
						<?php if ($display_price) { ?>
							<?php if (!$products[$j]['special']) { ?>
								<span style="color: #900; font-weight: bold;"><?php echo $products[$j]['price']; ?></span>
							<?php } else { ?>
								<span style="color: #900; font-weight: bold; text-decoration: line-through;"><?php echo $products[$j]['price']; ?></span> <span style="color: #F00;"><?php echo $products[$j]['special']; ?></span>
							<?php } ?>
							<a class="button_add_small" href="<?php echo $products[$j]['add']; ?>" title="<?php echo $button_add_to_cart; ?>" >&nbsp;</a>
						<?php } ?>
						<br />
						<?php if ($products[$j]['rating']) { ?>
							<img src="catalog/view/theme/default/image/stars_<?php echo $products[$j]['rating'] . '.png'; ?>" alt="<?php echo $products[$j]['stars']; ?>" />
						<?php } ?>
					<?php } ?>
					</td>
				<?php } ?>
				</tr>
			<?php } ?>
			</table>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
		<div class="bottom">
			<div class="left"></div>
			<div class="right"></div>
			<div class="center"></div>
		</div>
	</div>
	<?php echo $footer; ?>
	
<?php } else { ?>

	<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
	<div id="content">
		<?php echo $content_top; ?>
		<div class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
			<?php } ?>
		</div>
		<h1><?php echo $heading_title; ?></h1>
		<?php if ($products) { ?>
			<div class="product-filter">
				<div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
				<div class="limit">
					<?php echo $text_limit; ?>
					<select onchange="location = this.value;">
						<?php foreach ($limits as $limit) { ?>
							<?php if ($limit['value'] == $filters['limit']) { ?>
								<option value="<?php echo $limit['href']; ?>" selected="selected"><?php echo $limit['text']; ?></option>
							<?php } else { ?>
								<option value="<?php echo $limit['href']; ?>"><?php echo $limit['text']; ?></option>
							<?php } ?>
						<?php } ?>
					</select>
				</div>
				<div class="sort">
					<?php echo $text_sort; ?>
					<select onchange="location = this.value;">
						<?php foreach ($sorts as $sort) { ?>
							<?php if ($sort['value'] == $filters['sort'] . '-' . $filters['order']) { ?>
								<option value="<?php echo $sort['href']; ?>" selected="selected"><?php echo $sort['text']; ?></option>
							<?php } else { ?>
								<option value="<?php echo $sort['href']; ?>"><?php echo $sort['text']; ?></option>
							<?php } ?>
						<?php } ?>
					</select>
				</div>
			</div>
			<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare_total"><?php echo $text_compare; ?></a></div>
			<div class="product-list">
				<?php foreach ($products as $product) { ?>
					<div>
						<?php if ($product['thumb']) { ?>
							<div class="image">
								<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
							</div>
						<?php } ?>
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
						<div class="description"><?php echo $product['description']; ?></div>
						<?php if ($product['price']) { ?>
							<div class="price">
								<?php if (!$product['special']) { ?>
									<?php echo $product['price']; ?>
								<?php } else { ?>
									<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
								<?php } ?>
								<?php if ($product['base_price']) { ?>
									<br />
									<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['base_price']; ?></span>
								<?php } ?>
							</div>
						<?php } ?>
						<?php if ($product['rating']) { ?>
							<div class="rating">
								<img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
							</div>
						<?php } ?>
						<div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
						<div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
						<div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
					</div>
				<?php } ?>
			</div>
			<div class="pagination"><?php echo $pagination; ?></div>
		<?php } else { ?>
			<div class="content"><?php echo $text_empty; ?></div>
		<?php }?>
		<?php echo $content_bottom; ?>
	</div>
	
	<script type="text/javascript"><!--
	function display(view) {
		if (view == 'list') {
			$('.product-grid').attr('class', 'product-list');
			
			$('.product-list > div').each(function(index, element) {
				html	= '<div class="right">';
				html += '	<div class="cart">' + $(element).find('.cart').html() + '</div>';
				html += '	<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
				html += '	<div class="compare">' + $(element).find('.compare').html() + '</div>';
				html += '</div>';			
				
				html += '<div class="left">';
				
				var image = $(element).find('.image').html();
				
				if (image != null) { 
					html += '<div class="image">' + image + '</div>';
				}
				
				var price = $(element).find('.price').html();
				
				if (price != null) {
					html += '<div class="price">' + price	+ '</div>';
				}
				
				html += '	<div class="name">' + $(element).find('.name').html() + '</div>';
				html += '	<div class="description">' + $(element).find('.description').html() + '</div>';
				
				var rating = $(element).find('.rating').html();
				
				if (rating != null) {
					html += '<div class="rating">' + rating + '</div>';
				}
					
				html += '</div>';
				
				
				$(element).html(html);
			});		
			
			$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
			
			$.cookie('display', 'list'); 
		} else {
			$('.product-list').attr('class', 'product-grid');
			
			$('.product-grid > div').each(function(index, element) {
				html = '';
				
				var image = $(element).find('.image').html();
				
				if (image != null) {
					html += '<div class="image">' + image + '</div>';
				}
				
				html += '<div class="name">' + $(element).find('.name').html() + '</div>';
				html += '<div class="description">' + $(element).find('.description').html() + '</div>';
				
				var price = $(element).find('.price').html();
				
				if (price != null) {
					html += '<div class="price">' + price	+ '</div>';
				}
				
				var rating = $(element).find('.rating').html();
				
				if (rating != null) {
					html += '<div class="rating">' + rating + '</div>';
				}
				
				html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
				html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
				html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';
				
				$(element).html(html);
			});	
			
			$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
			
			$.cookie('display', 'grid');
		}
	}
	
	view = $.cookie('display');
	
	if (view) {
		display(view);
	} else {
		display('list');
	}
	//--></script>
	
	<?php echo $footer; ?>

<?php } ?>