// Action script...

// [Initial MovieClip Action of sprite 20780]
#initclip 45
if (!dofus.datacenter.MountPark)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.MountPark = function (nOwner, nPrice, nSize, nItems, sGuildName, oGuildEmblem)
    {
        super();
        this.owner = nOwner;
        this.price = nPrice;
        this.size = nSize;
        this.items = nItems;
        this.guildName = sGuildName;
        this.guildEmblem = oGuildEmblem;
    }).prototype;
    _loc1.__get__isPublic = function ()
    {
        return (this.owner == -1);
    };
    _loc1.__get__hasNoOwner = function ()
    {
        return (this.owner == 0);
    };
    _loc1.isMine = function (oApi)
    {
        return (this.guildName == oApi.datacenter.Player.guildInfos.name);
    };
    _loc1.addProperty("hasNoOwner", _loc1.__get__hasNoOwner, function ()
    {
    });
    _loc1.addProperty("isPublic", _loc1.__get__isPublic, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
