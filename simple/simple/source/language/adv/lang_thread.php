<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: lang_thread.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'thread_name' => '课件系统/群组 课件内广告',
	'thread_desc' => '展现方式: 课件内广告显示于课件内容的上方、下方或右方，课件内容的上方和下方通常使用文字的形式，课件内容右方通常使用图片的形式。当前页面有多个课件内广告时，系统会从中抽取与每页课件数相等的条目进行随机显示。您可以在 全局设置中的其他设置中修改每课件显示的广告数量。<br />价值分析: 由于课件是课件系统最核心的组成部分，嵌入课件内容内部的课件内广告，便可在用户浏览课件内容时自然的被接受，加上随机播放的特性，适合于特定内容的有效推广，也可用于课件系统自身的宣传和公告之用。建议设置多条课件内广告以实现广告内容的差异化，从而吸引更多访问者的注意力。',
	'thread_fids' => '投放版块',
	'thread_fids_comment' => '设置广告投放的课件系统版块，当广告投放范围中包含“课件系统”时有效',
	'thread_groups' => '投放群组分类',
	'thread_groups_comment' => '设置广告投放的群组分类，当广告投放范围中包含“群组”时有效',
	'thread_position' => '投放位置',
	'thread_position_comment' => '课件内容上方和下方的广告适合使用文字形式，而课件右侧广告适合使用图片或 Flash 形式，也可以同时显示多条文字广告',
	'thread_position_bottom' => '课件下方',
	'thread_position_top' => '课件上方',
	'thread_position_right' => '课件右侧',
	'thread_pnumber' => '广告显示楼层',
	'thread_pnumber_comment' => '选项 #1 #2 #3 ... 表示课件楼层，可以按住 CTRL 多选',
	'thread_pnumber_all' => '全部',
);

?>