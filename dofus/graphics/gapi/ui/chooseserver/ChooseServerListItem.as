// Action script...

// [Initial MovieClip Action of sprite 20913]
#initclip 178
if (!dofus.graphics.gapi.ui.chooseserver.ChooseServerListItem)
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
    if (!dofus.graphics.gapi.ui.chooseserver)
    {
        _global.dofus.graphics.gapi.ui.chooseserver = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.chooseserver.ChooseServerListItem = function ()
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
        var _loc5 = this._mcList._parent._parent.api;
        if (bUsed)
        {
            this._oItem = oItem;
            oItem.sortFlag = oItem.language;
            oItem.sortName = oItem.label;
            oItem.sortType = oItem.type;
            oItem.sortOnline = oItem.stateStrShort;
            oItem.sortCommunity = oItem.communityStr;
            oItem.sortPopulation = oItem.population;
            var _loc6 = new String();
            switch (oItem.community)
            {
                case 0:
                {
                    _loc6 = "fr";
                    break;
                } 
                case 1:
                {
                    _loc6 = "en";
                    break;
                } 
                case 3:
                {
                    _loc6 = "de";
                    break;
                } 
                case 4:
                {
                    _loc6 = "es";
                    break;
                } 
                case 5:
                {
                    _loc6 = "ru";
                    break;
                } 
                case 6:
                {
                    _loc6 = "pt";
                    break;
                } 
                case 7:
                {
                    _loc6 = "nl";
                    break;
                } 
                case 8:
                {
                    _loc6 = "jp";
                    break;
                } 
                case 9:
                {
                    _loc6 = "it";
                    break;
                } 
                case 2:
                default:
                {
                    _loc6 = "us";
                    break;
                } 
            } // End of switch
            this._ldrFlag.contentPath = "Flag_" + _loc6;
            this._lblName.text = oItem.sortName;
            this._lblCommunity.text = oItem.sortCommunity;
            switch (oItem.state)
            {
                case dofus.datacenter.Server.SERVER_OFFLINE:
                {
                    this._lblOnline.styleName = "RedCenterSmallLabel";
                    break;
                } 
                case dofus.datacenter.Server.SERVER_ONLINE:
                {
                    this._lblOnline.styleName = "GreenCenterSmallLabel";
                    break;
                } 
                default:
                {
                    this._lblOnline.styleName = "BrownCenterSmallLabel";
                    break;
                } 
            } // End of switch
            this._lblOnline.text = oItem.sortOnline;
            switch (oItem.sortPopulation)
            {
                case 0:
                {
                    this._lblPopulation.styleName = "GreenCenterSmallLabel";
                    break;
                } 
                case 1:
                {
                    this._lblPopulation.styleName = "BlueCenterSmallLabel";
                    break;
                } 
                case 2:
                {
                    this._lblPopulation.styleName = "RedCenterSmallLabel";
                    break;
                } 
                default:
                {
                    this._lblPopulation.styleName = "BrownCenterSmallLabel";
                    break;
                } 
            } // End of switch
            this._lblPopulation.text = oItem.populationStr;
            this._lblType.text = oItem.type;
            if (oItem.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
            {
                this._lblName.styleName = "RedLeftSmallLabel";
                this._lblType.styleName = "RedCenterSmallLabel";
                this._mcHeroic._visible = true;
            }
            else
            {
                this._lblName.styleName = "BrownLeftSmallLabel";
                this._lblType.styleName = "BrownCenterSmallLabel";
                this._mcHeroic._visible = false;
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._ldrFlag.contentPath = "";
            this._lblName.text = "";
            this._lblType.text = "";
            this._lblOnline.text = "";
            this._lblCommunity.text = "";
            this._lblPopulation.text = "";
            this._mcHeroic._visible = false;
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
    };
    _loc1.over = function ()
    {
        if (!this._oItem.friendCharactersCount)
        {
            return;
        } // end if
        var _loc2 = this._mcList.gapi.api;
        var _loc3 = ank.utils.PatternDecoder.combine(_loc2.lang.getText("A_POSSESS_CHARACTER", [this._oItem.search, this._oItem.friendCharactersCount]), null, this._oItem.friendCharactersCount == 1);
        _loc2.ui.showTooltip(_loc3, this._mcOver, -20);
    };
    _loc1.out = function (oEvent)
    {
        this._mcList.gapi.api.ui.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
