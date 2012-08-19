<?php
/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: ftn_upload.inc.php 29265 2012-03-31 06:03:26Z yexinhao $
 */
if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
$storageService = Cloud::loadClass('Service_Storage');

$formhash = formhash();
if($_GET['formhash'] == $formhash && $_GET['inajax']){
	$ftnFormhash = $storageService->ftnFormhash();
	$iframeurl = $storageService->makeIframeUrl($ftnFormhash);
} else {
	$iframeurl = '';
}

include template('xf_storage:upload');