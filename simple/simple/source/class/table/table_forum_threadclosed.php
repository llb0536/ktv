<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_threadclosed.php 27449 2012-02-15 05:32:35Z liulanbo $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
class table_forum_threadclosed extends discuz_table {

	public function __construct() {
		$this->_table = 'forum_threadclosed';
		$this->_pk    = 'tid';
		parent::__construct();
	}
}

?>