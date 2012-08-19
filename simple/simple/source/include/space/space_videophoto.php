<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: space_videophoto.php 22572 2011-05-12 09:35:18Z zhengqingpeng $
 */

if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}

if(empty($_G['setting']['verify'][7]['available'])) {
	showmessage('no_open_videophoto');
}

require_once libfile('function/spacecp');
ckvideophoto($space);

$videophoto = getvideophoto($space['videophoto']);

include_once template("home/space_videophoto");

?>