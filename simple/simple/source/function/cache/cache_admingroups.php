<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_admingroups.php 24830 2011-10-12 08:23:34Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_admingroups() {
	foreach(C::t('common_admingroup')->range() as $data) {
		savecache('admingroup_'.$data['admingid'], $data);
	}
}

?>