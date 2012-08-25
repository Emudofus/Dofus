// Action script...

// [Initial MovieClip Action of sprite 20558]
#initclip 79
if (!dofus.graphics.gapi.ui.Zoom)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.Zoom = function ()
    {
        super();
    }).prototype;
    _loc1.__set__sprite = function (oSprite)
    {
        this._oSprite = oSprite;
        //return (this.sprite());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.Zoom.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        Mouse.removeListener(this);
        this.api.kernel.GameManager.zoomGfx();
        this.unloadThis();
    };
    _loc1.createChildren = function ()
    {
        Mouse.addListener(this);
        this.api.kernel.GameManager.zoomGfx();
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnCancel.addEventListener("click", this);
        this._btnCancel.addEventListener("over", this);
        this._btnCancel.addEventListener("out", this);
        this._vsZoom.addEventListener("change", this);
        this._vsZoom.min = this.api.gfx.getZoom();
    };
    _loc1.setZoom = function (bOnSprite)
    {
        if (this._vsZoom.value < this._vsZoom.min + this._vsZoom.min * 10 / 100)
        {
            this.api.kernel.GameManager.zoomGfx();
        }
        else if (bOnSprite)
        {
            this.api.kernel.GameManager.zoomGfx(this._vsZoom.value, this._oSprite.mc._x, this._oSprite.mc._y - 20);
        }
        else
        {
            var _loc3 = this.api.gfx.getZoom();
            var _loc4 = (_root._xmouse - this.api.gfx.container._x) * 100 / _loc3;
            var _loc5 = (_root._ymouse - this.api.gfx.container._y) * 100 / _loc3;
            this.api.kernel.GameManager.zoomGfx(this._vsZoom.value, _loc4, _loc5, _root._xmouse, _root._ymouse);
        } // end else if
    };
    _loc1.onMouseWheel = function (nValue)
    {
        this._vsZoom.value = this._vsZoom.value + nValue * 5;
        this.setZoom(false);
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnCancel:
            {
                this.callClose();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        this.setZoom(true);
    };
    _loc1.over = function (oEvent)
    {
        this.gapi.showTooltip(this.api.lang.getText("CLOSE"), oEvent.target, -20);
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("sprite", function ()
    {
    }, _loc1.__set__sprite);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.Zoom = function ()
    {
        super();
    }).CLASS_NAME = "Zoom";
} // end if
#endinitclip
