<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: checkpost.php 27451 2012-02-01 05:48:47Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

$_GET['mod'] = 'forumdisplay';
include_once 'forum.php';

class mobile_api {

	function common() {
		$apifile = 'source/plugin/mobile/api/'.$_GET['version'].'/sub_checkpost.php';
		if(file_exists($apifile)) {
			require_once $apifile;
		}
		mobile_core::result(mobile_core::variable(mobile_api_sub::getvariable()));
	}

	function output() {}

}

?>