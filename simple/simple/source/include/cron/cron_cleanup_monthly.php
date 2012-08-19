<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_cleanup_monthly.php 26922 2011-12-27 10:00:36Z svn_project_zhangjie $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}


C::t('common_mytask')->delete_exceed(2592000);

?>