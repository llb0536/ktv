<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_split.php 24152 2011-08-26 10:04:08Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_split() {
	global $_G;
	$splitcaches = array('threadtableids', 'threadtable_info', 'posttable_info', 'posttableids');
	foreach($splitcaches as $splitcache) {
		loadcache($splitcache);
		if(empty($_G['cache'][$splitcache])) {
			savecache($splitcache, '');
		}
	}
}

?>