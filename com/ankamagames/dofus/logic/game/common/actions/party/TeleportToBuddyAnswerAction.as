package com.ankamagames.dofus.logic.game.common.actions.party
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TeleportToBuddyAnswerAction extends Object implements Action
    {
        public var dungeonId:int;
        public var buddyId:int;
        public var accept:Boolean;

        public function TeleportToBuddyAnswerAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:int, param3:Boolean) : TeleportToBuddyAnswerAction
        {
            var _loc_4:* = new TeleportToBuddyAnswerAction;
            new TeleportToBuddyAnswerAction.dungeonId = param1;
            _loc_4.buddyId = param2;
            _loc_4.accept = param3;
            return _loc_4;
        }// end function

    }
}
