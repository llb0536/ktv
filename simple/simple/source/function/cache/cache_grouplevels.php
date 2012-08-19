<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_grouplevels.php 24623 2011-09-28 06:54:39Z liulanbo $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_grouplevels() {
	$data = array();
	$query = C::t('forum_grouplevel')->range();
	foreach($query as $level) {
		$level['creditspolicy'] = unserialize($level['creditspolicy']);
		$level['postpolicy'] = unserialize($level['postpolicy']);
		$level['specialswitch'] = unserialize($level['specialswitch']);
		$data[$level['levelid']] = $level;
	}

	savecache('grouplevels', $data);
}

?>