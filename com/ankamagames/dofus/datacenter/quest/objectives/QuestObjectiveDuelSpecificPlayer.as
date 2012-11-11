package com.ankamagames.dofus.datacenter.quest.objectives
{
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.pattern.*;

    public class QuestObjectiveDuelSpecificPlayer extends QuestObjective implements IDataCenter
    {
        private var _specificPlayerText:String;
        private var _text:String;

        public function QuestObjectiveDuelSpecificPlayer()
        {
            return;
        }// end function

        public function get specificPlayerTextId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[0];
        }// end function

        public function get specificPlayerText() : String
        {
            if (!this._specificPlayerText)
            {
                this._specificPlayerText = I18n.getText(this.specificPlayerTextId);
            }
            return this._specificPlayerText;
        }// end function

        override public function get text() : String
        {
            if (!this._text)
            {
                this._text = PatternDecoder.getDescription(this.type.name, [this.specificPlayerText]);
            }
            return this._text;
        }// end function

    }
}
