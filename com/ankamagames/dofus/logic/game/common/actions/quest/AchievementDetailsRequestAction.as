package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AchievementDetailsRequestAction extends Object implements Action
    {
        public var achievementId:int;

        public function AchievementDetailsRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : AchievementDetailsRequestAction
        {
            var _loc_2:* = new AchievementDetailsRequestAction;
            _loc_2.achievementId = param1;
            return _loc_2;
        }// end function

    }
}
