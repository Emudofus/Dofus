// Action script...

// [Initial MovieClip Action of sprite 949]
#initclip 161
class dofus.datacenter.Skill extends Object
{
    var _nID, _oSkillText, api, _nParam1, _nParam2, _nParam3, _nParam4, __get__criterion, __get__craftsList, __get__description, __get__id, __get__interactiveObject, __get__item, __get__job, __get__param1, __get__param2, __get__param3, __get__param4;
    function Skill(nID, nParam1, nParam2, nParam3, nParam4)
    {
        super();
        this.initialize(nID, nParam1, nParam2, nParam3, nParam4);
    } // End of the function
    function get id()
    {
        return (_nID);
    } // End of the function
    function get description()
    {
        return (_oSkillText.d);
    } // End of the function
    function get job()
    {
        return (_oSkillText.j);
    } // End of the function
    function get criterion()
    {
        return (_oSkillText.c);
    } // End of the function
    function get item()
    {
        if (_oSkillText.i == undefined)
        {
            return (null);
        } // end if
        return (new dofus.datacenter.Item(0, _oSkillText.i));
    } // End of the function
    function get interactiveObject()
    {
        return (api.lang.getInteractiveObjectDataText(_oSkillText.io).n);
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
    function get craftsList()
    {
        return (_oSkillText.cl);
    } // End of the function
    function initialize(nID, nParam1, nParam2, nParam3, nParam4)
    {
        api = _global.API;
        _nID = nID;
        if (nParam1 != 0)
        {
            _nParam1 = nParam1;
        } // end if
        if (nParam2 != 0)
        {
            _nParam2 = nParam2;
        } // end if
        if (nParam3 != 0)
        {
            _nParam3 = nParam3;
        } // end if
        if (nParam4 != 0)
        {
            _nParam4 = nParam4;
        } // end if
        _oSkillText = api.lang.getSkillText(nID);
    } // End of the function
    function getState(bJob, bOwner, bForSale, bLocked, bIndoor, bNovice)
    {
        if (this.__get__criterion() == undefined || criterion.length == 0)
        {
            return ("V");
        } // end if
        var _loc13 = criterion.split("?");
        var _loc12 = _loc13[0].split("&");
        var _loc14 = _loc13[1].split(":");
        var _loc15 = _loc14[0];
        var _loc3 = _loc14[1];
        for (var _loc5 = 0; _loc5 < _loc12.length; ++_loc5)
        {
            var _loc4 = _loc12[_loc5];
            var _loc2 = _loc4.charAt(0) == "!";
            if (_loc2)
            {
                _loc4 = _loc4.substr(1);
            } // end if
            switch (_loc4)
            {
                case "J":
                {
                    if (_loc2)
                    {
                        bJob = !bJob;
                    } // end if
                    if (!bJob)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
                case "O":
                {
                    if (_loc2)
                    {
                        bOwner = !bOwner;
                    } // end if
                    if (!bOwner)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
                case "S":
                {
                    if (_loc2)
                    {
                        bForSale = !bForSale;
                    } // end if
                    if (!bForSale)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
                case "L":
                {
                    if (_loc2)
                    {
                        bLocked = !bLocked;
                    } // end if
                    if (!bLocked)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
                case "I":
                {
                    if (_loc2)
                    {
                        bIndoor = !bIndoor;
                    } // end if
                    if (!bIndoor)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
                case "N":
                {
                    if (_loc2)
                    {
                        bNovice = !bNovice;
                    } // end if
                    if (!bNovice)
                    {
                        return (_loc3);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end of for
        return (_loc15);
    } // End of the function
} // End of Class
#endinitclip
