package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SpellSetPositionAction extends Object implements Action
    {
        public var spellID:uint;
        public var position:uint;

        public function SpellSetPositionAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : SpellSetPositionAction
        {
            var _loc_3:* = new SpellSetPositionAction;
            _loc_3.spellID = param1;
            _loc_3.position = param2;
            return _loc_3;
        }// end function

    }
}
