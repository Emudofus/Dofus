package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class KrosmasterTokenRequestAction implements Action 
    {


        public static function create():KrosmasterTokenRequestAction
        {
            var action:KrosmasterTokenRequestAction = new (KrosmasterTokenRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

