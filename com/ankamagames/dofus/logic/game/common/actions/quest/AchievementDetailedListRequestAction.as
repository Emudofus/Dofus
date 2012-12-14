package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AchievementDetailedListRequestAction extends Object implements Action
    {
        public var categoryId:int;

        public function AchievementDetailedListRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : AchievementDetailedListRequestAction
        {
            var _loc_2:* = new AchievementDetailedListRequestAction;
            _loc_2.categoryId = param1;
            return _loc_2;
        }// end function

    }
}
