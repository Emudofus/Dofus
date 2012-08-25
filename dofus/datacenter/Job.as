// Action script...

// [Initial MovieClip Action of sprite 20893]
#initclip 158
if (!dofus.datacenter.Job)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Job = function (nID, eaSkills, options)
    {
        super();
        this.initialize(nID, eaSkills, options);
    }).prototype;
    _loc1.__set__options = function (o)
    {
        this._oOptions = o;
        this.dispatchEvent({type: "optionsChanged", value: o});
        //return (this.options());
    };
    _loc1.__get__options = function ()
    {
        return (this._oOptions);
    };
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__name = function ()
    {
        return (this._oJobText.n);
    };
    _loc1.__get__description = function ()
    {
        return (this._oJobText.d);
    };
    _loc1.__get__iconFile = function ()
    {
        return (dofus.Constants.JOBS_ICONS_PATH + this._oJobText.g + ".swf");
    };
    _loc1.__get__skills = function ()
    {
        return (this._eaSkills);
    };
    _loc1.__get__crafts = function ()
    {
        return (this._eaCrafts);
    };
    _loc1.__set__level = function (nLevel)
    {
        this._nLevel = nLevel;
        //return (this.level());
    };
    _loc1.__get__level = function ()
    {
        return (this._nLevel);
    };
    _loc1.__set__xpMin = function (nXPmin)
    {
        this._nXPmin = nXPmin;
        //return (this.xpMin());
    };
    _loc1.__get__xpMin = function ()
    {
        return (this._nXPmin);
    };
    _loc1.__set__xp = function (nXP)
    {
        this._nXP = nXP;
        //return (this.xp());
    };
    _loc1.__get__xp = function ()
    {
        return (this._nXP);
    };
    _loc1.__set__xpMax = function (nXPmax)
    {
        this._nXPmax = nXPmax;
        //return (this.xpMax());
    };
    _loc1.__get__xpMax = function ()
    {
        return (this._nXPmax > Math.pow(10, 17) ? (this._nXP) : (this._nXPmax));
    };
    _loc1.__get__specializationOf = function ()
    {
        return (this._oJobText.s);
    };
    _loc1.initialize = function (nID, eaSkills, options)
    {
        mx.events.EventDispatcher.initialize(this);
        this.api = _global.API;
        this._nID = nID;
        this._eaSkills = eaSkills;
        this._oOptions = options;
        this._oJobText = this.api.lang.getJobText(nID);
        if (!_global.isNaN(eaSkills.length))
        {
            this._eaCrafts = new ank.utils.ExtendedArray();
            var _loc5 = new ank.utils.ExtendedArray();
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < eaSkills.length)
            {
                var _loc7 = _loc5.findFirstItem("id", eaSkills[_loc6].id);
                if (_loc7.index == -1)
                {
                    _loc5.push(eaSkills[_loc6]);
                    continue;
                } // end if
                if (_loc7.item.param1 < eaSkills[_loc6].param1)
                {
                    _loc5[_loc7.index] = eaSkills[_loc6];
                } // end if
            } // end while
            var _loc8 = 0;
            
            while (++_loc8, _loc8 < _loc5.length)
            {
                var _loc9 = _loc5[_loc8];
                var _loc10 = _loc9.craftsList;
                if (_loc10 != undefined)
                {
                    var _loc11 = 0;
                    
                    while (++_loc11, _loc11 < _loc10.length)
                    {
                        var _loc12 = _loc10[_loc11];
                        var _loc13 = new dofus.datacenter.Craft(_loc12, _loc9);
                        if (_loc13.itemsCount <= _loc9.param1)
                        {
                            this._eaCrafts.push(_loc13);
                        } // end if
                    } // end while
                } // end if
                this._eaCrafts.sortOn("name");
            } // end while
        } // end if
    };
    _loc1.getMaxSkillSlot = function ()
    {
        var _loc2 = -1;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < this._eaSkills.length)
        {
            var _loc4 = this._eaSkills[_loc3];
            if (_loc4.param1 > _loc2)
            {
                _loc2 = _loc4.param1;
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.addProperty("xpMax", _loc1.__get__xpMax, _loc1.__set__xpMax);
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("iconFile", _loc1.__get__iconFile, function ()
    {
    });
    _loc1.addProperty("crafts", _loc1.__get__crafts, function ()
    {
    });
    _loc1.addProperty("options", _loc1.__get__options, _loc1.__set__options);
    _loc1.addProperty("level", _loc1.__get__level, _loc1.__set__level);
    _loc1.addProperty("specializationOf", _loc1.__get__specializationOf, function ()
    {
    });
    _loc1.addProperty("xp", _loc1.__get__xp, _loc1.__set__xp);
    _loc1.addProperty("skills", _loc1.__get__skills, function ()
    {
    });
    _loc1.addProperty("xpMin", _loc1.__get__xpMin, _loc1.__set__xpMin);
    _loc1.addProperty("name", _loc1.__get__name, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
