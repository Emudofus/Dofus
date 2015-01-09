package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PlayerFightFriendlyAnswerAction implements Action 
    {

        public var accept:Boolean;


        public static function create(accept:Boolean=true):PlayerFightFriendlyAnswerAction
        {
            var o:PlayerFightFriendlyAnswerAction = new (PlayerFightFriendlyAnswerAction)();
            o.accept = accept;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

