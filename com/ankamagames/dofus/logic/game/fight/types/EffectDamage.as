package com.ankamagames.dofus.logic.game.fight.types
{
   public class EffectDamage extends Object
   {
      
      public function EffectDamage(param1:int, param2:int, param3:int) {
         super();
         this._effectId = param1;
         this._element = param2;
         this._random = param3;
      }
      
      private var _effectId:int;
      
      private var _element:int;
      
      private var _random:int;
      
      public var minDamage:int;
      
      public var maxDamage:int;
      
      public var minCriticalDamage:int;
      
      public var maxCriticalDamage:int;
      
      public var minErosionDamage:int;
      
      public var maxErosionDamage:int;
      
      public var minCriticalErosionDamage:int;
      
      public var maxCriticalErosionDamage:int;
      
      public var minShieldPointsRemoved:int;
      
      public var maxShieldPointsRemoved:int;
      
      public var minCriticalShieldPointsRemoved:int;
      
      public var maxCriticalShieldPointsRemoved:int;
      
      public var minLifePointsAdded:int;
      
      public var maxLifePointsAdded:int;
      
      public var minCriticalLifePointsAdded:int;
      
      public var maxCriticalLifePointsAdded:int;
      
      public var lifePointsAddedBasedOnLifePercent:int;
      
      public var criticalLifePointsAddedBasedOnLifePercent:int;
      
      public var hasCritical:Boolean;
      
      public var damageConvertedToHeal:Boolean;
      
      public function get effectId() : int {
         return this._effectId;
      }
      
      public function get element() : int {
         return this._element;
      }
      
      public function get random() : int {
         return this._random;
      }
      
      public function applyDamageMultiplier(param1:Number) : void {
         this.minDamage = this.minDamage * param1;
         this.maxDamage = this.maxDamage * param1;
         this.minCriticalDamage = this.minCriticalDamage * param1;
         this.maxCriticalDamage = this.maxCriticalDamage * param1;
      }
      
      public function applyDamageModification(param1:int) : void {
         this.minDamage = this.minDamage + param1;
         if(this.minDamage < 0)
         {
            this.minDamage = 0;
         }
         this.maxDamage = this.maxDamage + param1;
         if(this.maxDamage < 0)
         {
            this.maxDamage = 0;
         }
         this.minCriticalDamage = this.minCriticalDamage + param1;
         if(this.minCriticalDamage < 0)
         {
            this.minCriticalDamage = 0;
         }
         this.maxCriticalDamage = this.maxCriticalDamage + param1;
         if(this.maxCriticalDamage < 0)
         {
            this.maxCriticalDamage = 0;
         }
      }
      
      public function convertDamageToHeal() : void {
         this.minLifePointsAdded = this.minLifePointsAdded + this.minDamage;
         this.minDamage = 0;
         this.maxLifePointsAdded = this.maxLifePointsAdded + this.maxDamage;
         this.maxDamage = 0;
         this.minCriticalLifePointsAdded = this.minCriticalLifePointsAdded + this.minCriticalDamage;
         this.minCriticalDamage = 0;
         this.maxCriticalLifePointsAdded = this.maxCriticalLifePointsAdded + this.maxCriticalDamage;
         this.maxCriticalDamage = 0;
         this.damageConvertedToHeal = true;
      }
   }
}
