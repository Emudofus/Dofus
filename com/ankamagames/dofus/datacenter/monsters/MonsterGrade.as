package com.ankamagames.dofus.datacenter.monsters
{
    import com.ankamagames.jerakine.interfaces.*;

    public class MonsterGrade extends Object implements IDataCenter
    {
        public var grade:uint;
        public var monsterId:int;
        public var level:uint;
        public var paDodge:int;
        public var pmDodge:int;
        public var wisdom:int;
        public var earthResistance:int;
        public var airResistance:int;
        public var fireResistance:int;
        public var waterResistance:int;
        public var neutralResistance:int;
        public var gradeXp:int;
        public var lifePoints:int;
        public var actionPoints:int;
        public var movementPoints:int;
        private var _monster:Monster;

        public function MonsterGrade()
        {
            return;
        }// end function

        public function get monster() : Monster
        {
            if (!this._monster)
            {
                this._monster = Monster.getMonsterById(this.monsterId);
            }
            return this._monster;
        }// end function

        public function get static() : Boolean
        {
            return this.movementPoints == -1;
        }// end function

    }
}
