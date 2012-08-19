<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_focus.php 24152 2011-08-26 10:04:08Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_focus() {
	$data = array();

	$focus = C::t('common_setting')->fetch('focus', true);
	$data['title'] = $focus['title'];
	$data['cookie'] = intval($focus['cookie']);
	$data['data'] = array();
	if(is_array($focus['data'])) foreach($focus['data'] as $k => $v) {
		if($v['available']) {
			$data['data'][$k] = $v;
		}
	}

	savecache('focus', $data);
}

?>