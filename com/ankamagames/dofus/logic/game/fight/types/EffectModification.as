package com.ankamagames.dofus.logic.game.fight.types
{
   public class EffectModification extends Object
   {
      
      public function EffectModification(param1:int)
      {
         super();
         this._effectId = param1;
      }
      
      private var _effectId:int;
      
      public var damagesBonus:int;
      
      public var shieldPoints:int;
      
      public function get effectId() : int
      {
         return this._effectId;
      }
   }
}
