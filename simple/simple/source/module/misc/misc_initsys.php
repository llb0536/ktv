<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: misc_initsys.php 27433 2012-01-31 08:16:01Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

if(!($_G['adminid'] == 1 && $_GET['formhash'] == formhash()) && $_G['setting']) {
	exit('Access Denied');
}

require_once libfile('function/cache');
updatecache();

require_once libfile('function/block');
blockclass_cache();

if($_G['config']['output']['tplrefresh']) {
	cleartemplatecache();
}

$plugins = array('qqconnect', 'cloudstat', 'soso_smilies', 'cloudsearch', 'qqgroup', 'security', 'xf_storage', 'mobile');
$opens = array('mobile');

require_once libfile('function/plugin');
require_once libfile('function/admincp');

foreach($plugins as $pluginid) {
	$importfile = DISCUZ_ROOT.'./source/plugin/'.$pluginid.'/discuz_plugin_'.$pluginid.'.xml';
	if(!file_exists($importfile)) {
		continue;
	}
	$importtxt = @implode('', file($importfile));
	$pluginarray = getimportdata('Kejian.TV Plugin', $importtxt);
	$plugin = C::t('common_plugin')->fetch_by_identifier($pluginid);
	if($plugin) {
		$modules = unserialize($plugin['modules']);
		if($modules['system'] > 0) {
			if($pluginarray['plugin']['version'] != $plugin['version']) {
				pluginupgrade($pluginarray, '');
				if($pluginarray['upgradefile']) {
					$plugindir = DISCUZ_ROOT.'./source/plugin/'.$pluginarray['plugin']['directory'];
					if(file_exists($plugindir.'/'.$pluginarray['upgradefile'])) {
						@include_once $plugindir.'/'.$pluginarray['upgradefile'];
					}
				}
			}
			if($modules['system'] != 2) {
				$modules['system'] = 2;
				$modules = serialize($modules);
				C::t('common_plugin')->update($plugin['pluginid'], array('modules' => $modules));
			}
			continue;
		}
		C::t('common_plugin')->delete_by_identifier($pluginid);
	}

	$pluginarray['plugin']['modules'] = unserialize(dstripslashes($pluginarray['plugin']['modules']));
	$pluginarray['plugin']['modules']['system'] = 2;
	$pluginarray['plugin']['modules'] = serialize($pluginarray['plugin']['modules']);
	plugininstall($pluginarray, '', in_array($pluginid, $opens));

	if($pluginarray['installfile']) {
		$plugindir = DISCUZ_ROOT.'./source/plugin/'.$pluginarray['plugin']['directory'];
		if(file_exists($plugindir.'/'.$pluginarray['installfile'])) {
			@include_once $plugindir.'/'.$pluginarray['installfile'];
		}
	}
}

?>