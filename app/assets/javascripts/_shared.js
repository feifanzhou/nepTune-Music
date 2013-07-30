$('body').djax('.DJAX', ['login', 'logout', '#', 'join?status', 'leave']);

function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";
    document.cookie = escape(name) + "=" + escape(value) + expires + "; path=/";
}

function readCookie(name) {
    var nameEQ = escape(name) + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return unescape(c.substring(nameEQ.length, c.length));
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

function getArtistNameFromURL() {
    return document.URL.split("/")[3];
}

function getEventIDFromURL() {
    var c = document.URL.split('/')[4];
    return c.split('?')[0];
}

function JSONFromID(v_id) {
    return JSON.parse(document.getElementById(v_id).contentWindow.document.body.textContent);
}

function youtubeEmbedForURL(ytURL) {
    var v_id_param_index = ytURL.indexOf('?v=');
    if (v_id_param_index < 0)
        return false;
    var v_id = ytURL.slice(v_id_param_index + 3);
    var embed = 'http://www.youtube.com/embed/' + v_id + '?rel=0';
    return embed;
}

function youtubeIframeForURL(ytURL, width, height) {
    // http://stackoverflow.com/a/894877/472768
    width = typeof width !== 'undefined' ? width : 239;
    height = typeof height !== 'undefined' ? height : 132;
    var embedURL = youtubeEmbedForURL(ytURL);
    return "<iframe width='" + width + "' height='" + height + "' src='" + embedURL + "' frameborder='0' allowfullscreen></iframe>";
}
