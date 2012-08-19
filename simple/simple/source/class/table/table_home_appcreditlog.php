<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_home_appcreditlog.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_home_appcreditlog extends discuz_table
{
	public function __construct() {

		$this->_table = 'home_appcreditlog';
		$this->_pk    = 'logid';

		parent::__construct();
	}

}

?>