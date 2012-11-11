package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class QuestStartRequestAction extends Object implements Action
    {
        public var questId:int;

        public function QuestStartRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : QuestStartRequestAction
        {
            var _loc_2:* = new QuestStartRequestAction;
            _loc_2.questId = param1;
            return _loc_2;
        }// end function

    }
}
