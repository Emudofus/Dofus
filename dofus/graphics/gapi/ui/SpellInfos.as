// Action script...

// [Initial MovieClip Action of sprite 20648]
#initclip 169
if (!dofus.graphics.gapi.ui.SpellInfos)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.SpellInfos = function ()
    {
        super();
    }).prototype;
    _loc1.__set__spell = function (oSpell)
    {
        if (oSpell == this._oSpell)
        {
            return;
        } // end if
        this.addToQueue({object: this, method: function (s)
        {
            this._oSpell = s;
            if (this.initialized)
            {
                this.initData();
            } // end if
        }, params: [oSpell]});
        //return (this.spell());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.SpellInfos.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.unloadThis();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initData});
    };
    _loc1.addListeners = function ()
    {
        this._bghBackground.addEventListener("click", this);
        this._sfivSpellFullInfosViewer.addEventListener("close", this);
    };
    _loc1.initData = function ()
    {
        if (this._oSpell != undefined)
        {
            this._sfivSpellFullInfosViewer.spell = this._oSpell;
        } // end if
    };
    _loc1.click = function (oEvent)
    {
        this.unloadThis();
    };
    _loc1.close = function (oEvent)
    {
        this.unloadThis();
    };
    _loc1.addProperty("spell", function ()
    {
    }, _loc1.__set__spell);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.SpellInfos = function ()
    {
        super();
    }).CLASS_NAME = "SpellInfos";
} // end if
#endinitclip
