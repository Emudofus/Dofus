// Action script...

// [Initial MovieClip Action of sprite 20506]
#initclip 27
if (!dofus.datacenter.Skill)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.Skill = function (nID, nParam1, nParam2, nParam3, nParam4)
    {
        super();
        this.initialize(nID, nParam1, nParam2, nParam3, nParam4);
    }).prototype;
    _loc1.__get__id = function ()
    {
        return (this._nID);
    };
    _loc1.__get__description = function ()
    {
        return (this._oSkillText.d);
    };
    _loc1.__get__job = function ()
    {
        return (this._oSkillText.j);
    };
    _loc1.__get__criterion = function ()
    {
        return (this._oSkillText.c);
    };
    _loc1.__get__item = function ()
    {
        if (this._oSkillText.i == undefined)
        {
            return (null);
        } // end if
        return (new dofus.datacenter.Item(0, this._oSkillText.i));
    };
    _loc1.__get__interactiveObject = function ()
    {
        return (this.api.lang.getInteractiveObjectDataText(this._oSkillText.io).n);
    };
    _loc1.__get__param1 = function ()
    {
        return (this._nParam1);
    };
    _loc1.__get__param2 = function ()
    {
        return (this._nParam2);
    };
    _loc1.__get__param3 = function ()
    {
        return (this._nParam3);
    };
    _loc1.__get__param4 = function ()
    {
        return (this._nParam4);
    };
    _loc1.__get__craftsList = function ()
    {
        if (this._oCraftsList instanceof Array)
        {
            return (this._oCraftsList);
        } // end if
        this._oCraftsList = new Array();
        var _loc2 = 0;
        
        while (++_loc2, _loc2 < this._oSkillText.cl.length)
        {
            var _loc3 = this.api.lang.getItemUnicText(this._oSkillText.cl[_loc2]).ep;
            if (_loc3 <= this.api.datacenter.Basics.aks_current_regional_version && (_loc3 != undefined && !_global.isNaN(_loc3)))
            {
                this._oCraftsList.push(this._oSkillText.cl[_loc2]);
            } // end if
        } // end while
        return (this._oCraftsList);
    };
    _loc1.initialize = function (nID, nParam1, nParam2, nParam3, nParam4)
    {
        this.api = _global.API;
        this._nID = nID;
        if (nParam1 != 0)
        {
            this._nParam1 = nParam1;
        } // end if
        if (nParam2 != 0)
        {
            this._nParam2 = nParam2;
        } // end if
        if (nParam3 != 0)
        {
            this._nParam3 = nParam3;
        } // end if
        if (nParam4 != 0)
        {
            this._nParam4 = nParam4;
        } // end if
        this._oSkillText = this.api.lang.getSkillText(nID);
        this.skillName = this.description;
    };
    _loc1.getState = function (bJob, bOwner, bForSale, bLocked, bIndoor, bNovice)
    {
        if (this.criterion == undefined || this.criterion.length == 0)
        {
            return ("V");
        } // end if
        var _loc8 = this.criterion.split("?");
        var _loc9 = _loc8[0].split("&");
        var _loc10 = _loc8[1].split(":");
        var _loc11 = _loc10[0];
        var _loc12 = _loc10[1];
        var _loc13 = 0;
        
        while (++_loc13, _loc13 < _loc9.length)
        {
            var _loc14 = _loc9[_loc13];
            var _loc15 = _loc14.charAt(0) == "!";
            if (_loc15)
            {
                _loc14 = _loc14.substr(1);
            } // end if
            switch (_loc14)
            {
                case "J":
                {
                    if (_loc15)
                    {
                        bJob = !bJob;
                    } // end if
                    if (!bJob)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
                case "O":
                {
                    if (_loc15)
                    {
                        bOwner = !bOwner;
                    } // end if
                    if (!bOwner)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
                case "S":
                {
                    if (_loc15)
                    {
                        bForSale = !bForSale;
                    } // end if
                    if (!bForSale)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
                case "L":
                {
                    if (_loc15)
                    {
                        bLocked = !bLocked;
                    } // end if
                    if (!bLocked)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
                case "I":
                {
                    if (_loc15)
                    {
                        bIndoor = !bIndoor;
                    } // end if
                    if (!bIndoor)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
                case "N":
                {
                    if (_loc15)
                    {
                        bNovice = !bNovice;
                    } // end if
                    if (!bNovice)
                    {
                        return (_loc12);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end while
        return (_loc11);
    };
    _loc1.addProperty("param2", _loc1.__get__param2, function ()
    {
    });
    _loc1.addProperty("param3", _loc1.__get__param3, function ()
    {
    });
    _loc1.addProperty("interactiveObject", _loc1.__get__interactiveObject, function ()
    {
    });
    _loc1.addProperty("param4", _loc1.__get__param4, function ()
    {
    });
    _loc1.addProperty("description", _loc1.__get__description, function ()
    {
    });
    _loc1.addProperty("item", _loc1.__get__item, function ()
    {
    });
    _loc1.addProperty("criterion", _loc1.__get__criterion, function ()
    {
    });
    _loc1.addProperty("job", _loc1.__get__job, function ()
    {
    });
    _loc1.addProperty("craftsList", _loc1.__get__craftsList, function ()
    {
    });
    _loc1.addProperty("id", _loc1.__get__id, function ()
    {
    });
    _loc1.addProperty("param1", _loc1.__get__param1, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
