package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PresetSetPositionAction implements Action 
    {

        public var presetId:uint;
        public var position:uint;


        public static function create(presetId:uint, position:uint):PresetSetPositionAction
        {
            var a:PresetSetPositionAction = new (PresetSetPositionAction)();
            a.presetId = presetId;
            a.position = position;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

