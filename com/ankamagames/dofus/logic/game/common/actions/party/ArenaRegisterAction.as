package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ArenaRegisterAction extends Object implements Action
    {
        public var fightTypeId:uint;

        public function ArenaRegisterAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ArenaRegisterAction
        {
            var _loc_2:* = new ArenaRegisterAction;
            _loc_2.fightTypeId = param1;
            return _loc_2;
        }// end function

    }
}
