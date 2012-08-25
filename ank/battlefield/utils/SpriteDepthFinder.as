// Action script...

// [Initial MovieClip Action of sprite 20829]
#initclip 94
if (!ank.battlefield.utils.SpriteDepthFinder)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.utils)
    {
        _global.ank.battlefield.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.utils.SpriteDepthFinder = function ()
    {
    }).prototype;
    (_global.ank.battlefield.utils.SpriteDepthFinder = function ()
    {
    }).getFreeDepthOnCell = function (mapHandler, oSprites, nCellNum, bGhostView)
    {
        if (nCellNum < 0)
        {
            ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être < 0.");
            nCellNum = 0;
        } // end if
        if (nCellNum > mapHandler.getCellCount())
        {
            ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être > " + mapHandler.getCellCount());
            nCellNum = 0;
        } // end if
        var _loc6 = mapHandler.getCellData(nCellNum).allSpritesOn;
        var _loc7 = new Object();
        for (var k in _loc6)
        {
            _loc7[oSprites.getItemAt(k).mc.getDepth()] = true;
        } // end of for...in
        var _loc8 = nCellNum * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (bGhostView ? (ank.battlefield.Constants.MAX_DEPTH_IN_MAP) : (0));
        var _loc9 = 0;
        
        while (++_loc9, _loc9 < ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
        {
            if (_loc7[_loc8 + _loc9] != true)
            {
                break;
            } // end if
        } // end while
        if (_loc9 == ank.battlefield.Constants.MAX_SPRITES_ON_CELL - 1 && _loc7[_loc8 + _loc9] == true)
        {
            ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
        } // end if
        return (_loc8 + _loc9);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
