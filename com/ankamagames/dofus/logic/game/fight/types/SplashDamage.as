package com.ankamagames.dofus.logic.game.fight.types
{
   import __AS3__.vec.Vector;
   
   public class SplashDamage extends Object
   {
      
      public function SplashDamage(pSpellId:int, pCasterId:int, pTargets:Vector.<int>, pSourceSpellDamage:SpellDamage, pSplashPercent:int, pSplashElement:int, pSpellShape:uint, pSpellShapeSize:Object, pSpellShapeMinSize:Object, pSpellShapeEfficiencyPercent:Object, pSpellShapeMaxEfficiency:Object, pHasCritical:Boolean) {
         var ed:EffectDamage = null;
         super();
         this._spellId = pSpellId;
         this._casterId = pCasterId;
         this._targets = pTargets;
         this._damage = pSourceSpellDamage;
         this._spellShape = pSpellShape;
         this._spellShapeSize = pSpellShapeSize;
         this._spellShapeMinSize = pSpellShapeMinSize;
         this._spellShapeEfficiencyPercent = pSpellShapeEfficiencyPercent;
         this._spellShapeMaxEfficiency = pSpellShapeMaxEfficiency;
         this._hasCritical = pHasCritical;
         for each (ed in this._damage.effectDamages)
         {
            ed.applyDamageMultiplier(pSplashPercent / 100);
            if((!(pSplashElement == -1)) && (!(ed.element == -1)))
            {
               ed.element = pSplashElement;
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
      
      public function get spellId() : int {
         return this._spellId;
      }
      
      public function get casterId() : int {
         return this._casterId;
      }
      
      public function get targets() : Vector.<int> {
         return this._targets;
      }
      
      public function get damage() : SpellDamage {
         return this._damage;
      }
      
      public function get spellShape() : uint {
         return this._spellShape;
      }
      
      public function get spellShapeSize() : Object {
         return this._spellShapeSize;
      }
      
      public function get spellShapeMinSize() : Object {
         return this._spellShapeMinSize;
      }
      
      public function get spellShapeEfficiencyPercent() : Object {
         return this._spellShapeEfficiencyPercent;
      }
      
      public function get spellShapeMaxEfficiency() : Object {
         return this._spellShapeMaxEfficiency;
      }
      
      public function get hasCritical() : Boolean {
         return this._hasCritical;
      }
   }
}
