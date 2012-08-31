// Action script...

// [Initial MovieClip Action of sprite 915]
#initclip 127
class dofus.managers.InteractionsManager extends dofus.utils.ApiElement
{
    var _playerManager, _state, api;
    function InteractionsManager(playerManager, oAPI)
    {
        super();
        this.initialize(playerManager, oAPI);
    } // End of the function
    function initialize(playerManager, oAPI)
    {
        super.initialize(oAPI);
        _playerManager = playerManager;
    } // End of the function
    function setState(bFight)
    {
        if (bFight)
        {
            _state = dofus.managers.InteractionsManager.STATE_SELECT;
            _playerManager.lastClickedCell = null;
        }
        else
        {
            _state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
        } // end else if
    } // End of the function
    function calculatePath(mapHandler, cell, bRelease, bIsFight, bIgnoreSprites)
    {
        if (cell == _playerManager.data.cellNum)
        {
            return (false);
        } // end if
        var _loc2 = mapHandler.getCellData(cell);
        var _loc5 = bIgnoreSprites ? (false) : (_loc2.spriteOnID == undefined ? (false) : (true));
        if (_loc5)
        {
            return (false);
        } // end if
        if (_loc2.movement == 0)
        {
            return (false);
        } // end if
        if (_loc2.movement == 1 && bIsFight)
        {
            return (false);
        } // end if
        switch (_state)
        {
            case dofus.managers.InteractionsManager.STATE_MOVE_SINGLE:
            {
                api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler, _playerManager.data.cellNum, cell, {bAllDirections: true, bIgnoreSprites: bIgnoreSprites});
                if (api.datacenter.Basics.interactionsManager_path != null)
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
                    api.gfx.select(this.convertToSimplePath(api.datacenter.Basics.interactionsManager_path), dofus.Constants.CELL_PATH_SELECT_COLOR);
                    return (api.datacenter.Basics.interactionsManager_path != null);
                }
                else
                {
                    api.datacenter.Basics.interactionsManager_path = ank.battlefield.utils.Pathfinding.pathFind(mapHandler, _playerManager.data.cellNum, cell, {bAllDirections: false, nMaxLength: bIsFight ? (_playerManager.data.MP) : (500)});
                    api.gfx.unSelect(true);
                    api.gfx.select(this.convertToSimplePath(api.datacenter.Basics.interactionsManager_path), dofus.Constants.CELL_PATH_OVER_COLOR);
                } // end else if
                break;
            } 
        } // End of switch
        return (false);
    } // End of the function
    function convertToSimplePath(aFullPath)
    {
        var _loc2 = new Array();
        for (var _loc3 in aFullPath)
        {
            _loc2.push(aFullPath[_loc3].num);
        } // end of for...in
        return (_loc2);
    } // End of the function
    static var STATE_MOVE_SINGLE = 0;
    static var STATE_SELECT = 1;
} // End of Class
#endinitclip
