<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: memory_driver_eaccelerator.php 30458 2012-05-30 01:50:37Z zhangguosheng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

class memory_driver_eaccelerator
{

	public function init($config) {

	}

	public function get($key) {
		return eaccelerator_get($key);
	}

	public function set($key, $value, $ttl = 0) {
		return eaccelerator_put($key, $value, $ttl);
	}

	public function rm($key) {
		return eaccelerator_rm($key);
	}

	public function clear() {
		return @eaccelerator_clear();
	}

}

?>