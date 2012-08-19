<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cache_creditrule.php 24850 2011-10-12 11:09:19Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

function build_cache_creditrule() {
	$data = array();

	foreach(C::t('common_credit_rule')->fetch_all_rule() as $rule) {
		$rule['rulenameuni'] = urlencode(diconv($rule['rulename'], CHARSET, 'UTF-8', true));
		$data[$rule['action']] = $rule;
	}

	savecache('creditrule', $data);
}

?>