<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_polloption.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_forum_polloption extends discuz_table
{
	public function __construct() {

		$this->_table = 'forum_polloption';
		$this->_pk    = 'polloptionid';

		parent::__construct();
	}
	public function update_vote($polloptionids, $voterids, $num = 1) {
		DB::query('UPDATE %t SET votes=votes+\'%d\', voterids=CONCAT(voterids,%s) WHERE polloptionid IN (%n)', array($this->_table, $num, $voterids, $polloptionids), false, true);
	}
	public function fetch_all_by_tid($tids, $displayorder = 0, $limit = 0) {
		$sqladd = '';
		if($displayorder) {
			$sqladd = ' ORDER BY displayorder';
		}
		if($limit) {
			$sqladd .= ' LIMIT '.intval($limit);
		}
		return DB::fetch_all('SELECT * FROM %t WHERE '.DB::field('tid', $tids).$sqladd, array($this->_table));
	}
	public function delete_safe_tid($tid, $polloptionid = 0) {
		$sqladd = '';
		if($polloptionid) {
			$sqladd = DB::field('polloptionid', $polloptionid).' AND ';
		}
		DB::query("DELETE FROM %t WHERE $sqladd tid=%d", array($this->_table, $tid));
	}

	public function delete_by_tid($tids) {
		return DB::delete($this->_table, DB::field('tid', $tids));
	}

	public function update_safe_tid($polloptionid, $tid, $displayorder, $polloption = '') {
		if($polloption) {
			$sqladd = ', '.DB::field('polloption', $polloption);
		}
		DB::query('UPDATE %t SET displayorder=%d'.$sqladd.' WHERE polloptionid=%d AND tid=%d', array($this->_table, $displayorder, $polloptionid, $tid));
	}
	public function fetch_count_by_tid($tid) {
		return DB::fetch_first('SELECT MAX(votes) AS max, SUM(votes) AS total FROM %t WHERE tid=%d', array($this->_table, $tid));
	}
}

?>