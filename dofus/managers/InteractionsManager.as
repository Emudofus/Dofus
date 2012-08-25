// Action script...

// [Initial MovieClip Action of sprite 20792]
#initclip 57
if (!dofus.managers.InteractionsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.InteractionsManager = function (playerManager, oAPI)
    {
        super();
        this.initialize(playerManager, oAPI);
    }).prototype;
    _loc1.initialize = function (playerManager, oAPI)
    {
        super.initialize(oAPI);
        this._playerManager = playerManager;
    };
    _loc1.setState = function (bFight)
    {
        if (bFight)
        {
            this._state = dofus.managers.InteractionsManager.STATE_SELECT;
            this._playerManager.lastClickedCell = null;
        }
        else
        {
            this._state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
        } // end else if
    };
    _loc1.calculatePath = function (mapHandler, cell, bRelease, bIsFight, bIgnoreSprites, bAllDir)
    {
        if (cell == this._playerManager.data.cellNum)
        {
            return (false);
        } // end if
        var _loc8 = mapHandler.getCellData(cell);
        var _loc9 = bIgnoreSprites ? (false) : (_loc8.spriteOnID == undefined ? (false) : (true));
        if (_loc9)
        {
            return (false);
        } // end if
        if (_loc8.movement == 0)
        {
            return (false);
        } // end if
        if (_loc8.movement == 1 && bIsFight)
        {
            return (false);
        } // end if
        switch (this._state)
        {
            case dofus.managers.InteractionsManager.STATE_MOVE_SINGLE:
            {
                this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler, this._playerManager.data.cellNum, cell, {bAllDirections: bAllDir, bIgnoreSprites: bIgnoreSprites});
                if (this.api.datacenter.Basics.interactionsManager_path != null)
                {
                    return (true);
                } // end if
                return (false);
                break;
            } 
            case dofus.managers.InteractionsManager.STATE_SELECT:
            {
                if (bRelease)
                {
                    this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path), dofus.Constants.CELL_PATH_SELECT_COLOR);
                    return (this.api.datacenter.Basics.interactionsManager_path != null);
                }
                else
                {
                    this.api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler, this._playerManager.data.cellNum, cell, {bAllDirections: false, nMaxLength: bIsFight ? (this._playerManager.data.MP) : (500)});
                    this.api.gfx.unSelect(true);
                    this.api.gfx.select(this.convertToSimplePath(this.api.datacenter.Basics.interactionsManager_path), dofus.Constants.CELL_PATH_OVER_COLOR);
                } // end else if
                break;
            } 
        } // End of switch
        return (false);
    };
    _loc1.convertToSimplePath = function (aFullPath)
    {
        var _loc3 = new Array();
        for (var k in aFullPath)
        {
            _loc3.push(aFullPath[k].num);
        } // end of for...in
        return (_loc3);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.InteractionsManager = function (playerManager, oAPI)
    {
        super();
        this.initialize(playerManager, oAPI);
    }).STATE_MOVE_SINGLE = 0;
    (_global.dofus.managers.InteractionsManager = function (playerManager, oAPI)
    {
        super();
        this.initialize(playerManager, oAPI);
    }).STATE_SELECT = 1;
} // end if
#endinitclip
