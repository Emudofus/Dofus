// Action script...

// [Initial MovieClip Action of sprite 20588]
#initclip 109
if (!dofus.graphics.gapi.controls.statsviewer.StatsViewerStatItem)
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
    if (!dofus.graphics.gapi.controls.statsviewer)
    {
        _global.dofus.graphics.gapi.controls.statsviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.statsviewer.StatsViewerStatItem = function ()
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
            if (oItem.isCat)
            {
                this._mcCatBackground._visible = true;
                this._ldrIcon.contentPath = "";
                this._lblCatName.text = oItem.name;
                this._lblName.text = "";
                this._lblBase.text = "";
                this._lblItems.text = "";
                this._lblAlign.text = "";
                this._lblBoost.text = "";
                this._lblTotal.text = "";
            }
            else
            {
                this._mcCatBackground._visible = false;
                if (oItem.p != undefined)
                {
                    this._ldrIcon.contentPath = oItem.p;
                }
                else
                {
                    this._ldrIcon.contentPath = "";
                } // end else if
                this._lblCatName.text = "";
                this._lblName.text = oItem.name;
                if (oItem.s != 0)
                {
                    this._lblBase.text = oItem.s;
                    if (oItem.s > 0)
                    {
                        this._lblBase.styleName = "GreenCenterSmallLabel";
                    }
                    else
                    {
                        this._lblBase.styleName = "RedCenterSmallLabel";
                    } // end else if
                }
                else
                {
                    this._lblBase.text = "-";
                    this._lblBase.styleName = "BrownCenterSmallLabel";
                } // end else if
                if (oItem.i != 0)
                {
                    this._lblItems.text = oItem.i;
                    if (oItem.i > 0)
                    {
                        this._lblItems.styleName = "GreenCenterSmallLabel";
                    }
                    else
                    {
                        this._lblItems.styleName = "RedCenterSmallLabel";
                    } // end else if
                }
                else
                {
                    this._lblItems.text = "-";
                    this._lblItems.styleName = "BrownCenterSmallLabel";
                } // end else if
                if (oItem.d != 0)
                {
                    this._lblAlign.text = oItem.d;
                    if (oItem.d > 0)
                    {
                        this._lblAlign.styleName = "GreenCenterSmallLabel";
                    }
                    else
                    {
                        this._lblAlign.styleName = "RedCenterSmallLabel";
                    } // end else if
                }
                else
                {
                    this._lblAlign.text = "-";
                    this._lblAlign.styleName = "BrownCenterSmallLabel";
                } // end else if
                if (oItem.b != 0)
                {
                    this._lblBoost.text = oItem.b;
                    if (oItem.b > 0)
                    {
                        this._lblBoost.styleName = "GreenCenterSmallLabel";
                    }
                    else
                    {
                        this._lblBoost.styleName = "RedCenterSmallLabel";
                    } // end else if
                }
                else
                {
                    this._lblBoost.text = "-";
                    this._lblBoost.styleName = "BrownCenterSmallLabel";
                } // end else if
                var _loc5 = oItem.b + oItem.d + oItem.i + oItem.s;
                if (_loc5 != 0)
                {
                    this._lblTotal.text = String(_loc5);
                    if (_loc5 > 0)
                    {
                        this._lblTotal.styleName = "GreenCenterSmallLabel";
                    }
                    else
                    {
                        this._lblTotal.styleName = "RedCenterSmallLabel";
                    } // end else if
                }
                else
                {
                    this._lblTotal.text = "-";
                    this._lblTotal.styleName = "BrownCenterSmallLabel";
                } // end else if
            } // end else if
        }
        else if (this._lblName.text != undefined)
        {
            this._mcCatBackground._visible = false;
            this._ldrIcon.contentPath = "";
            this._lblCatName.text = "";
            this._lblName.text = "";
            this._lblBase.text = "";
            this._lblBase.styleName = "BrownCenterSmallLabel";
            this._lblItems.text = "";
            this._lblItems.styleName = "BrownCenterSmallLabel";
            this._lblAlign.text = "";
            this._lblAlign.styleName = "BrownCenterSmallLabel";
            this._lblBoost.text = "";
            this._lblBoost.styleName = "BrownCenterSmallLabel";
            this._lblTotal.text = "";
            this._lblTotal.styleName = "BrownCenterSmallLabel";
        } // end else if
    };
    _loc1.init = function ()
    {
        super.init(false);
        this._mcCatBackground._visible = false;
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
