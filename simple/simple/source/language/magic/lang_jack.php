<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: lang_jack.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'jack_name' => '千斤顶',
	'jack_desc' => '可以将课件顶起一段时间，重复使用可延长课件被顶起的时间',
	'jack_expiration' => '时长',
	'jack_expiration_comment' => '设置课件可以被顶起多长时间，默认 1 小时',
	'jack_forum' => '允许使用本道具的版块',
	'jack_info' => '<p class="mtn xw0 mbn">顶起指定的课件<span class="xi1 xw1 xs2"> {expiration} </span> 小时。</p> <p class="mtn xw0 mbn">您现在有<span class="xi1 xw1 xs2"> {magicnum} </span>个千斤顶可以使用。</p>',
	'jack_num' => '本次使用数量:',
	'jack_num_not_enough' => '道具数量不足或没有填写使用数量。',
	'jack_info_nonexistence' => '请指定要顶起的课件',
	'jack_succeed' => '千斤顶成功将课件顶起',
	'jack_info_noperm' => '对不起，课件所在版块不允许使用本道具',

	'jack_notification' => '您的课件 {subject} 被 {actor} 使用了{magicname}，<a href="forum.php?mod=viewthread&tid={tid}">快去看看吧！</a>',
);

?>