package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TreasureHuntRequestAction implements Action 
    {

        public var level:int;
        public var questType:int;


        public static function create(level:int, questType:int):TreasureHuntRequestAction
        {
            var action:TreasureHuntRequestAction = new (TreasureHuntRequestAction)();
            action.level = level;
            action.questType = questType;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt

