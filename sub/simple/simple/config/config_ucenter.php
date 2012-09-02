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
  case 'cnu':define('UC_KEY', '96131WFHBWXGjPBw+Dvo5HkNwMSDu5KmcFK6Q/E=');break;
  case 'ibeike':define('UC_KEY', 'cfc0iLO/l4lZbfTRVyij4LbiOi/Pl55xoYUQBmw=');break;
  case 'cas':define('UC_KEY', '4a4dXGotWK6W+2LzudsrmPuvKEDzk7cU7iGu9Xg=');break;
}

if(!PSVR_IN_DEV){
	define('UC_API', 'http://uc.kejian.tv');
}else{
	define('UC_API', 'http://uc.kejian.lvh.me');
}

define('UC_CHARSET', 'utf-8');
define('UC_IP', '');
define('UC_APPID', '4');
define('UC_PPP', '20');
