<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_common_failedlogin.php 30409 2012-05-28 02:53:10Z liulanbo $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_common_failedlogin extends discuz_table
{
	public function __construct() {

		$this->_table = 'common_failedlogin';
		$this->_pk    = '';

		parent::__construct();
	}

	public function fetch_username($ip, $username) {
		return DB::fetch_first("SELECT * FROM %t WHERE ip=%s AND username=%s", array($this->_table, $ip, $username));
	}
	public function fetch_ip($ip) {
		return DB::fetch_first("SELECT * FROM %t WHERE ip=%s", array($this->_table, $ip));
	}

	public function delete_old($time) {
		DB::query("DELETE FROM %t WHERE lastupdate<%d", array($this->_table, TIMESTAMP - intval($time)), 'UNBUFFERED');
	}

	public function update_failed($ip, $username) {
		DB::query("UPDATE %t SET count=count+1, lastupdate=%d WHERE ip=%s", array($this->_table, TIMESTAMP, $ip));
	}

}

?>