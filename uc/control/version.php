<?php

/*
	[Kejian.TV UserCenter] (C)2012 P.S.V.R
	This code won't be disclosed to anyone.

	$Id: user.php 753 2008-11-14 06:48:25Z cnteacher $
*/

!defined('IN_UC') && exit('Access Denied');

class versioncontrol extends base {

	function __construct() {
		$this->versioncontrol();
	}

	function versioncontrol() {
		parent::__construct();
		$this->load('version');
	}

	function oncheck() {
		$db_version = $_ENV['version']->check();
		$return = array('file' => UC_SERVER_VERSION, 'db' => $db_version);
		return $return;
	}

}

?>