package com.ankamagames.dofus.logic.game.fight.fightEvents
{

    public class FightEvent extends Object
    {
        public var name:String;
        public var targetId:int;
        public var params:Array;
        public var checkParams:int;
        public var castingSpellId:int;

        public function FightEvent(param1:String, param2:Array, param3:int, param4:int, param5:int)
        {
            this.name = param1;
            this.targetId = param3;
            this.params = param2;
            this.checkParams = param4;
            this.castingSpellId = param5;
            return;
        }// end function

    }
}
