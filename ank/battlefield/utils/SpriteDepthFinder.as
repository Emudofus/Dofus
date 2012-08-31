// Action script...

// [Initial MovieClip Action of sprite 858]
#initclip 70
class ank.battlefield.utils.SpriteDepthFinder
{
    function SpriteDepthFinder()
    {
    } // End of the function
    static function getFreeDepthOnCell(mapHandler, oSprites, nCellNum, bGhostView)
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
        var _loc4 = mapHandler.getCellData(nCellNum).allSpritesOn;
        var _loc2 = new Object();
        for (var _loc7 in _loc4)
        {
            _loc2[oSprites.getItemAt(_loc7).mc.getDepth()] = true;
        } // end of for...in
        var _loc3 = nCellNum * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (bGhostView ? (ank.battlefield.Constants.MAX_DEPTH_IN_MAP) : (0));
        var _loc1;
        for (var _loc1 = 0; _loc1 < ank.battlefield.Constants.MAX_SPRITES_ON_CELL; ++_loc1)
        {
            if (_loc2[_loc3 + _loc1] == undefined)
            {
                break;
            } // end if
        } // end of for
        if (_loc1 == ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
        {
            ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
        } // end if
        return (_loc3 + _loc1);
    } // End of the function
} // End of Class
#endinitclip
