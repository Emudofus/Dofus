package com.ankamagames.dofus.datacenter.quest.objectives
{
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.pattern.*;

    public class QuestObjectiveDiscoverSubArea extends QuestObjective implements IDataCenter
    {
        private var _subArea:SubArea;
        private var _text:String;

        public function QuestObjectiveDiscoverSubArea()
        {
            return;
        }// end function

        public function get subAreaId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[0];
        }// end function

        public function get subArea() : SubArea
        {
            if (!this._subArea)
            {
                this._subArea = SubArea.getSubAreaById(this.subAreaId);
            }
            return this._subArea;
        }// end function

        override public function get text() : String
        {
            if (!this._text)
            {
                this._text = PatternDecoder.getDescription(this.type.name, [this.subArea.name]);
            }
            return this._text;
        }// end function

    }
}
