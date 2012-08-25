// Action script...

// [Initial MovieClip Action of sprite 20884]
#initclip 149
if (!dofus.datacenter.MonsterGroup)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.MonsterGroup = function (sID, clipClass, sGfxFile, cellNum, dir, bonus)
    {
        super();
        this.api = _global.API;
        this._nBonusValue = bonus;
        this.initialize(sID, clipClass, sGfxFile, cellNum, dir, null);
    }).prototype;
    _loc1.__set__name = function (value)
    {
        this._aNamesList = new Array();
        var _loc3 = value.split(",");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = this.api.lang.getMonstersText(_loc3[_loc4]);
            this._aNamesList.push(_loc5.n);
            if (_loc5.a != -1)
            {
                this._nAlignmentIndex = _loc5.a;
            } // end if
        } // end while
        //return (this.name());
    };
    _loc1.__get__name = function ()
    {
        return (this.getName());
    };
    _loc1.getName = function (sEndChar)
    {
        sEndChar = sEndChar == undefined ? ("\n") : (sEndChar);
        var _loc3 = new Array();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < this._aLevelsList.length)
        {
            _loc3.push({level: Number(this._aLevelsList[_loc4]), name: this._aNamesList[_loc4]});
        } // end while
        _loc3.sortOn(["level"], Array.DESCENDING | Array.NUMERIC);
        var _loc5 = new String();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc3.length)
        {
            var _loc7 = _loc3[_loc6];
            _loc5 = _loc5 + (_loc7.name + " (" + _loc7.level + ")" + sEndChar);
        } // end while
        return (_loc5);
    };
    _loc1.alertChatText = function ()
    {
        var _loc2 = this.api.datacenter.Map;
        return ("Groupe niveau " + this.totalLevel + " en " + _loc2.x + "," + _loc2.y + " : <br/>" + this.getName("<br/>"));
    };
    _loc1.__set__Level = function (value)
    {
        this._aLevelsList = value.split(",");
        //return (this.Level());
    };
    _loc1.__get__totalLevel = function ()
    {
        var _loc2 = 0;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._aLevelsList.length)
        {
            _loc2 = _loc2 + Number(this._aLevelsList[_loc3]);
        } // end while
        return (_loc2);
    };
    _loc1.__get__bonusValue = function ()
    {
        return (this._nBonusValue);
    };
    _loc1.__get__alignment = function ()
    {
        return (new dofus.datacenter.Alignment(this._nAlignmentIndex, 0));
    };
    _loc1.addProperty("alignment", _loc1.__get__alignment, function ()
    {
    });
    _loc1.addProperty("name", _loc1.__get__name, _loc1.__set__name);
    _loc1.addProperty("bonusValue", _loc1.__get__bonusValue, function ()
    {
    });
    _loc1.addProperty("totalLevel", _loc1.__get__totalLevel, function ()
    {
    });
    _loc1.addProperty("Level", function ()
    {
    }, _loc1.__set__Level);
    ASSetPropFlags(_loc1, null, 1);
    _loc1._sDefaultAnimation = "static";
    _loc1._bAllDirections = false;
    _loc1._bForceWalk = true;
    _loc1._nAlignmentIndex = -1;
} // end if
#endinitclip
