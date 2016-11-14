<?php 
	$html = '';
	foreach ($json['feed']['entries'] as $entries){ 
		$html .= '<a href="' .$entries['link']. '"><span class="feeddisplay_title">' .$entries['title']. ' </span></a>';
		if($entries['publishedDate'] != '') {
			$html .='<span class="feeddisplay_date">' .$entries['publishedDate']. '</span>';
		}
		$html .= '<p>' .$entries['contentSnippet']. '</p>';
	}
	?>
<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?>:</div>
  <div class="box-content">
	<div class="feeddisplay"><?php echo $html ?></div>
  </div>
</div>


