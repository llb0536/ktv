
$(document).ready(function(){

	// 个人设置弹层，离开隐藏
	$('#userInfoPop').mouseleave(function(){
		$(this).hide();
	});
	
	$('.userPageHeader img.imgHead').mouseenter(function(){
		$(this).next().show();
	});
	
	// 上传头像表单模拟
	$("#file_uploader").change(function(){
		$("#file_uploader_text").val(this.value);
    });
	
	
	/*
	var windowHeight = $(window).height(), // 屏幕高度
		bodyHeight = $(document).height();   // 整页高度
	$(document).scroll(function(){
		var scrollTop = $(this).scrollTop(); // 当前滚动条高度 scrollTop
		console.log(windowHeight);
		console.log(bodyHeight);
		if ((scrollTop + windowHeight) === bodyHeight) {
			console.log('到了');
		}
	});
	*/
});