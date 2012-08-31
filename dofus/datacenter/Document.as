// Action script...

// [Initial MovieClip Action of sprite 889]
#initclip 101
class dofus.datacenter.Document extends Object
{
    var _sType, _sTitle, _sSubTitle, _sAuthor, _aPages, api, _sCSS, _aChapters, __get__author, __get__pageCount, __get__subtitle, __get__title, __get__uiType;
    function Document(mcSwfData)
    {
        super();
        this.initialize(mcSwfData);
    } // End of the function
    function get uiType()
    {
        switch (_sType)
        {
            case "book":
            {
                return ("DocumentBook");
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
    } // End of the function
    function get title()
    {
        return (_sTitle);
    } // End of the function
    function get subtitle()
    {
        return (_sSubTitle);
    } // End of the function
    function get author()
    {
        return (_sAuthor);
    } // End of the function
    function get pageCount()
    {
        return (_aPages.length);
    } // End of the function
    function initialize(mcSwfData)
    {
        api = _global.API;
        _sType = mcSwfData.type;
        _sTitle = mcSwfData.title;
        _sSubTitle = mcSwfData.subtitle;
        _sAuthor = mcSwfData.author;
        _sCSS = dofus.Constants.STYLES_PATH + mcSwfData.style + ".css";
        _aChapters = mcSwfData.chapters;
        _aPages = new ank.utils.ExtendedArray();
        switch (_sType)
        {
            case "book":
            {
                var _loc5 = 1;
                if (_sTitle != undefined)
                {
                    _aPages.push({type: "blank"});
                    _aPages.push({type: "title", num: _loc5++, title: _sTitle, subtitle: _sSubTitle, author: _sAuthor});
                } // end if
                var _loc4 = new Object();
                var _loc13 = _aChapters.length;
                if (_loc13 != 0 && _aChapters != undefined)
                {
                    _aPages.push({type: "blank", num: _loc5++});
                    var _loc6 = 0;
                    for (var _loc14 = 0; _loc6 < _loc13; ++_loc14)
                    {
                        var _loc9 = _aChapters.slice(_loc6, _loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE);
                        _aPages.push({type: "index", num: _loc5++, chapters: _loc9});
                        _loc6 = _loc6 + dofus.datacenter.Document.MAX_CHAPTER_ON_PAGE;
                    } // end of for
                    if (_loc14 % 2 == 0)
                    {
                        _aPages.push({type: "blank", num: _loc5++});
                    } // end if
                    for (var _loc17 in _aChapters)
                    {
                        _loc4[_aChapters[_loc17][1]] = _aChapters[_loc17];
                    } // end of for...in
                } // end if
                var _loc8 = mcSwfData.pages;
                var _loc15 = _loc8.length;
                if (_loc15 != 0)
                {
                    _aPages.push({type: "blank", num: _loc5++});
                    var _loc19 = api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
                    for (var _loc3 = 0; _loc3 < _loc15; ++_loc3)
                    {
                        var _loc7 = new String();
                        if (_loc4[_loc3] != undefined)
                        {
                            if (_loc4[_loc3][2] && _loc5 % 2 == 0)
                            {
                                _aPages.push({type: "blank", num: _loc5++});
                            } // end if
                            _loc4[_loc3][4] = _loc5;
                            if (_loc4[_loc3][3])
                            {
                                _loc7 = "<br/><p class=\'chapter\'>" + _loc4[_loc3][0] + "</p><br/>";
                            } // end if
                        } // end if
                        _loc8[_loc3] = ank.utils.PatternDecoder.replace(_loc8[_loc3], _loc19);
                        _aPages.push({type: "text", num: _loc5++, text: _loc7 + _loc8[_loc3], cssFile: _sCSS});
                    } // end of for
                } // end if
                break;
            } 
            case "roadsignleft":
            case "roadsignright":
            {
                var _loc18 = mcSwfData.pages[0];
                _loc19 = api.kernel.DocumentsServersManager.getCurrentServer() + "#1/#2.#1";
                _loc18 = ank.utils.PatternDecoder.replace(_loc18, _loc19);
                _aPages.push({text: _loc18, cssFile: _sCSS});
                break;
            } 
        } // End of switch
    } // End of the function
    function getPage(nPageNum)
    {
        return (_aPages[nPageNum]);
    } // End of the function
    static var MAX_CHAPTER_ON_PAGE = 13;
} // End of Class
#endinitclip
