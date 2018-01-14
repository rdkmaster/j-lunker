(function() {
	return {
		post: function(req) {
			log(req.path);
			return 1;
		}
	}
})();