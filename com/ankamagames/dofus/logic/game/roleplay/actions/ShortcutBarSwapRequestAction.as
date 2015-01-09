package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShortcutBarSwapRequestAction implements Action 
    {

        public var barType:uint;
        public var firstSlot:uint;
        public var secondSlot:uint;


        public static function create(barType:uint, firstSlot:uint, secondSlot:uint):ShortcutBarSwapRequestAction
        {
            var a:ShortcutBarSwapRequestAction = new (ShortcutBarSwapRequestAction)();
            a.barType = barType;
            a.firstSlot = firstSlot;
            a.secondSlot = secondSlot;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

