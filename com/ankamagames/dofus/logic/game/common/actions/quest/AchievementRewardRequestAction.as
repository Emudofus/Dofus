package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AchievementRewardRequestAction extends Object implements Action
    {
        public var achievementId:int;

        public function AchievementRewardRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : AchievementRewardRequestAction
        {
            var _loc_2:* = new AchievementRewardRequestAction;
            _loc_2.achievementId = param1;
            return _loc_2;
        }// end function

    }
}
