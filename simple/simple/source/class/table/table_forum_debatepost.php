<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_debatepost.php 27745 2012-02-14 01:43:38Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_forum_debatepost extends discuz_table
{
	public function __construct() {

		$this->_table = 'forum_debatepost';
		$this->_pk    = 'pid';

		parent::__construct();
	}

	public function update_voters($pid, $uid) {
		DB::query("UPDATE %t SET voters=voters+1, voterids=CONCAT(voterids, '%d\t') WHERE pid=%d", array($this->_table, $uid, $pid));
	}

	public function fetch_all_voters($tid, $number) {
		return DB::fetch_all("SELECT SUM(voters) as voters, stand, uid FROM %t WHERE tid=%d AND stand>'0' GROUP BY uid ORDER BY voters DESC LIMIT %d", array($this->_table, $tid, $number));
	}

	public function get_stand_by_bestuid($tid, $bestuid, $excludeuids) {
		if(!$excludeuids) {
			return;
		}
		return DB::result_first("SELECT stand FROM %t WHERE tid=%d AND uid=%d AND stand>'0' AND %i LIMIT 1", array($this->_table, $tid, $bestuid, DB::field('uid', $excludeuids)));
	}

	public function get_numbers_by_bestuid($tid, $bestuid) {
		$return = DB::fetch_first("SELECT SUM(voters) AS voters, COUNT(*) AS replies FROM %t WHERE tid=%d AND uid=%d", array($this->_table, $tid, $bestuid));
		return array($return['voters'], $return['replies']);
	}

	public function count_by_tid_stand($tid, $stand) {
		return DB::result_first("SELECT COUNT(*) FROM %t WHERE tid=%d AND stand=%d", array($this->_table, $tid, $stand));
	}

	public function get_firststand($tid, $uid) {
		return DB::result_first("SELECT stand FROM %t WHERE tid=%d AND uid=%d AND stand>'0' ORDER BY dateline LIMIT 1", array($this->_table, $tid, $uid));
	}
	public function delete_by_tid($tids) {
		if(!$tids) {
			return;
		}
		return DB::delete($this->_table, DB::field('tid', $tids));
	}

}

?>