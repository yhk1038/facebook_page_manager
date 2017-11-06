function scrollToBottom(objDiv) {
    objDiv.scrollTop = objDiv.scrollHeight;
}

$(document).ready(function () {

    $('.mailbox').click(function () {
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
});