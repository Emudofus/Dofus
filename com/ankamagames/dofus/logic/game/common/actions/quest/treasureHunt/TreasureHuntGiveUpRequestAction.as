package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TreasureHuntGiveUpRequestAction implements Action 
    {

        public var questType:int;


        public static function create(questType:int):TreasureHuntGiveUpRequestAction
        {
            var action:TreasureHuntGiveUpRequestAction = new (TreasureHuntGiveUpRequestAction)();
            action.questType = questType;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt

