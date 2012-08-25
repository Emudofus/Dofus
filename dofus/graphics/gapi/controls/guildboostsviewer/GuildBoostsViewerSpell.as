// Action script...

// [Initial MovieClip Action of sprite 20712]
#initclip 233
if (!dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell)
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
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls.guildboostsviewer)
    {
        _global.dofus.graphics.gapi.controls.guildboostsviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell = function ()
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
            this._lblName.text = oItem.name;
            this._lblLevel.text = oItem.level != 0 ? (oItem.level) : ("-");
            this._ldrIcon.contentPath = oItem.iconFile;
            this._mcBorder._visible = true;
            this._mcBack._visible = true;
            var _loc5 = this._mcList.gapi.api.datacenter.Player.guildInfos;
            this._btnBoost._visible = _loc5.playerRights.canManageBoost && _loc5.canBoost("s", oItem.ID);
            if (oItem.level == 0)
            {
                this.setMovieClipTransform(this._ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.COLOR_TRANSFORM);
                this._mcCross._visible = true;
            }
            else
            {
                this.setMovieClipTransform(this._ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
                this._mcCross._visible = false;
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._lblName.text = "";
            this._lblLevel.text = "";
            this._ldrIcon.contentPath = "";
            this._mcBorder._visible = false;
            this._mcBack._visible = false;
            this._mcCross._visible = false;
            this._btnBoost._visible = false;
            this.setMovieClipTransform(this._ldrIcon, dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell.NO_COLOR_TRANSFORM);
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcBorder._visible = false;
        this._mcBack._visible = false;
        this._mcCross._visible = false;
        this._btnBoost._visible = false;
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnBoost.addEventListener("click", this);
        this._btnBoost.addEventListener("over", this);
        this._btnBoost.addEventListener("out", this);
    };
    _loc1.click = function (oEvent)
    {
        this._mcList.gapi.api.network.Guild.boostSpell(this._oItem.ID);
    };
    _loc1.over = function (oEvent)
    {
        var _loc3 = this._mcList.gapi.api;
        var _loc4 = _loc3.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("s", this._oItem.ID);
        this._mcList.gapi.showTooltip(_loc3.lang.getText("COST") + " : " + _loc4.cost, oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this._mcList.gapi.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell = function ()
    {
        super();
    }).COLOR_TRANSFORM = {ra: 60, rb: 0, ga: 60, gb: 0, ba: 60, bb: 0};
    (_global.dofus.graphics.gapi.controls.guildboostsviewer.GuildBoostsViewerSpell = function ()
    {
        super();
    }).NO_COLOR_TRANSFORM = {ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0};
} // end if
#endinitclip
