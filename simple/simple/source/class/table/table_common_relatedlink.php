<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_common_relatedlink.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_common_relatedlink extends discuz_table
{
	public function __construct() {

		$this->_table = 'common_relatedlink';
		$this->_pk    = 'id';

		parent::__construct();
	}

}

?>