<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: publicpm.php 27451 2012-02-01 05:48:47Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

$_GET['mod'] = 'space';
$_GET['do'] = 'pm';
$_GET['filter'] = 'announcepm';
include_once 'home.php';

class mobile_api {

	function common() {
	}

	function output() {
		global $_G;
		$variable = array(
			'list' => mobile_core::getvalues($GLOBALS['grouppms'], array('/^\d+$/'), array('id', 'authorid', 'author', 'dateline', 'message')),
			'count' => count($GLOBALS['grouppms']),
			'perpage' => $GLOBALS['perpage'],
                  'page' => $GLOBALS['page'],
		);
		mobile_core::result(mobile_core::variable($variable));
	}

}

?>