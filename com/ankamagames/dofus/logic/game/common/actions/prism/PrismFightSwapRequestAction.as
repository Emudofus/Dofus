package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismFightSwapRequestAction implements Action 
    {

        public var subAreaId:uint;
        public var targetId:uint;


        public static function create(subAreaId:uint, targetId:uint):PrismFightSwapRequestAction
        {
            var action:PrismFightSwapRequestAction = new (PrismFightSwapRequestAction)();
            action.targetId = targetId;
            action.subAreaId = subAreaId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism

