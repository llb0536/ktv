<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: misc_patch.php 30849 2012-06-26 02:21:32Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

if($_GET['action'] == 'checkpatch') {

	header('Content-Type: text/javascript');

	if($_G['uid'] && $_G['member']['allowadmincp'] == 1) {
		$discuz_patch = new discuz_patch();
		$discuz_patch->check_patch();
	}
	exit;

} elseif($_GET['action'] == 'patchnotice') {

	$patchlist = '';
	if($_G['member']['allowadmincp'] == 1) {
		$discuz_patch = new discuz_patch();
		$patchnotice = $discuz_patch->fetch_patch_notice();
		if(!empty($patchnotice['data'])) {
			$lang = lang('forum/misc');
			$patchlist .= '<div class="bm'.($patchnotice['fixed'] ? ' allfixed' : '').'"><div class="bm_h cl"><a href="javascript:;" onclick="$(\'patch_notice\').style.display=\'none\'" class="y" title="'.$lang['patch_close'].'">'.$lang['patch_close'].'</a><h2 class="i">';
			if($patchnotice['fixed']) {
				$patchlist .= $lang['patch_site_have'].' '.count($patchnotice['data']).' '.$lang['patch_is_fixed'];
			} else {
				$patchlist .= $lang['patch_site_have'].' '.count($patchnotice['data']).' '.$lang['patch_need_fix'];
			}
			$patchlist .= '</h2></div><div class="bm_c"><table width="100%" class="mbm"><tr><th>'.$lang['patch_name'].'</th><th class="patchdate">'.$lang['patch_dateline'].'</th><th class="patchstat">'.$lang['patch_status'].'</th><tr>';
			foreach($patchnotice['data'] as $notice) {
				$patchlist .= '<tr><td>'.$notice['serial'].'</td><td>'.dgmdate($notice['dateline'], 'Y-m-d').'</td><td>';
				if($notice['status'] >= 1) {
					$patchlist .= '<span class="fixed">'.$lang['patch_fixed_status'].'<span>';
				} elseif($notice['status'] < 0) {
					$patchlist .= '<span class="unfixed">'.$lang['patch_fix_failed_status'].'</span>';
				} else {
					$patchlist .= '<span class="unfixed">'.$lang['patch_unfix_status'].'</span>';
				}
				$patchlist .= '</td></tr>';
			}
			$patchlist .= '</table><p class="cl"><a href="admin.php?action=patch" class="y pn"><strong>'.($patchnotice['fixed'] ? $lang['patch_view_fix_detail'] : $lang['patch_fix_right_now']).'</strong></a></p>';
			$patchlist .= '</div></div>';
		}
	}
	include template('common/header_ajax');
	echo $patchlist;
	include template('common/footer_ajax');
	exit;

} elseif($_GET['action'] == 'pluginnotice') {
	require_once libfile('function/admincp');
	require_once libfile('function/plugin');
	require_once libfile('function/cloudaddons');
	$pluginarray = C::t('common_plugin')->fetch_all_data();
	$addonids = array();
	foreach($pluginarray as $row) {
		if(ispluginkey($row['identifier'])) {
			$addonids[] = $row['identifier'].'.plugin';
		}
	}
	$checkresult = dunserialize(cloudaddons_upgradecheck($addonids));
	savecache('addoncheck_plugin', $checkresult);
	$newversion = 0;
	foreach($checkresult as $value) {
		list(, $newver) = explode(':', $value);
		if($newver) {
			$newversion++;
		}
	}
	include template('common/header_ajax');
	if($newversion) {
		$lang = lang('forum/misc');
		echo '<div class="bm"><div class="bm_h cl"><a href="javascript:;" onclick="$(\'plugin_notice\').style.display=\'none\';setcookie(\'pluginnotice\', 1, 86400)" class="y" title="'.$lang['patch_close'].'">'.$lang['patch_close'].'</a>';
		echo '<h2 class="i">'.$lang['plugin_title'].'</h2></div><div class="bm_c">';
		echo lang('forum/misc', 'plugin_memo', array('number' => $newversion));
		echo '<div align="right"><a href="admin.php?action=plugins" class="xi2">'.$lang['plugin_link'].'</a></div>';
		echo '</div></div>';
	}
	include template('common/footer_ajax');
	exit;
}

?>