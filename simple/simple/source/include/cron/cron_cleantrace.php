<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_cleantrace.php 24958 2011-10-19 02:54:32Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$maxday = 90;
$deltime = $_G['timestamp'] - $maxday*3600*24;

C::t('home_clickuser')->delete_by_dateline($deltime);

C::t('home_visitor')->delete_by_dateline($deltime);

?>