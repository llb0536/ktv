<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_pollvoter.php 27737 2012-02-13 09:46:21Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_forum_pollvoter extends discuz_table
{
	public function __construct() {

		$this->_table = 'forum_pollvoter';
		$this->_pk    = '';

		parent::__construct();
	}
	public function delete_by_tid($tids) {
		if(!$tids) {
			return;
		}
		return DB::delete($this->_table, DB::field('tid', $tids));
	}

}

?>