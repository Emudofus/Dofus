package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ArenaFightAnswerAction extends Object implements Action
    {
        public var fightId:uint;
        public var accept:Boolean;

        public function ArenaFightAnswerAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:Boolean) : ArenaFightAnswerAction
        {
            var _loc_3:* = new ArenaFightAnswerAction;
            _loc_3.fightId = param1;
            _loc_3.accept = param2;
            return _loc_3;
        }// end function

    }
}
