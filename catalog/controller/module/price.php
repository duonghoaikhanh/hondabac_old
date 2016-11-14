<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerModulePrice extends Controller {
	private $type = 'module';
	private $name = 'price';
	
	protected function index($module = false) {
		$v14x = $this->data['v14x'] = (!defined('VERSION') || VERSION < 1.5);
		$v150 = $this->data['v150'] = (defined('VERSION') && strpos(VERSION, '1.5.0') === 0);
		$v151 = $this->data['v151'] = (defined('VERSION') && strpos(VERSION, '1.5.1') === 0);
		
		$this->language->load($this->type . '/' . $this->name);
		$this->data['heading_title'] = $this->language->get('filterbyprice_heading');
		
		// non-standard
		$this->data['ranges'] = array();
		
		$results = explode(',', str_replace(' ', '', $this->config->get($this->name . '_ranges')));
		if ($results[0] != '' && (int)$results[0] !== 0) {
			array_unshift($results, 0);
		}
		$num_results = (count($results) > 1) ? count($results) : 0;
		
		for ($i = 1; $i <= $num_results; $i++) {
			$lower = (strpos($results[$i-1], '.') === false) ? $results[$i-1] : number_format($results[$i-1], 2, '.', '');
			$upper = (isset($results[$i])) ? (float)$results[$i] : '';
			$upper = (strpos($upper, '.') === false) ? $upper : number_format($upper, 2, '.', '');
			
			if ($i == 1) {
				$text = sprintf($this->language->get('filterbyprice_bottom'), $this->currency->format($upper));
			} elseif ($i == $num_results) {
				$text = sprintf($this->language->get('filterbyprice_top'), $this->currency->format($lower));
			} else {
				$text = sprintf($this->language->get('filterbyprice_middle'), $this->currency->format($lower), $this->currency->format($upper));
			}
			
			$args = '';
			
			if ($this->config->get('price_category_filter') && !empty($this->request->get['path'])) {
				$args .= '&path=' . $this->request->get['path'];
			}
			
			if ($this->config->get('price_manufacturer_filter') && !empty($this->request->get['manufacturer_id'])) {
				$args .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}
			
			if ($this->config->get('price_search_filter')) {
				$search_filters = array(
					'keyword',
					'description',
					'model',
					'category_id',
					'filter_name',
					'filter_tag',
					'filter_description',
					'filter_category_id',
					'filter_sub_category'
				);
				foreach ($search_filters as $filter) {
					if (!empty($this->request->get[$filter])) {
						$args .= '&' . $filter . '=' . $this->request->get[$filter];
					}
				}
			}
			
			$this->data['args'] = $args;
			
			$args .= '&range=' . $lower . '-' . $upper;
			
			$this->data['ranges'][] = array(
				'text'	=> $text,
				'href'	=> $this->makeURL('product/' . $this->name, $args, 'NONSSL', false)
			);
		}
		
		$this->data['text_flexible_middle'] = sprintf($this->language->get('filterbyprice_middle'), '', '');
		if (!empty($this->request->get['range'])) {
			$range = explode('-', $this->request->get['range']);
			$this->data['lower'] = $range[0];
			$this->data['upper'] = (isset($range[1])) ? $range[1] : '';
		} else {
			$this->data['lower'] = '';
			$this->data['upper'] = '';
		}
		$this->data['button_go'] = $this->language->get('filterbyprice_go');
		// end
		
		$this->id = $this->name;
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->type . '/' . $this->name . '.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/' . $this->type . '/' . $this->name . '.tpl';
		} else {
			$this->template = 'default/template/' . $this->type . '/' . $this->name . '.tpl';
		}
		
		$this->render();
	}
	
	public function rewriteURL() {
		echo $this->makeURL($this->request->post['route'], html_entity_decode($this->request->post['args']), 'NONSSL', false);
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL', $rewrite = true) {
		if (!defined('VERSION') || VERSION < 1.5 || !$rewrite) {
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			if ($args) {
				$url .= '&' . ltrim($args, '&'); 
			}
			if ($rewrite) {
				$this->load->model('tool/seo_url');
				return $this->model_tool_seo_url->rewrite($url);
			} else {
				return $url;
			}
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
}
?>