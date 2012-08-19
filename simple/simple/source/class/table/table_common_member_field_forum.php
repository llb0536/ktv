<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_common_member_field_forum.php 28405 2012-02-29 03:47:50Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_common_member_field_forum extends discuz_table_archive
{
	public function __construct() {

		$this->_table = 'common_member_field_forum';
		$this->_pk    = 'uid';
		$this->_pre_cache_key = 'common_member_field_forum_';

		parent::__construct();
	}

}

?>