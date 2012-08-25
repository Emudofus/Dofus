package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class QuestItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _questId:uint;

        public function QuestItemCriterion(param1:String)
        {
            super(param1);
            this._questId = _criterionValue;
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:String = "";
            var _loc_2:* = Quest.getQuestById(this._questId);
            if (!_loc_2)
            {
                return _loc_1;
            }
            var _loc_3:* = _loc_2.name;
            var _loc_4:* = _serverCriterionForm.slice(0, 2);
            switch(_loc_4)
            {
                case "Qa":
                {
                    _loc_1 = I18n.getUiText("ui.grimoire.quest.active", [_loc_3]);
                    break;
                }
                case "Qc":
                {
                    _loc_1 = I18n.getUiText("ui.grimoire.quest.startable", [_loc_3]);
                    break;
                }
                case "Qf":
                {
                    _loc_1 = I18n.getUiText("ui.grimoire.quest.done", [_loc_3]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:* = Quest.getQuestById(this._questId);
            if (!_loc_1)
            {
                return false;
            }
            var _loc_2:* = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
            var _loc_3:* = _serverCriterionForm.slice(0, 2);
            switch(_loc_3)
            {
                case "Qa":
                {
                    return _loc_2.getActiveQuests().indexOf(this._questId) != -1;
                }
                case "Qc":
                {
                    return true;
                }
                case "Qf":
                {
                    return _loc_2.getCompletedQuests().indexOf(this._questId) != -1;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new QuestItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().infos.level;
        }// end function

    }
}
