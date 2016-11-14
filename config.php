<?php
// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/');
define('HTTP_IMAGE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/image/');
define('HTTP_ADMIN', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/admin/');

// HTTPS
//define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . 'hondabac_old/');
//define('HTTP_IMAGE', 'http://' . $_SERVER['HTTP_HOST'] . 'hondabac_old/image/');

// DIR
define('DIR_APPLICATION', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/catalog/');
define('DIR_SYSTEM', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/system/');
define('DIR_DATABASE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/system/database/');
define('DIR_LANGUAGE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/catalog/language/');
define('DIR_TEMPLATE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/catalog/view/theme/');
define('DIR_CONFIG', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/system/config/');
define('DIR_IMAGE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/image/');
define('DIR_CACHE', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/system/cache/');
define('DIR_DOWNLOAD', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/download/');
define('DIR_LOGS', 'http://' . $_SERVER['HTTP_HOST'] . '/hondabac_old/system/logs/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_DATABASE', 'hondabac_old');
define('DB_PREFIX', 'hdb');
?>