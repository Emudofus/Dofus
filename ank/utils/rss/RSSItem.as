// Action script...

// [Initial MovieClip Action of sprite 20816]
#initclip 81
if (!ank.utils.rss.RSSItem)
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
    var _loc1 = (_global.ank.utils.rss.RSSItem = function ()
    {
    }).prototype;
    _loc1.parse = function (xItemNode)
    {
        this.initialize();
        if (xItemNode.nodeName.toLowerCase() != "item")
        {
            return (false);
        } // end if
        for (var _loc3 = xItemNode.firstChild; _loc3 != null; _loc3 = _loc3.nextSibling)
        {
            switch (_loc3.nodeName.toLowerCase())
            {
                case "title":
                {
                    this._sTitle = _loc3.childNodes.join("");
                    var _loc4 = this._sTitle.split("&apos;");
                    this._sTitle = _loc4.join("\'");
                    break;
                } 
                case "link":
                {
                    this._sLink = _loc3.childNodes.join("");
                    break;
                } 
                case "pubdate":
                {
                    this._sPubDate = _loc3.childNodes.join("");
                    this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0, 25), "E, d MMM yyyy H:m:s");
                    if (this._dPubDate == null)
                    {
                        this._dPubDate = org.utils.SimpleDateFormatter.getDateFromFormat(this._sPubDate.substr(0, 25), "E,  d MMM yyyy H:m:s");
                    } // end if
                    this.sortByDate = org.utils.SimpleDateFormatter.formatDate(this._dPubDate, "yyyyMMdd");
                    break;
                } 
                case "guid":
                {
                    this._sGuid = _loc3.childNodes.join("");
                    break;
                } 
                case "icon":
                {
                    this._sIcon = _loc3.childNodes.join("");
                    break;
                } 
            } // End of switch
        } // end of for
        return (true);
    };
    _loc1.toString = function ()
    {
        return ("RSSItem title:" + this._sTitle + "\tlink:" + this._sLink + "\tpubdate:" + this._dPubDate + "\tguid:" + this._sGuid);
    };
    _loc1.getTitle = function ()
    {
        return (this._sTitle);
    };
    _loc1.getLink = function ()
    {
        return (this._sLink);
    };
    _loc1.getPubDate = function ()
    {
        return (this._dPubDate);
    };
    _loc1.getPubDateStr = function (sFormat, sLanguage)
    {
        return (this._dPubDate == null ? (this._sPubDate) : (org.utils.SimpleDateFormatter.formatDate(this._dPubDate, sFormat, sLanguage)));
    };
    _loc1.getGuid = function ()
    {
        return (this._sGuid);
    };
    _loc1.getIcon = function ()
    {
        return (this._sIcon);
    };
    _loc1.initialize = function ()
    {
        this._sTitle = "";
        this._sLink = "";
        this._dPubDate = null;
        this._sGuid = "";
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
