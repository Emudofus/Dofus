package com.ankamagames.dofus.datacenter.quest.objectives
{
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class QuestObjectiveFreeForm extends QuestObjective implements IDataCenter
    {
        private var _freeFormText:String;

        public function QuestObjectiveFreeForm()
        {
            return;
        }// end function

        public function get freeFormTextId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[0];
        }// end function

        public function get freeFormText() : String
        {
            if (!this._freeFormText)
            {
                this._freeFormText = I18n.getText(this.freeFormTextId);
            }
            return this._freeFormText;
        }// end function

        override public function get text() : String
        {
            return this.freeFormText;
        }// end function

    }
}
