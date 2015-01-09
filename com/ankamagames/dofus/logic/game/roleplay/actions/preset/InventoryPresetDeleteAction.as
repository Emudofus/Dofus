package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class InventoryPresetDeleteAction implements Action 
    {

        public var presetId:uint;


        public static function create(presetId:uint):InventoryPresetDeleteAction
        {
            var a:InventoryPresetDeleteAction = new (InventoryPresetDeleteAction)();
            a.presetId = presetId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.preset

