package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMinimalStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   
   public class SpellDamageInfo extends Object
   {
      
      public function SpellDamageInfo() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellDamageInfo));
      
      private static const NEUTRAL_ELEMENT:int = 0;
      
      private static const EARTH_ELEMENT:int = 1;
      
      private static const FIRE_ELEMENT:int = 2;
      
      private static const WATER_ELEMENT:int = 3;
      
      private static const AIR_ELEMENT:int = 4;
      
      private static const NONE_ELEMENT:int = 5;
      
      public static function fromCurrentPlayer(param1:Object, param2:int) : SpellDamageInfo {
         var _loc7_:EffectInstance = null;
         var _loc8_:EffectInstanceDice = null;
         var _loc9_:EffectDamage = null;
         var _loc10_:* = 0;
         var _loc11_:Array = null;
         var _loc12_:BasicBuff = null;
         var _loc13_:Array = null;
         var _loc14_:WeaponWrapper = null;
         var _loc15_:GameFightMinimalStats = null;
         var _loc3_:SpellDamageInfo = new SpellDamageInfo();
         var _loc4_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!_loc4_)
         {
            return _loc3_;
         }
         _loc3_.casterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
         _loc3_.casterLevel = _loc4_.getFighterLevel(CurrentPlayedFighterManager.getInstance().currentFighterId);
         _loc3_.targetId = param2;
         _loc3_.targetLevel = _loc4_.getFighterLevel(param2);
         _loc3_.spellEffects = param1.effects;
         _loc3_.isWeapon = !(param1 is SpellWrapper);
         var _loc5_:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         var _loc6_:GameFightFighterInformations = _loc4_.entitiesFrame.getEntityInfos(param2) as GameFightFighterInformations;
         _loc3_.casterStrength = _loc5_.strength.base + _loc5_.strength.objectsAndMountBonus + _loc5_.strength.alignGiftBonus + _loc5_.strength.contextModif;
         _loc3_.casterChance = _loc5_.chance.base + _loc5_.chance.objectsAndMountBonus + _loc5_.chance.alignGiftBonus + _loc5_.chance.contextModif;
         _loc3_.casterAgility = _loc5_.agility.base + _loc5_.agility.objectsAndMountBonus + _loc5_.agility.alignGiftBonus + _loc5_.agility.contextModif;
         _loc3_.casterIntelligence = _loc5_.intelligence.base + _loc5_.intelligence.objectsAndMountBonus + _loc5_.intelligence.alignGiftBonus + _loc5_.intelligence.contextModif;
         _loc3_.casterCriticalHit = _loc5_.criticalHit.base + _loc5_.criticalHit.objectsAndMountBonus + _loc5_.criticalHit.alignGiftBonus + _loc5_.criticalHit.contextModif;
         _loc3_.casterCriticalHitWeapon = _loc5_.criticalHitWeapon;
         _loc3_.casterHealBonus = _loc5_.healBonus.base + _loc5_.healBonus.objectsAndMountBonus + _loc5_.healBonus.alignGiftBonus + _loc5_.healBonus.contextModif;
         _loc3_.casterAllDamagesBonus = _loc5_.allDamagesBonus.base + _loc5_.allDamagesBonus.objectsAndMountBonus + _loc5_.allDamagesBonus.alignGiftBonus + _loc5_.allDamagesBonus.contextModif;
         _loc3_.casterDamagesBonus = _loc5_.damagesBonusPercent.base + _loc5_.damagesBonusPercent.objectsAndMountBonus + _loc5_.damagesBonusPercent.alignGiftBonus + _loc5_.damagesBonusPercent.contextModif;
         _loc3_.casterTrapBonus = _loc5_.trapBonus.base + _loc5_.trapBonus.objectsAndMountBonus + _loc5_.trapBonus.alignGiftBonus + _loc5_.trapBonus.contextModif;
         _loc3_.casterTrapBonusPercent = _loc5_.trapBonusPercent.base + _loc5_.trapBonusPercent.objectsAndMountBonus + _loc5_.trapBonusPercent.alignGiftBonus + _loc5_.trapBonusPercent.contextModif;
         _loc3_.casterGlyphBonusPercent = _loc5_.glyphBonusPercent.base + _loc5_.glyphBonusPercent.objectsAndMountBonus + _loc5_.glyphBonusPercent.alignGiftBonus + _loc5_.glyphBonusPercent.contextModif;
         _loc3_.casterPermanentDamagePercent = _loc5_.permanentDamagePercent.base + _loc5_.permanentDamagePercent.objectsAndMountBonus + _loc5_.permanentDamagePercent.alignGiftBonus + _loc5_.permanentDamagePercent.contextModif;
         _loc3_.casterPushDamageBonus = _loc5_.pushDamageBonus.base + _loc5_.pushDamageBonus.objectsAndMountBonus + _loc5_.pushDamageBonus.alignGiftBonus + _loc5_.pushDamageBonus.contextModif;
         _loc3_.casterCriticalDamageBonus = _loc5_.criticalDamageBonus.base + _loc5_.criticalDamageBonus.objectsAndMountBonus + _loc5_.criticalDamageBonus.alignGiftBonus + _loc5_.criticalDamageBonus.contextModif;
         _loc3_.casterNeutralDamageBonus = _loc5_.neutralDamageBonus.base + _loc5_.neutralDamageBonus.objectsAndMountBonus + _loc5_.neutralDamageBonus.alignGiftBonus + _loc5_.neutralDamageBonus.contextModif;
         _loc3_.casterEarthDamageBonus = _loc5_.earthDamageBonus.base + _loc5_.earthDamageBonus.objectsAndMountBonus + _loc5_.earthDamageBonus.alignGiftBonus + _loc5_.earthDamageBonus.contextModif;
         _loc3_.casterWaterDamageBonus = _loc5_.waterDamageBonus.base + _loc5_.waterDamageBonus.objectsAndMountBonus + _loc5_.waterDamageBonus.alignGiftBonus + _loc5_.waterDamageBonus.contextModif;
         _loc3_.casterAirDamageBonus = _loc5_.airDamageBonus.base + _loc5_.airDamageBonus.objectsAndMountBonus + _loc5_.airDamageBonus.alignGiftBonus + _loc5_.airDamageBonus.contextModif;
         _loc3_.casterFireDamageBonus = _loc5_.fireDamageBonus.base + _loc5_.fireDamageBonus.objectsAndMountBonus + _loc5_.fireDamageBonus.alignGiftBonus + _loc5_.fireDamageBonus.contextModif;
         _loc3_.neutralDamage = DamageUtil.getSpellElementDamage(param1,NEUTRAL_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,param2);
         _loc3_.earthDamage = DamageUtil.getSpellElementDamage(param1,EARTH_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,param2);
         _loc3_.fireDamage = DamageUtil.getSpellElementDamage(param1,FIRE_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,param2);
         _loc3_.waterDamage = DamageUtil.getSpellElementDamage(param1,WATER_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,param2);
         _loc3_.airDamage = DamageUtil.getSpellElementDamage(param1,AIR_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,param2);
         _loc3_.spellHasCriticalDamage = (_loc3_.isWeapon) || (_loc3_.neutralDamage.hasCriticalDamage) || (_loc3_.earthDamage.hasCriticalDamage) || (_loc3_.fireDamage.hasCriticalDamage) || (_loc3_.waterDamage.hasCriticalDamage) || (_loc3_.airDamage.hasCriticalDamage);
         _loc3_.healDamage = new SpellDamage();
         for each (_loc7_ in param1.effects)
         {
            if(!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc7_.effectId) == -1) && (DamageUtil.verifySpellEffectMask(CurrentPlayedFighterManager.getInstance().currentFighterId,param2,_loc7_)))
            {
               _loc8_ = _loc7_ as EffectInstanceDice;
               _loc9_ = DamageUtil.getEffectDamageByEffectId(_loc3_.healDamage,_loc8_.effectId);
               if(!_loc9_)
               {
                  _loc9_ = new EffectDamage(_loc7_.effectId,-1,_loc7_.random);
                  _loc3_.healDamage.addEffectDamage(_loc9_);
               }
               if(_loc7_.effectId == 1109)
               {
                  if(_loc6_)
                  {
                     _loc9_.lifePointsAddedBasedOnLifePercent = _loc9_.lifePointsAddedBasedOnLifePercent + _loc8_.diceNum * _loc6_.stats.maxLifePoints / 100;
                  }
               }
               else
               {
                  _loc9_.minLifePointsAdded = _loc9_.minLifePointsAdded + _loc8_.diceNum;
                  _loc9_.maxLifePointsAdded = _loc9_.maxLifePointsAdded + (_loc8_.diceSide == 0?_loc8_.diceNum:_loc8_.diceSide);
               }
            }
         }
         for each (_loc7_ in param1.criticalEffect)
         {
            if(!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc7_.effectId) == -1) && (DamageUtil.verifySpellEffectMask(CurrentPlayedFighterManager.getInstance().currentFighterId,param2,_loc7_)))
            {
               _loc8_ = _loc7_ as EffectInstanceDice;
               _loc9_ = DamageUtil.getEffectDamageByEffectId(_loc3_.healDamage,_loc8_.effectId);
               if(!_loc9_)
               {
                  _loc9_ = new EffectDamage(_loc7_.effectId,-1,_loc7_.random);
                  _loc3_.healDamage.addEffectDamage(_loc9_);
               }
               if(_loc7_.effectId == 1109)
               {
                  if(_loc6_)
                  {
                     _loc9_.criticalLifePointsAddedBasedOnLifePercent = _loc9_.criticalLifePointsAddedBasedOnLifePercent + _loc8_.diceNum * _loc6_.stats.maxLifePoints / 100;
                  }
               }
               else
               {
                  _loc9_.minCriticalLifePointsAdded = _loc9_.minCriticalLifePointsAdded + _loc8_.diceNum;
                  _loc9_.maxCriticalLifePointsAdded = _loc9_.maxCriticalLifePointsAdded + (_loc8_.diceSide == 0?_loc8_.diceNum:_loc8_.diceSide);
               }
               _loc3_.spellHasCriticalHeal = true;
            }
         }
         _loc3_.spellHasRandomEffects = (_loc3_.neutralDamage.hasRandomEffects) || (_loc3_.earthDamage.hasRandomEffects) || (_loc3_.fireDamage.hasRandomEffects) || (_loc3_.waterDamage.hasRandomEffects) || (_loc3_.airDamage.hasRandomEffects) || (_loc3_.healDamage.hasRandomEffects);
         if(_loc3_.isWeapon)
         {
            _loc14_ = PlayedCharacterManager.getInstance().currentWeapon;
            _loc3_.spellWeaponCriticalBonus = _loc14_.criticalHitBonus;
            if(_loc14_.type.id == 7)
            {
               _loc3_.spellShapeEfficiencyPercent = 25;
            }
         }
         if(_loc6_)
         {
            _loc15_ = _loc6_.stats;
            _loc3_.targetShieldsPoints = _loc15_.shieldPoints;
            _loc3_.targetNeutralElementResistPercent = _loc15_.neutralElementResistPercent;
            _loc3_.targetEarthElementResistPercent = _loc15_.earthElementResistPercent;
            _loc3_.targetWaterElementResistPercent = _loc15_.waterElementResistPercent;
            _loc3_.targetAirElementResistPercent = _loc15_.airElementResistPercent;
            _loc3_.targetFireElementResistPercent = _loc15_.fireElementResistPercent;
            _loc3_.targetNeutralElementReduction = _loc15_.neutralElementReduction;
            _loc3_.targetEarthElementReduction = _loc15_.earthElementReduction;
            _loc3_.targetWaterElementReduction = _loc15_.waterElementReduction;
            _loc3_.targetAirElementReduction = _loc15_.airElementReduction;
            _loc3_.targetFireElementReduction = _loc15_.fireElementReduction;
            _loc3_.targetCriticalDamageFixedResist = _loc15_.criticalDamageFixedResist;
            _loc3_.targetPushDamageFixedResist = _loc15_.pushDamageFixedResist;
            _loc3_.targetCell = _loc6_.disposition.cellId;
         }
         _loc3_.spellCenterCell = FightContextFrame.currentCell;
         for each (_loc7_ in param1.effects)
         {
            if(_loc7_.category == DamageUtil.DAMAGE_EFFECT_CATEGORY)
            {
               if(_loc7_.rawZone)
               {
                  _loc3_.spellShapeSize = _loc7_.zoneSize;
                  _loc3_.spellShapeMinSize = _loc7_.zoneMinSize;
                  _loc3_.spellShapeEfficiencyPercent = _loc7_.zoneEfficiencyPercent;
                  _loc3_.spellShapeMaxEfficiency = _loc7_.zoneMaxEfficiency;
                  break;
               }
            }
         }
         _loc11_ = BuffManager.getInstance().getAllBuff(CurrentPlayedFighterManager.getInstance().currentFighterId);
         for each (_loc12_ in _loc11_)
         {
            if(_loc12_.actionId == 1144)
            {
               _loc3_.casterDamagesBonus = _loc3_.casterDamagesBonus + _loc12_.param1;
            }
         }
         _loc3_.targetBuffs = BuffManager.getInstance().getAllBuff(param2);
         _loc13_ = FightersStateManager.getInstance().getStates(param2);
         if(_loc13_)
         {
            _loc3_.targetIsInvulnerable = !(_loc13_.indexOf(56) == -1);
         }
         return _loc3_;
      }
      
      public var isWeapon:Boolean;
      
      public var casterId:int;
      
      public var casterLevel:int;
      
      public var casterStrength:int;
      
      public var casterChance:int;
      
      public var casterAgility:int;
      
      public var casterIntelligence:int;
      
      public var casterCriticalHit:int;
      
      public var casterCriticalHitWeapon:int;
      
      public var casterHealBonus:int;
      
      public var casterAllDamagesBonus:int;
      
      public var casterDamagesBonus:int;
      
      public var casterTrapBonus:int;
      
      public var casterTrapBonusPercent:int;
      
      public var casterGlyphBonusPercent:int;
      
      public var casterPermanentDamagePercent:int;
      
      public var casterPushDamageBonus:int;
      
      public var casterCriticalDamageBonus:int;
      
      public var casterNeutralDamageBonus:int;
      
      public var casterEarthDamageBonus:int;
      
      public var casterWaterDamageBonus:int;
      
      public var casterAirDamageBonus:int;
      
      public var casterFireDamageBonus:int;
      
      public var spellEffects:Vector.<EffectInstance>;
      
      public var spellCenterCell:int;
      
      public var neutralDamage:SpellDamage;
      
      public var earthDamage:SpellDamage;
      
      public var fireDamage:SpellDamage;
      
      public var waterDamage:SpellDamage;
      
      public var airDamage:SpellDamage;
      
      public var spellWeaponCriticalBonus:int;
      
      public var spellShapeSize:int;
      
      public var spellShapeMinSize:int;
      
      public var spellShapeEfficiencyPercent:int;
      
      public var spellShapeMaxEfficiency:int;
      
      public var healDamage:SpellDamage;
      
      public var spellHasCriticalDamage:Boolean;
      
      public var spellHasCriticalHeal:Boolean;
      
      public var spellHasRandomEffects:Boolean;
      
      public var targetId:int;
      
      public var targetLevel:int;
      
      public var targetIsInvulnerable:Boolean;
      
      public var targetCell:int = -1;
      
      public var targetShieldsPoints:uint;
      
      public var targetNeutralElementResistPercent:int;
      
      public var targetEarthElementResistPercent:int;
      
      public var targetWaterElementResistPercent:int;
      
      public var targetAirElementResistPercent:int;
      
      public var targetFireElementResistPercent:int;
      
      public var targetBuffs:Array;
      
      public var targetNeutralElementReduction:int;
      
      public var targetEarthElementReduction:int;
      
      public var targetWaterElementReduction:int;
      
      public var targetAirElementReduction:int;
      
      public var targetFireElementReduction:int;
      
      public var targetCriticalDamageFixedResist:int;
      
      public var targetPushDamageFixedResist:int;
   }
}
