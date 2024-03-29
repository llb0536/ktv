<?php

/**
 *		[KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *		This is NOT a freeware, use is subject to license terms
 *
 *		$Id: DiscuzTips.php 29283 2012-03-31 09:35:36Z liudongdong $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class Cloud_Service_DiscuzTips {

	protected static $_instance;

	public static function getInstance() {
		global $_G;

		if (!(self::$_instance instanceof self)) {
			self::$_instance = new self();
		}

		return self::$_instance;
	}

	public function show() {
	  //psvr disable
	  return;
		global $_G;
		$clientVersion = '2';
		$util = Cloud::loadclass('Service_Util');
		include_once DISCUZ_ROOT . '/source/discuz_version.php';
		$release = DISCUZ_RELEASE;
		$fix = DISCUZ_FIXBUG;
		$cloudApi = $util->getApiVersion();
		$isfounder = $util->isfounder($_G['member']);
		$sId = $_G['setting']['my_siteid'];
		$version = $_G['setting']['version'];
		$ts = TIMESTAMP;
		$sig = '';
		$adminId = $_G['adminid'];
		$openId = $_G['member']['conopenid'];
		$uid = $_G['uid'];
		$groupId = $_G['groupid'];

		if ($sId) {
			$params = array(
				's_id' => $sId,
				'product_version' => $version,
				'product_release' => $release,
				'fix_bug' => $fix,
				'is_founder' => $isfounder,
				's_url' => $_G['siteurl'],
				'admin_id' => $adminId,
				'open_id' => $openId,
				'uid' => $uid,
				'group_id' => $groupId,
				'last_send_time' => $_COOKIE['dctips'],
			);
			ksort($params);

			$str = $util->httpBuildQuery($params, '', '&');
			$sig = md5(sprintf('%s|%s|%s', $str, $_G['setting']['my_sitekey'], $ts));
		}

		$jsCode = <<<EOF
			<div id="discuz_tips" style="display:none;"></div>
			<script type="text/javascript">
				var discuzSId = '$sId';
				var discuzVersion = '$version';
				var discuzRelease = '$release';
				var discuzApi = '$cloudApi';
				var discuzIsFounder = '$isfounder';
				var discuzFixbug = '$fix';
				var discuzAdminId = '$adminId';
				var discuzOpenId = '$openId';
				var discuzUid = '$uid';
				var discuzGroupId = '$groupId';
				var ts = '$ts';
				var sig = '$sig';
				var discuzTipsCVersion = '$clientVersion';
			</script>
			<script src="http://discuz.gtimg.cn/cloud/scripts/discuz_tips.js?v=1" type="text/javascript" charset="UTF-8"></script>
EOF;
		echo $jsCode;
	}

}