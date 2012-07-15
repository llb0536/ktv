/*
说明：

1. nBtn为小绿色关注按钮，用于话题，人物等等列表中的关注操作。
	与其配套的是 nBtnFocus（关注） 和 nBtnUnFocus（取消关注） 两个class。
	使用方法：<a class="nBtn nBtnFocus"></a>
2. bBtn为大绿色关注按钮，用于话题，人物单一出现的显眼关注操作。
	与其配套的是 bBtnFocus（关注） 和 bBtnUnFocus（取消操作）
	使用方法：<a class="bBtn bBtnFocus"></a>
3. nBtnFocusAll为关注全部按钮，目前此按钮只有小样式。
	使用方法：<a class="nBtn nBtnFocusAll"></a>
4. btnNormalGreen为自适应按钮样式，宽度由其内部文本长度控制。
	使用方法：<div class="btnNormalGreen"><span>&nbsp;保 存&nbsp;</span></div>
	<div class="btnNormalSilver"><span>&nbsp;保 存&nbsp;</span></div>
	
5. 上面宽2px，下面宽1px的灰色分割线。
	使用方法：<div class="dline mt10"></div>
6. 各种小图标使用方法：
	跟随名字后行内绿色认证VLOGO：<img src="img/transparent.png" class="verifyLogoS" />
	行内绿色问号LOGO：<img src="img/transparent.png" class="questionLogo" />

注意：

1. 修改资料的时候，选择头像图片URL后，浏览器无法预览本地图片文件（头像）。
2. 问题页<section id="mainContent" class="askPage">注意后面比其他页面多了一个askPage的class。
3. 不需要侧边栏的页面，需要给wrapper添加noSidebar类，如下：
	<section class="wrapper noSidebar clearfix" id="container">
4. css.css文件中 #popTopic 里面的top和left属性需要删除。
*/