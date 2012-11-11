package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class QuestInfosRequestAction extends Object implements Action
    {
        public var questId:int;

        public function QuestInfosRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : QuestInfosRequestAction
        {
            var _loc_2:* = new QuestInfosRequestAction;
            _loc_2.questId = param1;
            return _loc_2;
        }// end function

    }
}
