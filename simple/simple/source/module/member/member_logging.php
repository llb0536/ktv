<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: member_logging.php 25246 2011-11-02 03:34:53Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

define('NOROBOT', TRUE);

if(!in_array($_GET['action'], array('login', 'logout'))) {
	showmessage('undefined_action');
}

$ctl_obj = new logging_ctl();
$ctl_obj->setting = $_G['setting'];
$method = 'on_'.$_GET['action'];
$ctl_obj->template = 'member/login';
$ctl_obj->$method();

?>