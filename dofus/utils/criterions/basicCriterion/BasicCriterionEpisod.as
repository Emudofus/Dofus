// Action script...

// [Initial MovieClip Action of sprite 20865]
#initclip 130
if (!dofus.utils.criterions.basicCriterion.BasicCriterionEpisod)
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
    if (!dofus.utils.criterions.basicCriterion)
    {
        _global.dofus.utils.criterions.basicCriterion = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.criterions.basicCriterion.BasicCriterionEpisod = function (sOperator, nValue)
    {
        super();
        this._sOperator = sOperator;
        this._nValue = nValue;
    }).prototype;
    _loc1.isFilled = function ()
    {
        var _loc2 = this.api.datacenter.Basics.aks_current_regional_version;
        switch (this._sOperator)
        {
            case "=":
            {
                return (_loc2 == this._nValue);
            } 
            case "!":
            {
                return (_loc2 != this._nValue);
            } 
            case ">":
            {
                return (_loc2 > this._nValue);
            } 
            case "<":
            {
                return (_loc2 < this._nValue);
            } 
        } // End of switch
        return (false);
    };
    _loc1.check = function ()
    {
        return ("=!<>".indexOf(this._sOperator) > -1);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
