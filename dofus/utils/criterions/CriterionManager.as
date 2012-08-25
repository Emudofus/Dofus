// Action script...

// [Initial MovieClip Action of sprite 20535]
#initclip 56
if (!dofus.utils.criterions.CriterionManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.criterions)
    {
        _global.dofus.utils.criterions = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).prototype;
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).fillingCriterions = function (sCriterions)
    {
        var _loc3 = sCriterions.split("|");
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = String(_loc3[_loc4]).split("&");
            if (_loc5.length == 0)
            {
                continue;
            } // end if
            var _loc6 = 0;
            var _loc7 = 0;
            
            while (++_loc7, _loc7 < _loc5.length)
            {
                var _loc8 = dofus.utils.criterions.CriterionManager.parseCriterion(_loc5[_loc7]);
                if (_loc8.isFilled())
                {
                    ++_loc6;
                } // end if
            } // end while
            if (_loc6 == _loc5.length)
            {
                return (true);
            } // end if
        } // end while
        return (false);
    };
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).parseCriterion = function (sCriterion)
    {
        var _loc3 = sCriterion.charAt(0);
        var _loc4 = sCriterion.charAt(1);
        var _loc5 = sCriterion.charAt(2);
        var _loc6 = sCriterion.substring(3);
        switch (_loc3)
        {
            case dofus.utils.criterions.CriterionManager.MAIN_TYPE_AREA:
            {
                switch (_loc4)
                {
                    case dofus.utils.criterions.CriterionManager.TYPE_AREA_ALIGNMENT:
                    {
                        var _loc7 = new dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment(_loc5, Number(_loc6));
                        break;
                    } 
                } // End of switch
                break;
            } 
            case dofus.utils.criterions.CriterionManager.MAIN_TYPE_BASIC:
            {
                switch (_loc4)
                {
                    case dofus.utils.criterions.CriterionManager.TYPE_BASIC_EPISOD:
                    {
                        _loc7 = new dofus.utils.criterions.basicCriterion.BasicCriterionEpisod(_loc5, Number(_loc6));
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
        if (_loc7 == null || !_loc7.check())
        {
            return (null);
        } // end if
        return (_loc7);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).MAIN_TYPE_AREA = "A";
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).TYPE_AREA_ALIGNMENT = "A";
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).MAIN_TYPE_BASIC = "B";
    (_global.dofus.utils.criterions.CriterionManager = function ()
    {
    }).TYPE_BASIC_EPISOD = "E";
} // end if
#endinitclip
