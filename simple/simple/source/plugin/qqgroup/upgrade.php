<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: upgrade.php 29283 2012-03-31 09:35:36Z liudongdong $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$setting = C::t('common_setting')->fetch_all(array('qqgroup_usergroup_feed_list'));

if (!$setting) {

	$usergroups = array(1, 2, 3);

	$updateData = array(
							'qqgroup_usergroup_feed_list' => serialize($usergroups),
						);


	C::t('common_setting')->update_batch($updateData);

}

$finish = true;

?>