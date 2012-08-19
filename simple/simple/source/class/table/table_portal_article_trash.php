<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_portal_article_trash.php 27836 2012-02-15 08:14:02Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_portal_article_trash extends discuz_table
{
	public function __construct() {

		$this->_table = 'portal_article_trash';
		$this->_pk    = 'aid';

		parent::__construct();
	}

	public function insert_batch($inserts) {
		$sql = array();
		foreach($inserts as $value) {
			if(($value['aid'] = dintval($value['aid']))) {
				$sql[] = "('$value[aid]', '".addslashes($value['content'])."')";
			}
		}
		if($sql) {
			DB::query('INSERT INTO '.DB::table($this->_table)."(`aid`, `content`) VALUES ".implode(', ', $sql));
		}
	}
}

?>