<?php

/**
 *      [KTV_SUB] (C)2001-2099 Kejian.TV Inc.
 *      This is NOT a freeware, use is subject to license terms
 *
 *      $Id: class_core.php 28824 2012-03-14 06:41:27Z zhangguosheng $
 */
// psvr add
function psvr_in_dev(){
  $server_name = @$_SERVER['SERVER_NAME'];
  if($server_name){
    $tmparr=(explode('.',$server_name));
    define('PSVR_KTV_SUB',$tmparr[0]);
    return substr($server_name,-6) === 'lvh.me';
  }else{
    return false;
  }
}
if(psvr_in_dev()){
  define('PSVR_IN_DEV',true);
}else{
  define('PSVR_IN_DEV',false);
}
define('PSVR_RAILS_ENV','sub_'.PSVR_KTV_SUB.(PSVR_IN_DEV ? '_dev' : ''));

global $PSVR;
$PSVR=array();
$PSVR['parsed_setting'] = yaml_parse(file_get_contents('../../config/setting.yml'));
$PSVR['parsed_setting'] = $PSVR['parsed_setting'][PSVR_RAILS_ENV];

$PSVR['foto'] = rand(0,count($PSVR['parsed_setting']['fotos'])-1);
$PSVR['foto_desc'] = $PSVR['parsed_setting']['fotos'][$PSVR['foto']];
$PSVR['foto_src'] = "http://ktv-pic.b0.upaiyun.com/sub/".PSVR_KTV_SUB."_foto/{$PSVR['foto']}.jpg";
if(!PSVR_IN_DEV){
  global $PSVR;
  $PSVR['parsed_manifest'] = yaml_parse(file_get_contents('../../../_assets_sub/manifest.yml'));
}
function asset_path($file){
  global $PSVR;
  return PSVR_IN_DEV ? '/assets/'.$file : 'http://ktv-intrinsic-sub.b0.upaiyun.com/'.$PSVR['parsed_manifest'][$file];
}

function puts($str){
  $psvr_fp = fopen("/tmp/psvr_simple_log.log", "a");
  fprintf($psvr_fp,"> ");
  if (true===$str) {
    fputs($psvr_fp,"true");
  }else if(false===$str){
    fputs($psvr_fp,"false");
  }else{
    fputs($psvr_fp,var_export($str, TRUE));
    fprintf($psvr_fp,"\n\n");
  }
  fclose($psvr_fp);
}

function startsWith($haystack, $needle)
{
    $length = strlen($needle);
    return (substr($haystack, 0, $length) === $needle);
}

function endsWith($haystack, $needle)
{
    $length = strlen($needle);
    if ($length == 0) {
        return true;
    }

    return (substr($haystack, -$length) === $needle);
}
error_reporting(E_ALL);

define('IN_DISCUZ', true);
define('DISCUZ_ROOT', substr(dirname(__FILE__), 0, -12));
define('DISCUZ_CORE_DEBUG', false);

set_exception_handler(array('core', 'handleException'));

if(DISCUZ_CORE_DEBUG) {
	set_error_handler(array('core', 'handleError'));
	register_shutdown_function(array('core', 'handleShutdown'));
}

if(function_exists('spl_autoload_register')) {
	spl_autoload_register(array('core', 'autoload'));
} else {
	function __autoload($class) {
		return core::autoload($class);
	}
}

C::creatapp();

class core
{
	private static $_tables;
	private static $_imports;
	private static $_app;
	private static $_memory;

	public static function app() {
		return self::$_app;
	}

	public static function creatapp() {
		if(!is_object(self::$_app)) {
			self::$_app = discuz_application::instance();
		}
		return self::$_app;
	}

	public static function t($name) {
		$pluginid = null;
		if($name[0] === '#') {
			list(, $pluginid, $name) = explode('#', $name);
		}
		$classname = 'table_'.$name;
		if(!isset(self::$_tables[$classname])) {
			if(!class_exists($classname, false)) {
				self::import(($pluginid ? 'plugin/'.$pluginid : 'class').'/table/'.$name);
			}
			self::$_tables[$classname] = new $classname;
		}
		return self::$_tables[$classname];
	}

	public static function memory() {
		if(!self::$_memory) {
			self::$_memory = new discuz_memory();
			self::$_memory->init(self::app()->config['memory']);
		}
		return self::$_memory;
	}

	public static function import($name, $folder = '', $force = true) {
		$key = $folder.$name;
		if(!isset(self::$_imports[$key])) {
			$path = DISCUZ_ROOT.'/source/'.$folder;
			if(strpos($name, '/') !== false) {
				$pre = basename(dirname($name));
				$filename = dirname($name).'/'.$pre.'_'.basename($name).'.php';
			} else {
				$filename = $name.'.php';
			}

			if(is_file($path.'/'.$filename)) {
				self::$_imports[$key] = true;
				return include $path.'/'.$filename;
			} elseif(!$force) {
				return false;
			} else {
				throw new Exception('Oops! System file lost: '.$filename);
			}
		}
		return true;
	}

	public static function handleException($exception) {
		discuz_error::exception_error($exception);
	}


	public static function handleError($errno, $errstr, $errfile, $errline) {
		if($errno & DISCUZ_CORE_DEBUG) {
			discuz_error::system_error($errstr, false, true, false);
		}
	}

	public static function handleShutdown() {
		if(($error = error_get_last()) && $error['type'] & DISCUZ_CORE_DEBUG) {
			discuz_error::system_error($error['message'], false, true, false);
		}
	}

	public static function autoload($class) {
		$class = strtolower($class);
		if(strpos($class, '_') !== false) {
			list($folder) = explode('_', $class);
			$file = 'class/'.$folder.'/'.substr($class, strlen($folder) + 1);
		} else {
			$file = 'class/'.$class;
		}

		try {

			self::import($file);
			return true;

		} catch (Exception $exc) {

			$trace = $exc->getTrace();
			foreach ($trace as $log) {
				if(empty($log['class']) && $log['function'] == 'class_exists') {
					return false;
				}
			}
			discuz_error::exception_error($exc);
		}
	}
}

class C extends core {}
class DB extends discuz_database {}

?>
