<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: mypm.php 27451 2012-02-01 05:48:47Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

$_GET['mod'] = 'space';
$_GET['do'] = 'pm';
include_once 'home.php';

class mobile_api {

	function common() {
	}

	function output() {
		global $_G;
		$variable = array(
			'list' => mobile_core::getvalues($GLOBALS['list'], array('/^\d+$/'), array('plid', 'isnew', 'pmnum', 'lastupdate', 'lastdateline', 'authorid', 'author', 'pmtype', 'subject', 'members', 'dateline', 'touid', 'pmid', 'lastauthorid', 'lastauthor', 'lastsummary', 'msgfromid', 'msgfrom', 'message', 'msgtoid', 'tousername')),
                  'count' => $GLOBALS['count'],
			'perpage' => $GLOBALS['perpage'],
			'page' => intval($GLOBALS['page']),
		);
            if($_GET['subop']) {
                $variable = array_merge($variable, array('pmid' => $GLOBALS['pmid']));
            }
		mobile_core::result(mobile_core::variable($variable));
	}

}

?>