// Action script...

// [Initial MovieClip Action of sprite 20760]
#initclip 25
if (!dofus.graphics.gapi.ui.DirectionChooser)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.DirectionChooser = function ()
    {
        super();
    }).prototype;
    _loc1.__set__target = function (mcSprite)
    {
        this._mcSprite = mcSprite;
        //return (this.target());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.DirectionChooser.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        var _loc2 = this.api.gfx.getZoom();
        var _loc3 = {x: this._mcSprite._x, y: this._mcSprite._y};
        this._mcSprite._parent.localToGlobal(_loc3);
        this._mcArrows._x = _loc3.x;
        this._mcArrows._y = _loc3.y;
        this._mcArrows._xscale = this._mcArrows._yscale = _loc2;
        this._btnTL = this._mcArrows._btnTL;
        this._btnTR = this._mcArrows._btnTR;
        this._btnBL = this._mcArrows._btnBL;
        this._btnBR = this._mcArrows._btnBR;
        this._btnT = this._mcArrows._btnT;
        this._btnL = this._mcArrows._btnL;
        this._btnR = this._mcArrows._btnR;
        this._btnB = this._mcArrows._btnB;
        if (!this.allDirections)
        {
            this._btnT._visible = false;
            this._mcArrows._mcShadowT._visible = false;
            this._btnB._visible = false;
            this._mcArrows._mcShadowB._visible = false;
            this._btnL._visible = false;
            this._mcArrows._mcShadowL._visible = false;
            this._btnR._visible = false;
            this._mcArrows._mcShadowR._visible = false;
        } // end if
        this.out({target: this._btnT});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.addListeners = function ()
    {
        this._btnTL.addEventListener("click", this);
        this._btnTR.addEventListener("click", this);
        this._btnBL.addEventListener("click", this);
        this._btnBR.addEventListener("click", this);
        this._btnT.addEventListener("click", this);
        this._btnL.addEventListener("click", this);
        this._btnR.addEventListener("click", this);
        this._btnB.addEventListener("click", this);
        this._btnTL.addEventListener("over", this);
        this._btnTR.addEventListener("over", this);
        this._btnBL.addEventListener("over", this);
        this._btnBR.addEventListener("over", this);
        this._btnT.addEventListener("over", this);
        this._btnL.addEventListener("over", this);
        this._btnR.addEventListener("over", this);
        this._btnB.addEventListener("over", this);
        this._btnTL.addEventListener("out", this);
        this._btnTR.addEventListener("out", this);
        this._btnBL.addEventListener("out", this);
        this._btnBR.addEventListener("out", this);
        this._btnT.addEventListener("out", this);
        this._btnL.addEventListener("out", this);
        this._btnR.addEventListener("out", this);
        this._btnB.addEventListener("out", this);
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = 0;
        switch (oEvent.target)
        {
            case this._btnR:
            {
                _loc3 = 0;
                break;
            } 
            case this._btnBR:
            {
                _loc3 = 1;
                break;
            } 
            case this._btnB:
            {
                _loc3 = 2;
                break;
            } 
            case this._btnBL:
            {
                _loc3 = 3;
                break;
            } 
            case this._btnL:
            {
                _loc3 = 4;
                break;
            } 
            case this._btnTL:
            {
                _loc3 = 5;
                break;
            } 
            case this._btnT:
            {
                _loc3 = 6;
                break;
            } 
            case this._btnTR:
            {
                _loc3 = 7;
                break;
            } 
        } // End of switch
        this.api.network.Emotes.setDirection(_loc3);
        this.unloadThis();
    };
    _loc1.over = function (oEvent)
    {
        oEvent.target._alpha = 80;
        this.onMouseUp = undefined;
    };
    _loc1.out = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnT:
            {
                this._btnT._alpha = 0;
                break;
            } 
            default:
            {
                oEvent.target._alpha = 100;
                break;
            } 
        } // End of switch
        this.onMouseUp = this._onMouseUp;
    };
    _loc1._onMouseUp = function ()
    {
        this.unloadThis();
    };
    _loc1.onMouseUp = function ()
    {
        this.out();
    };
    _loc1.addProperty("target", function ()
    {
    }, _loc1.__set__target);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.DirectionChooser = function ()
    {
        super();
    }).CLASS_NAME = "DirectionChooser";
} // end if
#endinitclip
