<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: task_friend.php 6752 2010-03-25 08:47:54Z cnteacher $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class task_friend {

	var $version = '1.0';
	var $name = 'friend_name';
	var $description = 'friend_desc';
	var $copyright = '<a href="http://www.kejian.tv" target="_blank">P.S.V.R</a>';
	var $icon = '';
	var $period = '';
	var $periodtype = 0;
	var $conditions = array();

	function csc($task = array()) {
		global $_G;

		if(getuserprofile('friends') >= 5) {
			return true;
		}
		return array('csc' => 0, 'remaintime' => 0);
	}

	function view() {
		return lang('task/friend', 'friend_view');
	}

}

?>