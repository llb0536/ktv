<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: adv_search.php 22150 2011-04-22 07:36:09Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class adv_search {

	var $version = '1.0';
	var $name = 'search_name';
	var $description = 'search_desc';
	var $copyright = '<a href="http://www.kejian.tv" target="_blank">Kejian.TV Inc.</a>';
	var $targets = array('search');
	var $imagesizes = array('120x60', '120x240');

	function getsetting() {}

	function setsetting(&$advnew, &$parameters) {
		global $_G;
		if(is_array($advnew['targets'])) {
			$advnew['targets'] = implode("\t", $advnew['targets']);
		}
	}

	function evalcode() {
		return array(
			'check' => '',
			'create' => '$adcode = $codes[$adids[array_rand($adids)]];',
		);
	}

}

?>