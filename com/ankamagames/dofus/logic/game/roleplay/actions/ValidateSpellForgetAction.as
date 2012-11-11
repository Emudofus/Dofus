package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ValidateSpellForgetAction extends Object implements Action
    {
        public var spellId:uint;

        public function ValidateSpellForgetAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ValidateSpellForgetAction
        {
            var _loc_2:* = new ValidateSpellForgetAction;
            _loc_2.spellId = param1;
            return _loc_2;
        }// end function

    }
}
