<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_connect_tthreadlog.php 29265 2012-03-31 06:03:26Z yexinhao $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_connect_tthreadlog extends discuz_table {

	public function __construct() {
		$this->_table = 'connect_tthreadlog';
		$this->_pk = 'twid';

		parent::__construct();
	}

	public function fetch_max_updatetime_by_tid($tid) {
		return DB::result_first('SELECT updatetime FROM %t WHERE tid=%d ORDER BY updatetime DESC LIMIT 1', array($this->_table, $tid));
	}

	public function fetch_min_nexttime_by_tid($tid) {
		return DB::fetch_first('SELECT * FROM %t WHERE tid=%d ORDER BY nexttime ASC LIMIT 1', array($this->_table, $tid));
	}

}