<?php
define('UC_CONNECT', 'mysql');
define('UC_DBHOST', 'localhost');
define('UC_DBUSER', 'root');
define('UC_DBPW', 'jknlff8-pro-17m7755');
define('UC_DBNAME', 'ucenter');
define('UC_DBCHARSET', 'utf8');
define('UC_DBTABLEPRE', '`ucenter`.uc_');
define('UC_DBCONNECT', '0');
switch(PSVR_KTV_SUB){
  case 'cnu':
	define('UC_KEY', '96131WFHBWXGjPBw+Dvo5HkNwMSDu5KmcFK6Q/E=');
	define('UC_APPID', '4');
	break;
  case 'ibeike':
	define('UC_KEY', 'F0a2ufTaJcAaucv5Hdt9Jah9l4BaKasdx9n2qeJdXaUeP463x2fcdfQaR5f0L339');
	define('UC_APPID', '10');
	break;
}

if(!PSVR_IN_DEV){
	define('UC_API', 'http://uc.kejian.tv');
}else{
	define('UC_API', 'http://uc.kejian.lvh.me');
}

define('UC_CHARSET', 'utf-8');
define('UC_IP', '');
define('UC_PPP', '20');
