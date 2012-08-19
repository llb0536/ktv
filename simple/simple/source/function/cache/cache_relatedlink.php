<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_relatedlink.php 24479 2011-09-21 06:40:33Z liulanbo $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_relatedlink() {
	global $_G;

	$data = array();
	$query = C::t('common_relatedlink')->range();
	foreach($query as $link) {
		if(substr($link['url'], 0, 7) != 'http://') {
			$link['url'] = 'http://'.$link['url'];
		}
		$data[] = $link;
	}
	savecache('relatedlink', $data);
}

?>