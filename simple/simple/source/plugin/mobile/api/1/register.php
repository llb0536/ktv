<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: register.php 27979 2012-02-20 06:01:40Z monkey $
 */

if(!defined('IN_MOBILE_API')) {
	exit('Access Denied');
}

include_once 'member.php';

class mobile_api {

	function common() {
		global $_G;
		if(empty($_POST['regsubmit'])) {
			$_G['mobile_version'] = intval($_GET['version']);
		}
		require_once libfile('class/member');
		$ctl_obj = new register_ctl();
		$ctl_obj->setting = $_G['setting'];
		$ctl_obj->template = 'mobile:register';
		$ctl_obj->on_register();
		if(empty($_POST['regsubmit'])) {
			exit;
		}
	}

	function output() {
		mobile_core::result(mobile_core::variable());
	}

}

?>