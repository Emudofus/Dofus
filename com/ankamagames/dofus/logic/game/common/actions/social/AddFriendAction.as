package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AddFriendAction implements Action 
    {

        public var name:String;


        public static function create(name:String):AddFriendAction
        {
            var a:AddFriendAction = new (AddFriendAction)();
            a.name = name;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

