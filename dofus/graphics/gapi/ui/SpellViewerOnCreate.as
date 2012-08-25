// Action script...

// [Initial MovieClip Action of sprite 20848]
#initclip 113
if (!dofus.graphics.gapi.ui.SpellViewerOnCreate)
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
    var _loc1 = (_global.dofus.graphics.gapi.ui.SpellViewerOnCreate = function ()
    {
        super();
    }).prototype;
    _loc1.__get__breed = function ()
    {
        return (this._nBreed);
    };
    _loc1.__set__breed = function (n)
    {
        this._nBreed = n;
        //return (this.breed());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.SpellViewerOnCreate.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initText});
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initText = function ()
    {
        this._lblBreedSpells.text = this.api.lang.getText("CLASS_SPELLS");
        this._lblBreedName.text = this.api.lang.getClassText(this._nBreed).sn;
        this._lbViewSpell.text = this.api.lang.getText("SEE_ALL_SPELLS");
    };
    _loc1.addListeners = function ()
    {
        this._btnClose.addEventListener("click", this);
        this._btnClose.addEventListener("over", this);
        this._btnClose.addEventListener("out", this);
        this._bhClose.addEventListener("click", this);
        this._mcWindowBg.onRelease = function ()
        {
        };
        this._mcWindowBg.useHandCursor = false;
        this._mcViewAllSpell.onRelease = function ()
        {
            var aTarget = new Object();
            var _loc2 = 0;
            
            while (++_loc2, _loc2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
            {
                var _loc3 = this._parent["_ctr" + _loc2];
                var _loc4 = this._parent._mcPlacerSpell._x;
                var _loc5 = this._parent._mcPlacerSpell._y;
                var _loc6 = _loc4 + (_loc2 - (_loc2 > 9 ? (10) : (0))) * (_loc3.width + 5);
                var _loc7 = _loc5 + (5 + _loc3.height) * (_loc2 > 9 ? (1) : (0));
                aTarget["_ctr" + _loc2] = {x: _loc6, y: _loc7};
                _loc3.onEnterFrame = function ()
                {
                    this._x = this._x + (aTarget[this._name].x - this._x) / 2;
                    this._y = this._y + (aTarget[this._name].y - this._y) / 2;
                    this._alpha = this._alpha + (100 - this._alpha) / 2;
                    if (Math.abs(this._x - aTarget[this._name].x) < 5.000000E-001 && (Math.abs(this._y - aTarget[this._name].y) < 5.000000E-001 && Math.abs(this._alpha - 100) < 5.000000E-001))
                    {
                        delete this.onEnterFrame;
                    } // end if
                };
            } // end while
            var ref = this._parent;
            var _loc8 = 0;
            this.onEnterFrame = function ()
            {
                var _loc2 = (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y) / 2;
                ref._mcSpellDesc._y = ref._mcSpellDesc._y + _loc2;
                ref._mcWindowBg._y = ref._mcWindowBg._y + _loc2;
                if (Math.abs(ref._mcSpellDesc._y - ref._mcPlacerAllSpell._y) < 5.000000E-001)
                {
                    ref._mcWindowBg._y = ref._mcWindowBg._y + (ref._mcPlacerAllSpell._y - ref._mcSpellDesc._y);
                    ref._mcSpellDesc._y = ref._mcPlacerAllSpell._y;
                    delete this.onEnterFrame;
                } // end if
            };
            this._parent._mcBgViewAllSpell1._visible = false;
            this._parent._mcBgViewAllSpell2._visible = false;
            this._parent._lbViewSpell._visible = false;
            delete this.onRelease;
        };
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
        {
            var _loc3 = this["_ctr" + _loc2];
            _loc3.addEventListener("over", this);
            _loc3.addEventListener("out", this);
            _loc3.addEventListener("click", this);
        } // end while
    };
    _loc1.initData = function ()
    {
        var _loc2 = dofus.Constants.SPELLS_ICONS_PATH;
        var _loc3 = this.api.lang.getClassText(this._nBreed).s;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < dofus.graphics.gapi.ui.SpellViewerOnCreate.SPELLS_DISPLAYED)
        {
            var _loc5 = this["_ctr" + _loc4];
            _loc5.contentPath = _loc2 + _loc3[_loc4] + ".swf";
            _loc5.params = {spellID: _loc3[_loc4]};
            _loc5._alpha = _loc4 < 3 ? (100) : (0);
        } // end while
        this.showSpellInfo(_loc3[0], 1);
    };
    _loc1.showSpellInfo = function (nSpellID, nLevel)
    {
        this._nSpellID = nSpellID;
        var _loc4 = this.api.kernel.CharactersManager.getSpellObjectFromData(nSpellID + "~" + nLevel + "~");
        if (!_loc4.isValid)
        {
            if (nLevel != 1)
            {
                this.showSpellInfo(nSpellID, 1);
                return;
            }
            else
            {
                _loc4 = undefined;
            } // end if
        } // end else if
        var _loc5 = 1;
        
        while (++_loc5, _loc5 < 7)
        {
            var _loc6 = this["_btnLevel" + _loc5];
            _loc6.selected = _loc5 == nLevel;
        } // end while
        if (_loc4.name == undefined)
        {
            this._mcSpellDesc._lblSpellName.text = "";
            this._mcSpellDesc._lblSpellRange.text = "";
            this._mcSpellDesc._lblSpellAP.text = "";
            this._mcSpellDesc._txtSpellDescription.text = "";
            this._mcSpellDesc._ldrSpellBig.contentPath = "";
        }
        else if (this._mcSpellDesc._lblSpellName.text != undefined)
        {
            this._mcSpellDesc._lblSpellName.text = _loc4.name;
            this._mcSpellDesc._lblSpellRange.text = this.api.lang.getText("RANGEFULL") + " : " + _loc4.rangeStr;
            this._mcSpellDesc._lblSpellAP.text = this.api.lang.getText("ACTIONPOINTS") + " : " + _loc4.apCost;
            this._mcSpellDesc._txtSpellDescription.text = _loc4.description + "\n" + _loc4.descriptionNormalHit;
            this._mcSpellDesc._ldrSpellBig.contentPath = _loc4.iconFile;
        } // end else if
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._bhClose:
            case this._btnClose:
            {
                this.unloadThis();
                break;
            } 
            default:
            {
                this.showSpellInfo(oEvent.target.params.spellID, 1);
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.gapi.showTooltip(this.api.lang.getText("CLOSE"), oEvent.target, -20);
                break;
            } 
            default:
            {
                var _loc3 = (dofus.datacenter.Spell)(this.api.kernel.CharactersManager.getSpellObjectFromData(oEvent.target.params.spellID + "~1~"));
                this.gapi.showTooltip(_loc3.name + ", " + this.api.lang.getText("REQUIRED_SPELL_LEVEL").toLowerCase() + ": " + _loc3.minPlayerLevel, oEvent.target, -20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.addProperty("breed", _loc1.__get__breed, _loc1.__set__breed);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.SpellViewerOnCreate = function ()
    {
        super();
    }).CLASS_NAME = "SpellViewerOnCreate";
    (_global.dofus.graphics.gapi.ui.SpellViewerOnCreate = function ()
    {
        super();
    }).SPELLS_DISPLAYED = 20;
} // end if
#endinitclip
