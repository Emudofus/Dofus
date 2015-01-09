package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class QuestInfosRequestAction implements Action 
    {

        public var questId:int;


        public static function create(questId:int):QuestInfosRequestAction
        {
            var a:QuestInfosRequestAction = new (QuestInfosRequestAction)();
            a.questId = questId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

