package com.ankamagames.dofus.logic.game.fight.types
{
   public class SplashDamage extends Object
   {
      
      public function SplashDamage(param1:int, param2:int, param3:Vector.<int>, param4:SpellDamage, param5:uint, param6:int, param7:int, param8:int, param9:uint, param10:Object, param11:Object, param12:Object, param13:Object, param14:Boolean)
      {
         var _loc15_:EffectDamage = null;
         super();
         this._spellId = param1;
         this._casterId = param2;
         this._targets = param3;
         this._damage = param4;
         this._spellShape = param9;
         this._spellShapeSize = param10;
         this._spellShapeMinSize = param11;
         this._spellShapeEfficiencyPercent = param12;
         this._spellShapeMaxEfficiency = param13;
         this._hasCritical = param14;
         for each(_loc15_ in this._damage.effectDamages)
         {
            _loc15_.effectId = param5;
            _loc15_.applyDamageMultiplier(param6 / 100);
            _loc15_.random = param8;
            if(!(param7 == -1) && !(_loc15_.element == -1))
            {
               _loc15_.element = param7;
            }
         }
         this._damage.updateDamage();
      }
      
      private var _spellId:int;
      
      private var _casterId:int;
      
      private var _targets:Vector.<int>;
      
      private var _damage:SpellDamage;
      
      private var _spellShape:uint;
      
      private var _spellShapeSize:Object;
      
      private var _spellShapeMinSize:Object;
      
      private var _spellShapeEfficiencyPercent:Object;
      
      private var _spellShapeMaxEfficiency:Object;
      
      private var _hasCritical:Boolean;
      
      public function get spellId() : int
      {
         return this._spellId;
      }
      
      public function get casterId() : int
      {
         return this._casterId;
      }
      
      public function get targets() : Vector.<int>
      {
         return this._targets;
      }
      
      public function get damage() : SpellDamage
      {
         return this._damage;
      }
      
      public function get spellShape() : uint
      {
         return this._spellShape;
      }
      
      public function get spellShapeSize() : Object
      {
         return this._spellShapeSize;
      }
      
      public function get spellShapeMinSize() : Object
      {
         return this._spellShapeMinSize;
      }
      
      public function get spellShapeEfficiencyPercent() : Object
      {
         return this._spellShapeEfficiencyPercent;
      }
      
      public function get spellShapeMaxEfficiency() : Object
      {
         return this._spellShapeMaxEfficiency;
      }
      
      public function get hasCritical() : Boolean
      {
         return this._hasCritical;
      }
   }
}
