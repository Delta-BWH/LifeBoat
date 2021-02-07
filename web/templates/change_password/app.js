(function ($) {
    $.fn.wrongInput = function () {
        return this.each(function () {
            var $this = $(this),
                $field = $this.is("input.txt") || $this.is("input[type=text]") ? $this : $this.find("input.txt"),
                rmWrng = function ($field) {
                    $field.removeClass('wronginput');
                };
            if ($field.hasClass('wronginput')) {
                return
            }
            $field.addClass('wronginput');
            $field.one('input', function () {
                rmWrng($field);
            });
        });
    };
})(Zepto);

$(document).ready(function () {
    function createPopup(text, type) {
        var $popup = $("<div class='popup'></div>"),
            $body = $('body');
        if (type) {
            $popup.addClass(type);
        }
        $popup.text(text);
        if ($body.find('.popup').length) {
            $('.popup').remove();
        }
        $body.append($popup);
        $popup.animate({
            right: '20px',
            opacity: 0.8
        }, 500, 'ease-out');
        setTimeout(function () {
            $popup.animate({
                right: '-' + $popup.width() + 'px',
                opacity: 0
            }, 500, 'ease-out');
            setTimeout(function () {
                $popup.remove();
            }, 500);
        }, 3000);
    }

    $('#savePass').on('click', function () {
        var passwordVal = $('#password').val().trim(),
            $confpassword = $('#confpassword'),
            $container = $('.regsuccess'),
            $ul = $container.find('ul'),
            confpasswordVal = $confpassword.val().trim();
        if (passwordVal.length && passwordVal != confpasswordVal) {
            $confpassword.wrongInput();
            createPopup('Passwords do not match!', 'error');
        } else if(!passwordVal.length) {
            createPopup('Password cannot be empty!', 'error');
        } else {
            $.ajax({
                type: "POST",
                url: location.href,
                contentType: 'application/json',
                data: JSON.stringify({
                    password: passwordVal
                }),
                success: function () {
                    createPopup('Password changed successfully', 'success');
                    $ul.remove();
                    $container.find('h3').text('Password changed').after('<img src="img/success.png">');
                },
                error: function (error) {
                    createPopup(error.responseText, 'error');
                }
            });
        }
    });
});