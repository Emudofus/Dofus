// Action script...

// [Initial MovieClip Action of sprite 20652]
#initclip 173
if (!dofus.graphics.gapi.ui.spellforget.SpellForgetItem)
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
    if (!dofus.graphics.gapi.ui.spellforget)
    {
        _global.dofus.graphics.gapi.ui.spellforget = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.spellforget.SpellForgetItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = (dofus.datacenter.Spell)(oItem);
            this._lblName.text = this._oItem.name;
            this._lblLevel.text = String(this._oItem.level);
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
        } // end else if
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
