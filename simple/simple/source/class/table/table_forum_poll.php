<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_poll.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_forum_poll extends discuz_table
{
	public function __construct() {

		$this->_table = 'forum_poll';
		$this->_pk    = 'tid';

		parent::__construct();
	}
	public function update_vote($tid, $num = 1) {
		DB::query('UPDATE %t SET voters=voters+\'%d\' WHERE tid=%d', array($this->_table, $num, $tid), false, true);
	}
	public function delete_by_tid($tids) {
		return DB::delete($this->_table, DB::field('tid', $tids));
	}
}

?>