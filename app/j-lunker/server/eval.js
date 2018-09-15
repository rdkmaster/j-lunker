(function() {

    var utils = require('$svr/utils.js');
    var template = File.readString('app/j-lunker/template/j-lunker-run.html.tpl');
    var mainJs = File.readString('app/j-lunker/template/main.js');

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
            res += ' onclick="loadFile(' + selfId + ')" x-file="' + parentPath + '"';
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
            var options = [];
            var entries = {name: 'Project', children: []};
            var title = 'J-lunker - The online evaluator';
            for(var i = 0; i < data.length; i++) {
                var val = getValue(data[i]);
                var match = val.key.match(/entries\[(.*?)\]\[content\]/);
                if (match) {
                    var path = match[1];
                    parseEntry(entries, path.split(/\//g));
                    File.save('www/j-lunker/job/' + privateKey + '/' + path, val.value);
                }
                match = val.key.match(/option\[(.*?)\]/);
                if (match) {
                    options.push(match[1] + '=' + encodeURI(val.value));
                }
                if (val.key == 'title') {
                    title = val.value;
                }
            }

            if (entries.children.length == 0) {
                Request.completeWithError(400, '400, no entries found!');
            }

            var folder = 'j-lunker/job/' + privateKey;
            var indexFile = template.replace('/* to-be-replaced-with-file-list */', JSON.stringify(entries))
                                    .replace('/* to-be-replaced-with-folder */', '"' + folder + '"')
                                    .replace('<!-- to-be-replaced-with-file-tree -->', createCodeTree(entries))
                                    .replace(/<!-- to-be-replaced-with-title -->/g, title)
            File.save('www/j-lunker/job/' + privateKey + '/j-lunker-run.html', indexFile);
            File.save('www/j-lunker/job/' + privateKey + '/main.js', mainJs);

            header.put('Content-Type', 'text/html');
            options = options.length > 0 ? '?' + options.join('&') : '';
            return '<script>window.open("/' + folder + '/j-lunker-run.html' + options + '", "_self")</script>';
        }
    }

})();
