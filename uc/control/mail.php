<?php

/*
	[Kejian.TV UserCenter] (C)2012 P.S.V.R
	This code won't be disclosed to anyone.

	$Id: mail.php 1059 2011-03-01 07:25:09Z monkey $
*/

!defined('IN_UC') && exit('Access Denied');

class mailcontrol extends base {

	function __construct() {
		$this->mailcontrol();
	}

	function mailcontrol() {
		parent::__construct();
		$this->init_input();
	}

	function onadd() {
		$this->load('mail');
		$mail = array();
		$mail['appid']		= $this->app['appid'];
		$mail['uids']		= explode(',', $this->input('uids'));
		$mail['emails']		= explode(',', $this->input('emails'));
		$mail['subject']	= $this->input('subject');
		$mail['message']	= $this->input('message');
		$mail['charset']	= $this->input('charset');
		$mail['htmlon']		= intval($this->input('htmlon'));
		$mail['level']		= abs(intval($this->input('level')));
		$mail['frommail']	= $this->input('frommail');
		$mail['dateline']	= $this->time;
		return $_ENV['mail']->add($mail);
	}

}

?>