package com.ankamagames.dofus.logic.game.fight.fightEvents
{
   public class FightEvent extends Object
   {
      
      public function FightEvent(pName:String, pParams:Array, pTargetId:int, pCheckParams:int, pCastingSpellId:int, pOrder:int=-1, pFirstParamToCheck:int=1) {
         super();
         this.name = pName;
         this.targetId = pTargetId;
         this.params = pParams;
         this.checkParams = pCheckParams;
         this.castingSpellId = pCastingSpellId;
         this.order = pOrder;
         this.firstParamToCheck = pFirstParamToCheck;
      }
      
      public var name:String;
      
      public var targetId:int;
      
      public var params:Array;
      
      public var checkParams:int;
      
      public var firstParamToCheck:int;
      
      public var castingSpellId:int;
      
      public var order:int;
   }
}
