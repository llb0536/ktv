<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: index.php 28682 2012-03-08 01:40:01Z monkey $
 */

if(!empty($_SERVER['QUERY_STRING'])) {
	$dir = '../../source/plugin/mobile/';
	chdir($dir);
	if($_SERVER['QUERY_STRING'] == 'check' && is_file('check.php')) {
		require_once 'check.php';
	} elseif(is_file('mobile.php')) {
		require_once 'mobile.php';
	}
}

?>