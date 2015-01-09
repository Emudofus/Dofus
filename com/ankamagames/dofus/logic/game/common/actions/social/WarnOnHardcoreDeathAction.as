package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class WarnOnHardcoreDeathAction implements Action 
    {

        public var enable:Boolean;


        public static function create(enable:Boolean):WarnOnHardcoreDeathAction
        {
            var a:WarnOnHardcoreDeathAction = new (WarnOnHardcoreDeathAction)();
            a.enable = enable;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

