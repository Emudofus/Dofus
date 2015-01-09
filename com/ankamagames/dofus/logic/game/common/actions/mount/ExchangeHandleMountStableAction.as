package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeHandleMountStableAction implements Action 
    {

        public var rideId:uint;
        public var actionType:int;


        public static function create(actionType:uint, mountId:uint):ExchangeHandleMountStableAction
        {
            var act:ExchangeHandleMountStableAction = new (ExchangeHandleMountStableAction)();
            act.actionType = actionType;
            act.rideId = mountId;
            return (act);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.mount

