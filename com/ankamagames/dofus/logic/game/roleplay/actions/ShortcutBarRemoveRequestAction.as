package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShortcutBarRemoveRequestAction implements Action 
    {

        public var barType:uint;
        public var slot:uint;


        public static function create(barType:uint, slot:uint):ShortcutBarRemoveRequestAction
        {
            var a:ShortcutBarRemoveRequestAction = new (ShortcutBarRemoveRequestAction)();
            a.barType = barType;
            a.slot = slot;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

