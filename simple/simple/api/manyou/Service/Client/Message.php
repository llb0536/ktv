<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: Message.php 29721 2012-04-26 07:01:08Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

Cloud::loadFile('Service_Client_Restful');

class Cloud_Service_Client_Message extends Cloud_Service_Client_Restful {

	protected static $_instance;

	public static function getInstance($debug = false) {

		if (!(self::$_instance instanceof self)) {
			self::$_instance = new self($debug);
		}

		return self::$_instance;
	}

	public function __construct($debug = false) {

		return parent::__construct($debug);
	}

	public function add($siteUids, $authorId, $author, $dateline) {
		$toUids = array();
		if($siteUids) {
			foreach(C::t('#qqconnect#common_member_connect')->fetch_all((array)$siteUids) as $user) {
				$toUids[$user['conopenid']] = $user['uid'];
			}
			$_params = array(
					'openidData' => $toUids,
					'authorId' => $authorId,
					'author' => $author,
					'dateline' => $dateline,
					'deviceToken' => $this->getUserDeviceToken($siteUids)
				);
			return $this->_callMethod('connect.discuz.message.add', $_params);
		}
		return false;
	}
	public function setMsgFlag($siteUid, $dateline) {
		$_params = array(
				'openid' => $this->getUserOpenId($siteUid),
				'sSiteUid' => $siteUid,
				'dateline' => $dateline
			);
		return $this->_callMethod('connect.discuz.message.read', $_params);
	}

	protected function _callMethod($method, $args) {
		try {
			return parent::_callMethod($method, $args);
		} catch (Exception $e) {

		}
	}
}