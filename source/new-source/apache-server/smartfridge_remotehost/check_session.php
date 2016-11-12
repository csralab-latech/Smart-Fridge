<?php

session_start();

$time = time();
//echo $_SESSION['Username'];
if(($time - $_SESSION['session_time'])>600)
{
	
	session_destroy();
	echo "no";
	//header("Location: login2.php");
}
else
	echo "yes";
