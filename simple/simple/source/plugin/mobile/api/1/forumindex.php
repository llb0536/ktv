<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: forumindex.php 27451 2012-02-01 05:48:47Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

$_GET['mod'] = 'index';
include_once 'forum.php';

class mobile_api {

	function common() {
	}

	function output() {
		global $_G;
		$variable = array(
			'member_email' => $_G['member']['email'],
			'member_credits' => $_G['member']['credits'],
			'setting_bbclosed' => $_G['setting']['bbclosed'],
			'group' => mobile_core::getvalues($_G['group'], array('groupid', 'grouptitle', '/^allow.+?$/')),
			'catlist' => array_values(mobile_core::getvalues($GLOBALS['catlist'], array('/^\d+$/'), array('fid', 'name', 'forums'))),
			'forumlist' => array_values(mobile_core::getvalues($GLOBALS['forumlist'], array('/^\d+$/'), array('fid', 'name', 'threads', 'posts', 'redirect', 'todayposts', 'description'))),
		);
		mobile_core::result(mobile_core::variable($variable));
	}

}

?>