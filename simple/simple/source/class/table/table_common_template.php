<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: table_common_template.php 27745 2012-02-14 01:43:38Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class table_common_template extends discuz_table
{
	public function __construct() {

		$this->_table = 'common_template';
		$this->_pk    = 'templateid';

		parent::__construct();
	}

	public function fetch_all_data() {
		return DB::fetch_all('SELECT * FROM %t', array($this->_table));
	}

	public function delete($val) {
		if(!$val) {
			return;
		}
		DB::query("DELETE FROM %t WHERE %i AND templateid<>1", array($this->_table, DB::field('templateid', $val)));
	}

	public function get_templateid($name) {
		return DB::result_first("SELECT templateid FROM %t WHERE name=%s", array($this->_table, $name));
	}

}

?>