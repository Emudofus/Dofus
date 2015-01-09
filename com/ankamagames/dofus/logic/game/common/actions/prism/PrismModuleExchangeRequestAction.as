package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismModuleExchangeRequestAction implements Action 
    {


        public static function create():PrismModuleExchangeRequestAction
        {
            var action:PrismModuleExchangeRequestAction = new (PrismModuleExchangeRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism

