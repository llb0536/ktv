<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_forum_threaddisablepos.php 27449 2012-03-01 05:32:35Z liulanbo $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
class table_forum_threaddisablepos extends discuz_table {

	public function __construct() {
		$this->_table = 'forum_threaddisablepos';
		$this->_pk    = 'tid';
		parent::__construct();
	}
	public function truncate() {
		DB::query("TRUNCATE ".DB::table('forum_threaddisablepos'));
	}
}

?>