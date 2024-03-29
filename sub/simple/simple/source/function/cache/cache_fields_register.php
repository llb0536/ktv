<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: cache_fields_register.php 24935 2011-10-17 07:41:48Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_fields_register() {
	$data = array();

	foreach(C::t('common_member_profile_setting')->fetch_all_by_available_showinregister(1, 1) as $field) {
		$choices = array();
		if($field['selective']) {
			foreach(explode("\n", $field['choices']) as $item) {
				list($index, $choice) = explode('=', $item);
				$choices[trim($index)] = trim($choice);
			}
			$field['choices'] = $choices;
		} else {
			unset($field['choices']);
		}
		$data['field_'.$field['fieldid']] = $field;
	}

	savecache('fields_register', $data);
}

?>