package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class SpouseRequestAction implements Action 
    {


        public static function create():SpouseRequestAction
        {
            var a:SpouseRequestAction = new (SpouseRequestAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

