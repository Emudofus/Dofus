package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FriendGuildSetWarnOnAchievementCompleteAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):FriendGuildSetWarnOnAchievementCompleteAction
        {
            var a:FriendGuildSetWarnOnAchievementCompleteAction = new (FriendGuildSetWarnOnAchievementCompleteAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

