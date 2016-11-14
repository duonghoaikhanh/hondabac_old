<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo $header; ?>

<?php if ($v14x) { ?>

	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
		<div class="left"></div>
		<div class="right"></div>
		<div class="heading">
			<h1 style="background-image: url('view/image/module.png');"><?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="$('#form').attr('action', '<?php echo $save_exit; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save_exit; ?></span></a>
				<a onclick="$('#form').attr('action', '<?php echo $save_keep_editing; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save_keep_editing; ?></span></a>
				<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
			</div>
		</div>
		<div class="content">
			<form action="" method="post" enctype="multipart/form-data" id="form">
				<table class="form">
					<tr>
						<td style="width: 300px"><?php echo $entry_status; ?></td>
						<td><select name="price_status">
								<option value="1" <?php if ($price_status) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
								<option value="0" <?php if (!$price_status) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_position; ?></td>
						<td><select name="price_position">
								<?php foreach ($positions as $position) { ?>
									<option value="<?php echo $position['position']; ?>" <?php if ($price_position == $position['position']) echo 'selected="selected"'; ?>><?php echo $position['title']; ?></option>
								<?php } ?>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_sort_order; ?></td>
						<td><input type="text" name="price_sort_order" value="<?php echo $price_sort_order; ?>" size="1" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_filter_categories; ?></td>
						<td><select name="price_category_filter">
								<option value="1" <?php if ($price_category_filter == 1) echo 'selected="selected"'; ?>><?php echo $text_yes_current_category; ?></option>
								<option value="2" <?php if ($price_category_filter == 2) echo 'selected="selected"'; ?>><?php echo $text_yes_category_and_subs; ?></option>
								<option value="0" <?php if (!$price_category_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_filter_manufacturers; ?></td>
						<td><select name="price_manufacturer_filter">
								<option value="1" <?php if ($price_manufacturer_filter) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_manufacturer_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_filter_search; ?></td>
						<td><select name="price_search_filter">
								<option value="1" <?php if ($price_search_filter) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_search_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_price_ranges; ?></td>
						<td><input name="price_ranges" size="30" value="<?php echo $price_ranges; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_include_flexible_filter; ?></td>
						<td><select name="price_flexible_range">
								<option value="1" <?php if ($price_flexible_range) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_flexible_range) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

<?php } else { ?>

	<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="$('#form').attr('action', '<?php echo $save_exit; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save_exit; ?></span></a>
				<a onclick="$('#form').attr('action', '<?php echo $save_keep_editing; ?>'); $('#form').submit();" class="button"><span><?php echo $button_save_keep_editing; ?></span></a>
				<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
			</div>
		</div>
		<div class="content">
			<form action="" method="post" enctype="multipart/form-data" id="form">
				<table class="form">
					<tr>
						<td style="width: 300px"><?php echo $entry_filter_categories; ?></td>
						<td><select name="price_category_filter">
								<option value="1" <?php if ($price_category_filter == 1) echo 'selected="selected"'; ?>><?php echo $text_yes_current_category; ?></option>
								<option value="2" <?php if ($price_category_filter == 2) echo 'selected="selected"'; ?>><?php echo $text_yes_category_and_subs; ?></option>
								<option value="0" <?php if (!$price_category_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_filter_manufacturers; ?></td>
						<td><select name="price_manufacturer_filter">
								<option value="1" <?php if ($price_manufacturer_filter) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_manufacturer_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_filter_search; ?></td>
						<td><select name="price_search_filter">
								<option value="1" <?php if ($price_search_filter) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_search_filter) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_price_ranges; ?></td>
						<td><input name="price_ranges" size="30" value="<?php echo $price_ranges; ?>" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_include_flexible_filter; ?></td>
						<td><select name="price_flexible_range">
								<option value="1" <?php if ($price_flexible_range) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
								<option value="0" <?php if (!$price_flexible_range) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
							</select>
						</td>
					</tr>
				</table>
				<table id="module" class="list">
					<thead>
						<tr>
							<td class="left"><?php echo $entry_status; ?></td>
							<td class="left"><?php echo $entry_layout; ?></td>
							<td class="left"><?php echo $entry_position; ?></td>
							<td class="left"><?php echo $entry_sort_order; ?></td>
							<td></td>
						</tr>
					</thead>
					<?php $module_row = 0; ?>
					
					<?php if ($v150) { ?>
						
						<?php if (!empty($modules)) { ?>
						<?php foreach ($modules as $module) { ?>
							<tbody id="module-row<?php echo $module_row; ?>">
								<tr>
									<td class="left">
										<select name="price_<?php echo $module_row; ?>_status">
											<?php $status = ${'price_' . $module . '_status'}; ?>
											<option value="1" <?php if ($status) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
											<option value="0" <?php if (!$status) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
										</select>
									</td>
									<td class="left">
										<select name="price_<?php echo $module_row; ?>_layout_id">
											<?php $layout_id = ${'price_' . $module . '_layout_id'}; ?>
											<?php foreach ($layouts as $layout) { ?>
												<option value="<?php echo $layout['layout_id']; ?>" <?php if ($layout['layout_id'] == $layout_id) echo 'selected="selected"'; ?>><?php echo $layout['name']; ?></option>
											<?php } ?>
										</select>
									</td>
									<td class="left">
										<select name="price_<?php echo $module_row; ?>_position">
											<?php $position = ${'price_' . $module . '_position'}; ?>
											<option value="content_top" <?php if ($position == 'content_top') echo 'selected="selected"'; ?>><?php echo $text_content_top; ?></option>
											<option value="content_bottom" <?php if ($position == 'content_bottom') echo 'selected="selected"'; ?>><?php echo $text_content_bottom; ?></option>
											<option value="column_left" <?php if ($position == 'column_left') echo 'selected="selected"'; ?>><?php echo $text_column_left; ?></option>
											<option value="column_right" <?php if ($position == 'column_right') echo 'selected="selected"'; ?>><?php echo $text_column_right; ?></option>
										</select>
									</td>
									<td class="left"><input type="text" name="price_<?php echo $module_row; ?>_sort_order" value="<?php echo ${'price_' . $module . '_sort_order'}; ?>" size="1" /></td>
									<td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
								</tr>
							</tbody>
							<?php $module_row++; ?>
						<?php } ?>
						<?php } ?>
						
					<?php } else { ?>
						
						<?php if (!empty($price_module)) { ?>
						<?php foreach ($price_module as $module) { ?>
							<tbody id="module-row<?php echo $module_row; ?>">
								<tr>
									<td class="left">
										<select name="price_module[<?php echo $module_row; ?>][status]">
											<option value="1" <?php if ($module['status']) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
											<option value="0" <?php if (!$module['status']) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
										</select>
									</td>
									<td class="left">
										<select name="price_module[<?php echo $module_row; ?>][layout_id]">
											<?php foreach ($layouts as $layout) { ?>
												<option value="<?php echo $layout['layout_id']; ?>" <?php if ($layout['layout_id'] == $module['layout_id']) echo 'selected="selected"'; ?>><?php echo $layout['name']; ?></option>
											<?php } ?>
										</select>
									</td>
									<td class="left">
										<select name="price_module[<?php echo $module_row; ?>][position]">
											<option value="content_top" <?php if ($module['position'] == 'content_top') echo 'selected="selected"'; ?>><?php echo $text_content_top; ?></option>
											<option value="content_bottom" <?php if ($module['position'] == 'content_bottom') echo 'selected="selected"'; ?>><?php echo $text_content_bottom; ?></option>
											<option value="column_left" <?php if ($module['position'] == 'column_left') echo 'selected="selected"'; ?>><?php echo $text_column_left; ?></option>
											<option value="column_right" <?php if ($module['position'] == 'column_right') echo 'selected="selected"'; ?>><?php echo $text_column_right; ?></option>
										</select>
									</td>
									<td class="left"><input type="text" name="price_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="1" /></td>
									<td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
								</tr>
							</tbody>
							<?php $module_row++; ?>
						<?php } ?>
						<?php } ?>
						
					<?php } ?>
					
					<tfoot>
						<tr>
							<td colspan="4"></td>
							<td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
						</tr>
					</tfoot>
				</table>
				<?php if ($v150) { ?>
					<input type="hidden" id="price_module" name="price_module" value="<?php echo $price_module; ?>" />
				<?php } ?>
			</form>
		</div>
	</div>
	
	<script type="text/javascript"><!--
	var module_row = <?php echo $module_row; ?>;
	
	<?php if ($v150) { ?>
		
		function addModule() {
			html = '<tbody id="module-row' + module_row + '">';
			html += '	<tr>';
			html += '		<td class="left">';
			html += '			<select name="price_' + module_row + '_status">';
			html += '				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
			html += '				<option value="0"><?php echo $text_disabled; ?></option>';
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left">';
			html += '			<select name="price_' + module_row + '_layout_id">';
			<?php foreach ($layouts as $layout) { ?>
			html += '				<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
			<?php } ?>
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left">';
			html += '			<select name="price_' + module_row + '_position">';
			html += '				<option value="content_top"><?php echo $text_content_top; ?></option>';
			html += '				<option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
			html += '				<option value="column_left"><?php echo $text_column_left; ?></option>';
			html += '				<option value="column_right"><?php echo $text_column_right; ?></option>';
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left"><input type="text" name="price_' + module_row + '_sort_order" value="" size="1" /></td>';
			html += '		<td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
			html += '	</tr>';
			html += '</tbody>';
			
			$('#module tfoot').before(html);
			
			module_row++;
		}
		
		$('#form').bind('submit', function() {
			var module = new Array(); 
			$('#module tbody').each(function(index, element) {
				module[index] = $(element).attr('id').substr(10);
			});
			$('#price_module').val(module.join(','));
		});
		
	<?php } else { ?>
	
		function addModule() {
			html = '<tbody id="module-row' + module_row + '">';
			html += '	<tr>';
			html += '		<td class="left">';
			html += '			<select name="price_module[' + module_row + '][status]">';
			html += '				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
			html += '				<option value="0"><?php echo $text_disabled; ?></option>';
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left">';
			html += '			<select name="price_module[' + module_row + '][layout_id]">';
			<?php foreach ($layouts as $layout) { ?>
			html += '				<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
			<?php } ?>
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left">';
			html += '			<select name="price_module[' + module_row + '][position]">';
			html += '				<option value="content_top"><?php echo $text_content_top; ?></option>';
			html += '				<option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
			html += '				<option value="column_left"><?php echo $text_column_left; ?></option>';
			html += '				<option value="column_right"><?php echo $text_column_right; ?></option>';
			html += '			</select>';
			html += '		</td>';
			html += '		<td class="left"><input type="text" name="price_module[' + module_row + '][sort_order]" value="" size="1" /></td>';
			html += '		<td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
			html += '	</tr>';
			html += '</tbody>';
			
			$('#module tfoot').before(html);
			
			module_row++;
		}
		
	<?php } ?>
	
	//--></script>

<?php } ?>

<?php echo $footer; ?>