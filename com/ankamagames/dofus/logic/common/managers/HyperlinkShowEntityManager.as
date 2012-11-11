package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import flash.display.*;
    import flash.geom.*;

    public class HyperlinkShowEntityManager extends Object
    {

        public function HyperlinkShowEntityManager()
        {
            return;
        }// end function

        public static function showEntity(param1:int, param2:int = 0) : Sprite
        {
            var _loc_4:* = null;
            var _loc_3:* = DofusEntities.getEntity(param1) as DisplayObject;
            if (_loc_3)
            {
                if (param2)
                {
                    HyperlinkShowCellManager.showCell((_loc_3 as IEntity).position.cellId);
                    return null;
                }
                _loc_4 = _loc_3.getRect(Berilia.getInstance().docMain);
                return HyperlinkDisplayArrowManager.showAbsoluteArrow(int(_loc_4.x), int(_loc_4.y));
            }
            else
            {
                return null;
            }
        }// end function

    }
}
