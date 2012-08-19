<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: Storage.php 29263 2012-03-31 05:45:08Z yexinhao $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class Cloud_Service_Server_Storage extends Cloud_Service_Server_Restful {

	protected static $_instance;

	public static function getInstance() {

		if (!(self::$_instance instanceof self)) {
			self::$_instance = new self();
		}

		return self::$_instance;
	}

	public function onStorageSetConfig($data) {
		if ($data['xf_storage_enc_key']) {
			$insert = array(
						'skey' => 'xf_storage_enc_key',
						'svalue' => $data['xf_storage_enc_key'],
					);
			C::t('common_setting')->insert($insert, 0, 1);
			return true;
		}
		return false;
	}
}