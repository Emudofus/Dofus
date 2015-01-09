package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FriendWarningSetAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):FriendWarningSetAction
        {
            var a:FriendWarningSetAction = new (FriendWarningSetAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

