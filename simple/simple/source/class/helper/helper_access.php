<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: helper_access.php 28057 2012-02-21 22:19:33Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class helper_access {

	public static function check_module($module) {
		$status = 0;
		$allowfuntype = array('portal', 'group', 'follow', 'collection', 'guide', 'feed', 'blog', 'doing', 'album', 'share', 'wall', 'homepage', 'ranklist');
		$module = in_array($module, $allowfuntype) ? trim($module) : '';
		if(!empty($module)) {
			$status = getglobal('setting/'.$module.'status');
		}
		return $status;
	}
}

?>