<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerProductPrice extends Controller {
	private $type = 'product';
	private $name = 'price';
	private $breadcrumbs = array();
	
	public function index() {
		$v14x = $this->data['v14x'] = (!defined('VERSION') || VERSION < 1.5);
		$v150 = $this->data['v150'] = (defined('VERSION') && strpos(VERSION, '1.5.0') === 0);
		$v151 = $this->data['v151'] = (defined('VERSION') && strpos(VERSION, '1.5.1') === 0);
		
		$this->data = array_merge($this->data, $this->load->language($this->type . '/' . $this->name));
		
		$url = array();
		
		$filters = array(
			'path'					=> '',
			'manufacturer_id'		=> '',
			'keyword'				=> '',
			'description'			=> '',
			'model'					=> '',
			'category_id'			=> '',
			'filter_name'			=> '',
			'filter_tag'			=> '',
			'filter_description'	=> '',
			'filter_category_id'	=> '',
			'filter_sub_category'	=> '',
			'range' 				=> '0-100',
			'sort'					=> 'price',
			'order'					=> 'ASC',
			'limit' 				=> $this->config->get('config_catalog_limit'),
			'page'					=> 1
		);
		
		foreach ($filters as $key => $value) {
			if (isset($this->request->get[$key])) {
				$url[$key] = '&' . $key . '=' . $this->request->get[$key];
				$filters[$key] = $this->request->get[$key];
			} else {
				$url[$key] = '';
			}
		}
		$url['search'] = $url['keyword'] . $url['description'] . $url['model'] . $url['category_id'] . $url['filter_name'] . $url['filter_tag'] . $url['filter_description'] . $url['filter_category_id'] . $url['filter_sub_category'];
		
		$this->breadcrumbs[] = array(
			'href'		=> $this->makeURL('common/home'),
			'text'		=> $this->language->get('text_home'),
			'separator'	=> FALSE
		);
		
		$heading_beg = $this->language->get('heading_products');
		if ($this->config->get('price_category_filter') && !empty($filters['path'])) {
			$this->load->model('catalog/category');
			$path = '';
			
			foreach (explode('_', $filters['path']) as $path_id) {
				if (!$path) {
					$path = $path_id;
				} else {
					$path .= '_' . $path_id;
				}
				
				$category = $this->model_catalog_category->getCategory($path_id);
				
				if ($category) {
					$this->breadcrumbs[] = array(
						'href'		=> $this->makeURL('product/category', 'path=' . $path),
						'text'		=> $category['name'],
						'separator'	=> $this->language->get('text_separator')
					);
				}
			}
			
			$heading_beg = $category['name'];
		}
		
		$heading_end = '';
		if ($this->config->get('price_manufacturer_filter') && !empty($filters['manufacturer_id'])) {
			$this->load->model('catalog/manufacturer');
			$manufacturer = $this->model_catalog_manufacturer->getManufacturer($filters['manufacturer_id']);
			
			if ($manufacturer) {
				if ($v14x) {
					$this->breadcrumbs[] = array(
						'href'		=> HTTP_SERVER . 'index.php?route=product/manufacturer' . $url['manufacturer_id'],
						'text'		=> $manufacturer['name'],
						'separator'	=> $this->language->get('text_separator')
					);
				} else {
					$this->breadcrumbs[] = array(
						'href'		=> $this->url->link('product/manufacturer'),
						'text'		=> $this->language->get('text_brand'),
						'separator'	=> $this->language->get('text_separator')
					);
					$this->breadcrumbs[] = array(
						'href'		=> $this->url->link('product/manufacturer/product', $url['manufacturer_id']),
						'text'		=> $manufacturer['name'],
						'separator'	=> $this->language->get('text_separator')
					);
				}
				$heading_end = $this->language->get('heading_made_by') . ' ' . $manufacturer['name'];
			}
		}
		
		if ($this->config->get('price_search_filter') && !empty($url['search'])) {
			$this->breadcrumbs[] = array(
				'href'		=> $this->makeURL('product/search', $url['search']),
				'text'		=> $this->language->get('button_search'),
				'separator'	=> $this->language->get('text_separator')
			);
		}
		
		$range = explode('-', $filters['range']);
		if (!empty($range[1])) {
			$heading_mid = sprintf($this->language->get('heading_title'), $this->currency->format($range[0]), $this->currency->format($range[1]));
		} else {
			$heading_mid = sprintf($this->language->get('heading_title_alt'), $this->currency->format($range[0]));
		}
		$this->breadcrumbs[] = array(
			'href'		=> $this->makeURL($this->type . '/' . $this->name, $url['path'] . $url['manufacturer_id'] . $url['search'] . $url['range'] . $url['sort'] . $url['order'] . $url['limit'] . $url['page'], 'NONSSL', false),
			'text'      => $heading_mid,
			'separator' => $this->language->get('text_separator')
		);
		
		$heading_title = $heading_beg . ' ' . $heading_mid . ' ' . $heading_end;
		$this->data['heading_title'] = $heading_title;
		
		if ($v14x) {
			$this->document->title = $heading_title;
			$this->document->breadcrumbs = $this->breadcrumbs;
		} else {
			$this->document->setTitle($heading_title);
			$this->data['breadcrumbs'] = $this->breadcrumbs;
		}
		
		$this->load->model('tool/image');
		$this->load->model('catalog/product');
		$this->load->model('catalog/' . $this->name);
		
		$product_total = $this->{'model_catalog_'.$this->name}->getProducts($filters, 'total');
		
		if ($product_total) {
			$this->data['products'] = array();
			
			$results = $this->{'model_catalog_'.$this->name}->getProducts($filters);
			
			foreach ($results as $result) {
				if (!$result['image']) {
					$result['image'] = 'no_image.jpg';
				}
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = FALSE;
				}
				
				if ($this->config->get('config_tax')) {
					$base_price = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$base_price = FALSE;
				}
				
				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = FALSE;
				}	
				
				if (($v14x && $this->config->get('config_review')) || (!$v14x && $this->config->get('config_review_status'))) {
					$rating = (int)$result['rating'];
				} else {
					$rating = FALSE;
				}
				
				$options = $this->model_catalog_product->getProductOptions($result['product_id']);
				if ($options) {
					$add = $this->makeURL('product/product', 'product_id=' . $result['product_id']);
				} else {
					$add = $this->makeURL('checkout/cart', 'product_id=' . $result['product_id']);
				}
				
				$this->data['products'][] = array(
					'add'			=> $add,
					'base_price'	=> $base_price,
					'description'	=> substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '...',
					'href'			=> $this->makeURL('product/product', $url['path'] . $url['manufacturer_id'] . $url['search'] . $url['range'] . '&product_id=' . $result['product_id']),
					'model'			=> $result['model'],
					'name'			=> $result['name'],
					'options'		=> $options,
					'price'			=> $price,
					'product_id'	=> $result['product_id'],
					'rating'		=> $rating,
					'reviews'		=> sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
					'special'		=> $special,
					'stars'			=> sprintf($this->language->get('text_stars'), $rating),
					'thumb'			=> $image
				);
			}
			
			$this->data['sorts'] = array();
			
			$sort_array = array(
				'price',
				'name',
				'rating',
				'model'
			);
			$order_array = array(
				'ASC',
				'DESC'
			);
			
			foreach ($sort_array as $sort) {
				foreach ($order_array as $order) {
					$this->data['sorts'][] = array(
						'text'	=> $this->language->get('text_' . $sort . '_' . $order),
						'value' => $sort . '-' . $order,
						'href'	=> $this->makeURL($this->type . '/' . $this->name, $url['path'] . $url['manufacturer_id'] . $url['search'] . $url['range'] . '&sort=' . $sort . '&order=' . $order . $url['limit'], 'NONSSL', false)
					);
				}
			}
			
			$limits_array = array(
				$this->config->get('config_catalog_limit'),
				$this->config->get('config_catalog_limit') * 2,
				$this->config->get('config_catalog_limit') * 3,
				$this->config->get('config_catalog_limit') * 4,
				$this->config->get('config_catalog_limit') * 5
			);
			
			foreach ($limits_array as $limit) {
				$this->data['limits'][] = array(
					'text'  => $limit,
					'value' => $limit,
					'href'  => $this->makeURL($this->type . '/' . $this->name, $url['path'] . $url['manufacturer_id'] . $url['search'] . $url['range'] . $url['sort'] . $url['order'] . '&limit=' . $limit, 'NONSSL', false)
				);
			}
			
			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $filters['page'];
			$pagination->limit = $filters['limit'];
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->makeURL($this->type . '/' . $this->name, $url['path'] . $url['manufacturer_id'] . $url['search'] . $url['range'] . $url['sort'] . $url['order'] . $url['limit'] . '&page={page}', 'NONSSL', false);
			
			$this->data['pagination'] = $pagination->render();
			
			$this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$this->data['compare'] = $this->makeURL('product/compare');
			$this->data['filters'] = $filters;
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $this->type . '/' . $this->name . '.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/' . $this->type . '/' . $this->name . '.tpl';
			} else {
				$this->template = 'default/template/' . $this->type . '/' . $this->name . '.tpl';
			}
		} else {
			$this->data['text_error'] = $this->language->get('text_empty');
			$this->data['continue'] = $this->makeURL('common/home');
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
		}
		
		if ($v14x) {
			if (!$this->config->get('config_customer_price') || $this->customer->isLogged()) {
				$this->data['display_price'] = TRUE;
			} else {
				$this->data['display_price'] = FALSE;
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/footer',
				'common/header'
			);
			$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
		} else {
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
			$this->response->setOutput($this->render());
		}
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