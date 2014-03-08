package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.utils.display.spellZone.ICellZoneProvider;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.jerakine.utils.display.spellZone.IZoneShape;
   import com.ankamagames.jerakine.utils.display.spellZone.ZoneEffect;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   
   public class SpellLevel extends Object implements ICellZoneProvider, IDataCenter
   {
      
      public function SpellLevel() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellLevel));
      
      private static const MODULE:String = "SpellLevels";
      
      public static function getLevelById(param1:int) : SpellLevel {
         return GameData.getObject(MODULE,param1) as SpellLevel;
      }
      
      public var id:uint;
      
      public var spellId:uint;
      
      public var grade:uint;
      
      public var spellBreed:uint;
      
      public var apCost:uint;
      
      public var minRange:uint;
      
      public var range:uint;
      
      public var castInLine:Boolean;
      
      public var castInDiagonal:Boolean;
      
      public var castTestLos:Boolean;
      
      public var criticalHitProbability:uint;
      
      public var criticalFailureProbability:uint;
      
      public var needFreeCell:Boolean;
      
      public var needTakenCell:Boolean;
      
      public var needFreeTrapCell:Boolean;
      
      public var rangeCanBeBoosted:Boolean;
      
      public var maxStack:int;
      
      public var maxCastPerTurn:uint;
      
      public var maxCastPerTarget:uint;
      
      public var minCastInterval:uint;
      
      public var initialCooldown:uint;
      
      public var globalCooldown:int;
      
      public var minPlayerLevel:uint;
      
      public var criticalFailureEndsTurn:Boolean;
      
      public var hideEffects:Boolean;
      
      public var hidden:Boolean;
      
      public var statesRequired:Vector.<int>;
      
      public var statesForbidden:Vector.<int>;
      
      public var effects:Vector.<EffectInstanceDice>;
      
      public var criticalEffect:Vector.<EffectInstanceDice>;
      
      private var _spell:Spell;
      
      private var _spellZoneEffects:Vector.<IZoneShape>;
      
      public function get spell() : Spell {
         if(!this._spell)
         {
            this._spell = Spell.getSpellById(this.spellId);
         }
         return this._spell;
      }
      
      public function get minimalRange() : uint {
         return this.minRange;
      }
      
      public function set minimalRange(param1:uint) : void {
         this.minRange = param1;
      }
      
      public function get maximalRange() : uint {
         return this.range;
      }
      
      public function set maximalRange(param1:uint) : void {
         this.range = param1;
      }
      
      public function get castZoneInLine() : Boolean {
         return this.castInLine;
      }
      
      public function set castZoneInLine(param1:Boolean) : void {
         this.castInLine = param1;
      }
      
      public function get castZoneInDiagonal() : Boolean {
         return this.castInDiagonal;
      }
      
      public function set castZoneInDiagonal(param1:Boolean) : void {
         this.castInDiagonal = param1;
      }
      
      public function get spellZoneEffects() : Vector.<IZoneShape> {
         var _loc1_:EffectInstanceDice = null;
         var _loc2_:ZoneEffect = null;
         if(!this._spellZoneEffects)
         {
            this._spellZoneEffects = new Vector.<IZoneShape>();
            for each (_loc1_ in this.effects)
            {
               _loc2_ = new ZoneEffect(_loc1_.zoneSize,_loc1_.zoneShape);
               this._spellZoneEffects.push(_loc2_);
            }
         }
         return this._spellZoneEffects;
      }
      
      public function get canSummon() : Boolean {
         var _loc1_:EffectInstanceDice = null;
         var _loc2_:* = 0;
         var _loc3_:Monster = null;
         for each (_loc1_ in this.effects)
         {
            if(_loc1_.effectId == 180 || _loc1_.effectId == 1011)
            {
               return true;
            }
            if(_loc1_.effectId == 181)
            {
               _loc2_ = _loc1_.diceNum;
               _loc3_ = Monster.getMonsterById(_loc2_);
               if((_loc3_) && (_loc3_.useSummonSlot))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get canBomb() : Boolean {
         var _loc1_:EffectInstanceDice = null;
         var _loc2_:* = 0;
         var _loc3_:Monster = null;
         for each (_loc1_ in this.effects)
         {
            if(_loc1_.effectId == 1008)
            {
               return true;
            }
            if(_loc1_.effectId == 181)
            {
               _loc2_ = _loc1_.diceNum;
               _loc3_ = Monster.getMonsterById(_loc2_);
               if((_loc3_) && (_loc3_.useBombSlot))
               {
                  return true;
               }
            }
         }
         return false;
      }
   }
}
