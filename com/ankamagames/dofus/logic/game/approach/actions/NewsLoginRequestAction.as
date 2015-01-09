package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class NewsLoginRequestAction implements Action 
    {


        public static function create():NewsLoginRequestAction
        {
            var action:NewsLoginRequestAction = new (NewsLoginRequestAction)();
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

