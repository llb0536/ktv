<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: topicadmin_stamplist.php 25289 2011-11-03 10:06:19Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

if(!$_G['group']['allowstamplist']) {
	showmessage('no_privilege_stamplist');
}

loadcache('stamps');

if(!submitcheck('modsubmit')) {

	include template('forum/topicadmin_action');

} else {

	$_GET['stamplist'] = $_GET['stamplist'] !== '' ? $_GET['stamplist'] : -1;
	$modaction = $_GET['stamplist'] >= 0 ? 'L'.sprintf('%02d', $_GET['stamplist']) : 'SLD';
	$reason = checkreasonpm();

	C::t('forum_thread')->update($_G['tid'], array('moderated'=>1, 'icon'=>$_GET['stamplist']));
	$resultarray = array(
	'redirect'	=> "forum.php?mod=viewthread&tid=$_G[tid]&page=$page",
	'reasonpm'	=> ($sendreasonpm ? array('data' => array($thread), 'var' => 'thread', 'item' => $_GET['stamplist'] !== '' ? 'reason_stamplist_update' : 'reason_stamplist_delete') : array()),
	'reasonvar'	=> array('tid' => $thread['tid'], 'subject' => $thread['subject'], 'modaction' => $modaction, 'reason' => $reason, 'stamp' => $_G['cache']['stamps'][$_GET['stamplist']]['text']),
	'modaction'	=> $modaction,
	'modlog'	=> $thread
	);
	$modpostsnum = 1;

	updatemodlog($_G['tid'], $modaction);

}

?>