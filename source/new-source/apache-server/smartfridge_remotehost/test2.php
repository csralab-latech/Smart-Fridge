<?php require_once('Connections/MyConnection.php'); ?>
<?php
if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

$maxRows_rsTest = 10;
$pageNum_rsTest = 0;
if (isset($_GET['pageNum_rsTest'])) {
  $pageNum_rsTest = $_GET['pageNum_rsTest'];
}
$startRow_rsTest = $pageNum_rsTest * $maxRows_rsTest;

mysql_select_db($database_MyConnection, $MyConnection);
$query_rsTest = "SELECT text FROM table1";
$query_limit_rsTest = sprintf("%s LIMIT %d, %d", $query_rsTest, $startRow_rsTest, $maxRows_rsTest);
$rsTest = mysql_query($query_limit_rsTest, $MyConnection) or die(mysql_error());
$row_rsTest = mysql_fetch_assoc($rsTest);

if (isset($_GET['totalRows_rsTest'])) {
  $totalRows_rsTest = $_GET['totalRows_rsTest'];
} else {
  $all_rsTest = mysql_query($query_rsTest);
  $totalRows_rsTest = mysql_num_rows($all_rsTest);
}
$totalPages_rsTest = ceil($totalRows_rsTest/$maxRows_rsTest)-1;
?>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Untitled Document</title>
</head>

<body>
<h1>Data Pull</h1>	

<p>
  <?php do { ?>
    <?php echo $row_rsTest['text']; ?><br>
<?php } while ($row_rsTest = mysql_fetch_assoc($rsTest)); ?>
</p>
<p>&nbsp;</p>
</body>
</html>
<?php
mysql_free_result($rsTest);
?>
