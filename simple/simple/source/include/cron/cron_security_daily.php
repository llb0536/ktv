<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_security_daily.php 29568 2012-04-19 03:39:25Z songlixin $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

C::t('#security#security_failedlog')->optimize();