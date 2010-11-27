$(document).ready(function() {
    $('#micropost_content').keyup(
                                 function(event) {
                                     updateCnt(event,$(this));
                                 });
});

function updateCnt(event,textarea) {    
    var maxlength = textarea.attr('maxlength');
    var messageLength = textarea.val().length
    if (messageLength >= maxlength) {
        textarea.val(textarea.val().substr(0, maxlength));
//        event.preventDefault();
    }
    $('#symbolsCnt').text(maxlength - messageLength)
}