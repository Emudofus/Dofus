// Action script...

// [Initial MovieClip Action of sprite 20695]
#initclip 216
if (!dofus.utils.nameChecker.rules.INameCheckerRules)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.nameChecker)
    {
        _global.dofus.utils.nameChecker = new Object();
    } // end if
    if (!dofus.utils.nameChecker.rules)
    {
        _global.dofus.utils.nameChecker.rules = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.nameChecker.rules.INameCheckerRules = function ()
    {
    }).prototype;
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
