package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TeleportBuddiesAnswerAction implements Action 
    {

        public var accept:Boolean;


        public static function create(accept:Boolean):TeleportBuddiesAnswerAction
        {
            var a:TeleportBuddiesAnswerAction = new (TeleportBuddiesAnswerAction)();
            a.accept = accept;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.party

