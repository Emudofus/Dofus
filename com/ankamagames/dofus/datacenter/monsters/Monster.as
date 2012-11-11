package com.ankamagames.dofus.datacenter.monsters
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class Monster extends Object implements IDataCenter
    {
        public var id:int;
        public var nameId:uint;
        public var gfxId:uint;
        public var race:int;
        public var grades:Vector.<MonsterGrade>;
        public var look:String;
        public var useSummonSlot:Boolean;
        public var useBombSlot:Boolean;
        public var canPlay:Boolean;
        public var canTackle:Boolean;
        public var animFunList:Vector.<AnimFunMonsterData>;
        public var isBoss:Boolean;
        private var _name:String;
        private static const MODULE:String = "Monsters";

        public function Monster()
        {
            return;
        }// end function

        public function get name() : String
        {
            if (!this._name)
            {
                this._name = I18n.getText(this.nameId);
            }
            return this._name;
        }// end function

        public function get type() : MonsterRace
        {
            return MonsterRace.getMonsterRaceById(this.race);
        }// end function

        public function get isMiniBoss() : Boolean
        {
            return MonsterMiniBoss.getMonsterById(this.id) != null;
        }// end function

        public function getMonsterGrade(param1:uint) : MonsterGrade
        {
            return this.grades[(param1 - 1)] as MonsterGrade;
        }// end function

        public static function getMonsterById(param1:uint) : Monster
        {
            return GameData.getObject(MODULE, param1) as Monster;
        }// end function

        public static function getMonsters() : Array
        {
            return GameData.getObjects(MODULE);
        }// end function

    }
}
