<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_common_connect_guest.php 29265 2012-03-31 06:03:26Z yexinhao $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_common_connect_guest extends discuz_table {

	public function __construct() {
		$this->_table = 'common_connect_guest';
		$this->_pk = 'conopenid';

		parent::__construct();
	}

}