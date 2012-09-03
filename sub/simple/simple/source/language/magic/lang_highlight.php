<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: lang_highlight.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'highlight_name' => '变色卡',
	'highlight_desc' => '可以将课件或日志的标题高亮，变更颜色',
	'highlight_expiration' => '高亮有效期',
	'highlight_expiration_comment' => '设置标题可以被高亮多长时间，默认 24 小时。作用于日志时无有效期。',
	'highlight_forum' => '允许使用本道具的课程',
	'highlight_info_tid' => '高亮课件的标题 {expiration} 小时',
	'highlight_info_blogid' => '可以将日志或课件的标题高亮，变更颜色',
	'highlight_color' => '颜色',
	'highlight_info_nonexistence_tid' => '请指定要高亮的课件',
	'highlight_info_nonexistence_blogid' => '请指定要高亮的日志',
	'highlight_succeed_tid' => '您操作的课件已高亮',
	'highlight_succeed_blogid' => '您操作的日志已高亮',
	'highlight_info_noperm' => '对不起，课件所在课程不允许使用本道具',
	'highlight_info_notype' => '参数错误，没有指定操作类型。',

	'highlight_notification' => '您的课件 {subject} 被 {actor} 使用了{magicname}，<a href="forum.php?mod=viewthread&tid={tid}">快去看看吧！</a>',
	'highlight_notification_blogid' => '您的日志 {subject} 被 {actor} 使用了{magicname}，<a href="home.php?mod=space&do=blog&id={blogid}">快去看看吧！</a>',
);

?>