<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_connect_blacklist.php 24406 2011-09-18 06:53:04Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_connect_blacklist() {
	global $_G;
	$data = array();

	foreach(C::t('common_uin_black')->fetch_all_by_uin() as $blacklist) {
		$data[] = $blacklist['uin'];
	}

	savecache('connect_blacklist', $data);
}

?>