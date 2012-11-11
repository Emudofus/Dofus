package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PlayerFightFriendlyAnswerAction extends Object implements Action
    {
        public var accept:Boolean;

        public function PlayerFightFriendlyAnswerAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean = true) : PlayerFightFriendlyAnswerAction
        {
            var _loc_2:* = new PlayerFightFriendlyAnswerAction;
            _loc_2.accept = param1;
            return _loc_2;
        }// end function

    }
}
