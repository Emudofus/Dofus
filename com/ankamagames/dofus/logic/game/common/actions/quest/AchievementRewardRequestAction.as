package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AchievementRewardRequestAction implements Action 
    {

        public var achievementId:int;


        public static function create(achievementId:int):AchievementRewardRequestAction
        {
            var action:AchievementRewardRequestAction = new (AchievementRewardRequestAction)();
            action.achievementId = achievementId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

