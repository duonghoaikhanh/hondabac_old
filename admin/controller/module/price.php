<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerModulePrice extends Controller {
	private $error = array(); 
	private $type = 'module';
	private $name = 'price';
	private $breadcrumbs = array();
	private $settings = array(
		'category_filter',
		'manufacturer_filter',
		'search_filter',
		'ranges',
		'flexible_range'
	);
	private $module_settings = array(
		'status',
		'layout_id',
		'position',
		'sort_order'
	);
	
	public function index() {	
		$v14x = $this->data['v14x'] = (!defined('VERSION') || VERSION < 1.5);
		$v150 = $this->data['v150'] = (defined('VERSION') && strpos(VERSION, '1.5.0') === 0);
		$v151 = $this->data['v151'] = (defined('VERSION') && strpos(VERSION, '1.5.1') === 0);
		
		$token = $this->data['token'] = (isset($this->session->data['token'])) ? $this->session->data['token'] : '';
		
		$this->data = array_merge($this->data, $this->load->language($this->type . '/' . $this->name));
		
		if ($v14x) {
			$this->document->title = $this->language->get('heading_title');
		} else {
			$this->document->setTitle($this->language->get('heading_title'));
		}
		
		$this->load->model('setting/setting');
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			$postdata = array();
			if ($v14x || $v150) {
				foreach ($this->request->post as $key => $value) {
					$postdata[$key] = is_array($value) ? serialize($value) : $value;
				}
			} else {
				$postdata = $this->request->post;
			}
			$this->model_setting_setting->editSetting($this->name, $postdata);
			
			$this->session->data['success'] = $this->language->get('text_success');
			if (isset($this->request->get['exit'])) {
				$this->redirect($this->makeURL('extension/' . $this->type, 'token=' . $token, 'SSL'));
			} else {
				$this->redirect($this->makeURL($this->type . '/' . $this->name, 'token=' . $token, 'SSL'));
			}
		}
		
		$this->data['save_exit'] = $this->makeURL($this->type . '/' . $this->name, 'token=' . $token . '&exit=true', 'SSL');
		$this->data['save_keep_editing'] = $this->makeURL($this->type . '/' . $this->name, 'token=' . $token, 'SSL');
		$this->data['cancel'] = $this->makeURL('extension/' . $this->type, 'token=' . $token, 'SSL');
		
		$this->data['error_warning'] = isset($this->error['warning']) ? $this->error['warning'] : '';
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->breadcrumbs[] = array(
			'href'		=> $this->makeURL('common/home', 'token=' . $token, 'SSL'),
			'text'		=> $this->language->get('text_home'),
			'separator' => FALSE
		);
		$this->breadcrumbs[] = array(
			'href'		=> $this->makeURL('extension/' . $this->type, 'token=' . $token, 'SSL'),
			'text'		=> $this->language->get('text_' . $this->type),
			'separator' => ' :: '
		);
		$this->breadcrumbs[] = array(
			'href'		=> $this->makeURL($this->type . '/' . $this->name, 'token=' . $token, 'SSL'),
			'text'		=> $this->language->get('heading_title'),
			'separator' => ' :: '
		);
		
		if ($v14x) {
			$this->document->breadcrumbs = $this->breadcrumbs;
			
			$this->data['positions'] = array();
			$this->data['positions'][] = array(
				'position' => 'left',
				'title'    => $this->language->get('text_left'),
			);
			$this->data['positions'][] = array(
				'position' => 'right',
				'title'    => $this->language->get('text_right'),
			);
			/*
			$this->data['positions'][] = array(
				'position' => 'home',
				'title'    => $this->language->get('text_home'),
			);
			*/
			
			$settings = array_merge($this->settings, $this->module_settings);
		} else {
			$this->data['breadcrumbs'] = $this->breadcrumbs;
			
			$this->load->model('design/layout');
			$this->data['layouts'] = $this->model_design_layout->getLayouts();
			
			if ($v150) {
				if (isset($this->request->post[$this->name . '_module'])) {
					$modules = explode(',', $this->request->post[$this->name . '_module']);
				} elseif ($this->config->get($this->name . '_module') != '') {
					$modules = explode(',', $this->config->get($this->name . '_module'));
				} else {
					$modules = array();
				}
				
				foreach ($modules as $module) {
					foreach ($this->module_settings as $setting) {
						$key = $this->name . '_' . $module . '_' . $setting;
						$this->data[$key] = isset($this->request->post[$key]) ? $this->request->post[$key] : $this->config->get($key);
						if (is_string($this->data[$key]) && strpos($this->data[$key], 'a:') === 0) {
							$this->data[$key] = unserialize($this->data[$key]);
						}
					}
				}
				
				$this->data['modules'] = $modules;
			}
			
			$settings = $this->settings;
			$settings[] = 'module';
		}
		
		foreach ($settings as $setting) {
			$key = $this->name . '_' . $setting;
			$this->data[$key] = isset($this->request->post[$key]) ? $this->request->post[$key] : $this->config->get($key);
			if (is_string($this->data[$key]) && strpos($this->data[$key], 'a:') === 0) {
				$this->data[$key] = unserialize($this->data[$key]);
			}
		}
		
		$this->template = $this->type . '/' . $this->name . '.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		if ($v14x) {
			$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
		} else {
			$this->response->setOutput($this->render());
		}
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL') {
		if (!defined('VERSION') || VERSION < 1.5) {
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			if ($args) {
				$url .= '&' . ltrim($args, '&'); 
			}
			return $url;
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
?>