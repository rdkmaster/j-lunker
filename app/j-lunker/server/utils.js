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
    
    return {
        randomString: _randomString,
        randomNumber: _random,
        genPrivateKey: _genPrivateKey
    }
})();