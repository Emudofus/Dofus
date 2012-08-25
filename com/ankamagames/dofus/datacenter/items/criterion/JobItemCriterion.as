package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.jobs.*;
    import com.ankamagames.dofus.internalDatacenter.jobs.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class JobItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _jobId:uint;
        private var _jobLevel:int = -1;

        public function JobItemCriterion(param1:String)
        {
            super(param1);
            var _loc_2:* = String(_criterionValueText).split(",");
            if (_loc_2 && _loc_2.length > 0)
            {
                if (_loc_2.length > 2)
                {
                }
                else
                {
                    this._jobId = uint(_loc_2[0]);
                    this._jobLevel = int(_loc_2[1]);
                }
            }
            else
            {
                this._jobId = uint(_criterionValue);
                this._jobLevel = -1;
            }
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_1:KnownJob = null;
            var _loc_2:KnownJob = null;
            for each (_loc_2 in PlayedCharacterManager.getInstance().jobs)
            {
                
                if (_loc_2.jobDescription.jobId == this._jobId)
                {
                    _loc_1 = _loc_2;
                }
            }
            if (this._jobLevel != -1)
            {
                if (_loc_1 && _loc_1.jobExperience.jobLevel > this._jobLevel)
                {
                    return true;
                }
            }
            else if (_loc_1)
            {
                return true;
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:String = "";
            var _loc_2:String = "";
            var _loc_3:* = Job.getJobById(this._jobId);
            if (!_loc_3)
            {
                return _loc_2;
            }
            var _loc_4:* = _loc_3.name;
            var _loc_5:String = "";
            if (this._jobLevel >= 0)
            {
                _loc_5 = " " + I18n.getUiText("ui.common.short.level") + " " + String(this._jobLevel);
            }
            switch(_operator.text)
            {
                case ItemCriterionOperator.EQUAL:
                {
                    _loc_2 = _loc_4 + _loc_5;
                    break;
                }
                case ItemCriterionOperator.DIFFERENT:
                {
                    _loc_2 = I18n.getUiText("ui.common.dontBe") + _loc_4 + _loc_5;
                    break;
                }
                case ItemCriterionOperator.SUPERIOR:
                {
                    _loc_1 = " >";
                    _loc_2 = _loc_4 + _loc_1 + _loc_5;
                    break;
                }
                case ItemCriterionOperator.INFERIOR:
                {
                    _loc_1 = " <";
                    _loc_2 = _loc_4 + _loc_1 + _loc_5;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new JobItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
