(function() {
    function _genPrivateKey() {
        return _randomString(8) + '-' + _randomString(8) + '-' + _randomString(8) + '-' + _randomString(8);
    }

    var CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var CHARS_LEN = CHARS.length - 1;

    function _random(min, max, isFloat) {
        var r = Math.random() * 1000000;
        if (isFloat) {
            r = r % (max - min);
        } else {
            r = Math.round(r);
            r = r % (max - min + 1);
        }
        r += min;
        return r;
    }

    function _randomString(length) {
        var s = '';
        for (var i = 0; i < length; i++) {
            s += CHARS[_random(0, CHARS_LEN)];
        }
        return s;
    }

    function _getOwner(privateKey) {
        var owner = _checkOwner();
        if (!owner.hasOwnProperty('error')) {
            return owner;
        }
        if (!privateKey) {
            // error
            return owner;
        }

        owner = Cache.get(privateKey);
        if (owner) {
            return owner;
        }
        
        var r = Data.fetch('select id from user where private_key="' + privateKey + '"');
        if (r.hasOwnProperty('error') || r.data.length == 0) {
            Log.error('unable to get id from privateKey[' + privateKey + '], detail: ' + r);
            return {error: 469, detail: 'invalid private key'};
        }
        owner = r.data[0][0];
        Cache.put(privateKey, owner);
        return owner;
    }
    
    return {
        randomString: _randomString,
        randomNumber: _random,
        genPrivateKey: _genPrivateKey,
        getOwner: _getOwner
    }
})();