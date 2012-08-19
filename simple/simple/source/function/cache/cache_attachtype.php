<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_attachtype.php 28372 2012-02-28 08:15:06Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_attachtype() {
	$attachtypes = C::t('forum_attachtype')->fetch_all_data();
	$data = array();
	foreach($attachtypes as $row) {
		$data[$row['fid']][strtolower($row['extension'])] = $row['maxsize'];
	}

	savecache('attachtype', $data);
}

?>