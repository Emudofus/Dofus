// Action script...

// [Initial MovieClip Action of sprite 20522]
#initclip 43
if (!dofus.graphics.gapi.ui.MapInfos)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.MapInfos = function ()
    {
        super();
    }).prototype;
    _loc1.update = function ()
    {
        this.initText();
        this._visible = true;
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MapInfos.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initText});
    };
    _loc1.initText = function ()
    {
        var _loc2 = this.api.datacenter.Map;
        if (_loc2.name == undefined)
        {
            this._lblArea.text = "";
            this._lblCoordinates.text = "";
            this._lblAreaShadow.text = "";
            this._lblCoordinatesShadow.text = "";
        }
        else
        {
            var _loc3 = (dofus.datacenter.Subarea)(this.api.datacenter.Subareas.getItemAt(_loc2.subarea));
            var _loc4 = _loc2.name + (_loc3 == undefined ? ("") : (_loc3.alignment.name == undefined ? ("") : (" - " + _loc3.alignment.name)));
            this._lblArea.text = _loc4;
            this._lblCoordinates.text = _loc2.coordinates;
            this._lblAreaShadow.text = _loc4;
            this._lblCoordinatesShadow.text = _loc2.coordinates;
        } // end else if
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MapInfos = function ()
    {
        super();
    }).CLASS_NAME = "MapInfos";
} // end if
#endinitclip
