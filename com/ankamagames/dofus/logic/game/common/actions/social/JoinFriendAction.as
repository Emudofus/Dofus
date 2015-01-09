package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class JoinFriendAction implements Action 
    {

        public var name:String;


        public static function create(name:String):JoinFriendAction
        {
            var a:JoinFriendAction = new (JoinFriendAction)();
            a.name = name;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

