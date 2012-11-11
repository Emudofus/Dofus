package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PresetSetPositionAction extends Object implements Action
    {
        public var presetId:uint;
        public var position:uint;

        public function PresetSetPositionAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : PresetSetPositionAction
        {
            var _loc_3:* = new PresetSetPositionAction;
            _loc_3.presetId = param1;
            _loc_3.position = param2;
            return _loc_3;
        }// end function

    }
}
