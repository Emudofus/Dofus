// Action script...

// [Initial MovieClip Action of sprite 20874]
#initclip 139
if (!dofus.graphics.gapi.controls.itemviewer.ItemViewerItem)
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
    if (!dofus.graphics.gapi.controls.itemviewer)
    {
        _global.dofus.graphics.gapi.controls.itemviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.itemviewer.ItemViewerItem = function ()
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
        this._oItem = oItem;
        if (bUsed)
        {
            this.showButton(false);
            this.showLoader(false);
            if (oItem instanceof dofus.datacenter.Effect)
            {
                this._lbl.text = oItem.description;
                switch (oItem.operator)
                {
                    case "+":
                    {
                        this._lbl.styleName = "GreenLeftSmallLabel";
                        break;
                    } 
                    case "-":
                    {
                        this._lbl.styleName = "RedLeftSmallLabel";
                        break;
                    } 
                    default:
                    {
                        this._lbl.styleName = "BrownLeftSmallLabel";
                        break;
                    } 
                } // End of switch
                switch (oItem.type)
                {
                    case 995:
                    {
                        this.showButton(true, "ItemViewerUseHand");
                        this._btn.addEventListener("click", this);
                        break;
                    } 
                    default:
                    {
                        this.showButton(false, "");
                        this._btn.removeEventListener();
                        break;
                    } 
                } // End of switch
                if (oItem.element != undefined)
                {
                    switch (oItem.element)
                    {
                        case "W":
                        {
                            this.showLoader(true, "IconWaterDommage");
                            break;
                        } 
                        case "F":
                        {
                            this.showLoader(true, "IconFireDommage");
                            break;
                        } 
                        case "E":
                        {
                            this.showLoader(true, "IconEarthDommage");
                            break;
                        } 
                        case "A":
                        {
                            this.showLoader(true, "IconAirDommage");
                            break;
                        } 
                        case "N":
                        {
                            this.showLoader(true, "IconNeutralDommage");
                            break;
                        } 
                    } // End of switch
                }
                else
                {
                    switch (Number(oItem.characteristic))
                    {
                        case 13:
                        {
                            this.showLoader(true, "IconWaterBonus");
                            break;
                        } 
                        case 35:
                        {
                            this.showLoader(true, "IconWater");
                            break;
                        } 
                        case 15:
                        {
                            this.showLoader(true, "IconFireBonus");
                            break;
                        } 
                        case 34:
                        {
                            this.showLoader(true, "IconFire");
                            break;
                        } 
                        case 10:
                        {
                            this.showLoader(true, "IconEarthBonus");
                            break;
                        } 
                        case 33:
                        {
                            this.showLoader(true, "IconEarth");
                            break;
                        } 
                        case 14:
                        {
                            this.showLoader(true, "IconAirBonus");
                            break;
                        } 
                        case 36:
                        {
                            this.showLoader(true, "IconAir");
                            break;
                        } 
                        case 37:
                        {
                            this.showLoader(true, "IconNeutral");
                            break;
                        } 
                        case 1:
                        {
                            this.showLoader(true, "Star");
                            break;
                        } 
                        case 11:
                        {
                            this.showLoader(true, "IconVita");
                            break;
                        } 
                        case 12:
                        {
                            this.showLoader(true, "IconWisdom");
                            break;
                        } 
                        case 44:
                        {
                            this.showLoader(true, "IconInit");
                            break;
                        } 
                        case 48:
                        {
                            this.showLoader(true, "IconPP");
                            break;
                        } 
                        case 2:
                        {
                            this.showLoader(true, "KamaSymbol");
                            break;
                        } 
                        case 23:
                        {
                            this.showLoader(true, "IconMP");
                            break;
                        } 
                    } // End of switch
                } // end else if
            }
            else
            {
                this._lbl.text = sSuggested;
                this._lbl.styleName = "BrownLeftSmallLabel";
            } // end else if
        }
        else if (this._lbl.text != undefined)
        {
            this._lbl.text = "";
            this.showLoader(false, "");
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
    };
    _loc1.createChildren = function ()
    {
        this.arrange();
    };
    _loc1.size = function ()
    {
        super.size();
        this.addToQueue({object: this, method: this.arrange});
    };
    _loc1.arrange = function ()
    {
        this._lbl.setSize(this.__width, this.__height);
    };
    _loc1.showButton = function (bShow, sIcon)
    {
        this._btn._visible = bShow;
        this._btn.icon = sIcon;
        this.moveLabel(bShow ? (20) : (0));
        if (bShow == false)
        {
            this._btn.removeEventListener("click", this);
        } // end if
    };
    _loc1.showLoader = function (bShow, sIcon)
    {
        this._ldr._visible = bShow;
        this._ldr.contentPath = sIcon;
        this._ldr._x = this.__width - 17;
    };
    _loc1.moveLabel = function (x)
    {
        this._lbl._x = x;
    };
    _loc1.click = function ()
    {
        this._mcList.gapi.api.network.Mount.data(this._oItem.param1, this._oItem.param2);
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
