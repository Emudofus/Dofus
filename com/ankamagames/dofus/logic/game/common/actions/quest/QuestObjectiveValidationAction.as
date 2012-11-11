package com.ankamagames.dofus.logic.game.common.actions.quest
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class QuestObjectiveValidationAction extends Object implements Action
    {
        public var questId:int;
        public var objectiveId:int;

        public function QuestObjectiveValidationAction()
        {
            return;
        }// end function

        public static function create(param1:int, param2:int) : QuestObjectiveValidationAction
        {
            var _loc_3:* = new QuestObjectiveValidationAction;
            _loc_3.questId = param1;
            _loc_3.objectiveId = param2;
            return _loc_3;
        }// end function

    }
}
