<?php
require_once("simple_html_dom.php");
require_once("db.class.php");

DB::$user = "root";
DB::$password = "";
DB::$host = "localhost";
DB::$port = 3306;
DB::$dbName = "anokha";

$html = file_get_html('http://www.indiacollegesearch.com/engineering?page=4');

foreach($html->find('#middle_results_form > li') as $collegeHolder) {
	echo $collegeHolder->outertext;
	$colLogo = $collegeHolder->find('div > div.relative.clearfix > img',0);
	$name = "ss";
	$colLocation = $collegeHolder->find('div > div.relative.clearfix > p',0);
	$colLocation = str_ireplace("<span class=\"icon_location\"></span>","",$colLocation);
	$colLocation = str_ireplace(" &nbsp;|&nbsp;","",$colLocation);
	//$colLocation = str_ireplace($colLocation->find('span')->outertext,"",$colLocation);
	echo "$name --- $colLocation";
	echo "\n\n";
}       