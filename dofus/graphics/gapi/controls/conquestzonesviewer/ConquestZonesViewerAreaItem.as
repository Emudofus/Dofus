// Action script...

// [Initial MovieClip Action of sprite 20539]
#initclip 60
if (!dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem)
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
    if (!dofus.graphics.gapi.controls.conquestzonesviewer)
    {
        _global.dofus.graphics.gapi.controls.conquestzonesviewer = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem = function ()
    {
        super();
        this.api = _global.API;
        this._ldrAlignment._alpha = 0;
        this._mcNotAligned._alpha = 0;
        this._mcFighting._alpha = 0;
        this._mcLocate._alpha = 0;
        this._mcSubtitleBackground._alpha = 0;
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
            if (this._oItem.area == undefined || (Number(oItem.area) < 0 || _global.isNaN(oItem.area)))
            {
                var _loc5 = this.api.lang.getMapSubAreaText(oItem.id).n;
                this._lblArea.text = _loc5.substr(0, 2) == "//" ? (_loc5.substr(2)) : (_loc5);
                this._mcFighting._alpha = oItem.fighting ? (100) : (0);
                if (oItem.alignment == -1)
                {
                    this._ldrAlignment._alpha = 0;
                    this._mcNotAligned._alpha = 100;
                }
                else
                {
                    this._mcNotAligned._alpha = 0;
                    this._ldrAlignment._alpha = 100;
                    this._ldrAlignment.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignment + ".swf";
                } // end else if
                var ref = this;
                this._mcTooltip.onRollOver = function ()
                {
                    ref.over({target: this});
                };
                this._mcTooltip.onRollOut = function ()
                {
                    ref.out({target: this});
                };
                if (oItem.prism == 0)
                {
                    delete this._oPrismData;
                    this._lblPrism.text = "-";
                    this._mcLocate._alpha = 0;
                    delete this._mcLocate.onRelease;
                    delete this._mcLocate.onRollOver;
                    delete this._mcLocate.onRollOut;
                }
                else
                {
                    this._oPrismData = this.api.lang.getMapText(oItem.prism);
                    this._lblPrism.text = this._oPrismData.x + ";" + this._oPrismData.y;
                    this._mcLocate._alpha = 100;
                    this._mcLocate.onRelease = function ()
                    {
                        ref.click({target: this});
                    };
                    this._mcLocate.onRollOver = function ()
                    {
                        ref.over({target: this});
                    };
                    this._mcLocate.onRollOut = function ()
                    {
                        ref.out({target: this});
                    };
                } // end else if
                this._mcAlignmentInteractivity.onRollOver = function ()
                {
                    ref.over({target: this});
                };
                this._mcAlignmentInteractivity.onRollOut = function ()
                {
                    ref.out({target: this});
                };
                if (this._mcFighting._alpha == 0)
                {
                    if (!this._mcNotAligned.moved)
                    {
                        this._mcNotAligned._x = this._mcNotAligned._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._mcNotAligned.moved = true;
                    } // end if
                    if (!this._ldrAlignment.moved)
                    {
                        this._ldrAlignment._x = this._ldrAlignment._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._ldrAlignment.moved = true;
                    } // end if
                    if (!this._mcAlignmentInteractivity.moved)
                    {
                        this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x + dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._mcAlignmentInteractivity.moved = true;
                    } // end if
                }
                else
                {
                    this._mcFightingInteractivity.onRollOver = function ()
                    {
                        ref.over({target: this});
                    };
                    this._mcFightingInteractivity.onRollOut = function ()
                    {
                        ref.out({target: this});
                    };
                    if (this._mcNotAligned.moved)
                    {
                        this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._mcNotAligned.moved = false;
                    } // end if
                    if (this._ldrAlignment.moved)
                    {
                        this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._ldrAlignment.moved = false;
                    } // end if
                    if (this._mcAlignmentInteractivity.moved)
                    {
                        this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                        this._mcAlignmentInteractivity.moved = false;
                    } // end if
                } // end else if
                this._mcSubtitleBackground._alpha = 0;
                this._lblSubtitle.text = "";
            }
            else
            {
                this._lblArea.text = "";
                this._ldrAlignment._alpha = 0;
                this._mcNotAligned._alpha = 0;
                this._mcFighting._alpha = 0;
                this._mcLocate._alpha = 0;
                delete this._mcLocate.onRelease;
                delete this._mcAlignmentInteractivity.onRollOver;
                delete this._mcAlignmentInteractivity.onRollOut;
                delete this._mcFightingInteractivity.onRollOver;
                delete this._mcFightingInteractivity.onRollOut;
                delete this._mcTooltip.onRollOver;
                delete this._mcTooltip.onRollOut;
                this._lblPrism.text = "";
                if (this._mcNotAligned.moved)
                {
                    this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                    this._mcNotAligned.moved = false;
                } // end if
                if (this._ldrAlignment.moved)
                {
                    this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                    this._ldrAlignment.moved = false;
                } // end if
                if (this._mcAlignmentInteractivity.moved)
                {
                    this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                    this._mcAlignmentInteractivity.moved = false;
                } // end if
                this._mcSubtitleBackground._alpha = 100;
                this._lblSubtitle.text = this.api.lang.getMapAreaText(this._oItem.area).n;
            } // end else if
        }
        else if (this._lblArea.text != undefined)
        {
            this._lblArea.text = "";
            this._ldrAlignment._alpha = 0;
            this._mcNotAligned._alpha = 0;
            this._mcFighting._alpha = 0;
            this._mcLocate._alpha = 0;
            this._mcSubtitleBackground._alpha = 0;
            this._lblSubtitle.text = "";
            delete this._mcLocate.onRelease;
            delete this._mcAlignmentInteractivity.onRollOver;
            delete this._mcAlignmentInteractivity.onRollOut;
            delete this._mcFightingInteractivity.onRollOver;
            delete this._mcFightingInteractivity.onRollOut;
            delete this._mcTooltip.onRollOver;
            delete this._mcTooltip.onRollOut;
            this._lblPrism.text = "";
            if (this._mcNotAligned.moved)
            {
                this._mcNotAligned._x = this._mcNotAligned._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                this._mcNotAligned.moved = false;
            } // end if
            if (this._ldrAlignment.moved)
            {
                this._ldrAlignment._x = this._ldrAlignment._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                this._ldrAlignment.moved = false;
            } // end if
            if (this._mcAlignmentInteractivity.moved)
            {
                this._mcAlignmentInteractivity._x = this._mcAlignmentInteractivity._x - dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem.MOVING_INDICE;
                this._mcAlignmentInteractivity.moved = false;
            } // end if
        } // end else if
    };
    _loc1.click = function (event)
    {
        switch (event.target)
        {
            case this._mcLocate:
            {
                this.api.kernel.GameManager.updateCompass(this._oPrismData.x, this._oPrismData.y, true);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (event)
    {
        switch (event.target)
        {
            case this._mcAlignmentInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("ALIGNMENT") + ": " + (this._oItem.alignment > 0 ? (new dofus.datacenter.Alignment(this._oItem.alignment, 1).name) : (this._oItem.alignment == -1 ? (this.api.lang.getText("NON_ALIGNED")) : (this.api.lang.getText("NEUTRAL_WORD")))), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcFightingInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("FIGHTING_PRISM"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcLocate:
            {
                this.api.ui.showTooltip(this.api.lang.getText("LOCATE"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcTooltip:
            {
                var _loc3 = new String();
                if (this._oItem.alignment == this.api.datacenter.Player.alignment.index)
                {
                    _loc3 = this.api.lang.getText("CONQUEST_AREA_OWNED") + "\n";
                    if (this._oItem.isVulnerable())
                    {
                        _loc3 = _loc3 + (this.api.lang.getText("CONQUEST_AREA_VULNERABLE") + "\n");
                    } // end if
                    _loc3 = _loc3 + "\n";
                }
                else if (this._oItem.isCapturable())
                {
                    _loc3 = this.api.lang.getText("CONQUEST_AREA_CAN_BE_CAPTURED") + "\n\n";
                }
                else
                {
                    _loc3 = this.api.lang.getText("CONQUEST_AREA_CANT_BE_CAPTURED") + "\n\n";
                } // end else if
                _loc3 = _loc3 + (this.api.lang.getText("CONQUEST_NEAR_ZONES") + ":\n");
                var _loc4 = this._oItem.getNearZonesList();
                for (var s in _loc4)
                {
                    var _loc5 = this.api.lang.getMapSubAreaText(_loc4[s]).n;
                    if (_loc5.substr(0, 2) == "//")
                    {
                        _loc5 = _loc5.substr(2);
                    } // end if
                    _loc3 = _loc3 + (" - " + _loc5 + "\n");
                } // end of for...in
                this.api.ui.showTooltip(_loc3, _root._xmouse, _root._ymouse + 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (event)
    {
        this.api.ui.hideTooltip();
    };
    _loc1.addProperty("list", function ()
    {
    }, _loc1.__set__list);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.conquestzonesviewer.ConquestZonesViewerAreaItem = function ()
    {
        super();
        this.api = _global.API;
        this._ldrAlignment._alpha = 0;
        this._mcNotAligned._alpha = 0;
        this._mcFighting._alpha = 0;
        this._mcLocate._alpha = 0;
        this._mcSubtitleBackground._alpha = 0;
    }).MOVING_INDICE = 5;
} // end if
#endinitclip
