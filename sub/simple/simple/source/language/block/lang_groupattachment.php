<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: lang_groupattachment.php 27449 2012-02-01 05:32:35Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

$lang = array
(
	'groupattachment_name' => '论坛附件列表',
	'groupattachment_desc' => '论坛附件列表调用',
	'groupattachment_fids' => '指定群组',
	'groupattachment_fids_comment' => '指定群组，多个ID之间请用半角逗号“,”隔开。',
	'groupattachment_tids' => '指定课件',
	'groupattachment_tids_comment' => '指定课件ID，多个ID之间用逗号分隔',
	'groupattachment_gtids' => '群组分类',
	'groupattachment_gtids_comment' => '设置群组所在分类，可以按住 CTRL 多选，全选或全不选均为不做限制',
	'groupattachment_startrow' => '起始数据行数',
	'groupattachment_startrow_comment' => '如需设定起始的数据行数，请输入具体数值，0 为从第一行开始，以此类推',
	'groupattachment_items' => '显示数据条数',
	'groupattachment_items_comment' => '设置一次显示的图片课件条目数，请设置为大于 0 的整数',
	'groupattachment_titlelength' => '标题长度',
	'groupattachment_titlelength_comment' => '设置当附件名称/课件标题显示的最大长度',
	'groupattachment_summarylength' => '内容长度',
	'groupattachment_summarylength_comment' => '设置附件介绍/课件内容显示的最大长度',
	'groupattachment_maxwidth' => '图片最大宽度(像素)',
	'groupattachment_maxwidth_comment' => '设置是否自动缩小或放大图片的尺寸到本设定的宽度，0 为不自动缩放',
	'groupattachment_maxheight' => '图片最大高度(像素)',
	'groupattachment_maxheight_comment' => '设置是否自动缩小或放大图片的尺寸到本设定的高度，0 为不自动缩放',
	'groupattachment_threadmethod' => '课件方式调用',
	'groupattachment_threadmethod_comment' => '选择“是”将按照课件方式调用附件，一个课件显示一个附件；选择“否”将按照附件方式调用',
	'groupattachment_digest' => '精华帖过滤',
	'groupattachment_digest_comment' => '设置特定的课件范围。注意: 全选或全不选均为不进行任何过滤',
	'groupattachment_digest_0' => '普通课件',
	'groupattachment_digest_1' => '精华 I',
	'groupattachment_digest_2' => '精华 II',
	'groupattachment_digest_3' => '精华 III',
	'groupattachment_special' => '特殊课件过滤',
	'groupattachment_special_comment' => '设置特定的课件范围。注意: 全选或全不选均为不进行任何过滤',
	'groupattachment_special_1' => '投票课件',
	'groupattachment_special_2' => '商品课件',
	'groupattachment_special_3' => '悬赏课件',
	'groupattachment_special_4' => '活动课件',
	'groupattachment_special_5' => '辩论课件',
	'groupattachment_special_0' => '普通课件',
	'groupattachment_special_reward' => '悬赏课件过滤',
	'groupattachment_special_reward_comment' => '设置特定类型的悬赏课件',
	'groupattachment_special_reward_0' => '全部',
	'groupattachment_special_reward_1' => '已解决',
	'groupattachment_special_reward_2' => '未解决',
	'groupattachment_dateline' => '附件上传时间',
	'groupattachment_dateline_nolimit' => '不限制',
	'groupattachment_dateline_hour' => '最近1小时',
	'groupattachment_dateline_day' => '最近24小时',
	'groupattachment_dateline_week' => '最近1周',
	'groupattachment_dateline_month' => '最近1月',
	'groupattachment_gviewperm' => '群组浏览权限',
	'groupattachment_gviewperm_nolimit' => '不限制',
	'groupattachment_gviewperm_only_member' => '仅成员',
	'groupattachment_gviewperm_all_member' => '所有人',
	'groupattachment_highlight' => '获得高亮值',
);

?>