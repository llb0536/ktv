<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_announcements_forum.php 26271 2011-12-07 09:15:53Z chenmengshu $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_announcements_forum() {
	$data = array();

	$data = C::t('forum_announcement')->fetch_by_displayorder(TIMESTAMP);
	if($data) {
		$memberdata = C::t('common_member')->fetch_uid_by_username($data['author']);
		$data['authorid'] = $memberdata['uid'];
		$data['authorid'] = intval($data['authorid']);
		if(empty($data['type'])) {
			unset($data['message']);
		}
	} else {
		$data = array();
	}
	savecache('announcements_forum', $data);
}

?>