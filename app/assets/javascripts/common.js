jQuery.noConflict();
var j$ = jQuery;


// alert messages

j$(document).ready(function () {

    j$('.x').click(function () {
        j$('.flash').fadeOut("slow")
    });

});
