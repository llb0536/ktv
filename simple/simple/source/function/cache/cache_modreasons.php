<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_modreasons.php 24152 2011-08-26 10:04:08Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_modreasons() {
	$settings = C::t('common_setting')->fetch_all(array('modreasons', 'userreasons'));
	foreach($settings as $key => $data) {
		$data = str_replace(array("\r\n", "\r"), array("\n", "\n"), $data);
		$data = explode("\n", trim($data));
		savecache($key, $data);
	}
}

?>