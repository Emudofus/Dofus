// Action script...

// [Initial MovieClip Action of sprite 20855]
#initclip 120
if (!dofus.datacenter.Document)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Document = function (mcSwfData)
    {
        super();
        this.initialize(mcSwfData);
    }).prototype;
    _loc1.__get__uiType = function ()
    {
        switch (this._sType)
        {
            case "book":
            {
                return ("DocumentBook");
            } 
            case "parchment":
            {
                return ("DocumentParchment");
            } 
            case "roadsignleft":
            {
                return ("DocumentRoadSignLeft");
            } 
            case "roadsignright":
            {
                return ("DocumentRoadSignRight");
            } 
        } // End of switch
    };
    _loc1.__get__title = function ()
    {
        return (this._sTitle);
    };
    _loc1.__get__subtitle = function ()
    {
        return (this._sSubTitle);
    };
    _loc1.__get__author = function ()
    {
        return (this._sAuthor);
    };
    _loc1.__get__pageCount = function ()
    {
        return (this._aPages.length);
    };
    _loc1.initialize = function (mcSwfData)
    {
        this.api = _global.API;
        this._sType = mcSwfData.type;
        this._sTitle = mcSwfData.title;
        this._sSubTitle = mcSwfData.subtitle;
        this._sAuthor = mcSwfData.author;
        this._sCSS = dofus.Constants.STYLES_PATH + mcSwfData.style + ".css";
        this._aChapters = mcSwfData.chapters;
        this._aPages = new ank.utils.ExtendedArray();
        switch (this._sType)
        {
            case "book":
            {
                var _loc3 = 1;
                if (this._sTitle != undefined)
                {
                    this._aPages.push({type: "blank"});
                    this._aPages.push({type: "title", num: _loc3++, title: this._sTitle, subtitle: this._sSubTitle, author: this._sAuthor});
                } // end if
                var _loc4 = new Object();
                var _loc5 = this._aChapters.length;
                if (_loc5 != 0 && this._aChapters != undefined)
                {
                    this._aPages.push({type: "blank", num: _loc3++});
                    var _loc6 = 0;
                    for (var _loc7 = 0; _loc6 < _loc5; ++_loc7)
                    {
                        var _loc8 = this._aChapters.slice(_loc6, _loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE);
                        this._aPages.push({type: "index", num: _loc3++, chapters: _loc8});
                        _loc6 = _loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE;
                    } // end of for
                    if (_loc7 % 2 == 0)
                    {
                        this._aPages.push({type: "blank", num: _loc3++});
                    } // end if
                    for (var k in this._aChapters)
                    {
                        _loc4[this._aChapters[k][1]] = this._aChapters[k];
                    } // end of for...in
                } // end if
                var _loc9 = mcSwfData.pages;
                var _loc10 = _loc9.length;
                if (_loc10 != 0)
                {
                    this._aPages.push({type: "blank", num: _loc3++});
                    var _loc11 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
                    var _loc12 = 0;
                    
                    while (++_loc12, _loc12 < _loc10)
                    {
                        var _loc13 = new String();
                        if (_loc4[_loc12] != undefined)
                        {
                            if (_loc4[_loc12][2] && _loc3 % 2 == 0)
                            {
                                this._aPages.push({type: "blank", num: _loc3++});
                            } // end if
                            _loc4[_loc12][4] = _loc3;
                            if (_loc4[_loc12][3])
                            {
                                _loc13 = "<br/><p class=\'chapter\'>" + _loc4[_loc12][0] + "</p><br/>";
                            } // end if
                        } // end if
                        _loc9[_loc12] = ank.utils.PatternDecoder.replace(_loc9[_loc12], _loc11);
                        this._aPages.push({type: "text", num: _loc3++, text: _loc13 + _loc9[_loc12], cssFile: this._sCSS});
                    } // end while
                } // end if
                break;
            } 
            case "parchment":
            case "roadsignleft":
            case "roadsignright":
            {
                var _loc14 = mcSwfData.pages[0];
                var _loc15 = this.api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
                _loc14 = ank.utils.PatternDecoder.replace(_loc14, _loc15);
                this._aPages.push({text: _loc14, cssFile: this._sCSS});
                break;
            } 
        } // End of switch
    };
    _loc1.getPage = function (nPageNum)
    {
        return (this._aPages[nPageNum]);
    };
    _loc1.addProperty("author", _loc1.__get__author, function ()
    {
    });
    _loc1.addProperty("title", _loc1.__get__title, function ()
    {
    });
    _loc1.addProperty("pageCount", _loc1.__get__pageCount, function ()
    {
    });
    _loc1.addProperty("subtitle", _loc1.__get__subtitle, function ()
    {
    });
    _loc1.addProperty("uiType", _loc1.__get__uiType, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.datacenter.Document = function (mcSwfData)
    {
        super();
        this.initialize(mcSwfData);
    }).MAX_CHAPTER_ON_PAGE = 13;
} // end if
#endinitclip
