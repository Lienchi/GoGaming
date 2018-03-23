; (function ($) {
    'use strict';
    var $body   = $('html, body'),
        content = $('#main').smoothState({
        onStart: {
            duration: 250,
            render: function (url, $container) {
                content.toggleAnimationClass('is-exiting');
                $body.animate({ 'scrollTop': 0 });
            }
        }
    }).data('smoothState');
})(jQuery);