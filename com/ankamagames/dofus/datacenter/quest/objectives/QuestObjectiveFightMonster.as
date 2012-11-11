package com.ankamagames.dofus.datacenter.quest.objectives
{
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.pattern.*;

    public class QuestObjectiveFightMonster extends QuestObjective implements IDataCenter
    {
        private var _monster:Monster;
        private var _text:String;

        public function QuestObjectiveFightMonster()
        {
            return;
        }// end function

        public function get monsterId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[0];
        }// end function

        public function get monster() : Monster
        {
            if (!this._monster)
            {
                this._monster = Monster.getMonsterById(this.monsterId);
            }
            return this._monster;
        }// end function

        public function get quantity() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[1];
        }// end function

        override public function get text() : String
        {
            if (!this._text)
            {
                this._text = PatternDecoder.getDescription(this.type.name, [this.monster.name, this.quantity]);
            }
            return this._text;
        }// end function

    }
}
