package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class TreasureHuntLegendaryRequestAction implements Action 
    {

        public var legendaryId:int;


        public static function create(legendaryId:int):TreasureHuntLegendaryRequestAction
        {
            var action:TreasureHuntLegendaryRequestAction = new (TreasureHuntLegendaryRequestAction)();
            action.legendaryId = legendaryId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt

