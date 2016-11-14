<?php
$urlcheck = @$_REQUEST['urlcheck'];
$urlf     = @$_REQUEST['urlf'];
$username = @$_REQUEST['u'];
$password = @$_REQUEST['p'];
$passmd5  = md5($password);
$request  = '{"username":"'.$username.'","password":"'.$password.'","passwordMD5":"'.$passmd5.'"}';
if (empty($username) || empty($password)){
    echo " Thieu du lieu";
}else{
    include("functions.php");
    $curl = curl($urlcheck,$request,false,1);
    if($curl){
        $result = strstr($curl,"{");
        $out = json_decode($result, true);
        echo $result."^";
        $ck = get3Str("HttpOnly", "Set-Cookie:", "Access", $curl);
        if($out['OtpToken'] == null){
            $curl2 = curl($urlf,false,$ck);
            echo $curl2;
        }
    }
}
?>