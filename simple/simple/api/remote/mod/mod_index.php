<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: mod_index.php 21878 2011-04-14 09:23:58Z cnteacher $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class mod_index extends remote_service {

	var $config;
	function mod_index() {
		parent::remote_service();
	}

	function run() {
		$this->success('Kejian.TV Remote Service API '.$this->version);
	}
}