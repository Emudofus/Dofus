package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class QuestStartRequestAction implements Action 
    {

        public var questId:int;


        public static function create(questId:int):QuestStartRequestAction
        {
            var a:QuestStartRequestAction = new (QuestStartRequestAction)();
            a.questId = questId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

