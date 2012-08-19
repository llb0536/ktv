<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: portalcp_plugin.php 25246 2011-11-02 03:34:53Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$pluginkey = 'portalcp';
$navtitle = $_G['setting']['plugins'][$pluginkey][$_GET['id']]['name'];

include pluginmodule($_GET['id'], $pluginkey);

include template('portal/portalcp_plugin');

?>