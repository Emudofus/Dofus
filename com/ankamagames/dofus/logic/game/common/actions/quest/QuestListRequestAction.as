package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class QuestListRequestAction extends Object implements Action
    {

        public function QuestListRequestAction()
        {
            return;
        }// end function

        public static function create() : QuestListRequestAction
        {
            return new QuestListRequestAction;
        }// end function

    }
}
