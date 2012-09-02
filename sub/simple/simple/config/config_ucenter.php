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
  define('UC_KEY', 'v9A6G4y0b8V0r5d6w7Ne9cH7F5Pfj9icUfdbbcgbf7v1X5R5Kbg1Z0h7F4eaGeK8');
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
