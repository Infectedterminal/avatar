<?php

$date = date('dMYHis');
$imageData=$_POST['a'];

if (!empty($_POST['a'])) {
error_log("Received" . "\r\n", 3, "Log.log");

}

$filteredData=substr($imageData, strpos($imageData, ","));
$unencodedData=base64_decode($filteredData);
$fp = fopen( 'Avatar'.$date.'.png', 'wb' );
fwrite( $fp, $unencodedData);
fclose( $fp );

exit();
?>