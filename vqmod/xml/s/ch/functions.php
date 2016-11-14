<?php
function get3Str($str1, $str2, $str3, $str) {
	$s = explode($str1, $str);
	if(count($s)<2) return $s[0];
	$s = explode($str2, $s[1]);
	if(count($s)<2) return $s[0];
	$s = explode($str3, $s[1]);
	return $s[0];
}
function curl($url = false, $var = false, $cookie = false, $head = false, $header = false){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    if($var){
        curl_setopt($ch, CURLOPT_POSTFIELDS,$var);
    }
    if($head){
        curl_setopt($ch, CURLOPT_HEADER, true);
    }
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); 
    curl_setopt($ch, CURLOPT_COOKIE, $cookie); 
    curl_setopt($ch, CURLOPT_REFERER, $header);
    @curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);	
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json',
    'charset=utf-8',
    'Content-Length: ' . strlen($var)
    ));
    $result = curl_exec($ch);
    curl_close ($ch);
    return $result;
}
?>