<?php
//==============================================================================
// Filter by Price Module v151.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ModelCatalogPrice extends Model {
	public function getProducts($filters = array(), $return = '') {
		$range = explode('-', $filters['range']);
		$lower = $range[0];
		$upper = (isset($range[1])) ? $range[1] : '';
		
		$pt_table = (VERSION < 1.5) ? 'product_tags' : 'product_tag';
		
		if ($this->customer->isLogged()) {
			$customer_group_id = $this->customer->getCustomerGroupId();
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$sql = "SELECT *, p.image, pd.name AS name, m.name AS manufacturer,";
		$sql .= " (";
			$sql .= "SELECT price";
			$sql .= " FROM " . DB_PREFIX . "product_discount pd2";
			$sql .= " WHERE pd2.product_id = p.product_id";
			$sql .= " AND pd2.customer_group_id = '" . (int)$customer_group_id . "'";
			$sql .= " AND pd2.quantity = '1'";
			$sql .= " AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))";
			$sql .= " ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1";
		$sql .= ") AS discount,";
		$sql .= " (";
			$sql .= "SELECT price";
			$sql .= " FROM " . DB_PREFIX . "product_special ps";
			$sql .= " WHERE ps.product_id = p.product_id";
			$sql .= " AND ps.customer_group_id = '" . (int)$customer_group_id . "'";
			$sql .= " AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))";
			$sql .= " ORDER BY ps.priority ASC, ps.price ASC LIMIT 1";
		$sql .= ") AS special,";
		
		if ($this->config->get('config_tax')) {
			if (isset($this->session->data['country_id']) && isset($this->session->data['zone_id'])) {
				$country_id = $this->session->data['country_id'];
				$zone_id = $this->session->data['zone_id'];
			} else {
				$country_id = $this->config->get('config_country_id');
				$zone_id = $this->config->get('config_zone_id');
			}
			
			$sql .= " (";
				$sql .= "(";
					$sql .= "SELECT IFNULL(SUM(tr.rate), 0) FROM " . DB_PREFIX . "tax_rate tr";
					$sql .= " LEFT JOIN " . DB_PREFIX . "zone_to_geo_zone z2gz ON (tr.geo_zone_id = z2gz.geo_zone_id)";
					$sql .= " WHERE (z2gz.country_id = '0' OR z2gz.country_id = '" . (int)$country_id . "')";
					$sql .= " AND (z2gz.zone_id = '0' OR z2gz.zone_id = '" . (int)$zone_id . "')";
					$sql .= " AND p.tax_class_id = tr.tax_class_id";
				$sql .= ") / 100 + 1";
			$sql .= ") AS tax_multiplier,";
			
			$tax_multiplier = "IFNULL(tax_multiplier, 1) * ";
		} else {
			$tax_multiplier = "";
		}
		
		if (VERSION >= 1.5) {
			$sql .= " (";
				$sql .= "SELECT points";
				$sql .= " FROM " . DB_PREFIX . "product_reward pr";
				$sql .= " WHERE pr.product_id = p.product_id";
				$sql .= " AND customer_group_id = '" . (int)$customer_group_id . "'";
			$sql .= ") AS reward,";
		}
		
		$sql .= " (";
			$sql .= "SELECT ss.name";
			$sql .= " FROM " . DB_PREFIX . "stock_status ss";
			$sql .= " WHERE ss.stock_status_id = p.stock_status_id";
			$sql .= " AND ss.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql .= ") AS stock_status,";
		$sql .= " (";
			$sql .= "SELECT wcd.unit";
			$sql .= " FROM " . DB_PREFIX . "weight_class_description wcd";
			$sql .= " WHERE p.weight_class_id = wcd.weight_class_id";
			$sql .= " AND wcd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql .= ") AS weight_class,";
		$sql .= " (";
			$sql .= "SELECT lcd.unit";
			$sql .= " FROM " . DB_PREFIX . "length_class_description lcd";
			$sql .= " WHERE p.length_class_id = lcd.length_class_id";
			$sql .= " AND lcd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql .= ") AS length_class,";
		$sql .= " (";
			$sql .= "SELECT AVG(rating) AS total";
			$sql .= " FROM " . DB_PREFIX . "review r1";
			$sql .= " WHERE r1.product_id = p.product_id";
			$sql .= " AND r1.status = '1'";
			$sql .= " GROUP BY r1.product_id";
		$sql .= ") AS rating,";
		$sql .= " (";
			$sql .= "SELECT COUNT(*) AS total";
			$sql .= " FROM " . DB_PREFIX . "review r2";
			$sql .= " WHERE r2.product_id = p.product_id";
			$sql .= " AND r2.status = '1'";
			$sql .= " GROUP BY r2.product_id";
		$sql .= ") AS reviews";
		$sql .= " FROM " . DB_PREFIX . "product p";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "')";
		$sql .= " LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "')";
		$sql .= " LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)";
 		$sql .= " WHERE p.status = '1'";
		$sql .= " AND p.date_available <= NOW()";
		
		if (!empty($filters['manufacturer_id'])) {
			$sql .= " AND p.manufacturer_id = '" . (int)$filters['manufacturer_id'] . "'";
		}
		
		if (!empty($filters['path']) || !empty($filters['category_id']) || !empty($filters['filter_category_id'])) {
			if (!empty($filters['path'])) {
				$paths = explode('_', $filters['path']);
				$category_id = array_pop($paths);
			} elseif (!empty($filters['category_id'])) {
				$category_id = $filters['category_id'];
			} else {
				$category_id = $filters['filter_category_id'];
			}
			
			$sql .= " AND p.product_id IN (SELECT p2c.product_id FROM " . DB_PREFIX . "product_to_category p2c WHERE p2c.category_id = '" . (int)$category_id . "'";
			if ($this->config->get('price_category_filter') == 2 || $filters['filter_sub_category']) {
				$implode_data = array("");
				
				$category_ids = $this->getCategoriesByParentId($category_id);
				foreach ($category_ids as $category_id) {
					$implode_data[] = "p2c.category_id = '" . (int)$category_id . "'";
				}
				
				$sql .= implode(" OR ", $implode_data);			
			}
			$sql .= ")";
		}
		
		if (!empty($filters['keyword']) || !empty($filters['filter_name'])) {
			if (!empty($filters['keyword'])) {
				$keyword = $this->db->escape(mb_strtolower($filters['keyword'], 'UTF-8'));
			} else {
				$keyword = $this->db->escape(mb_strtolower($filters['filter_name'], 'UTF-8'));
			}
			
			$sql .= " AND (";
				$sql .= "LCASE(pd.name) LIKE '%" . $keyword . "%' OR p.product_id IN (";
					$sql .= "SELECT pt.product_id";
					$sql .= " FROM " . DB_PREFIX . $pt_table . " pt";
					$sql .= " WHERE pt.language_id = '" . (int)$this->config->get('config_language_id') . "'";
					$sql .= " AND LCASE(pt.tag) LIKE '%" . $keyword . "%'";
				$sql .= ")";
				if (!empty($filters['description']) || !empty($filters['filter_description'])) {
					$sql .= " OR LCASE(pd.description) LIKE '%" . $keyword . "%'";
				}
				if (!empty($filters['model'])) {
					$sql .= " OR LCASE(p.model) LIKE '%" . $keyword . "%'";
				}
			$sql .= ")";
		}
		
		if (!empty($filters['filter_tag'])) {
			$sql .= " AND p.product_id IN (";
				$sql .= "SELECT pt.product_id";
				$sql .= " FROM " . DB_PREFIX . $pt_table . " pt";
				$sql .= " WHERE pt.language_id = '" . (int)$this->config->get('config_language_id') . "'";
				$sql .= " AND LCASE(pt.tag) LIKE '%" . $this->db->escape(mb_strtolower($filters['filter_tag'], 'UTF-8')) . "%'";
			$sql .= ")";
		}
		
		$sql .= " GROUP BY p.product_id";
		
		$sql .= " HAVING " . $tax_multiplier . "IFNULL(special, p.price) >= " . $lower;
		if (!empty($upper)) {
			$sql .= " AND " . $tax_multiplier . "IFNULL(special, p.price) < " . $upper;
		}
		
		$sort_data = array(
			'price',
			'name',
			'rating',
			'model'
		);
		
		$sql .= " ORDER BY ";
		if ($filters['sort'] == 'name') {
			$sql .= "LCASE(pd.name)";
		} elseif ($filters['sort'] == 'rating') {
			$sql .= "rating";
		} elseif ($filters['sort'] == 'model') {
			$sql .= "LCASE(p.model)";
		} else {
			$sql .= "IFNULL(special, p.price)";	
		}
		
		$sql .= ($filters['order'] == 'DESC') ? " DESC" : " ASC";
		
		if ($return != 'total') {
			$start = ($filters['page'] - 1) * $this->config->get('config_catalog_limit');
			$sql .= " LIMIT " . (int)$start . "," . (int)$filters['limit'];
			
			$query = $this->db->query($sql);
			return $query->rows;
		} else {
			$query = $this->db->query($sql);
			return $query->num_rows;
		}
	}
	
	// Borrowed from 1.5.x for use in earlier versions
	public function getCategoriesByParentId($category_id) {
		$category_data = array();
		
		$category_data[] = $category_id;
		
		$category_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int)$category_id . "'");
		
		foreach ($category_query->rows as $category) {
			$children = $this->getCategoriesByParentId($category['category_id']);
			
			if ($children) {
				$category_data = array_merge($children, $category_data);
			}			
		}
		
		return $category_data;
	}
}
?>