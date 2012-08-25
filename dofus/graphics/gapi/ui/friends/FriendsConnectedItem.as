// Action script...

// [Initial MovieClip Action of sprite 20519]
#initclip 40
if (!dofus.graphics.gapi.ui.friends.FriendsConnectedItem)
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
    if (!dofus.graphics.gapi.ui.friends)
    {
        _global.dofus.graphics.gapi.ui.friends = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.friends.FriendsConnectedItem = function ()
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
            this._oItem = oItem;
            if (oItem.account != undefined && !this._mcList._parent._parent.api.config.isStreaming)
            {
                this._lblName.text = oItem.account + " (" + oItem.name + ")";
            }
            else
            {
                this._lblName.text = oItem.name;
            } // end else if
            if (oItem.level != undefined)
            {
                this._lblLevel.text = oItem.level;
            }
            else
            {
                this._lblLevel.text = "";
            } // end else if
            this._mcFight._visible = oItem.state == "IN_MULTI";
            this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfxID + ".swf";
            if (oItem.alignement != -1)
            {
                this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignement + ".swf";
            }
            else
            {
                this._ldrAlignement.contentPath = "";
            } // end else if
            this._btnRemove._visible = true;
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._ldrAlignement.contentPath = "";
            this._mcFight._visible = false;
            this._ldrGuild.contentPath = "";
            this._btnRemove._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcFight._visible = false;
        this._btnRemove._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnRemove.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        if (this._oItem.account != undefined)
        {
            this._mcList._parent._parent.removeFriend("*" + this._oItem.account);
        }
        else
        {
            this._mcList._parent._parent.removeFriend(this._oItem.name);
        } // end else if
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
