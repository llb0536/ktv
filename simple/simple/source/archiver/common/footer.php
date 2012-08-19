<?php
if(!defined('IN_DISCUZ')) {
	exit('Access Denied');
}
?>
<br />
<center>
	<?php echo adshow('footerbanner//1').adshow('footerbanner//2').adshow('footerbanner//3'); ?>
	<div id="footer">
		版权所有 &copy; <!--{echo date("Y")}--> <a href="http://www.kejian.tv/">Kejian.TV</a>, 课件著作权为原作者所有.
		<br />
		<br />
	</div>
</center>
</body>
</html>
<?php output(); ?>
