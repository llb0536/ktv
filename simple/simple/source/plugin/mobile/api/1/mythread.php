<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: mythread.php 27451 2012-02-01 05:48:47Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

$_GET['mod'] = 'guide';
$_GET['view'] = 'my';
include_once 'forum.php';

class mobile_api {

	function common() {
	}

	function output() {
		global $_G;
		$variable = array(
			'data' => array_values(mobile_core::getvalues($GLOBALS['data']['my']['threadlist'], array('/^.+?$/'),
				array('tid', 'fid', 'author', 'authorid', 'dbdateline', 'dateline', 'replies', 'dblastpost', 'lastpost', 'lastposter', 'subject', 'attachment', 'views'))),
			'perpage' => $GLOBALS['perpage'],
		);
		mobile_core::result(mobile_core::variable($variable));
	}

}

?>