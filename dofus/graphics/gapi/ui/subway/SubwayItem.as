// Action script...

// [Initial MovieClip Action of sprite 20782]
#initclip 47
if (!dofus.graphics.gapi.ui.subway.SubwayItem)
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
    if (!dofus.graphics.gapi.ui.subway)
    {
        _global.dofus.graphics.gapi.ui.subway = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.subway.SubwayItem = function ()
    {
        super();
        this._mcUnderAttack._visible = false;
        this._mcUnderAttackInteractivity._visible = false;
        this.api = _global.API;
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
            this._lblCost.text = oItem.cost + " k";
            this._lblCoords.text = oItem.coordinates;
            this._lblName.text = oItem.name;
            this._btnLocate._visible = true;
            if (this._oItem.attackNear)
            {
                this._mcUnderAttack._visible = true;
                this._mcUnderAttackInteractivity._visible = true;
                var ref = this;
                this._mcUnderAttackInteractivity.onRollOver = function ()
                {
                    ref.over({target: this});
                };
                this._mcUnderAttackInteractivity.onRollOut = function ()
                {
                    ref.out({target: this});
                };
            }
            else
            {
                this._mcUnderAttack._visible = false;
                this._mcUnderAttackInteractivity._visible = false;
            } // end else if
        }
        else if (this._lblCost.text != undefined)
        {
            this._lblCost.text = "";
            this._lblCoords.text = "";
            this._lblName.text = "";
            this._btnLocate._visible = false;
            this._mcUnderAttack._visible = false;
            this._mcUnderAttackInteractivity._visible = false;
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
        this._btnLocate.addEventListener("click", this);
    };
    _loc1.click = function (oEvent)
    {
        this.api.kernel.GameManager.updateCompass(this._oItem.x, this._oItem.y, true);
    };
    _loc1.over = function (event)
    {
        switch (event.target)
        {
            case this._mcUnderAttackInteractivity:
            {
                this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_NEAR_PRISM_UNDER_ATTACK"), _root._xmouse, _root._ymouse);
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
} // end if
#endinitclip
