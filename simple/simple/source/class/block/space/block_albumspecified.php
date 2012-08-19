<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: block_albumspecified.php 23608 2011-07-27 08:10:07Z cnteacher $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

require_once libfile('block_album', 'class/block/space');

class block_albumspecified extends block_album {
	function block_albumspecified() {
		$this->setting = array(
			'catid' => array(
				'title' => 'albumlist_catid',
				'type' => 'mselect',
			),
			'aids'	=> array(
				'title' => 'albumlist_aids',
				'type' => 'text',
				'value' => ''
			),
			'uids'	=> array(
				'title' => 'albumlist_uids',
				'type' => 'text',
				'value' => ''
			),
			'titlelength' => array(
				'title' => 'albumlist_titlelength',
				'type' => 'text',
				'default' => 40
			)
		);
	}

	function name() {
		return lang('blockclass', 'blockclass_album_script_albumspecified');
	}
}

?>