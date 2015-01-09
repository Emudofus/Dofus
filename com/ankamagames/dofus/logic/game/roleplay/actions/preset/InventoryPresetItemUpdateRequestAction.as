package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class InventoryPresetItemUpdateRequestAction implements Action 
    {

        public var presetId:uint;
        public var position:uint;
        public var objUid:uint;


        public static function create(presetId:uint, position:uint, objUid:uint):InventoryPresetItemUpdateRequestAction
        {
            var a:InventoryPresetItemUpdateRequestAction = new (InventoryPresetItemUpdateRequestAction)();
            a.presetId = presetId;
            a.position = position;
            a.objUid = objUid;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.preset

