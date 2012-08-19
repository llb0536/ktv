<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: Connect.php 28957 2012-03-20 12:32:24Z houdelei $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class Cloud_Service_Server_Connect extends Cloud_Service_Server_Restful {

	protected static $_instance;

	public static function getInstance() {

		if (!(self::$_instance instanceof self)) {
			self::$_instance = new self();
		}

		return self::$_instance;
	}

	public function onConnectSetConfig($data) {
		global $_G;

		$settingFields = array('connectappid', 'connectappkey');
		if (!$data) {
			return false;
		}

		$setting = C::t('common_setting')->fetch_all(array('connect'));
		$connectData = (array)dunserialize($setting['connect']);

		if (!is_array($connectData)) {
			$connectData = array();
		}

		$settings = array();
		foreach($data as $k => $v) {
			if (in_array($k, $settingFields)) {
				$settings[$k] = $v;
			} else {
				$connectData[$k] = $v;
			}
		}
		if ($connectData) {
			$settings['connect'] = $connectData;
		}

		if ($settings) {
			C::t('common_setting')->update_batch($settings);
			return true;
		}
		return false;
	}

}