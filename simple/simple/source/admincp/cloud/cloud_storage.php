<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cloud_smilies.php 25510 2011-11-14 02:22:26Z yexinhao $
 */
if(!defined('IN_DISCUZ') || !defined('IN_ADMINCP')) {
	exit('Access Denied');
}

cpheader();

$_GET['anchor'] = in_array($_GET['anchor'], array('base')) ? $_GET['anchor'] : 'base';

shownav('navcloud', 'cloud_storage');

showsubmenu('cloud_storage');
showtips('cloud_storage_tips');