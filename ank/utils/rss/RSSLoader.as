// Action script...

// [Initial MovieClip Action of sprite 20487]
#initclip 8
if (!ank.utils.rss.RSSLoader)
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
    var _loc1 = (_global.ank.utils.rss.RSSLoader = function ()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this.ignoreWhite = true;
        this.initialize();
    }).prototype;
    _loc1.__get__data = function ()
    {
        return (this._oData);
    };
    _loc1.getChannels = function ()
    {
        return (this._aChannels);
    };
    _loc1.load = function (sUrl, oData)
    {
        super.load(sUrl);
        this._oData = oData;
    };
    _loc1.initialize = function ()
    {
        this._aChannels = new Array();
    };
    _loc1.parse = function ()
    {
        this.initialize();
        if (this.childNodes.length == 0)
        {
            return (false);
        } // end if
        var _loc2 = this.firstChild;
        if (_loc2.nodeName.toLowerCase() != "rss")
        {
            return (false);
        } // end if
        for (var _loc3 = _loc2.firstChild; _loc3 != null; _loc3 = _loc3.nextSibling)
        {
            if (_loc3.nodeName.toLowerCase() == "channel")
            {
                var _loc4 = new ank.utils.rss.RSSChannel();
                if (_loc4.parse(_loc3))
                {
                    this._aChannels.push(_loc4);
                } // end if
            } // end if
        } // end of for
        return (true);
    };
    _loc1.onLoad = function (bSuccess)
    {
        if (bSuccess)
        {
            if (this.parse())
            {
                this.dispatchEvent({type: "onRSSLoaded", data: this._oData});
            }
            else
            {
                this.dispatchEvent({type: "onBadRSSFile", data: this._oData});
            } // end else if
        }
        else
        {
            this.dispatchEvent({type: "onRSSLoadError", data: this._oData});
        } // end else if
    };
    _loc1.addProperty("data", _loc1.__get__data, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
