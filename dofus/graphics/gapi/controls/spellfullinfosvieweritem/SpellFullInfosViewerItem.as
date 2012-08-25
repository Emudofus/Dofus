// Action script...

// [Initial MovieClip Action of sprite 20699]
#initclip 220
if (!dofus.graphics.gapi.controls.spellfullinfosvieweritem.SpellFullInfosViewerItem)
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
    if (!dofus.graphics.gapi.controls.spellfullinfosvieweritem)
    {
        _global.dofus.graphics.gapi.controls.spellfullinfosvieweritem = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.spellfullinfosvieweritem.SpellFullInfosViewerItem = function ()
    {
        super();
        this._mcArea._visible = false;
    }).prototype;
    _loc1.setValue = function (bUsed, sSuggested, oItem)
    {
        if (bUsed)
        {
            this._oItem = oItem;
            if (oItem.fx.description == undefined && oItem.description == undefined)
            {
                this._lbl.text = sSuggested;
            }
            else
            {
                if (oItem.fx.description != undefined)
                {
                    this._lbl.text = oItem.fx.description;
                }
                else if (oItem.description != undefined)
                {
                    this._lbl.text = oItem.description;
                } // end else if
                var _loc5;
                if (oItem.fx.element != undefined)
                {
                    _loc5 = oItem.fx.element;
                }
                else if (oItem.element != undefined)
                {
                    _loc5 = oItem.element;
                } // end else if
                if (_loc5 != undefined)
                {
                    switch (_loc5)
                    {
                        case "N":
                        {
                            this._ctrElement.contentPath = "IconNeutralDommage";
                            break;
                        } 
                        case "F":
                        {
                            this._ctrElement.contentPath = "IconFireDommage";
                            break;
                        } 
                        case "A":
                        {
                            this._ctrElement.contentPath = "IconAirDommage";
                            break;
                        } 
                        case "W":
                        {
                            this._ctrElement.contentPath = "IconWaterDommage";
                            break;
                        } 
                        case "E":
                        {
                            this._ctrElement.contentPath = "IconEarthDommage";
                            break;
                        } 
                        default:
                        {
                            this._ctrElement.contentPath = "";
                            break;
                        } 
                    } // End of switch
                }
                else if (oItem.fx.icon != undefined)
                {
                    this._ctrElement.contentPath = oItem.fx.icon;
                }
                else if (oItem.icon != undefined)
                {
                    this._ctrElement.contentPath = oItem.icon;
                }
                else
                {
                    this._ctrElement.contentPath = "";
                } // end else if
            } // end else if
            if (oItem.ar > 1)
            {
                this._mcArea._visible = true;
                this._mcArea.onRollOver = function ()
                {
                    this._parent.onTooltipOver();
                };
                this._mcArea.onRollOut = function ()
                {
                    this._parent.onTooltipOut();
                };
                this._lblArea.text = (oItem.ar == 63 ? (_global.API.lang.getText("INFINIT_SHORT")) : (oItem.ar)) + " (" + oItem.at + ")";
            }
            else
            {
                this._mcArea._visible = false;
                this._mcArea.onRollOver = undefined;
                this._mcArea.onRollOut = undefined;
                this._lblArea.text = "";
            } // end else if
        }
        else if (this._lbl.text != undefined)
        {
            this._oItem = undefined;
            this._lbl.text = "";
            this._lblArea.text = "";
            this._mcArea._visible = false;
            this._ctrElement.contentPath = "";
        }
        else
        {
            this._oItem = undefined;
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
        this._lbl.setSize(this.__width - (this._oItem.ar > 1 ? (78) : (20)), this.__height);
    };
    _loc1.onTooltipOver = function ()
    {
        _global.API.ui.showTooltip(_global.API.lang.getText("EFFECT_SHAPE_TYPE_" + this._oItem.at, [this._oItem.ar == 63 ? (_global.API.lang.getText("INFINIT")) : (this._oItem.ar)]), this._mcArea, -20);
    };
    _loc1.onTooltipOut = function ()
    {
        _global.API.ui.hideTooltip();
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
