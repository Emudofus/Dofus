package com.ankamagames.dofus.logic.game.fight.types
{
   public class EffectModification extends Object
   {
      
      public function EffectModification(pEffectId:int) {
         super();
         this._effectId = pEffectId;
      }
      
      private var _effectId:int;
      
      public var damagesBonus:int;
      
      public var shieldPoints:int;
      
      public function get effectId() : int {
         return this._effectId;
      }
   }
}
