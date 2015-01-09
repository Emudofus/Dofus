package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismSetSabotagedRequestAction implements Action 
    {

        public var subAreaId:uint;


        public static function create(subAreaId:uint):PrismSetSabotagedRequestAction
        {
            var action:PrismSetSabotagedRequestAction = new (PrismSetSabotagedRequestAction)();
            action.subAreaId = subAreaId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism

