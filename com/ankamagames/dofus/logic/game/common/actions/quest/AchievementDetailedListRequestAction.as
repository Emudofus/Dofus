package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AchievementDetailedListRequestAction implements Action 
    {

        public var categoryId:int;


        public static function create(categoryId:int):AchievementDetailedListRequestAction
        {
            var action:AchievementDetailedListRequestAction = new (AchievementDetailedListRequestAction)();
            action.categoryId = categoryId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

