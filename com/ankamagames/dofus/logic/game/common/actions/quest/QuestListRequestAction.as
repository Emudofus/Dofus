package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class QuestListRequestAction implements Action 
    {


        public static function create():QuestListRequestAction
        {
            return (new (QuestListRequestAction)());
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.quest

