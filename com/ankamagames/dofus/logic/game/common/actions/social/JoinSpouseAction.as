package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JoinSpouseAction implements Action 
    {


        public static function create():JoinSpouseAction
        {
            var a:JoinSpouseAction = new (JoinSpouseAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

