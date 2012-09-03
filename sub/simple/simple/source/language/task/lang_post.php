<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: lang_post.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'post_name' => '课件交流系统课件类任务',
	'post_desc' => '通过上传课件课件评论完成任务，活跃课件交流系统的氛围',
	'post_complete_var_act' => '动作',
	'post_complete_var_act_newthread' => '上传新课件',
	'post_complete_var_act_newreply' => '发新评论',
	'post_complete_var_act_newpost' => '上传新课件/评论',
	'post_complate_var_forumid' => '课程限制',
	'post_complate_var_forumid_comment' => '设置会员只能在某个课程完成任务',
	'post_complate_var_threadid' => '评论指定课件',
	'post_complate_var_threadid_comment' => '设置会员只有评论该课件才能完成任务，请填写课件的 TID',
	'post_complate_var_author' => '评论指定作者',
	'post_complate_var_author_comment' => '设置会员只有评论该作者发表的课件才能完成任务，请填写作者的用户名',
	'post_complete_var_num' => '执行动作次数下限',
	'post_complete_var_num_comment' => '会员需要执行相应动作的最少次数',
	'post_complete_var_time' => '时间限制(小时)',
	'post_complete_var_time_comment' => '设置会员从申请任务到完成任务的时间限制，会员在此时间内未能完成任务则不能领取奖励并标记任务失败，0 或留空为不限制',

	'task_complete_forumid' => '在课程 {value} ',
	'task_complete_act_newthread' => '上传新课件 {num} 次',
	'task_complete_act_newpost' => '上传新课件/评论 {num} 次',
	'task_complete_act_newreply_thread' => '在“{value}”评论课件 {num} 次',
	'task_complete_act_newreply_author' => '评论作者“{value}”的课件 {num} 次',
);

?>