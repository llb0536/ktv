window.KTV={};

(function($) {
  KTV.headnav_css = function() {
    var header0;
    header0 = $('#header0 div div:not(.active)');
    $('img', header0).fadeTo(0, '0.7');
    return header0.mouseenter(function() {
      $('img', this).fadeTo(0, '1');
      return $('a', this).css('color', 'white');
    }).mouseleave(function() {
      $('img', this).fadeTo(0, '0.7');
      return $('a', this).css('color', '#C2C2C2');
    });
  };
})(jQuery);
