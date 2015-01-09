package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FriendOrGuildMemberLevelUpWarningSetAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):FriendOrGuildMemberLevelUpWarningSetAction
        {
            var a:FriendOrGuildMemberLevelUpWarningSetAction = new (FriendOrGuildMemberLevelUpWarningSetAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

