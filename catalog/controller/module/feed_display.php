<?php  
class ControllerModuleFeedDisplay extends Controller {
	protected function index($setting) {
		static $module = 0;

		$style = 'catalog/view/theme/' .$this->config->get('config_template') . '/stylesheet/feed_display.css';
		$this->document->addstyle($style);
		$this->load->language('module/feed_display');
		$this->data['heading_title'] = $this->language->get('heading_title');
	   
		$this->data['feed_url'] = $setting['feed_url'];
		$this->data['items'] = $setting['items'];
		if ($this->data['items'] == '') {$this->data['items'] = '5';}
	
	    $url = 'http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&num='. $this->data['items']. '&q='.$this->data['feed_url'];
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
		$response = curl_exec($ch);
		$json = json_decode($response, true);
		$this->data['json'] = $json['responseData'];

		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/feed_display.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/feed_display.tpl';
		} else {
			$this->template = 'default/template/module/feed_display.tpl';
		}
		
		$this->render();
	}
}
?>