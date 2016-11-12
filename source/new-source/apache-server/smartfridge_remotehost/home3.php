<?php
session_start();
?>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
<?php echo $_SESSION['Username']; ?>
<a href="login2.php"> login</a>
</body>
</html>
<?php
session_destroy();
?>