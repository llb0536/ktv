<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: check.php 30858 2012-06-26 10:30:21Z congyushuai $
 */

chdir('../../../');

define('APPTYPEID', 127);
define('CURSCRIPT', 'plugin');

$_GET['mobile'] = 'no';

require './source/class/class_core.php';
require './source/plugin/mobile/mobile.class.php';
if(!defined('DISCUZ_VERSION')) {
    require './source/discuz_version.php';
}

$discuz = C::app();

$discuz->init();

$array = in_array('mobile', $_G['setting']['plugins']['available']) ? array(
	'discuzversion' => DISCUZ_VERSION,
	'charset' => CHARSET,
    'version' => MOBILE_PLUGIN_VERSION,
	'regname' => $_G['setting']['regname'],
	'qqconnect' => in_array('qqconnect', $_G['setting']['plugins']['available']) ? '1' : '0',
	'sitename' => $_G['setting']['bbname'],
	'mysiteid' => $_G['setting']['my_siteid'],
	'ucenterurl' => $_G['setting']['ucenterurl'],
) : array();
mobile_core::result($array);

?>