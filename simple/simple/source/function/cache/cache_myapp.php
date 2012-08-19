<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_myapp.php 24946 2011-10-18 02:54:40Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_myapp() {
	$data = array();

	foreach(C::t('common_myapp')->fetch_all_by_flag(-1, '!=') as $myapp) {
		$myapp['icon'] = getmyappiconpath($myapp['appid'], $myapp['iconstatus']);
		$data[$myapp['appid']] = $myapp;
	}

	savecache('myapp', $data);
}

?>