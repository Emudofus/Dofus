package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TeleportBuddiesAnswerAction extends Object implements Action
    {
        public var accept:Boolean;

        public function TeleportBuddiesAnswerAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : TeleportBuddiesAnswerAction
        {
            var _loc_2:* = new TeleportBuddiesAnswerAction;
            _loc_2.accept = param1;
            return _loc_2;
        }// end function

    }
}
