// Action script...

// [Initial MovieClip Action of sprite 20996]
#initclip 5
if (!dofus.graphics.battlefield.EffectIcon)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.battlefield)
    {
        _global.dofus.graphics.battlefield = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.battlefield.EffectIcon = function ()
    {
        super();
        _global.subtrace("yahoo");
        this.initialize(this._sOperator, this._nQte);
    }).prototype;
    _loc1.__set__operator = function (sOperator)
    {
        this._sOperator = sOperator;
        //return (this.operator());
    };
    _loc1.__set__qte = function (nQte)
    {
        this._nQte = nQte;
        //return (this.qte());
    };
    _loc1.initialize = function (sOperator, nQte)
    {
        switch (sOperator)
        {
            case "-":
            {
                this.attachMovie("Icon-", "_mcOp", 10, {_x: 1, _y: 1});
                var _loc4 = new Color(this._mcbackground);
                _loc4.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_MINUS);
                break;
            } 
            case "+":
            {
                this.attachMovie("Icon+", "_mcOp", 10, {_x: 1, _y: 1});
                var _loc5 = new Color(this._mcbackground);
                _loc5.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_PLUS);
                break;
            } 
            case "*":
            {
                this.attachMovie("Icon*", "_mcOp", 10, {_x: 1, _y: 1});
                var _loc6 = new Color(this._mcbackground);
                _loc6.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_FACTOR);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("qte", function ()
    {
    }, _loc1.__set__qte);
    _loc1.addProperty("operator", function ()
    {
    }, _loc1.__set__operator);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.battlefield.EffectIcon = function ()
    {
        super();
        _global.subtrace("yahoo");
        this.initialize(this._sOperator, this._nQte);
    }).COLOR_PLUS = 255;
    (_global.dofus.graphics.battlefield.EffectIcon = function ()
    {
        super();
        _global.subtrace("yahoo");
        this.initialize(this._sOperator, this._nQte);
    }).COLOR_MINUS = 16711680;
    (_global.dofus.graphics.battlefield.EffectIcon = function ()
    {
        super();
        _global.subtrace("yahoo");
        this.initialize(this._sOperator, this._nQte);
    }).COLOR_FACTOR = 65280;
} // end if
#endinitclip
