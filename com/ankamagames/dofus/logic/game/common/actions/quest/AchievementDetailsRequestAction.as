package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AchievementDetailsRequestAction implements Action 
    {

        public var achievementId:int;


        public static function create(achievementId:int):AchievementDetailsRequestAction
        {
            var action:AchievementDetailsRequestAction = new (AchievementDetailsRequestAction)();
            action.achievementId = achievementId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

