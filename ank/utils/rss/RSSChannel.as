// Action script...

// [Initial MovieClip Action of sprite 20623]
#initclip 144
if (!ank.utils.rss.RSSChannel)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    if (!ank.utils.rss)
    {
        _global.ank.utils.rss = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.rss.RSSChannel = function ()
    {
        this.initialize();
    }).prototype;
    _loc1.parse = function (xChannelNode)
    {
        this.initialize();
        if (xChannelNode.nodeName.toLowerCase() != "channel")
        {
            return (false);
        } // end if
        for (var _loc3 = xChannelNode.firstChild; _loc3 != null; _loc3 = _loc3.nextSibling)
        {
            switch (_loc3.nodeName.toLowerCase())
            {
                case "title":
                {
                    this._sTitle = _loc3.childNodes.join("");
                    break;
                } 
                case "link":
                {
                    this._sLink = _loc3.childNodes.join("");
                    break;
                } 
                case "description":
                {
                    this._sDescription = _loc3.childNodes.join("");
                    break;
                } 
                case "language":
                {
                    this._sLanguage = _loc3.childNodes.join("");
                    break;
                } 
                case "pubdate":
                {
                    this._sPubDate = _loc3.childNodes.join("");
                    this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0, 25), "E, d MMM yyyy H:m:s");
                    break;
                } 
                case "lastbuilddate":
                {
                    this._sLastBuildDate = _loc3.childNodes.join("");
                    this._dLastBuildDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sLastBuildDate.substr(0, 25), "E, d MMM yyyy H:m:s");
                    break;
                } 
                case "docs":
                {
                    this._sDocs = _loc3.childNodes.join("");
                    break;
                } 
                case "generator":
                {
                    this._sGenerator = _loc3.childNodes.join("");
                    break;
                } 
                case "managingeditor":
                {
                    this._sManagingEditor = _loc3.childNodes.join("");
                    break;
                } 
                case "webmaster":
                {
                    this._sWebMaster = _loc3.childNodes.join("");
                    break;
                } 
                case "item":
                {
                    var _loc4 = new ank.utils.rss.RSSItem();
                    if (_loc4.parse(_loc3))
                    {
                        this._aItems.push(_loc4);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end of for
        return (true);
    };
    _loc1.toString = function ()
    {
        return ("RSSChannel title:" + this._sTitle + "\tlink:" + this._sLink + "\tdescription:" + this._dPubDate + "\tlanguage:" + this._dPubDate + "\tpubdate:" + this._dPubDate + "\tlastbuilddate:" + this._dPubDate + "\tdocs:" + this._dPubDate + "\tgenerator:" + this._dPubDate + "\tmanagingeditor:" + this._dPubDate + "\twebmaster:" + this._dPubDate + "\titems:" + this._aItems.join("\n"));
    };
    _loc1.getTitle = function ()
    {
        return (this._sTitle);
    };
    _loc1.getLink = function ()
    {
        return (this._sLink);
    };
    _loc1.getDescription = function ()
    {
        return (this._sDescription);
    };
    _loc1.getLanguage = function ()
    {
        return (this._sLanguage);
    };
    _loc1.getPubDate = function ()
    {
        return (this._dPubDate);
    };
    _loc1.getPubDateStr = function (sFormat, sLanguage)
    {
        return (this._dPubDate == null ? (this._sPubDate) : (org.utils.SimpleDateFormatter.formatDate(this._dPubDate, sFormat, sLanguage)));
    };
    _loc1.getLastBuildDate = function ()
    {
        return (this._dLastBuildDate);
    };
    _loc1.getLastBuildDateStr = function (sFormat, sLanguage)
    {
        return (this._dLastBuildDate == null ? (this._sLastBuildDate) : (org.utils.SimpleDateFormatter.formatDate(this._dLastBuildDate, sFormat, sLanguage)));
    };
    _loc1.getDocs = function ()
    {
        return (this._sDocs);
    };
    _loc1.getGenerator = function ()
    {
        return (this._sGenerator);
    };
    _loc1.getManagingEditor = function ()
    {
        return (this._sManagingEditor);
    };
    _loc1.getWebMaster = function ()
    {
        return (this._sWebMaster);
    };
    _loc1.getItems = function ()
    {
        return (this._aItems);
    };
    _loc1.initialize = function ()
    {
        this._sTitle = "";
        this._sLink = "";
        this._sDescription = "";
        this._sLanguage = "";
        this._dPubDate = null;
        this._dLastBuildDate = null;
        this._sDocs = "";
        this._sGenerator = "";
        this._sManagingEditor = "";
        this._sWebMaster = "";
        this._aItems = new Array();
    };
    _loc1.parseDate = function (sDate)
    {
        return (new Date());
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
