// Action script...

// [Initial MovieClip Action of sprite 20649]
#initclip 170
if (!dofus.datacenter.Mount)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Mount = function (nModelID, nChevauchorGfxID, bNewBorn)
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        this.newBorn = bNewBorn;
        this.modelID = nModelID;
        this._lang = _global.API.lang.getMountText(this.modelID);
        this.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + this._lang.g + ".swf";
        this.chevauchorGfxID = nChevauchorGfxID;
    }).prototype;
    _loc1.__set__name = function (value)
    {
        this._sName = value;
        this.dispatchEvent({type: "nameChanged", name: value});
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this._sName);
    };
    _loc1.__set__pods = function (value)
    {
        this._nPods = value;
        this.dispatchEvent({type: "podsChanged", pods: value});
        //return (this.pods());
    };
    _loc1.__get__pods = function ()
    {
        return (this._nPods);
    };
    _loc1.__get__label = function ()
    {
        return (this._lang.n);
    };
    _loc1.__get__modelName = function ()
    {
        return (this._lang.n);
    };
    _loc1.__get__gfxID = function ()
    {
        return (this._lang.g);
    };
    _loc1.__set__chevauchorGfxID = function (nID)
    {
        this._nChevauchorGfxID = nID;
        this.chevauchorGfxFile = dofus.Constants.CHEVAUCHOR_PATH + nID + ".swf";
        //return (this.chevauchorGfxID());
    };
    _loc1.__get__chevauchorGfxID = function ()
    {
        return (this._nChevauchorGfxID);
    };
    _loc1.__get__color1 = function ()
    {
        if (!_global.isNaN(this.customColor1))
        {
            return (this.customColor1);
        } // end if
        return (this._lang.c1);
    };
    _loc1.__get__color2 = function ()
    {
        if (!_global.isNaN(this.customColor2))
        {
            return (this.customColor2);
        } // end if
        return (this._lang.c2);
    };
    _loc1.__get__color3 = function ()
    {
        if (!_global.isNaN(this.customColor3))
        {
            return (this.customColor3);
        } // end if
        return (this._lang.c3);
    };
    _loc1.__get__mature = function ()
    {
        return (this.maturity == this.maturityMax && (this.maturity != undefined && this.maturityMax != undefined));
    };
    _loc1.__get__effects = function ()
    {
        return (dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects));
    };
    _loc1.setEffects = function (compressedData)
    {
        this._sEffects = compressedData;
        this._aEffects = new Array();
        var _loc3 = compressedData.split(",");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4].split("#");
            _loc5[0] = _global.parseInt(_loc5[0], 16);
            _loc5[1] = _loc5[1] == "0" ? (undefined) : (_global.parseInt(_loc5[1], 16));
            _loc5[2] = _loc5[2] == "0" ? (undefined) : (_global.parseInt(_loc5[2], 16));
            _loc5[3] = _loc5[3] == "0" ? (undefined) : (_global.parseInt(_loc5[3], 16));
            _loc5[4] = _loc5[4];
            this._aEffects.push(_loc5);
        } // end while
    };
    _loc1.getToolTip = function ()
    {
        var _loc2 = this.modelName;
        _loc2 = _loc2 + ("\n" + _global.API.lang.getText("NAME_BIG") + " : " + this.name);
        _loc2 = _loc2 + ("\n" + _global.API.lang.getText("LEVEL") + " : " + this.level);
        _loc2 = _loc2 + ("\n" + _global.API.lang.getText("CREATE_SEX") + " : " + (this.sex ? (_global.API.lang.getText("ANIMAL_WOMEN")) : (_global.API.lang.getText("ANIMAL_MEN"))));
        _loc2 = _loc2 + ("\n" + _global.API.lang.getText("MOUNTABLE") + " : " + (this.mountable ? (_global.API.lang.getText("YES")) : (_global.API.lang.getText("NO"))));
        _loc2 = _loc2 + ("\n" + _global.API.lang.getText("WILD") + " : " + (this.wild ? (_global.API.lang.getText("YES")) : (_global.API.lang.getText("NO"))));
        if (this.fecondation > 0)
        {
            _loc2 = _loc2 + ("\n" + _global.API.lang.getText("PREGNANT_SINCE", [this.fecondation]));
        }
        else if (this.fecondable)
        {
            _loc2 = _loc2 + ("\n" + _global.API.lang.getText("FECONDABLE"));
        } // end else if
        return (_loc2);
    };
    _loc1.addProperty("color3", _loc1.__get__color3, function ()
    {
    });
    _loc1.addProperty("label", _loc1.__get__label, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("modelName", _loc1.__get__modelName, function ()
    {
    });
    _loc1.addProperty("pods", _loc1.__get__pods, _loc1.__set__pods);
    _loc1.addProperty("effects", _loc1.__get__effects, function ()
    {
    });
    _loc1.addProperty("mature", _loc1.__get__mature, function ()
    {
    });
    _loc1.addProperty("color1", _loc1.__get__color1, function ()
    {
    });
    _loc1.addProperty("chevauchorGfxID", _loc1.__get__chevauchorGfxID, _loc1.__set__chevauchorGfxID);
    _loc1.addProperty("gfxID", _loc1.__get__gfxID, function ()
    {
    });
    _loc1.addProperty("color2", _loc1.__get__color2, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    _loc1.useCustomColor = false;
} // end if
#endinitclip
