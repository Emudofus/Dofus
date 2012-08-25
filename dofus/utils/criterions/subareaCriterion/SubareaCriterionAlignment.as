// Action script...

// [Initial MovieClip Action of sprite 20806]
#initclip 71
if (!dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment)
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
    if (!dofus.utils.criterions.subareaCriterion)
    {
        _global.dofus.utils.criterions.subareaCriterion = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment = function ()
    {
        super();
    }).prototype;
    _loc1.AreaCriterionAlignment = function (sOperator, nAlignmentIndex)
    {
        this._sOperator = sOperator;
        this._nAlignmentIndex = nAlignmentIndex;
        this._aSubarea = (dofus.datacenter.Subarea)(this.api.datacenter.Subareas.getItemAt(this.api.datacenter.Map.subarea));
    };
    _loc1.isFilled = function ()
    {
        var _loc2 = this._aSubarea.alignment;
        switch (this._sOperator)
        {
            case "=":
            {
                return (this._aSubarea.alignment.index == this._nAlignmentIndex);
            } 
            case "!":
            {
                return (this._aSubarea.alignment.index != this._nAlignmentIndex);
            } 
        } // End of switch
        return (false);
    };
    _loc1.check = function ()
    {
        return ("=!".indexOf(this._sOperator) > -1);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
