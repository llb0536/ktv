<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: lang_close.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'close_name' => '沉默卡',
	'close_desc' => '可以将课件关闭，禁止评论',
	'close_expiration' => '关闭有效期',
	'close_expiration_comment' => '设置课件可以被关闭多长时间，默认 24 小时',
	'close_forum' => '允许使用本道具的版块',
	'close_info' => '关闭指定的课件 {expiration} 小时，请输入课件的 ID',
	'close_info_nonexistence' => '请指定要关闭的课件',
	'close_succeed' => '您操作的课件已关闭',
	'close_info_noperm' => '对不起，课件所在版块不允许使用本道具',
	'close_info_user_noperm' => '对不起，您不能对此人使用本道具',

	'close_notification' => '您的课件 {subject} 被 {actor} 使用了{magicname}，<a href="forum.php?mod=viewthread&tid={tid}">快去看看吧！</a>',
);

?>