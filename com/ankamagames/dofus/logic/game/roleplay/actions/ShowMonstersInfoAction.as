package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShowMonstersInfoAction implements Action 
    {

        public var fromShortcut:Boolean;


        public static function create(pFromShortcut:Boolean=true):ShowMonstersInfoAction
        {
            var a:ShowMonstersInfoAction = new (ShowMonstersInfoAction)();
            a.fromShortcut = pFromShortcut;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

