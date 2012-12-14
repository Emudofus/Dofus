package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import flash.display.*;
    import flash.geom.*;

    public class HyperlinkShowMonsterFightManager extends Object
    {

        public function HyperlinkShowMonsterFightManager()
        {
            return;
        }// end function

        public static function showEntity(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if (_loc_2)
            {
                _loc_3 = DofusEntities.getEntity(param1) as DisplayObject;
                if (_loc_3)
                {
                    HyperlinkShowCellManager.showCell((_loc_3 as IEntity).position.cellId);
                }
            }
            return;
        }// end function

        public static function rollOver(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new Rectangle(param1, param2, 10, 10);
            var _loc_5:* = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
            TooltipManager.show(_loc_5, _loc_4, UiModuleManager.getInstance().getModule("Ankama_GameUiCore"), false, "HyperLink", 6, 2, 3, true, null, null, null, null, false, StrataEnum.STRATA_TOOLTIP, 1);
            return;
        }// end function

    }
}
