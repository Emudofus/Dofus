package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FriendSpouseFollowAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):FriendSpouseFollowAction
        {
            var a:FriendSpouseFollowAction = new (FriendSpouseFollowAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

