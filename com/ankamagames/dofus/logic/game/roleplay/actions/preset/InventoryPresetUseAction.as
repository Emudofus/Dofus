package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class InventoryPresetUseAction implements Action 
    {

        public var presetId:uint;


        public static function create(presetId:uint):InventoryPresetUseAction
        {
            var a:InventoryPresetUseAction = new (InventoryPresetUseAction)();
            a.presetId = presetId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.preset

