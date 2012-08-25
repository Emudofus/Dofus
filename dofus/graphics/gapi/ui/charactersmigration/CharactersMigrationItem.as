// Action script...

// [Initial MovieClip Action of sprite 20500]
#initclip 21
if (!dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem)
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
    if (!dofus.graphics.gapi.ui.charactersmigration)
    {
        _global.dofus.graphics.gapi.ui.charactersmigration = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem = function ()
    {
        super();
    }).prototype;
    _loc1.__set__list = function (mcList)
    {
        this._mcList = mcList;
        //return (this.list());
    };
    _loc1.updatePlayerName = function (sName)
    {
        this._lblName.text = sName;
    };
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            this._ldrFace._visible = true;
            this._mcInputNickname._visible = true;
            this._lblName._visible = true;
            this._lblLevel._visible = true;
            this._lblLevel.text = oItem.level;
            this._lblName.text = oItem.newPlayerName;
            this.list = oItem.list;
            this._ldrFace.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf";
            this._oItem.ref = this;
        }
        else
        {
            this._ldrFace._visible = false;
            this._mcInputNickname._visible = false;
            this._lblName._visible = false;
            this._lblLevel._visible = false;
        } // end else if
    };
    _loc1.getValue = function ()
    {
        return (this._oItem);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
    };
    _loc1.addListeners = function ()
    {
    };
    _loc1.initTexts = function ()
    {
    };
    _loc1.click = function (oEvent)
    {
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.charactersmigration.CharactersMigrationItem = function ()
    {
        super();
    }).CLASS_NAME = "CharactersMigrationItem";
} // end if
#endinitclip
