// Action script...

// [Initial MovieClip Action of sprite 20797]
#initclip 62
if (!ank.utils.XMLLoader)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.utils)
    {
        _global.ank.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.utils.XMLLoader = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.initialize = function ()
    {
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.loadXML = function (file)
    {
        this._xmlDoc = new XML();
        this._xmlDoc.ignoreWhite = true;
        var _owner = this;
        this._xmlDoc.onLoad = function (bSuccess)
        {
            if (bSuccess)
            {
                _owner.dispatchEvent({type: "onXMLLoadComplete", value: this});
            }
            else
            {
                _owner.dispatchEvent({type: "onXMLLoadError"});
            } // end else if
        };
        this._xmlDoc.load(file);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
