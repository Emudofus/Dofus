package com.ankamagames.dofus.logic.game.common.actions.taxCollector
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GameRolePlayTaxCollectorFightRequestAction implements Action 
    {

        public var taxCollectorId:uint;


        public static function create(pTaxCollectorId:uint):GameRolePlayTaxCollectorFightRequestAction
        {
            var action:GameRolePlayTaxCollectorFightRequestAction = new (GameRolePlayTaxCollectorFightRequestAction)();
            action.taxCollectorId = pTaxCollectorId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.taxCollector

