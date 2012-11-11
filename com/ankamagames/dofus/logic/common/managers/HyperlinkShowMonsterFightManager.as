package com.ankamagames.dofus.logic.common.managers
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import flash.display.*;

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

    }
}
