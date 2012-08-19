<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: lang_post.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'post_name' => '课件系统课件类任务',
	'post_desc' => '通过发课件学习笔记完成任务，活跃课件系统的氛围',
	'post_complete_var_act' => '动作',
	'post_complete_var_act_newthread' => '发新课件',
	'post_complete_var_act_newreply' => '发新回复',
	'post_complete_var_act_newpost' => '发新课件/回复',
	'post_complate_var_forumid' => '版块限制',
	'post_complate_var_forumid_comment' => '设置用户只能在某个版块完成任务',
	'post_complate_var_threadid' => '回复指定课件',
	'post_complate_var_threadid_comment' => '设置用户只有回复该课件才能完成任务，请填写课件的 TID',
	'post_complate_var_author' => '回复指定作者',
	'post_complate_var_author_comment' => '设置用户只有回复该作者上传的课件才能完成任务，请填写作者的用户名',
	'post_complete_var_num' => '执行动作次数下限',
	'post_complete_var_num_comment' => '用户需要执行相应动作的最少次数',
	'post_complete_var_time' => '时间限制(小时)',
	'post_complete_var_time_comment' => '设置用户从申请任务到完成任务的时间限制，用户在此时间内未能完成任务则不能领取奖励并标记任务失败，0 或留空为不限制',

	'task_complete_forumid' => '在版块 {value} ',
	'task_complete_act_newthread' => '发新课件 {num} 次',
	'task_complete_act_newpost' => '发新课件/回复 {num} 次',
	'task_complete_act_newreply_thread' => '在“{value}”回复课件 {num} 次',
	'task_complete_act_newreply_author' => '回复作者“{value}”的课件 {num} 次',
);

?>