
var utils;
if (!utils) {
    utils = require('$svr/utils.js');
}
var template;
if (!template) {
    template = File.readString('$base/template/j-lunker-run.tpl');
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

    function parseEntry(entries, entryParts) {
        var part = entryParts.shift();
        if (!part) {
            return;
        }
        var isFolder = entryParts.length > 0;
        var found = _.find(entries.children, function(item) {
            return isFolder == !!item.children && item.name == part;
        });
        if (!found) {
            found = {name: part};
            if (isFolder) {
                found.children = [];
            }
            entries.children.push(found);
        }
        if (isFolder) {
            parseEntry(found, entryParts);
        }
    }

    function createCodeTree(entry, parentPath) {
        parentPath = parentPath ? parentPath : '';
        var iconType = entry.hasOwnProperty('children') ? 'folder-open' : 'file';
        var isFolder = iconType === 'folder-open';
        var targetId = utils.randomNumber(10000000, 99999999);
        var selfId = utils.randomNumber(10000000, 99999999);
        var res = '<li id="' + selfId + '"';
        if (isFolder) {
            res += ' onclick="toggleFolder(' + selfId + ',' + targetId + ')" ';
        } else {
            res += ' onclick="loadFile(' + selfId + ',\'' + parentPath + '\')" ';
        }
        res += '><i class="far fa-' + iconType + '"></i> ' + entry.name + '</li>';

        if (isFolder) {
            res += '<li id="' + targetId + '"><ul>';
            _.each(entry.children, function(item) {
                res += createCodeTree(item, parentPath + '/' + item.name);
            });
            res += '</ul></li>';
        }
        return res;
    }

    return {
        post: function(request, script, header) {
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
                    parseEntry(entries, path.split(/\//g));
                    File.save('$web/temp/' + privateKey + '/' + path, val.value);
                }
            }

            if (entries.children.length == 0) {
                Request.completeWithError(400, '400, no entries found!');
            }

            var folder = 'app/j-lunker/web/temp/' + privateKey;
            var indexFile = template.replace('/* to-be-replaced-with-file-list */', JSON.stringify(entries))
                                    .replace('/* to-be-replaced-with-folder */', '"' + folder + '"')
                                    .replace('<!-- to-be-replaced-with-code-tree -->', createCodeTree(entries))
            File.save('$web/temp/' + privateKey + '/j-lunker-run.html', indexFile);
            template = '';

            header.put('Content-Type', 'text/html');
            return '<script>window.open("/' + folder + '/j-lunker-run.html", "_self")</script>';
        }
    }

})();
