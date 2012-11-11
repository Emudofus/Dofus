package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ChallengeTargetsListRequestAction extends Object implements Action
    {
        public var challengeId:uint;

        public function ChallengeTargetsListRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : ChallengeTargetsListRequestAction
        {
            var _loc_2:* = new ChallengeTargetsListRequestAction;
            _loc_2.challengeId = param1;
            return _loc_2;
        }// end function

    }
}
