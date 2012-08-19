<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_announcement_daily.php 25786 2011-11-22 06:17:25Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}


$delnum = C::t('forum_announcement')->delete_all_by_endtime($_G['timestamp']);

if($delnum) {
	require_once libfile('function/cache');
	updatecache(array('announcements', 'announcements_forum'));
}

?>