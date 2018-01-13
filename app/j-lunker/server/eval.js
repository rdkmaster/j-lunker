
var utils;
if (!utils) {
    utils = require('$svr/utils.js');
}
var template;
if (!template) {
    template = File.readString('$base/template/index.tpl');
}

(function() {
    function getValue(item) {
        item = item.replace(/\+/g, ' ');
        item = decodeURI(item).replace(/%([a-z0-9]{2})/ig, function(found, charCode) {
            return String.fromCharCode(parseInt(charCode, 16));
        });
        var idx = item.indexOf('=');
        idx = idx == -1 ? item.length : idx;
        var key = item.substring(0, idx);
        var value = item.substring(idx + 1);
        return {key: key, value: value};
    }

    function parseEntry(entries, entryString) {
        var parts = entryString.split(/\//g);
        _.each(parts, function(part, index) {
            
        });
        _.find(entries.children, function(item) {
            // return item.
        })
    }

    return {
        post: function(request, script, header) {
            log (request);
            if (!request) {
                Request.completeWithError(400, '400, invalid parameters!');
            }
            var data = request.split('&');
            if (data.length == 0) {
                Request.completeWithError(400, '400, invalid parameters!');
            }

            var privateKey = utils.genPrivateKey();


privateKey = 'frozen-key'

            var entries = {name: 'Project', children: []};
            for(var i = 0; i < data.length; i++) {
                var val = getValue(data[i]);
                var match = val.key.match(/entries\[(.*?)\]\[content\]/);
                if (match) {
                    var path = match[1];
                    entries.push(path);
                    File.save('$web/temp/' + privateKey + '/' + path, val.value);
                }
            }

            if (entries.length == 0) {
                Request.completeWithError(400, '400, no entries found!');
            }

            var indexFile = template.replace('/* will-be-replaced-by-file-list */', JSON.stringify(entries));
            File.save('$web/temp/' + privateKey + '/index.html', indexFile);
            template = '';

            header.put('Content-Type', 'text/html');
            return '<script>location="/app/j-lunker/web/temp/' + privateKey + '/index.html"</script>';
        }
    }

})();
