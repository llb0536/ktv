<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: install_plugin.php 26169 2011-12-05 04:15:45Z yexinhao $
 */

define('IN_COMSENZ', TRUE);
define('IN_ADMINCP', TRUE);

chdir('../../');

require_once './source/class/class_core.php';

$discuz = C::app();
$discuz->init_cron = false;
$discuz->init_session = false;
$discuz->init();

if($_GET['key'] !== md5($_G['setting']['authkey'].$_SERVER['REMOTE_ADDR'])) {
	exit;
}

$plugins = array('qqconnect', 'cloudstat', 'soso_smilies', 'cloudsearch', 'qqgroup', 'security', 'xf_storage');

require_once libfile('function/plugin');
require_once libfile('function/admincp');
require_once libfile('function/cache');

foreach($plugins as $pluginid) {
	$importfile = DISCUZ_ROOT.'./source/plugin/'.$pluginid.'/discuz_plugin_'.$pluginid.'.xml';
	$importtxt = @implode('', file($importfile));
	$pluginarray = getimportdata('Kejian.TV Plugin', $importtxt);
	if(plugininstall($pluginarray)) {
		if(!empty($pluginarray['installfile']) && file_exists(DISCUZ_ROOT.'./source/plugin/'.$pluginid.'/'.$pluginarray['installfile'])) {
			@include_once DISCUZ_ROOT.'./source/plugin/'.$pluginid.'/'.$pluginarray['installfile'];
		}
	}
}

?>