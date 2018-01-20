(function() {
	return {
		post: function(req) {
			var path = 'www/' + req.path;
			File.save(path, req.content);
			return 1;
		}
	}
})();