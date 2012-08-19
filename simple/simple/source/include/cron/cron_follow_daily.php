<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: cron_follow_daily.php 25889 2011-11-24 09:52:20Z monkey $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
$removetime = TIMESTAMP - $_G['setting']['followretainday'] * 86400;

foreach(C::t('home_follow_feed')->fetch_all_by_dateline($removetime, '<=') as $feed) {
	C::t('home_follow_feed')->insert_archiver($feed);
	C::t('home_follow_feed')->delete($feed['feedid']);
}

?>