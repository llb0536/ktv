$(function () {
    var cardDoc = window.cardDoc || {};
    $.extend($.fn, {
        personCard: function () {
            var that, _left, _top, _docTop, _docLeft, _currHeight, _currWidth, _l, _t, _class, pos;
            that = $(this);
            _docTop = $(document).scrollTop();
            _docLeft = $(document).scrollLeft();
            _currHeight = document.documentElement.clientHeight;
            _currWidth = document.documentElement.clientWidth;
            if (cardDoc[that.attr("usercard")]) {
                var data = cardDoc[that.attr("usercard")];
                $("#cardTip").html("");
                $("#cardTip").hide();
                insertTips(data);
                return
            }
            if (!parseInt(that.attr("usercard"))) {
                return
            }
            $.get(uri("URI_USER_CARD", that.attr("usercard")), function (data) {
                cardDoc[that.attr("usercard")] = data;
                if (document.getElementById("cardTip")) {
                    $("#cardTip").html("");
                    $("#cardTip").show();
                    $("#cardTip").css({
                        left: _left,
                        top: _top
                    });
                    insertTips(data)
                } else {
                    if ($("#message_dialog>div").size() == 1) {
                        sendMessageDialog.init("", loginUser.id)
                    }
                    var _html = '<div id="cardTip" class="card-mod" style="display:none;position:absolute;left:' + _left + "px;top:" + _top + 'px;z-index:99999999;"></div>';
                    $("body").append(_html);
                    insertTips(data)
                }
            });

            function insertTips(data) {
                var sSina, sQZone, sQQT, sRenren, sTaobao, sDouban, fllowMe, message, styles;
                data.snsSina ? sSina = '<a href="' + data.snsSinaUrl + '" class="pfbg minisina"></a>' : sSina = '<a href="#" class="pfbg unminisina"></a>';
                data.snsRenren ? sRenren = '<a href="' + data.snsRenrenUrl + '" class="pfbg minirr"></a>' : sRenren = '<a href="#" class="pfbg unminirr"></a>';
                data.snsQQT ? sQQT = '<a href="' + data.snsQQTUrl + '" class="pfbg minitx"></a>' : sQQT = '<a href="#" class="pfbg unminitx"></a>';
                data.snsQZone ? sQZone = '<a href="' + data.snsQZoneUrl + '" class="pfbg miniqq"></a>' : sQZone = '<a href="#" class="pfbg unminiqq"></a>';
                data.snsTaobao ? sTaobao = '<a href="' + data.snsTaobaoUrl + '" class="pfbg minitaobao"></a>' : sTaobao = '<a href="#" class="pfbg unminitaobao"></a>';
                data.snsDouban ? sDouban = '<a href="' + data.snsDoubanUrl + '" class="pfbg minidouban"></a>' : sDouban = '<a href="#" class="pfbg unminidouban"></a>';
                data.isFans && data.userId != loginUser.id ? message = '<a class="card-mail" href="#" letter_receiver = "' + data.userId + '" receiver_name="' + data.nickname + '"><span>发私信</span></a>' : message = '<a class="card-unmail" href="#" ></a>';
                data.isFollowed ? fllowMe = '<a class="buttonfollow unfriend-follow png fllowMe" follow="' + data.isFollowed + '" followed="' + data.userId + '">已关注</a>' : fllowMe = '<a followed="' + data.userId + '" follow="' + data.isFollowed + '" class="btn-cardfollow fllowMe">关注</a>';
                if (data.userId == loginUser.id) {
                    fllowMe = "";
                    message = ""
                }
                var des = "",
                    types, perId = data.userId;
                if (data.description == null) {
                    des = ""
                } else {
                    des = $.fn.filStr(data.description)
                }
                if (data.certifyType == 1) {
                    types = '<span class="ctf-icon small-ctf-g"  title="课件交流系统认证商家"></span>'
                } else {
                    if (data.certifyType == 2) {
                        types = '<span class="ctf-icon small-ctf-star-g" title="课件交流系统认证达人"></span>'
                    } else {
                        types = ""
                    }
                }
                var _html = ['<span class="cardArr png"></span>', '<div class="shadow-cd png">', '<div class="cardbody-cd">', '<div class="userinfo-cd cf">', '<a class="avatar-cd" href="/profile/' + data.userId + '" target="_blank"><img src="' + data.avatarTiny + '" /></a>', '<div class="profile-cd">', '<p class="name-cd"><a class="username-cd" href="/profile/' + data.userId + '"  target="_blank" title="' + data.nickname + '">' + $.fn.fixStr(data.nickname, 24, "...") + "</a>" + types + "</p>", '<p class="boardprofile-cd">', '<a href="/follow/' + data.userId + '/1"  target="_blank"><em>' + data.followCount + "</em><br /><span>关注</span></a>", '<a href="/fans/' + data.userId + '/1"  target="_blank"><em>' + data.fansCount + "</em><br /><span>粉丝</span></a>", '<a href="' + uri("URI_BOARDS_LIST", data.userId) + '"  target="_blank"><em>' + data.boardCount + "</em><br /><span>图格</span></a>", "</p>", "</div>", "</div>", '<div class="userprofile-cd">' + des + "</div>", '<div class="cardbottom">', '<div class="platform">' + sSina + sRenren + sQQT + sQZone + sTaobao + sDouban + "</div>", '<div class="cardfollow">' + fllowMe + message + "</div>", "</div>", "</div>", "</div>"].join("");
                $("#cardTip").html(_html);
                _l = that.offset().left - ($("body").width() - that.width() - that.offset().left);
                _t = (that.offset().top - $(document).scrollTop()) - ($(document).scrollTop() + document.documentElement.clientHeight - that.offset().top);
                if (_l > 0 && _t > 0) {
                    pos = "leftUp";
                    _left = that.offset().left - 250;
                    _top = that.offset().top - $("#cardTip").height();
                    _class = "cardArr-gdown"
                }
                if (_l > 0 && _t < 0) {
                    pos = "leftDown";
                    _left = that.offset().left - 250;
                    _top = that.offset().top + that.height() + 8;
                    _class = "cardArr-up"
                }
                if (_l < 0 && _t > 0) {
                    pos = "rightUp";
                    _left = that.offset().left;
                    _top = that.offset().top - $("#cardTip").height();
                    _class = "cardArr-gdown"
                }
                if (_l < 0 && _t < 0) {
                    pos = "rightDown";
                    _left = that.offset().left;
                    _top = that.offset().top + that.height() + 8;
                    _class = "cardArr-up"
                }
                $("#cardTip").show().css({
                    left: _left,
                    top: _top
                }).children(".cardArr").addClass(_class);
                if (pos == "leftUp" || pos == "leftDown") {
                    $("#cardTip").children(".cardArr").css({
                        left: "260px"
                    })
                }
                $("#cardTip .card-mail").live("click", function () {
                    var loginUserId = loginUser.id;
                    if (!loginUserId) {
                        var _path = window.location.pathname;
                        var flag = consts("REGIST_TYPE_STATION_GET");
                        window.location.href = "/login?flag=" + flag + "&p=" + _path;
                        return
                    }
                    var toUserId = $(this).attr("letter_receiver");
                    var toUserName = $(this).attr("receiver_name");
                    sendMessageDialog.otherOpenMessage("#message_" + toUserId, loginUserId, "" + toUserId, "" + toUserName)
                });
                $("#cardTip .fllowMe").die().live("click", function () {
                    var that = this;
                    var loginUserId = loginUser.id;
                    if (!loginUserId) {
                        var _path = window.location.pathname;
                        var flag = consts("REGIST_TYPE_STATION_GET");
                        window.location.href = "/login?flag=" + flag + "&p=" + _path;
                        return
                    }
                    var follow = parseInt($(this).attr("follow"));
                    var followed = $(this).attr("followed");
                    if (follow) {
                        postUrl = uri("URI_FANS_UNFOLLOW_USER", followed)
                    } else {
                        postUrl = uri("URI_FANS_ADD_FOLLOW_USER", followed)
                    }
                    if (follow) {
                        $.ajax({
                            type: "POST",
                            url: postUrl,
                            dataType: "json",
                            success: function (data) {
                                $(that).text("关注").removeClass().addClass("btn-cardfollow fllowMe").attr("follow", "0");
                                cardDoc[perId].isFollowed = 0
                            }
                        })
                    } else {
                        $.ajax({
                            type: "POST",
                            url: postUrl,
                            dataType: "json",
                            success: function (data) {
                                $(that).text("已关注").removeClass().addClass("buttonfollow unfriend-follow png fllowMe").attr("follow", "1");
                                cardDoc[perId].isFollowed = 1
                            }
                        })
                    }
                })
            }
        }
    });
    var hoverTimer = null,
        outTimer = null;
    $("a[havecard|=1]").live("mouseenter", function () {
        clearTimeout(outTimer);
        var that = $(this);
        hoverTimer = setTimeout(function () {
            that.personCard()
        }, 300)
    }).live("mouseleave", function () {
        var that = $(this);
        clearTimeout(hoverTimer);
        outTimer = setTimeout(function () {
            if (that.attr("usercard")) {
                $("#cardTip").hide()
            }
        }, 300)
    });
    $("img[havecard|=1]").live("mouseenter", function () {
        clearTimeout(outTimer);
        var that = $(this);
        hoverTimer = setTimeout(function () {
            that.personCard()
        }, 300)
    }).live("mouseleave", function () {
        var that = $(this);
        clearTimeout(hoverTimer);
        outTimer = setTimeout(function () {
            if (that.attr("usercard")) {
                $("#cardTip").hide()
            }
        }, 300)
    });
    $("#cardTip").live("mouseenter", function () {
        clearTimeout(outTimer);
        $("#cardTip").show()
    }).live("mouseleave", function () {
        $("#cardTip").hide()
    });
    if (typeof loginUser != "undefined" && loginUser.id) {
        setTimeout(function () {
            $.fn.imTipRun()
        }, 2000);
        $("#js-mesg .close").live("click", function () {
            $.ajax({
                type: "GET",
                url: im20uri("URI_NOTIFICATION_CLEAR_ALL_UNREAD"),
                dataType: "text",
                success: function (data) {
                    if ( !! data) {
                        $("#js-mesg").hide();
                        $("#js-mesg p").hide();
                        im.zm.messageShow = !1
                    }
                }
            })
        })
    }
    $(".picUrl").die().live("click", function () {
        if ((navigator.userAgent.indexOf("MSIE") > 0 && parseInt($.browser.version) < 7) || navigator.userAgent.toLowerCase().match(/iPad/i) == "ipad") {
            return true
        } else {
            var thisParent = $(this).offsetParent().offsetParent();
            if (thisParent.find(".small-label-gift").length > 0) {
                return true
            } else {
                im.zm.detailPic(thisParent.attr("dataid"), thisParent.attr("userid"));
                try {
                    _gaq.push(["_trackPageview", "/ajax/" + uri("URI_SHARE_AJAX", boardPicId)])
                } catch (e) {
                    return false
                }
                return false
            }
        }
    });
    var cursorPosition = {
        get: function (textarea) {
            var rangeData = {
                text: "",
                start: 0,
                end: 0
            };
            if (textarea.setSelectionRange) {
                textarea.focus();
                rangeData.start = textarea.selectionStart;
                rangeData.end = textarea.selectionEnd;
                rangeData.text = (rangeData.start != rangeData.end) ? textarea.value.substring(rangeData.start, rangeData.end) : ""
            } else {
                if (document.selection) {
                    textarea.focus();
                    var i, oS = document.selection.createRange(),
                        oR = document.body.createTextRange();
                    oR.moveToElementText(textarea);
                    rangeData.text = oS.text;
                    rangeData.bookmark = oS.getBookmark();
                    for (i = 0; oR.compareEndPoints("StartToStart", oS) < 0 && oS.moveStart("character", - 1) !== 0; i++) {
                        if (textarea.value.charAt(i) == "/r") {
                            i++
                        }
                    }
                    rangeData.start = i;
                    rangeData.end = rangeData.text.length + rangeData.start
                }
            }
            return rangeData
        },
        set: function (textarea, rangeData) {
            var oR, start, end;
            if (!rangeData) {
                alert("You must get cursor position first.")
            }
            textarea.focus();
            if (textarea.setSelectionRange) {
                textarea.setSelectionRange(rangeData.start, rangeData.end)
            } else {
                if (textarea.createTextRange) {
                    oR = textarea.createTextRange();
                    if (textarea.value.length === rangeData.start) {
                        oR.collapse(false);
                        oR.select()
                    } else {
                        oR.moveToBookmark(rangeData.bookmark);
                        oR.select()
                    }
                }
            }
        },
        add: function (textarea, rangeData, text) {
            var oValue, nValue, oR, sR, nStart, nEnd, st;
            this.set(textarea, rangeData);
            if (textarea.setSelectionRange) {
                oValue = textarea.value;
                nValue = oValue.substring(0, rangeData.start) + text + oValue.substring(rangeData.end);
                nStart = nEnd = rangeData.start + text.length;
                st = textarea.scrollTop;
                textarea.value = nValue;
                if (textarea.scrollTop != st) {
                    textarea.scrollTop = st
                }
                textarea.setSelectionRange(nStart, nEnd)
            } else {
                if (textarea.createTextRange) {
                    sR = document.selection.createRange();
                    sR.text = text;
                    sR.setEndPoint("StartToEnd", sR);
                    sR.select()
                }
            }
        },
        insertPrice: function (textarea, rangeData, text) {
            textarea.focus();
            var start = rangeData.start + 1;
            var end = rangeData.start + 5;
            if (textarea.setSelectionRange) {
                textarea.setSelectionRange(start, end)
            } else {
                var range = document.body.createTextRange();
                range.moveToElementText(textarea);
                range.moveStart("character", start);
                range.moveEnd("character", - (textarea.value.length - start - 4));
                range.select()
            }
        }
    };
    var pos;
    $("#insertTheme1").live("click", function () {
        var _t = this;
        if ($(_t).hasClass("off")) {
            return
        }
        var tag = "";
        pos = cursorPosition.get(document.getElementById("shareDialogTitle"));
        $.ajax({
            type: "GET",
            url: uri("URI_SUBJECT_WEEK_TAG_AJAX"),
            contentType: "text/plain; charset=utf-8",
            dataType: "text",
            success: function (data) {
                var datas = eval("(" + data + ")");
                if (!datas.expired) {
                    cursorPosition.add(document.getElementById("shareDialogTitle"), pos, input = datas.tag)
                }
                $(_t).addClass("off")
            }
        })
    });
    $("#insertprice1").live("click", function () {
        var obj = document.getElementById("shareDialogTitle");
        var pos = cursorPosition.get(obj);
        cursorPosition.add(obj, pos, input = "￥插入价格");
        cursorPosition.insertPrice(obj, pos, "￥插入价格");
        $.fn.countNumber("#shareDialogTitle", {
            scroll: false,
            numberid: 140,
            textareaid: "#shareDialogTitleTotal",
            effactOn: false
        })
    });
    $("#insertprice3").live("click", function () {
        var obj = document.getElementById("editTitle");
        var pos = cursorPosition.get(obj);
        cursorPosition.add(obj, pos, input = "￥插入价格");
        cursorPosition.insertPrice(obj, pos, "￥插入价格")
    });
    $("#insertprice4").live("click", function () {
        var obj = document.getElementById("reshare-ta");
        var pos = cursorPosition.get(obj);
        cursorPosition.add(obj, pos, input = "￥插入价格");
        cursorPosition.insertPrice(obj, pos, "￥插入价格")
    });
    $(document).keydown(function (e) {
        if (e.keyCode == 9 && e.target.nodeName == "A") {
            return false
        }
    });
    $(window).scroll(function () {
        if (im.zm.delayImg) {
            im.zm.delayImg.init(document)
        }
        fnfooter();
        $(document).scrollTop() > 1000 ? $("#backtotop").show().die().live("click", function () {
            $("body,html").animate({
                scrollTop: 0
            }, 500)
        }) : $("#backtotop").hide()
    });
    window.onload = fnfooter;

    function fnfooter() {
        var footObj = document.documentElement || document.body;
        if (document.documentElement.clientHeight < document.body.offsetHeight) {
            $("#footer").removeClass("fixedfooter")
        } else {
            $("#footer").addClass("fixedfooter")
        }
    }
    var reTimers = null;
    $(window).resize(function () {
        if (reTimers !== null) {
            return
        }
        setTimeout(function () {
            reTimers = null;
            fnfooter()
        }, 300)
    })
});