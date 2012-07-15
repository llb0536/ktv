App.search_css = ->
  $('#searchinput').focus( ->
    $('#searchbox').addClass('focused')
  ).blur( ->
    $('#searchbox').removeClass('focused')
  )
  $('#searchinput').placeholder();
App.headnav_css = ->
  list = $('.no-csstransitions #headnav_content div:not(.selected) a')
  list.fadeTo(0,'0.7')
  list.mouseenter(->
    $(this).fadeTo(250,'1')
  ).mouseleave(->
    $(this).fadeTo(250,'0.7')
  )
  header0 = $('#header0 div div:not(.active)')
  $('img',header0).fadeTo(0,'0.7')
  header0.mouseenter(->
    $('img',this).fadeTo(0,'1')
    $('a',this).css('color','white');
  ).mouseleave(->
    $('img',this).fadeTo(0,'0.7')
    $('a',this).css('color','#C2C2C2');
  )

App.logo_css = ->
  $('#logolink').hover(->
    $('#logotext').attr('src',App.logo_css_src1)
  ,->
    $('#logotext').attr('src',App.logo_css_src0)
  )
