<?php

/**
 *      [Kejian.TV] (C)2012 P.S.V.R
 *      This code won't be disclosed to anyone.
 *
 *      $Id: group.php 28091 2012-02-22 07:33:26Z zhengqingpeng $
 */

define('APPTYPEID', 3);
define('CURSCRIPT', 'group');


require './source/class/class_core.php';

$discuz = C::app();

$cachelist = array('grouptype', 'groupindex', 'diytemplatenamegroup');
$discuz->cachelist = $cachelist;
$discuz->init();

$_G['disabledwidthauto'] = 0;

$modarray = array('index', 'my', 'attentiongroup');
$mod = !in_array($_G['mod'], $modarray) ? 'index' : $_G['mod'];

define('CURMODULE', $mod);

runhooks();

$navtitle = str_replace('{bbname}', $_G['setting']['bbname'], $_G['setting']['seotitle']['group']);

require DISCUZ_ROOT.'./source/module/group/group_'.$mod.'.php';
?>