// Action script...

// [Initial MovieClip Action of sprite 881]
#initclip 93
class dofus.datacenter.Effect extends Object
{
    var _nType, _nParam1, _nParam2, _nParam3, _nParam4, _nRemainingTurn, __get__remainingTurn, _nSpellID, api, __get__operator, __get__characteristic, __get__description, __get__element, __get__param1, __get__param2, __get__param3, __get__param4, __set__remainingTurn, __get__remainingTurnStr, __get__showInTooltip, __get__spellID, __get__spellName, __get__type;
    function Effect(mType, mParam1, mParam2, mParam3, mParam4, mRemainingTurn, mSpellID)
    {
        super();
        this.initialize(mType, mParam1, mParam2, mParam3, mParam4, mRemainingTurn, mSpellID);
    } // End of the function
    function get type()
    {
        return (_nType);
    } // End of the function
    function get param1()
    {
        return (_nParam1);
    } // End of the function
    function get param2()
    {
        return (_nParam2);
    } // End of the function
    function get param3()
    {
        return (_nParam3);
    } // End of the function
    function get param4()
    {
        return (_nParam4);
    } // End of the function
    function set remainingTurn(nRremainingTurn)
    {
        _nRemainingTurn = nRremainingTurn;
        //return (this.remainingTurn());
        null;
    } // End of the function
    function get remainingTurn()
    {
        return (_nRemainingTurn);
    } // End of the function
    function get remainingTurnStr()
    {
        return (this.getTurnCountStr(true));
    } // End of the function
    function get spellID()
    {
        return (_nSpellID);
    } // End of the function
    function get description()
    {
        var _loc8 = api.lang.getEffectText(_nType).d;
        var _loc2 = [_nParam1, _nParam2, _nParam3, _nParam4];
        switch (_nType)
        {
            case 10:
            {
                _loc2[2] = api.lang.getEmoteText(_nParam3).n;
                break;
            } 
            case 601:
            {
                var _loc3 = api.lang.getMapText(String(_nParam2));
                _loc2[0] = api.lang.getMapSubAreaText(_loc3.sa).n;
                _loc2[1] = _loc3.x;
                _loc2[2] = _loc3.y;
                break;
            } 
            case 614:
            {
                _loc2[0] = _nParam3;
                _loc2[1] = api.lang.getJobText(_nParam2).n;
                break;
            } 
            case 615:
            {
                _loc2[2] = api.lang.getJobText(_nParam3).n;
                break;
            } 
            case 616:
            {
                _loc2[2] = api.lang.getSpellText(_nParam3).n;
                break;
            } 
            case 165:
            {
                _loc2[0] = api.lang.getItemTypeText(_nParam1).n;
                break;
            } 
            case 805:
            case 808:
            {
                var _loc10 = String(Math.floor(_nParam2) / 100).split(".");
                var _loc4 = Number(_loc10[0]);
                var _loc11 = _nParam2 - _loc4 * 100;
                var _loc12 = String(Math.floor(_nParam3) / 100).split(".");
                var _loc5 = Number(_loc12[0]);
                var _loc9 = _nParam3 - _loc5 * 100;
                _loc2[0] = ank.utils.PatternDecoder.getDescription(api.lang.getConfigText("DATE_FORMAT"), [_nParam1, String(_loc4 + 1).addLeftChar("0", 2), String(_loc11).addLeftChar("0", 2), _loc5, String(_loc9).addLeftChar("0", 2)]);
                break;
            } 
            case 806:
            {
                if (_nParam2 == undefined && _nParam3 == undefined)
                {
                    _loc2[0] = api.lang.getText("NORMAL");
                }
                else
                {
                    _loc2[0] = _nParam2 > 6 ? (api.lang.getText("FAT")) : (_nParam3 > 6 ? (api.lang.getText("LEAN")) : (api.lang.getText("NORMAL")));
                } // end else if
                break;
            } 
            case 807:
            {
                if (_nParam3 == undefined)
                {
                    _loc2[0] = api.lang.getText("NO_LAST_MEAL");
                }
                else
                {
                    _loc2[0] = api.lang.getItemUnicText(_nParam3).n;
                } // end else if
                break;
            } 
        } // End of switch
        var _loc6 = ank.utils.PatternDecoder.getDescription(_loc8, _loc2);
        var _loc7 = this.getTurnCountStr(false);
        if (_loc7.length == 0)
        {
            return (_loc6);
        }
        else
        {
            return (_loc6 + " (" + _loc7 + ")");
        } // end else if
    } // End of the function
    function get characteristic()
    {
        return (api.lang.getEffectText(_nType).c);
    } // End of the function
    function get operator()
    {
        return (api.lang.getEffectText(_nType).o);
    } // End of the function
    function get element()
    {
        return (api.lang.getEffectText(_nType).e);
    } // End of the function
    function get spellName()
    {
        return (api.lang.getSpellText(_nSpellID).n);
    } // End of the function
    function get showInTooltip()
    {
        return (api.lang.getEffectText(_nType).t);
    } // End of the function
    function initialize(mType, mParam1, mParam2, mParam3, mParam4, mRemainingTurn, mSpellID)
    {
        api = _global.API;
        _nType = Number(mType);
        _nParam1 = isNaN(Number(mParam1)) ? (undefined) : (Number(mParam1));
        _nParam2 = isNaN(Number(mParam2)) ? (undefined) : (Number(mParam2));
        _nParam3 = isNaN(Number(mParam3)) ? (undefined) : (Number(mParam3));
        _nParam4 = isNaN(Number(mParam3)) ? (undefined) : (Number(mParam3));
        _nRemainingTurn = mRemainingTurn == undefined ? (0) : (Number(mRemainingTurn));
        if (_nRemainingTurn < 0 || _nRemainingTurn >= 63)
        {
            _nRemainingTurn = Number.POSITIVE_INFINITY;
        } // end if
        _nSpellID = Number(mSpellID);
    } // End of the function
    function getParamWithOperator(nParamID)
    {
        var _loc2 = this.__get__operator() == "-" ? (-1) : (1);
        return (this["_nParam" + nParamID] * _loc2);
    } // End of the function
    function getTurnCountStr(bShowLast)
    {
        var _loc2 = new String();
        if (_nRemainingTurn == undefined)
        {
            return ("");
        } // end if
        if (isFinite(_nRemainingTurn))
        {
            if (_nRemainingTurn > 1)
            {
                return (String(_nRemainingTurn) + " " + api.lang.getText("TURNS"));
            }
            else if (_nRemainingTurn == 0)
            {
                return ("");
            }
            else if (bShowLast)
            {
                return (api.lang.getText("LAST_TURN"));
            }
            else
            {
                return (String(_nRemainingTurn) + " " + api.lang.getText("TURN"));
            } // end else if
        }
        else
        {
            return (api.lang.getText("INFINIT"));
        } // end else if
    } // End of the function
} // End of Class
#endinitclip
