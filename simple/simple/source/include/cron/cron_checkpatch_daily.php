<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_checkpatch_daily.php 23672 2011-08-03 06:27:03Z svn_project_zhangjie $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$discuz_patch = new discuz_patch();
$discuz_patch->check_patch();

?>