<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_ipctrl.php 24152 2011-08-26 10:04:08Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_ipctrl() {
	$data = C::t('common_setting')->fetch_all(array('ipregctrl', 'ipverifywhite'));
	savecache('ipctrl', $data);
}

?>