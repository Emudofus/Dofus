// Action script...

// [Initial MovieClip Action of sprite 20570]
#initclip 91
if (!dofus.datacenter.QuestBook)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.QuestBook = function ()
    {
        this.initialize();
    }).prototype;
    _loc1.__get__quests = function ()
    {
        return (this._eaQuests);
    };
    _loc1.getQuest = function (nID)
    {
        var _loc3 = this._eaQuests.findFirstItem("id", nID);
        if (_loc3.index != -1)
        {
            return (_loc3.item);
        } // end if
        return (null);
    };
    _loc1.initialize = function ()
    {
        this._eaQuests = new ank.utils.ExtendedArray();
    };
    _loc1.addProperty("quests", _loc1.__get__quests, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
