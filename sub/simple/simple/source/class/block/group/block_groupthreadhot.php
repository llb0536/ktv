<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: block_groupthreadhot.php 23608 2011-07-27 08:10:07Z cnteacher $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

require_once libfile('block_groupthread', 'class/block/group');

class block_groupthreadhot extends block_groupthread {
	function block_groupthreadhot() {
		$this->setting = array(
			'gtids' => array(
				'title' => 'groupthread_gtids',
				'type' => 'mselect',
				'value' => array(
				),
			),
			'special' => array(
				'title' => 'groupthread_special',
				'type' => 'mcheckbox',
				'value' => array(
					array(1, 'groupthread_special_1'),
					array(2, 'groupthread_special_2'),
					array(3, 'groupthread_special_3'),
					array(4, 'groupthread_special_4'),
					array(5, 'groupthread_special_5'),
					array(0, 'groupthread_special_0'),
				)
			),
			'rewardstatus' => array(
				'title' => 'groupthread_special_reward',
				'type' => 'mradio',
				'value' => array(
					array(0, 'groupthread_special_reward_0'),
					array(1, 'groupthread_special_reward_1'),
					array(2, 'groupthread_special_reward_2')
				),
				'default' => 0,
			),
			'picrequired' => array(
				'title' => 'groupthread_picrequired',
				'type' => 'radio',
				'value' => '0'
			),
			'orderby' => array(
				'title' => 'groupthread_orderby',
				'type'=> 'mradio',
				'value' => array(
					array('replies', 'groupthread_orderby_replies'),
					array('views', 'groupthread_orderby_views'),
					array('heats', 'groupthread_orderby_heats'),
					array('recommends', 'groupthread_orderby_recommends'),
				),
				'default' => 'replies'
			),
			'lastpost' => array(
				'title' => 'groupthread_lastpost',
				'type'=> 'mradio',
				'value' => array(
					array('0', 'groupthread_lastpost_nolimit'),
					array('3600', 'groupthread_lastpost_hour'),
					array('86400', 'groupthread_lastpost_day'),
					array('604800', 'groupthread_lastpost_week'),
					array('2592000', 'groupthread_lastpost_month'),
				),
				'default' => '0'
			),
			'gviewperm' => array(
				'title' => 'groupthread_gviewperm',
				'type' => 'mradio',
				'value' => array(
					array('0', 'groupthread_gviewperm_only_member'),
					array('1', 'groupthread_gviewperm_all_member')
				),
				'default' => '1'
			),
			'titlelength' => array(
				'title' => 'groupthread_titlelength',
				'type' => 'text',
				'default' => 40
			),
			'summarylength' => array(
				'title' => 'groupthread_summarylength',
				'type' => 'text',
				'default' => 80
			),
		);
	}

	function name() {
		return lang('blockclass', 'blockclass_groupthread_script_groupthreadhot');
	}
}

?>