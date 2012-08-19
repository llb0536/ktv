<?php
echo base64_decode('OVUP/PZrLzoZpaeQga/TpK9xeJAOuTTbUzm9NplDuhSUMkklPtDeDQDgidUEIX+ijxe80EI');echo "\n";
$str=base64_decode('OVUP/PZrLzoZpaeQga/TpK9xeJAOuTTbUzm9NplDuhSUMkklPtDeDQDgidUEIX+ijxe80EI');
$length=strlen($str);

$retval = '';
for($i = 0; $i < strlen($str); ++$i) {
    $retval .= '\x'.dechex(ord($str[$i]));
}
;echo "\n";
print($retval);
;echo "\n";

echo $length;echo "\n";
exit;
define('UC_KEY','a332MrfSAdOyVNFBIHjEEoY0FsJ7SbXxzS6cszg');
function authcode($string, $operation = 'DECODE', $key = '', $expiry = 0) {

	$ckey_length = 4;	// 随机密钥长度 取值 0-32;
				// 加入随机密钥，可以令密文无任何规律，即便是原文和密钥完全相同，加密结果也会每次不同，增大破解难度。
				// 取值越大，密文变动规律越大，密文变化 = 16 的 $ckey_length 次方
				// 当此值为 0 时，则不产生随机密钥

	$key = md5($key ? $key : UC_KEY);
	$keya = md5(substr($key, 0, 16));
	$keyb = md5(substr($key, 16, 16));
	$keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length): substr(md5(microtime()), -$ckey_length)) : '';
  // echo (UC_KEY);echo "\n";
  // echo (substr(UC_KEY, 0, 16));echo "\n";
  // echo (substr(UC_KEY, 16, 16));echo "\n";
  echo $key;echo "\n";
  echo $keya;echo "\n";
  echo $keyb;echo "\n";
  echo $keyc;echo "\n";

	$cryptkey = $keya.md5($keya.$keyc);
	$key_length = strlen($cryptkey);
;echo "\n";;echo "\n";;echo "\n";
	echo substr($string, $ckey_length);echo "\n";
	;echo "\n";;echo "\n";;echo "\n";
	$string = $operation == 'DECODE' ? base64_decode(substr($string, $ckey_length)) : sprintf('%010d', $expiry ? $expiry + time() : 0).substr(md5($string.$keyb), 0, 16).$string;
	echo $string;echo "\n";
	$string_length = strlen($string);
  echo $string_length;echo "\n";
	$result = '';
	$box = range(0, 255);
  echo "\n";
  echo $result;echo "\n";
  echo "\n";
	$rndkey = array();
	for($i = 0; $i <= 255; $i++) {
		$rndkey[$i] = ord($cryptkey[$i % $key_length]);
	}
  echo "\n";
  echo $result;echo "\n";
  echo "\n";
	for($j = $i = 0; $i < 256; $i++) {
		$j = ($j + $box[$i] + $rndkey[$i]) % 256;
		$tmp = $box[$i];
		$box[$i] = $box[$j];
		$box[$j] = $tmp;
	}
  echo "\n";
  echo $result;echo "\n";
  echo "\n";
	for($a = $j = $i = 0; $i < $string_length; $i++) {
		$a = ($a + 1) % 256;
		$j = ($j + $box[$a]) % 256;
		$tmp = $box[$a];
		$box[$a] = $box[$j];
		$box[$j] = $tmp;
		$result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
	}
//return $result;
  echo "\n";
  echo $result;echo "\n";
  echo "\n";
	if($operation == 'DECODE') {
		if((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26).$keyb), 0, 16)) {
			return substr($result, 26);
		} else {
			return '';
		}
	} else {
		return $keyc.str_replace('=', '', base64_encode($result));
	}

}
echo authcode('ae73OVUP/PZrLzoZpaeQga/TpK9xeJAOuTTbUzm9NplDuhSUMkklPtDeDQDgidUEIX+ijxe80EI','DECODE',UC_KEY);echo "\n";
echo 'no!!!';
?>
