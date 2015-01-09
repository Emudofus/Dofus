package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class MemberWarningSetAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):MemberWarningSetAction
        {
            var a:MemberWarningSetAction = new (MemberWarningSetAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

