package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AddIgnoredAction implements Action 
    {

        public var name:String;


        public static function create(name:String):AddIgnoredAction
        {
            var a:AddIgnoredAction = new (AddIgnoredAction)();
            a.name = name;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

