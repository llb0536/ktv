<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: topicadmin_delpost.php 25289 2011-11-03 10:06:19Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

if(!$_G['group']['allowdelpost']) {
	showmessage('no_privilege_delpost');
}

$topiclist = $_GET['topiclist'];
$modpostsnum = count($topiclist);

$authorcount = $crimenum = 0;
$crimeauthor = '';
$pids = $posts = $authors = array();

if(!($deletepids = dimplode($topiclist))) {
	showmessage('admin_delpost_invalid');
} elseif(!$_G['group']['allowdelpost'] || !$_G['tid']) {
	showmessage('admin_nopermission');
}  else {
	$posttable = getposttablebytid($_G['tid']);
	foreach(C::t('forum_post')->fetch_all('tid:'.$_G['tid'], $topiclist, false) as $post) {
		if($post['tid'] != $_G['tid']) {
			continue;
		}
		if($post['first'] == 1) {
			dheader("location: $_G[siteurl]forum.php?mod=topicadmin&action=moderate&operation=delete&optgroup=3&fid=$_G[fid]&moderate[]=$thread[tid]&inajax=yes".($_GET['infloat'] ? "&infloat=yes&handlekey={$_GET['handlekey']}" : ''));
		} else {
			$authors[$post['authorid']] = 1;
			$pids[] = $post['pid'];
			$posts[] = $post;
		}
	}
}

if(!submitcheck('modsubmit')) {

	$deleteid = '';
	foreach($topiclist as $id) {
		$deleteid .= '<input type="hidden" name="topiclist[]" value="'.$id.'" />';
	}

	$authorcount = count(array_keys($authors));

	if($modpostsnum == 1 || $authorcount == 1) {
		include_once libfile('function/member');
		$crimenum = crime('getcount', $posts[0]['authorid'], 'crime_delpost');
		$crimeauthor = $posts[0]['author'];
	}

	include template('forum/topicadmin_action');

} else {

	$reason = checkreasonpm();

	$uidarray = $puidarray = $auidarray = array();
	$losslessdel = $_G['setting']['losslessdel'] > 0 ? TIMESTAMP - $_G['setting']['losslessdel'] * 86400 : 0;

	if($pids) {
		require_once libfile('function/delete');
		if($_G['forum']['recyclebin']) {
			deletepost($pids, 'pid', true, false, true);
			manage_addnotify('verifyrecyclepost', $modpostsnum);
		} else {
			$logs = array();
			$ratelog = C::t('forum_ratelog')->fetch_all_by_pid($pids);
			$rposts = C::t('forum_post')->fetch_all('tid:'.$_G['tid'], $pids, false);
			foreach(C::t('forum_ratelog')->fetch_all_by_pid($pids) as $rpid => $author) {
				if($author['score'] > 0) {
					$rpost = $rposts[$rpid];
					updatemembercount($rpost['authorid'], array($author['extcredits'] => -$author['score']));
					$author['score'] = $_G['setting']['extcredits'][$id]['title'].' '.-$author['score'].' '.$_G['setting']['extcredits'][$id]['unit'];
					$logs[] = dhtmlspecialchars("$_G[timestamp]\t{$_G[member][username]}\t$_G[adminid]\t$rpost[author]\t$author[extcredits]\t$author[score]\t$thread[tid]\t$thread[subject]\t$delpostsubmit");
				}
			}
			if(!empty($logs)) {
				writelog('ratelog', $logs);
				unset($logs);
			}
			deletepost($pids, 'pid', true);
		}

		if($_GET['crimerecord']) {
			include_once libfile('function/member');

			foreach($posts as $post) {
				crime('recordaction', $post['authorid'], 'crime_delpost', lang('forum/misc', 'crime_postreason', array('reason' => $reason, 'tid' => $post['tid'], 'pid' => $post['pid'])));
			}
		}
	}

	updatethreadcount($_G['tid'], 1);
	updateforumcount($_G['fid']);

	$_G['forum']['threadcaches'] && deletethreadcaches($thread['tid']);

	$modaction = 'DLP';

	$resultarray = array(
	'redirect'	=> "forum.php?mod=viewthread&tid=$_G[tid]&page=$_GET[page]",
	'reasonpm'	=> ($sendreasonpm ? array('data' => $posts, 'var' => 'post', 'item' => 'reason_delete_post') : array()),
	'reasonvar'	=> array('tid' => $thread['tid'], 'subject' => $thread['subject'], 'modaction' => $modaction, 'reason' => $reason),
	'modtids'	=> 0,
	'modlog'	=> $thread
	);

}

?>