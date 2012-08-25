// Action script...

// [Initial MovieClip Action of sprite 20892]
#initclip 157
if (!dofus.utils.DofusConfiguration)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.DofusConfiguration = function ()
    {
        if (_global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] == undefined)
        {
            _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME);
        } // end if
    }).prototype;
    _loc1.__set__dataServers = function (aHosts)
    {
        this._aDataServers = aHosts;
        //return (this.dataServers());
    };
    _loc1.__get__dataServers = function ()
    {
        return (this._aDataServers);
    };
    _loc1.__set__language = function (sLanguage)
    {
        _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language = sLanguage;
        //return (this.language());
    };
    _loc1.__get__language = function ()
    {
        var _loc2 = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME].data.language;
        if (_loc2 == undefined || (_loc2 == "undefined" || _root.htmlLang != undefined))
        {
            if (_root.htmlLang != undefined)
            {
                var _loc3 = _root.htmlLang;
            }
            else
            {
                _loc3 = System.capabilities.language;
            } // end else if
            switch (_loc3)
            {
                case "fr":
                case "en":
                case "de":
                case "pt":
                case "ru":
                case "nl":
                case "es":
                case "it":
                {
                    return (_loc3);
                } 
            } // End of switch
            return ("en");
        }
        else
        {
            return (_loc2.toLowerCase());
        } // end else if
    };
    _loc1.__set__languages = function (aLanguages)
    {
        this._aLanguages = aLanguages;
        //return (this.languages());
    };
    _loc1.__get__languages = function ()
    {
        var _loc2 = new Array();
        if (this._aXmlLanguages != undefined)
        {
            var _loc3 = 0;
            
            while (++_loc3, _loc3 < this._aXmlLanguages.length)
            {
                _loc2.push(this._aXmlLanguages[_loc3]);
            } // end while
        } // end if
        if (this._aLanguages != undefined)
        {
            var _loc4 = 0;
            
            while (++_loc4, _loc4 < this._aLanguages.length)
            {
                var _loc5 = false;
                var _loc6 = 0;
                
                while (++_loc6, _loc6 < this._aXmlLanguages.length)
                {
                    if (this._aXmlLanguages[_loc6] == this._aLanguages[_loc4])
                    {
                        _loc5 = true;
                    } // end if
                } // end while
                if (!_loc5)
                {
                    _loc2.push(this._aLanguages[_loc4]);
                } // end if
            } // end while
        } // end if
        return (_loc2);
    };
    _loc1.__set__xmlLanguages = function (a)
    {
        this._aXmlLanguages = a;
        //return (this.xmlLanguages());
    };
    _loc1.__get__xmlLanguages = function ()
    {
        return (this._aXmlLanguages);
    };
    _loc1.__set__skipLanguageVerification = function (b)
    {
        this._bSkipLanguageVerification = b;
        //return (this.skipLanguageVerification());
    };
    _loc1.__get__skipLanguageVerification = function ()
    {
        return (this._bSkipLanguageVerification);
    };
    _loc1.__set__cacheAsBitmap = function (aCache)
    {
        this._aCacheAsBitmap = aCache;
        //return (this.cacheAsBitmap());
    };
    _loc1.__get__cacheAsBitmap = function ()
    {
        return (this._aCacheAsBitmap);
    };
    _loc1.__set__isExpo = function (bExpo)
    {
        this._bIsExpo = bExpo;
        //return (this.isExpo());
    };
    _loc1.__get__isExpo = function ()
    {
        return (this._bIsExpo);
    };
    _loc1.__set__isStreaming = function (bStreaming)
    {
        this._bIsStreaming = bStreaming;
        //return (this.isStreaming());
    };
    _loc1.__get__isStreaming = function ()
    {
        return (this._bIsStreaming);
    };
    _loc1.__set__streamingMethod = function (sName)
    {
        this._sStreamingMethod = sName;
        //return (this.streamingMethod());
    };
    _loc1.__get__streamingMethod = function ()
    {
        return (this._sStreamingMethod);
    };
    _loc1.__get__isLinux = function ()
    {
        return (String(System.capabilities.version).indexOf("LNX") > -1);
    };
    _loc1.__get__isWindows = function ()
    {
        return (String(System.capabilities.version).indexOf("WIN") > -1);
    };
    _loc1.__get__isMac = function ()
    {
        return (String(System.capabilities.version).indexOf("MAC") > -1);
    };
    _loc1.getCustomIP = function (nServerID)
    {
        return (this.customServersIP[nServerID]);
    };
    _loc1.addProperty("xmlLanguages", _loc1.__get__xmlLanguages, _loc1.__set__xmlLanguages);
    _loc1.addProperty("dataServers", _loc1.__get__dataServers, _loc1.__set__dataServers);
    _loc1.addProperty("language", _loc1.__get__language, _loc1.__set__language);
    _loc1.addProperty("isLinux", _loc1.__get__isLinux, function ()
    {
    });
    _loc1.addProperty("isStreaming", _loc1.__get__isStreaming, _loc1.__set__isStreaming);
    _loc1.addProperty("cacheAsBitmap", _loc1.__get__cacheAsBitmap, _loc1.__set__cacheAsBitmap);
    _loc1.addProperty("isExpo", _loc1.__get__isExpo, _loc1.__set__isExpo);
    _loc1.addProperty("skipLanguageVerification", _loc1.__get__skipLanguageVerification, _loc1.__set__skipLanguageVerification);
    _loc1.addProperty("isMac", _loc1.__get__isMac, function ()
    {
    });
    _loc1.addProperty("streamingMethod", _loc1.__get__streamingMethod, _loc1.__set__streamingMethod);
    _loc1.addProperty("languages", _loc1.__get__languages, _loc1.__set__languages);
    _loc1.addProperty("isWindows", _loc1.__get__isWindows, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1._bIsStreaming = false;
} // end if
#endinitclip
