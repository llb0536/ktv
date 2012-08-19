<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: misc_manyou.php 26825 2011-12-23 10:23:54Z svn_project_zhangjie $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
if($_GET['action'] == 'inviteCode') {
	$my_register_url = 'http://api.manyou.com/uchome.php';
	$response = dfsockopen($my_register_url, 0, 'action=inviteCode&app=search');
	showmessage($response, '', array(), array('msgtype' => 3, 'handle' => false));
}