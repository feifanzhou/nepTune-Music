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