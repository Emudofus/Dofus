// Action script...

// [Initial MovieClip Action of sprite 20877]
#initclip 142
if (!dofus.datacenter.Title)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Title = function (id, param)
    {
        this.api = _global.API;
        this._id = id;
        switch (this.api.lang.getTitle(id).pt)
        {
            case 1:
            {
                var _loc4 = this.api.lang.getTitle(id).t.split("%1").join(this.api.lang.getMonsters()[_global.parseInt(param)].n);
                break;
            } 
            case 0:
            default:
            {
                _loc4 = this.api.lang.getTitle(id).t.split("%1").join(param);
            } 
        } // End of switch
        this._text = "« " + _loc4 + " » ";
        this._color = this.api.lang.getTitle(id).c;
    }).prototype;
    _loc1.__get__color = function ()
    {
        return (this._color);
    };
    _loc1.__get__text = function ()
    {
        return (this._text);
    };
    _loc1.addProperty("text", _loc1.__get__text, function ()
    {
    });
    _loc1.addProperty("color", _loc1.__get__color, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
