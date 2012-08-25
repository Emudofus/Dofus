// Action script...

// [Initial MovieClip Action of sprite 20858]
#initclip 123
if (!dofus.datacenter.OfflineCharacter)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.OfflineCharacter = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super();
        if (this.__proto__ == dofus.datacenter.OfflineCharacter.prototype)
        {
            this.initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID);
        } // end if
    }).prototype;
    _loc1.__set__name = function (sName)
    {
        this._sName = sName;
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this._sName);
    };
    _loc1.__get__gfxID = function ()
    {
        return (this._gfxID);
    };
    _loc1.__set__gfxID = function (value)
    {
        this._gfxID = value;
        //return (this.gfxID());
    };
    _loc1.initialize = function (sID, clipClass, sGfxFile, cellNum, dir, gfxID)
    {
        super.initialize(sID, clipClass, sGfxFile, cellNum, dir);
        this._gfxID = gfxID;
    };
    _loc1.__set__guildName = function (sGuildName)
    {
        this._sGuildName = sGuildName;
        //return (this.guildName());
    };
    _loc1.__get__guildName = function ()
    {
        return (this._sGuildName);
    };
    _loc1.__set__emblem = function (oEmblem)
    {
        this._oEmblem = oEmblem;
        //return (this.emblem());
    };
    _loc1.__get__emblem = function ()
    {
        return (this._oEmblem);
    };
    _loc1.__set__offlineType = function (sOfflineType)
    {
        this._sOfflineType = sOfflineType;
        //return (this.offlineType());
    };
    _loc1.__get__offlineType = function ()
    {
        return (this._sOfflineType);
    };
    _loc1.addProperty("emblem", _loc1.__get__emblem, _loc1.__set__emblem);
    _loc1.addProperty("gfxID", _loc1.__get__gfxID, _loc1.__set__gfxID);
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("guildName", _loc1.__get__guildName, _loc1.__set__guildName);
    _loc1.addProperty("offlineType", _loc1.__get__offlineType, _loc1.__set__offlineType);
    ASSetPropFlags(_loc1, null, 1);
    _loc1.xtraClipTopAnimations = {staticL: true, staticF: true, staticR: true};
} // end if
#endinitclip
