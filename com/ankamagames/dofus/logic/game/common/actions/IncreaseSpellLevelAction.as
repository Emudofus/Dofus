package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class IncreaseSpellLevelAction extends Object implements Action
    {
        public var spellId:uint;

        public function IncreaseSpellLevelAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : IncreaseSpellLevelAction
        {
            var _loc_2:* = new IncreaseSpellLevelAction;
            _loc_2.spellId = param1;
            return _loc_2;
        }// end function

    }
}
