package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.jerakine.data.*;
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

        public static function rollOver(param1:int, param2:int, param3:int, param4:int = 0) : void
        {
            var _loc_5:* = new Rectangle(param1, param2, 10, 10);
            var _loc_6:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
            TooltipManager.show(_loc_6, _loc_5, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
