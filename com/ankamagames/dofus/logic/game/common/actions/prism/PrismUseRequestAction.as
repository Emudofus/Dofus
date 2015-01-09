package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PrismUseRequestAction implements Action 
    {


        public static function create():PrismUseRequestAction
        {
            var action:PrismUseRequestAction = new (PrismUseRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.prism

