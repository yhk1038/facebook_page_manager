function scrollToBottom(objDiv) {
    objDiv.scrollTop = objDiv.scrollHeight;
}

function clickable_binding_thread_list() {
    $('.mailbox').unbind().click(function () {
        var ground = $('#messages-main');
        var thread = $(this);
        var uid = thread.data('uid');
        var sender_img = thread.find('img').attr('src');
        var sender_name = thread.find('.lv-title').text();

        $('.mailbox.active').removeClass('active');
        thread.addClass('active');

        var lvh_sender_box = ground.find('.ms-body .listview .lv-header-alt').find('.lvh-label');
        lvh_sender_box.find('img').attr('src', sender_img);
        lvh_sender_box.find('span').text(sender_name);

        $('.each_msg').remove();
        $('#btn-load_more').hide();
        $('.msg_box.preloader-wrapper').addClass('hide');

        $.ajax({
            url: '/messages.js',
            method: 'GET',
            data: {
                authenticity_token: $token,
                thread: {
                    uid: uid
                }
            }
        });
    });
}
$(document).ready(function () {

    clickable_binding_thread_list();





    $('.ms-menu .listview').scroll(function(event){
        var st = $(this).scrollTop();
        var count = $('.ms-menu .listview .mailbox').length;
        var height = parseInt($('.ms-menu .listview .mailbox').css('height').replace('px',''));
        var total_h = count * height - $(this).height() - 100;

        var preloader = $('.thread_list.preloader-wrapper');
        var page_next_token = preloader.data('next_token');
        var page_uid = $(this).data('page_uid');

        if (page_next_token && page_next_token.length > 10){
            if (st > total_h && preloader.css('display') === 'none'){
                preloader.show();

                $.ajax({
                    url: '/msg_threads/more.js',
                    method: 'POST',
                    data: {
                        authenticity_token: $token,
                        page: {
                            uid: page_uid,
                            next: page_next_token
                        }
                    }
                });
            }
        } else {
            console.log('Next token does not exist anymore.')
        }
    });
});