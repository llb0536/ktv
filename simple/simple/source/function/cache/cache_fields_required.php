<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_fields_required.php 24935 2011-10-17 07:41:48Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_fields_required() {
	$data = array();

	foreach(C::t('common_member_profile_setting')->fetch_all_by_available_required(1, 1) as $field) {
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

	savecache('fields_required', $data);
}

?>