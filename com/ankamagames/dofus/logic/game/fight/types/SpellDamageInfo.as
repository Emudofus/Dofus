package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.fight.miscs.ActionIdConverter;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class SpellDamageInfo extends Object
   {
      
      public function SpellDamageInfo()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellDamageInfo));
      
      public static function fromCurrentPlayer(param1:Object, param2:int, param3:int) : SpellDamageInfo
      {
         var _loc4_:SpellDamageInfo = null;
         var _loc9_:uint = 0;
         var _loc10_:Array = null;
         var _loc11_:AnimatedCharacter = null;
         var _loc13_:EffectInstance = null;
         var _loc14_:EffectInstanceDice = null;
         var _loc15_:EffectDamage = null;
         var _loc16_:* = false;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:Array = null;
         var _loc26_:BasicBuff = null;
         var _loc27_:Dictionary = null;
         var _loc28_:Vector.<BasicBuff> = null;
         var _loc29_:* = undefined;
         var _loc30_:SpellWrapper = null;
         var _loc31_:* = false;
         var _loc32_:* = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc38_:* = 0;
         var _loc39_:* = 0;
         var _loc40_:WeaponWrapper = null;
         var _loc5_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!_loc5_)
         {
            return _loc4_;
         }
         _loc4_ = new SpellDamageInfo();
         _loc4_._originalTargetsIds = new Vector.<int>(0);
         _loc4_.targetId = param2;
         _loc4_.casterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
         _loc4_.casterStates = FightersStateManager.getInstance().getStates(_loc4_.casterId);
         _loc4_.casterLevel = _loc5_.getFighterLevel(_loc4_.casterId);
         _loc4_.spellEffects = param1.effects;
         _loc4_.spellCriticalEffects = param1.criticalEffect;
         _loc4_.isWeapon = !(param1 is SpellWrapper);
         var _loc6_:GameFightFighterInformations = _loc5_.entitiesFrame.getEntityInfos(_loc4_.casterId) as GameFightFighterInformations;
         var _loc7_:IZone = SpellZoneManager.getInstance().getSpellZone(param1,false,false);
         _loc7_.direction = MapPoint.fromCellId(_loc6_.disposition.cellId).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell),false);
         var _loc8_:Vector.<uint> = _loc7_.getCells(param3);
         for each(_loc9_ in _loc8_)
         {
            _loc10_ = EntitiesManager.getInstance().getEntitiesOnCell(_loc9_,AnimatedCharacter);
            for each(_loc11_ in _loc10_)
            {
               if((_loc5_.entitiesFrame.getEntityInfos(_loc11_.id)) && (_loc4_._originalTargetsIds.indexOf(_loc11_.id) == -1) && (DamageUtil.isDamagedOrHealedBySpell(_loc4_.casterId,_loc11_.id,param1,param3)))
               {
                  _loc4_._originalTargetsIds.push(_loc11_.id);
               }
            }
         }
         if(_loc4_._originalTargetsIds.indexOf(_loc4_.casterId) == -1 && param1 is SpellWrapper && ((param1 as SpellWrapper).canTargetCasterOutOfZone))
         {
            _loc4_._originalTargetsIds.push(_loc4_.casterId);
         }
         var _loc12_:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         _loc4_.casterStrength = _loc12_.strength.base + _loc12_.strength.additionnal + _loc12_.strength.objectsAndMountBonus + _loc12_.strength.alignGiftBonus + _loc12_.strength.contextModif;
         _loc4_.casterChance = _loc12_.chance.base + _loc12_.chance.additionnal + _loc12_.chance.objectsAndMountBonus + _loc12_.chance.alignGiftBonus + _loc12_.chance.contextModif;
         _loc4_.casterAgility = _loc12_.agility.base + _loc12_.agility.additionnal + _loc12_.agility.objectsAndMountBonus + _loc12_.agility.alignGiftBonus + _loc12_.agility.contextModif;
         _loc4_.casterIntelligence = _loc12_.intelligence.base + _loc12_.intelligence.additionnal + _loc12_.intelligence.objectsAndMountBonus + _loc12_.intelligence.alignGiftBonus + _loc12_.intelligence.contextModif;
         _loc4_.casterCriticalHit = _loc12_.criticalHit.base + _loc12_.criticalHit.additionnal + _loc12_.criticalHit.objectsAndMountBonus + _loc12_.criticalHit.alignGiftBonus + _loc12_.criticalHit.contextModif;
         _loc4_.casterCriticalHitWeapon = _loc12_.criticalHitWeapon;
         _loc4_.casterHealBonus = _loc12_.healBonus.base + _loc12_.healBonus.additionnal + _loc12_.healBonus.objectsAndMountBonus + _loc12_.healBonus.alignGiftBonus + _loc12_.healBonus.contextModif;
         _loc4_.casterAllDamagesBonus = _loc12_.allDamagesBonus.base + _loc12_.allDamagesBonus.additionnal + _loc12_.allDamagesBonus.objectsAndMountBonus + _loc12_.allDamagesBonus.alignGiftBonus + _loc12_.allDamagesBonus.contextModif;
         _loc4_.casterDamagesBonus = _loc12_.damagesBonusPercent.base + _loc12_.damagesBonusPercent.additionnal + _loc12_.damagesBonusPercent.objectsAndMountBonus + _loc12_.damagesBonusPercent.alignGiftBonus + _loc12_.damagesBonusPercent.contextModif;
         _loc4_.casterTrapBonus = _loc12_.trapBonus.base + _loc12_.trapBonus.additionnal + _loc12_.trapBonus.objectsAndMountBonus + _loc12_.trapBonus.alignGiftBonus + _loc12_.trapBonus.contextModif;
         _loc4_.casterTrapBonusPercent = _loc12_.trapBonusPercent.base + _loc12_.trapBonusPercent.additionnal + _loc12_.trapBonusPercent.objectsAndMountBonus + _loc12_.trapBonusPercent.alignGiftBonus + _loc12_.trapBonusPercent.contextModif;
         _loc4_.casterGlyphBonusPercent = _loc12_.glyphBonusPercent.base + _loc12_.glyphBonusPercent.additionnal + _loc12_.glyphBonusPercent.objectsAndMountBonus + _loc12_.glyphBonusPercent.alignGiftBonus + _loc12_.glyphBonusPercent.contextModif;
         _loc4_.casterPermanentDamagePercent = _loc12_.permanentDamagePercent.base + _loc12_.permanentDamagePercent.additionnal + _loc12_.permanentDamagePercent.objectsAndMountBonus + _loc12_.permanentDamagePercent.alignGiftBonus + _loc12_.permanentDamagePercent.contextModif;
         _loc4_.casterPushDamageBonus = _loc12_.pushDamageBonus.base + _loc12_.pushDamageBonus.additionnal + _loc12_.pushDamageBonus.objectsAndMountBonus + _loc12_.pushDamageBonus.alignGiftBonus + _loc12_.pushDamageBonus.contextModif;
         _loc4_.casterCriticalPushDamageBonus = _loc12_.pushDamageBonus.base + _loc12_.pushDamageBonus.additionnal + _loc12_.pushDamageBonus.objectsAndMountBonus + _loc12_.pushDamageBonus.alignGiftBonus;
         _loc4_.casterCriticalDamageBonus = _loc12_.criticalDamageBonus.base + _loc12_.criticalDamageBonus.additionnal + _loc12_.criticalDamageBonus.objectsAndMountBonus + _loc12_.criticalDamageBonus.alignGiftBonus + _loc12_.criticalDamageBonus.contextModif;
         _loc4_.casterNeutralDamageBonus = _loc12_.neutralDamageBonus.base + _loc12_.neutralDamageBonus.additionnal + _loc12_.neutralDamageBonus.objectsAndMountBonus + _loc12_.neutralDamageBonus.alignGiftBonus + _loc12_.neutralDamageBonus.contextModif;
         _loc4_.casterEarthDamageBonus = _loc12_.earthDamageBonus.base + _loc12_.earthDamageBonus.additionnal + _loc12_.earthDamageBonus.objectsAndMountBonus + _loc12_.earthDamageBonus.alignGiftBonus + _loc12_.earthDamageBonus.contextModif;
         _loc4_.casterWaterDamageBonus = _loc12_.waterDamageBonus.base + _loc12_.waterDamageBonus.additionnal + _loc12_.waterDamageBonus.objectsAndMountBonus + _loc12_.waterDamageBonus.alignGiftBonus + _loc12_.waterDamageBonus.contextModif;
         _loc4_.casterAirDamageBonus = _loc12_.airDamageBonus.base + _loc12_.airDamageBonus.additionnal + _loc12_.airDamageBonus.objectsAndMountBonus + _loc12_.airDamageBonus.alignGiftBonus + _loc12_.airDamageBonus.contextModif;
         _loc4_.casterFireDamageBonus = _loc12_.fireDamageBonus.base + _loc12_.fireDamageBonus.additionnal + _loc12_.fireDamageBonus.objectsAndMountBonus + _loc12_.fireDamageBonus.alignGiftBonus + _loc12_.fireDamageBonus.contextModif;
         _loc4_.portalsSpellEfficiencyBonus = DamageUtil.getPortalsSpellEfficiencyBonus(FightContextFrame.currentCell);
         _loc4_.neutralDamage = DamageUtil.getSpellElementDamage(param1,DamageUtil.NEUTRAL_ELEMENT,_loc4_.casterId,param2,param3);
         _loc4_.earthDamage = DamageUtil.getSpellElementDamage(param1,DamageUtil.EARTH_ELEMENT,_loc4_.casterId,param2,param3);
         _loc4_.fireDamage = DamageUtil.getSpellElementDamage(param1,DamageUtil.FIRE_ELEMENT,_loc4_.casterId,param2,param3);
         _loc4_.waterDamage = DamageUtil.getSpellElementDamage(param1,DamageUtil.WATER_ELEMENT,_loc4_.casterId,param2,param3);
         _loc4_.airDamage = DamageUtil.getSpellElementDamage(param1,DamageUtil.AIR_ELEMENT,_loc4_.casterId,param2,param3);
         _loc4_.spellHasCriticalDamage = (_loc4_.isWeapon) || (_loc4_.neutralDamage.hasCriticalDamage) || (_loc4_.earthDamage.hasCriticalDamage) || (_loc4_.fireDamage.hasCriticalDamage) || (_loc4_.waterDamage.hasCriticalDamage) || (_loc4_.airDamage.hasCriticalDamage);
         _loc4_.fixedDamage = new SpellDamage();
         _loc4_.healDamage = new SpellDamage();
         for each(_loc13_ in param1.effects)
         {
            if(!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc13_.effectId) == -1) && (!(_loc13_.effectId == 90) || !(param2 == _loc4_.casterId)))
            {
               if(DamageUtil.verifySpellEffectMask(_loc4_.casterId,param2,_loc13_,param3))
               {
                  _loc16_ = true;
               }
            }
            else if(_loc13_.category == DamageUtil.DAMAGE_EFFECT_CATEGORY && (DamageUtil.verifySpellEffectMask(_loc4_.casterId,param2,_loc13_,param3)))
            {
               _loc16_ = false;
               break;
            }
            
         }
         _loc4_.isHealingSpell = _loc16_;
         _loc17_ = getMinimumDamageEffectOrder(_loc4_.casterId,param2,param1.effects,param3);
         _loc20_ = param1.effects.length;
         _loc18_ = 0;
         while(_loc18_ < _loc20_)
         {
            _loc13_ = param1.effects[_loc18_];
            if(DamageUtil.verifySpellEffectMask(_loc4_.casterId,param2,_loc13_,param3))
            {
               _loc14_ = _loc13_ as EffectInstanceDice;
               if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc13_.effectId) != -1)
               {
                  _loc15_ = new EffectDamage(_loc13_.effectId,-1,_loc13_.random);
                  if(_loc13_.effectId == 90)
                  {
                     if(param2 != _loc4_.casterId)
                     {
                        _loc4_.healDamage.addEffectDamage(_loc15_);
                        _loc15_.lifePointsAddedBasedOnLifePercent = _loc15_.lifePointsAddedBasedOnLifePercent + _loc14_.diceNum * _loc12_.lifePoints / 100;
                     }
                     else
                     {
                        _loc4_.fixedDamage.addEffectDamage(_loc15_);
                        _loc15_.minDamage = _loc15_.maxDamage = _loc14_.diceNum * _loc12_.lifePoints / 100;
                     }
                  }
                  else
                  {
                     _loc4_.healDamage.addEffectDamage(_loc15_);
                     if(_loc13_.effectId == 1109)
                     {
                        if(_loc4_.targetInfos)
                        {
                           _loc15_.lifePointsAddedBasedOnLifePercent = _loc15_.lifePointsAddedBasedOnLifePercent + _loc14_.diceNum * _loc4_.targetInfos.stats.maxLifePoints / 100;
                        }
                     }
                     else
                     {
                        _loc15_.minLifePointsAdded = _loc15_.minLifePointsAdded + _loc14_.diceNum;
                        _loc15_.maxLifePointsAdded = _loc15_.maxLifePointsAdded + (_loc14_.diceSide == 0?_loc14_.diceNum:_loc14_.diceSide);
                     }
                  }
               }
               else if(!(DamageUtil.IMMEDIATE_BOOST_EFFECTS_IDS.indexOf(_loc13_.effectId) == -1) && _loc13_.order < _loc17_)
               {
                  switch(_loc13_.effectId)
                  {
                     case 266:
                        _loc4_.casterChanceBonus = _loc4_.casterChanceBonus + _loc14_.diceNum;
                        break;
                     case 268:
                        _loc4_.casterAgilityBonus = _loc4_.casterAgilityBonus + _loc14_.diceNum;
                        break;
                     case 269:
                        _loc4_.casterIntelligenceBonus = _loc4_.casterIntelligenceBonus + _loc14_.diceNum;
                        break;
                     case 271:
                        _loc4_.casterStrengthBonus = _loc4_.casterStrengthBonus + _loc14_.diceNum;
                        break;
                     case 414:
                        _loc4_.casterPushDamageBonus = _loc4_.casterPushDamageBonus + _loc14_.diceNum;
                        break;
                  }
               }
               
               if((_loc17_ == -1 || _loc13_.order < _loc17_) && _loc13_.effectId == 1075)
               {
                  _loc4_.spellTargetEffectsDurationReduction = _loc14_.diceNum;
               }
            }
            _loc18_++;
         }
         var _loc21_:int = _loc4_.healDamage.effectDamages.length;
         var _loc22_:int = param1.criticalEffect?param1.criticalEffect.length:0;
         var _loc23_:int = _loc22_ > 0?getMinimumDamageEffectOrder(_loc4_.casterId,param2,param1.criticalEffect,param3):0;
         _loc18_ = 0;
         while(_loc18_ < _loc22_)
         {
            _loc13_ = param1.criticalEffect[_loc18_];
            if(DamageUtil.verifySpellEffectMask(_loc4_.casterId,param2,_loc13_,param3))
            {
               _loc14_ = _loc13_ as EffectInstanceDice;
               if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc13_.effectId) != -1)
               {
                  if(_loc13_.effectId == 90 && param2 == _loc4_.casterId)
                  {
                     _loc15_ = _loc4_.fixedDamage.effectDamages[_loc19_];
                     _loc19_++;
                  }
                  else if(_loc18_ < _loc21_)
                  {
                     _loc15_ = _loc4_.healDamage.effectDamages[_loc18_];
                  }
                  else
                  {
                     _loc15_ = new EffectDamage(_loc13_.effectId,-1,_loc13_.random);
                     _loc4_.healDamage.addEffectDamage(_loc15_);
                  }
                  
                  if(_loc13_.effectId == 1109)
                  {
                     if(_loc4_.targetInfos)
                     {
                        _loc15_.criticalLifePointsAddedBasedOnLifePercent = _loc15_.criticalLifePointsAddedBasedOnLifePercent + _loc14_.diceNum * _loc4_.targetInfos.stats.maxLifePoints / 100;
                     }
                  }
                  else if(_loc13_.effectId == 90)
                  {
                     if(param2 != _loc4_.casterId)
                     {
                        _loc15_.criticalLifePointsAddedBasedOnLifePercent = _loc15_.criticalLifePointsAddedBasedOnLifePercent + _loc14_.diceNum * _loc12_.lifePoints / 100;
                     }
                     else
                     {
                        _loc15_.minCriticalDamage = _loc15_.maxCriticalDamage = _loc14_.diceNum * _loc12_.lifePoints / 100;
                        _loc4_.spellHasCriticalDamage = _loc4_.fixedDamage.hasCriticalDamage = _loc15_.hasCritical = true;
                     }
                  }
                  else
                  {
                     _loc15_.minCriticalLifePointsAdded = _loc15_.minCriticalLifePointsAdded + _loc14_.diceNum;
                     _loc15_.maxCriticalLifePointsAdded = _loc15_.maxCriticalLifePointsAdded + (_loc14_.diceSide == 0?_loc14_.diceNum:_loc14_.diceSide);
                  }
                  
                  _loc4_.spellHasCriticalHeal = true;
               }
               else if(!(DamageUtil.IMMEDIATE_BOOST_EFFECTS_IDS.indexOf(_loc13_.effectId) == -1) && _loc13_.order < _loc23_)
               {
                  switch(_loc13_.effectId)
                  {
                     case 266:
                        _loc4_.casterCriticalChanceBonus = _loc4_.casterCriticalChanceBonus + _loc14_.diceNum;
                        break;
                     case 268:
                        _loc4_.casterCriticalAgilityBonus = _loc4_.casterCriticalAgilityBonus + _loc14_.diceNum;
                        break;
                     case 269:
                        _loc4_.casterCriticalIntelligenceBonus = _loc4_.casterCriticalIntelligenceBonus + _loc14_.diceNum;
                        break;
                     case 271:
                        _loc4_.casterCriticalStrengthBonus = _loc4_.casterCriticalStrengthBonus + _loc14_.diceNum;
                        break;
                     case 414:
                        _loc4_.casterCriticalPushDamageBonus = _loc4_.casterCriticalPushDamageBonus + _loc14_.diceNum;
                        break;
                  }
               }
               
               if((_loc23_ == -1 || _loc13_.order < _loc23_) && _loc13_.effectId == 1075)
               {
                  _loc4_.spellTargetEffectsDurationCriticalReduction = _loc14_.diceNum;
               }
            }
            _loc18_++;
         }
         _loc4_.spellHasRandomEffects = (_loc4_.neutralDamage.hasRandomEffects) || (_loc4_.earthDamage.hasRandomEffects) || (_loc4_.fireDamage.hasRandomEffects) || (_loc4_.waterDamage.hasRandomEffects) || (_loc4_.airDamage.hasRandomEffects) || (_loc4_.healDamage.hasRandomEffects);
         if(_loc4_.isWeapon)
         {
            _loc40_ = PlayedCharacterManager.getInstance().currentWeapon;
            _loc4_.spellWeaponCriticalBonus = _loc40_.criticalHitBonus;
            if(_loc40_.type.id == 7)
            {
               _loc4_.spellShapeEfficiencyPercent = 25;
            }
         }
         _loc4_.spellCenterCell = param3;
         for each(_loc13_ in param1.effects)
         {
            if(_loc13_.category == DamageUtil.DAMAGE_EFFECT_CATEGORY)
            {
               if(_loc13_.rawZone)
               {
                  _loc4_.spellShape = _loc13_.rawZone.charCodeAt(0);
                  _loc4_.spellShapeSize = _loc13_.zoneSize;
                  _loc4_.spellShapeMinSize = _loc13_.zoneMinSize;
                  _loc4_.spellShapeEfficiencyPercent = _loc13_.zoneEfficiencyPercent;
                  _loc4_.spellShapeMaxEfficiency = _loc13_.zoneMaxEfficiency;
                  break;
               }
            }
         }
         _loc25_ = BuffManager.getInstance().getAllBuff(_loc4_.casterId);
         _loc27_ = groupBuffsBySpell(_loc25_);
         _loc33_ = -1;
         _loc34_ = 0;
         for(_loc29_ in _loc27_)
         {
            _loc28_ = _loc27_[_loc29_];
            if(_loc29_ == param1.id)
            {
               _loc30_ = param1 as SpellWrapper;
               _loc31_ = false;
               for each(_loc26_ in _loc28_)
               {
                  if((_loc26_.stack) && _loc26_.stack.length == _loc30_.spellLevelInfos.maxStack)
                  {
                     applyBuffModification(_loc4_,_loc26_.stack[0].actionId,-_loc26_.stack[0].param1);
                     _loc31_ = true;
                  }
               }
               if(!_loc31_)
               {
                  _loc34_ = 1;
                  _loc33_ = _loc32_ = _loc28_[0].castingSpell.castingSpellId;
                  for each(_loc26_ in _loc28_)
                  {
                     if(_loc33_ != _loc26_.castingSpell.castingSpellId)
                     {
                        _loc33_ = _loc26_.castingSpell.castingSpellId;
                        _loc34_++;
                     }
                  }
                  if(_loc34_ == _loc30_.spellLevelInfos.maxStack)
                  {
                     for each(_loc26_ in _loc28_)
                     {
                        if(_loc26_.castingSpell.castingSpellId == _loc32_)
                        {
                           applyBuffModification(_loc4_,_loc26_.actionId,-_loc26_.param1);
                           continue;
                        }
                        break;
                     }
                  }
               }
            }
            for each(_loc26_ in _loc28_)
            {
               if(_loc26_.effects.category == DamageUtil.DAMAGE_EFFECT_CATEGORY)
               {
                  if(!_loc4_.buffDamage)
                  {
                     _loc4_.buffDamage = new SpellDamage();
                  }
                  if(_loc26_.castingSpell.spell.id == param1.id)
                  {
                     for each(_loc13_ in param1.effects)
                     {
                        if(_loc13_.effectId == _loc26_.effects.effectId)
                        {
                           break;
                        }
                     }
                  }
                  else
                  {
                     _loc13_ = _loc26_.effects;
                  }
                  if(DamageUtil.verifySpellEffectMask(_loc4_.casterId,param2,_loc13_,param3))
                  {
                     _loc35_ = Effect.getEffectById(_loc13_.effectId).elementId;
                     _loc15_ = new EffectDamage(_loc13_.effectId,_loc35_,_loc13_.random);
                     if(!(_loc13_ is EffectInstanceDice))
                     {
                        if(_loc13_ is EffectInstanceInteger)
                        {
                           _loc15_.minDamage = _loc15_.maxDamage = _loc15_.minCriticalDamage = _loc15_.maxCriticalDamage = (_loc13_ as EffectInstanceInteger).value;
                        }
                        else if(_loc13_ is EffectInstanceMinMax)
                        {
                           _loc15_.minDamage = _loc15_.minCriticalDamage = (_loc13_ as EffectInstanceMinMax).min;
                           _loc15_.maxDamage = _loc15_.maxCriticalDamage = (_loc13_ as EffectInstanceMinMax).max;
                        }
                        
                     }
                     else
                     {
                        _loc14_ = _loc13_ as EffectInstanceDice;
                        _loc15_.minDamage = _loc15_.minCriticalDamage = _loc14_.diceNum;
                        _loc15_.maxDamage = _loc15_.maxCriticalDamage = _loc14_.diceSide == 0?_loc14_.diceNum:_loc14_.diceSide;
                     }
                     _loc36_ = _loc13_.zoneSize != null?int(_loc13_.zoneSize):DamageUtil.EFFECTSHAPE_DEFAULT_AREA_SIZE;
                     _loc37_ = _loc13_.zoneMinSize != null?int(_loc13_.zoneMinSize):DamageUtil.EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE;
                     _loc38_ = _loc13_.zoneEfficiencyPercent != null?int(_loc13_.zoneEfficiencyPercent):DamageUtil.EFFECTSHAPE_DEFAULT_EFFICIENCY;
                     _loc39_ = _loc13_.zoneMaxEfficiency != null?int(_loc13_.zoneMaxEfficiency):DamageUtil.EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY;
                     _loc15_.efficiencyMultiplier = DamageUtil.getShapeEfficiency(_loc13_.rawZone.charCodeAt(0),_loc4_.targetCell,_loc4_.targetCell,_loc36_,_loc37_,_loc38_,_loc39_);
                     _loc4_.buffDamage.addEffectDamage(_loc15_);
                  }
                  continue;
               }
               switch(_loc26_.actionId)
               {
                  case 1054:
                     _loc4_.casterSpellDamagesBonus = _loc4_.casterSpellDamagesBonus + _loc26_.param1;
                     continue;
                  case 1144:
                     _loc4_.casterWeaponDamagesBonus = _loc4_.casterWeaponDamagesBonus + _loc26_.param1;
                     continue;
                  case 1171:
                     _loc4_.casterDamageBoostPercent = _loc4_.casterDamageBoostPercent + _loc26_.param1;
                     continue;
                  case 1172:
                     _loc4_.casterDamageDeboostPercent = _loc4_.casterDamageDeboostPercent + _loc26_.param1;
                     continue;
                  default:
                     continue;
               }
            }
         }
         for each(_loc26_ in _loc4_.targetBuffs)
         {
            if(!_loc26_.trigger && _loc26_.effects.effectId == 952)
            {
               if(isInvulnerableState(int(_loc26_.effects.parameter0)))
               {
                  _loc4_.targetIsInvulnerable = false;
               }
               if(isUnhealableState(int(_loc26_.effects.parameter0)))
               {
                  _loc4_.targetIsUnhealable = false;
               }
            }
            if(_loc26_.actionId == 776)
            {
               _loc4_.targetErosionPercentBonus = _loc4_.targetErosionPercentBonus + _loc26_.param1;
            }
         }
         _loc4_.spellDamageModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(param1.id,CharacterSpellModificationTypeEnum.DAMAGE);
         return _loc4_;
      }
      
      private static function isInvulnerableState(param1:int) : Boolean
      {
         var _loc2_:SpellState = SpellState.getSpellStateById(param1);
         if(_loc2_)
         {
            return !(_loc2_.effectsIds.indexOf(7) == -1);
         }
         return false;
      }
      
      private static function isUnhealableState(param1:int) : Boolean
      {
         var _loc2_:SpellState = SpellState.getSpellStateById(param1);
         if(_loc2_)
         {
            return !(_loc2_.effectsIds.indexOf(5) == -1);
         }
         return false;
      }
      
      private static function applyBuffModification(param1:SpellDamageInfo, param2:int, param3:int) : void
      {
         switch(param2)
         {
            case 118:
               param1.casterStrength = param1.casterStrength + param3;
               break;
            case 119:
               param1.casterAgility = param1.casterAgility + param3;
               break;
            case 123:
               param1.casterChance = param1.casterChance + param3;
               break;
            case 126:
               param1.casterIntelligence = param1.casterIntelligence + param3;
               break;
            case 414:
               param1.casterPushDamageBonus = param1.casterPushDamageBonus + param3;
               break;
         }
      }
      
      private static function groupBuffsBySpell(param1:Array) : Dictionary
      {
         var _loc2_:Dictionary = null;
         var _loc3_:BasicBuff = null;
         for each(_loc3_ in param1)
         {
            if(!_loc2_)
            {
               _loc2_ = new Dictionary();
            }
            if(!_loc2_[_loc3_.castingSpell.spell.id])
            {
               _loc2_[_loc3_.castingSpell.spell.id] = new Vector.<BasicBuff>(0);
            }
            _loc2_[_loc3_.castingSpell.spell.id].push(_loc3_);
         }
         return _loc2_;
      }
      
      private static function getMinimumDamageEffectOrder(param1:int, param2:int, param3:Vector.<EffectInstance>, param4:int) : int
      {
         var _loc6_:EffectInstance = null;
         var _loc5_:* = -1;
         for each(_loc6_ in param3)
         {
            if((_loc6_.category == 2 || !(DamageUtil.HEALING_EFFECTS_IDS.indexOf(_loc6_.effectId) == -1) || _loc6_.effectId == 5) && (DamageUtil.verifySpellEffectMask(param1,param2,_loc6_,param4)))
            {
               if(_loc5_ == -1)
               {
                  _loc5_ = _loc6_.order;
               }
               else
               {
                  _loc5_ = _loc6_.order < _loc5_?_loc6_.order:_loc5_;
               }
            }
         }
         return _loc5_;
      }
      
      private var _targetId:int;
      
      private var _targetInfos:GameFightFighterInformations;
      
      private var _originalTargetsIds:Vector.<int>;
      
      private var _buffsWithSpellsTriggered:Vector.<uint>;
      
      private var _effectsModifications:Vector.<EffectModification>;
      
      private var _criticalEffectsModifications:Vector.<EffectModification>;
      
      public var isWeapon:Boolean;
      
      public var isHealingSpell:Boolean;
      
      public var casterId:int;
      
      public var casterLevel:int;
      
      public var casterStrength:int;
      
      public var casterChance:int;
      
      public var casterAgility:int;
      
      public var casterIntelligence:int;
      
      public var casterLifePointsAfterNormalMinDamage:uint;
      
      public var casterLifePointsAfterNormalMaxDamage:uint;
      
      public var casterLifePointsAfterCriticalMinDamage:uint;
      
      public var casterLifePointsAfterCriticalMaxDamage:uint;
      
      public var targetLifePointsAfterNormalMinDamage:uint;
      
      public var targetLifePointsAfterNormalMaxDamage:uint;
      
      public var targetLifePointsAfterCriticalMinDamage:uint;
      
      public var targetLifePointsAfterCriticalMaxDamage:uint;
      
      public var casterStrengthBonus:int;
      
      public var casterChanceBonus:int;
      
      public var casterAgilityBonus:int;
      
      public var casterIntelligenceBonus:int;
      
      public var casterCriticalStrengthBonus:int;
      
      public var casterCriticalChanceBonus:int;
      
      public var casterCriticalAgilityBonus:int;
      
      public var casterCriticalIntelligenceBonus:int;
      
      public var casterCriticalHit:int;
      
      public var casterCriticalHitWeapon:int;
      
      public var casterHealBonus:int;
      
      public var casterAllDamagesBonus:int;
      
      public var casterDamagesBonus:int;
      
      public var casterSpellDamagesBonus:int;
      
      public var casterWeaponDamagesBonus:int;
      
      public var casterTrapBonus:int;
      
      public var casterTrapBonusPercent:int;
      
      public var casterGlyphBonusPercent:int;
      
      public var casterPermanentDamagePercent:int;
      
      public var casterPushDamageBonus:int;
      
      public var casterCriticalPushDamageBonus:int;
      
      public var casterCriticalDamageBonus:int;
      
      public var casterNeutralDamageBonus:int;
      
      public var casterEarthDamageBonus:int;
      
      public var casterWaterDamageBonus:int;
      
      public var casterAirDamageBonus:int;
      
      public var casterFireDamageBonus:int;
      
      public var casterDamageBoostPercent:int;
      
      public var casterDamageDeboostPercent:int;
      
      public var casterStates:Array;
      
      public var spellEffects:Vector.<EffectInstance>;
      
      public var spellCriticalEffects:Vector.<EffectInstance>;
      
      public var spellCenterCell:int;
      
      public var neutralDamage:SpellDamage;
      
      public var earthDamage:SpellDamage;
      
      public var fireDamage:SpellDamage;
      
      public var waterDamage:SpellDamage;
      
      public var airDamage:SpellDamage;
      
      public var buffDamage:SpellDamage;
      
      public var fixedDamage:SpellDamage;
      
      public var spellWeaponCriticalBonus:int;
      
      public var spellShape:uint;
      
      public var spellShapeSize:Object;
      
      public var spellShapeMinSize:Object;
      
      public var spellShapeEfficiencyPercent:Object;
      
      public var spellShapeMaxEfficiency:Object;
      
      public var healDamage:SpellDamage;
      
      public var spellHasCriticalDamage:Boolean;
      
      public var spellHasCriticalHeal:Boolean;
      
      public var spellHasRandomEffects:Boolean;
      
      public var spellDamageModification:CharacterSpellModification;
      
      public var targetLevel:int;
      
      public var targetIsInvulnerable:Boolean;
      
      public var targetIsUnhealable:Boolean;
      
      public var targetCell:int = -1;
      
      public var targetShieldPoints:uint;
      
      public var targetTriggeredShieldPoints:uint;
      
      public var targetNeutralElementResistPercent:int;
      
      public var targetEarthElementResistPercent:int;
      
      public var targetWaterElementResistPercent:int;
      
      public var targetAirElementResistPercent:int;
      
      public var targetFireElementResistPercent:int;
      
      public var targetBuffs:Array;
      
      public var targetStates:Array;
      
      public var targetNeutralElementReduction:int;
      
      public var targetEarthElementReduction:int;
      
      public var targetWaterElementReduction:int;
      
      public var targetAirElementReduction:int;
      
      public var targetFireElementReduction:int;
      
      public var targetCriticalDamageFixedResist:int;
      
      public var targetPushDamageFixedResist:int;
      
      public var targetErosionLifePoints:int;
      
      public var targetSpellMinErosionLifePoints:int;
      
      public var targetSpellMaxErosionLifePoints:int;
      
      public var targetSpellMinCriticalErosionLifePoints:int;
      
      public var targetSpellMaxCriticalErosionLifePoints:int;
      
      public var targetErosionPercentBonus:int;
      
      public var pushedEntities:Vector.<PushedEntity>;
      
      public var splashDamages:Vector.<SplashDamage>;
      
      public var sharedDamage:SpellDamage;
      
      public var damageSharingTargets:Vector.<int>;
      
      public var portalsSpellEfficiencyBonus:Number;
      
      public var spellTargetEffectsDurationReduction:int;
      
      public var spellTargetEffectsDurationCriticalReduction:int;
      
      public function getEffectModification(param1:int, param2:int, param3:Boolean) : EffectModification
      {
         var _loc4_:* = 0;
         var _loc5_:int = this._effectsModifications?this._effectsModifications.length:0;
         var _loc6_:int = this._criticalEffectsModifications?this._criticalEffectsModifications.length:0;
         var _loc7_:int = param2;
         if(!param3 && (this._effectsModifications))
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(this._effectsModifications[_loc4_].effectId == param1)
               {
                  if(_loc7_ == 0)
                  {
                     return this._effectsModifications[_loc4_];
                  }
                  _loc7_--;
               }
               _loc4_++;
            }
         }
         else if(this._criticalEffectsModifications)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               if(this._criticalEffectsModifications[_loc4_].effectId == param1)
               {
                  if(_loc7_ == 0)
                  {
                     return this._criticalEffectsModifications[_loc4_];
                  }
                  _loc7_--;
               }
               _loc4_++;
            }
         }
         
         return null;
      }
      
      public function get targetId() : int
      {
         return this._targetId;
      }
      
      public function set targetId(param1:int) : void
      {
         var _loc3_:* = 0;
         var _loc2_:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!_loc2_)
         {
            return;
         }
         this._targetId = param1;
         this.targetLevel = _loc2_.getFighterLevel(this._targetId);
         this._targetInfos = _loc2_.entitiesFrame.getEntityInfos(this._targetId) as GameFightFighterInformations;
         if(this.targetInfos)
         {
            this.targetShieldPoints = this.targetInfos.stats.shieldPoints;
            this.targetNeutralElementResistPercent = this.targetInfos.stats.neutralElementResistPercent;
            this.targetEarthElementResistPercent = this.targetInfos.stats.earthElementResistPercent;
            this.targetWaterElementResistPercent = this.targetInfos.stats.waterElementResistPercent;
            this.targetAirElementResistPercent = this.targetInfos.stats.airElementResistPercent;
            this.targetFireElementResistPercent = this.targetInfos.stats.fireElementResistPercent;
            this.targetNeutralElementReduction = this.targetInfos.stats.neutralElementReduction;
            this.targetEarthElementReduction = this.targetInfos.stats.earthElementReduction;
            this.targetWaterElementReduction = this.targetInfos.stats.waterElementReduction;
            this.targetAirElementReduction = this.targetInfos.stats.airElementReduction;
            this.targetFireElementReduction = this.targetInfos.stats.fireElementReduction;
            this.targetCriticalDamageFixedResist = this.targetInfos.stats.criticalDamageFixedResist;
            this.targetPushDamageFixedResist = this.targetInfos.stats.pushDamageFixedResist;
            this.targetErosionLifePoints = this.targetInfos.stats.baseMaxLifePoints - this.targetInfos.stats.maxLifePoints;
            this.targetCell = this.targetInfos.disposition.cellId;
         }
         this.targetBuffs = BuffManager.getInstance().getAllBuff(this._targetId);
         this.targetIsInvulnerable = false;
         this.targetIsUnhealable = false;
         this.targetStates = FightersStateManager.getInstance().getStates(param1);
         if(this.targetStates)
         {
            for each(_loc3_ in this.targetStates)
            {
               if(isInvulnerableState(_loc3_))
               {
                  this.targetIsInvulnerable = true;
               }
               if(isUnhealableState(_loc3_))
               {
                  this.targetIsUnhealable = true;
               }
            }
         }
      }
      
      public function get targetInfos() : GameFightFighterInformations
      {
         return this._targetInfos;
      }
      
      public function get originalTargetsIds() : Vector.<int>
      {
         return this._originalTargetsIds;
      }
      
      public function get triggeredSpellsByCasterOnTarget() : Vector.<TriggeredSpell>
      {
         var _loc1_:Vector.<TriggeredSpell> = null;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:EffectInstance = null;
         var _loc5_:EffectInstance = null;
         var _loc6_:* = 0;
         for each(_loc4_ in this.spellEffects)
         {
            if(_loc4_.effectId == 1160 && (DamageUtil.verifySpellEffectMask(this.casterId,this.targetId,_loc4_,this.spellCenterCell)) && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,this.spellEffects,_loc4_,false,_loc4_.triggers,this.spellCenterCell)))
            {
               if(!_loc1_)
               {
                  _loc1_ = new Vector.<TriggeredSpell>();
               }
               _loc2_ = int(_loc4_.parameter0);
               _loc3_ = int(_loc4_.parameter1);
               _loc6_ = 0;
               for each(_loc5_ in this.spellCriticalEffects)
               {
                  if(_loc5_.effectId == 1160 && int(_loc5_.parameter0) == _loc2_)
                  {
                     _loc6_ = int(_loc5_.parameter1);
                     break;
                  }
               }
               _loc1_.push(TriggeredSpell.create(_loc4_.triggers,_loc2_,_loc3_,_loc6_,this.casterId,this.targetId));
            }
         }
         return _loc1_;
      }
      
      public function get targetTriggeredSpells() : Vector.<TriggeredSpell>
      {
         var _loc1_:BasicBuff = null;
         var _loc2_:Vector.<TriggeredSpell> = null;
         var _loc3_:* = 0;
         var _loc4_:EffectInstance = null;
         var _loc5_:* = 0;
         var _loc6_:* = false;
         for each(_loc1_ in this.targetBuffs)
         {
            _loc6_ = !this._buffsWithSpellsTriggered || this._buffsWithSpellsTriggered.indexOf(_loc1_.uid) == -1;
            if((_loc6_) && (_loc1_.effects.effectId == ActionIdConverter.ACTION_TARGET_CASTS_SPELL || _loc1_.effects.effectId == ActionIdConverter.ACTION_TARGET_CASTS_SPELL_WITH_ANIM) && (DamageUtil.verifyBuffTriggers(this,_loc1_)))
            {
               if(!this._buffsWithSpellsTriggered)
               {
                  this._buffsWithSpellsTriggered = new Vector.<uint>(0);
               }
               this._buffsWithSpellsTriggered.push(_loc1_.uid);
               if(!_loc2_)
               {
                  _loc2_ = new Vector.<TriggeredSpell>(0);
               }
               _loc3_ = int(_loc1_.effects.parameter0);
               _loc5_ = 0;
               if((_loc1_.castingSpell.spellRank) && (_loc1_.castingSpell.spellRank.criticalEffect))
               {
                  for each(_loc4_ in _loc1_.castingSpell.spellRank.criticalEffect)
                  {
                     if((_loc4_.effectId == ActionIdConverter.ACTION_TARGET_CASTS_SPELL || _loc4_.effectId == ActionIdConverter.ACTION_TARGET_CASTS_SPELL_WITH_ANIM) && int(_loc4_.parameter0) == _loc3_)
                     {
                        _loc5_ = int(_loc4_.parameter1);
                        break;
                     }
                  }
               }
               _loc2_.push(TriggeredSpell.create(_loc1_.effects.triggers,_loc3_,int(_loc1_.effects.parameter1),_loc5_,this.targetId,this.targetId));
            }
         }
         return _loc2_;
      }
      
      public function addTriggeredSpellsEffects(param1:Vector.<TriggeredSpell>) : Boolean
      {
         var _loc2_:* = false;
         var _loc3_:TriggeredSpell = null;
         var _loc6_:EffectInstance = null;
         var _loc7_:EffectInstance = null;
         var _loc8_:* = 0;
         var _loc9_:EffectModification = null;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = false;
         var _loc13_:* = false;
         var _loc4_:int = this.spellEffects.length;
         var _loc5_:int = this.spellCriticalEffects?this.spellCriticalEffects.length:0;
         for each(_loc3_ in param1)
         {
            _loc10_ = 0;
            _loc11_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc6_ = this.spellEffects[_loc8_];
               if(_loc6_.random == 0 && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,this.spellEffects,_loc6_,this.isWeapon,_loc3_.triggers,this.spellCenterCell)))
               {
                  for each(_loc7_ in _loc3_.spell.effects)
                  {
                     _loc12_ = DamageUtil.verifySpellEffectMask(_loc3_.spell.playerId,this.casterId,_loc7_,this.spellCenterCell,this.casterId);
                     _loc13_ = DamageUtil.verifySpellEffectMask(_loc3_.spell.playerId,_loc3_.spell.playerId,_loc7_,this.spellCenterCell,this.casterId);
                     if(DamageUtil.TRIGGERED_EFFECTS_IDS.indexOf(_loc7_.effectId) != -1)
                     {
                        if(!this._effectsModifications)
                        {
                           this._effectsModifications = new Vector.<EffectModification>(0);
                        }
                        _loc9_ = _loc8_ + 1 <= this._effectsModifications.length?this._effectsModifications[_loc8_]:null;
                        if(!_loc9_)
                        {
                           _loc9_ = new EffectModification(_loc6_.effectId);
                           this._effectsModifications.push(_loc9_);
                        }
                        if((Effect.getEffectById(_loc7_.effectId).active) && (_loc12_))
                        {
                           switch(_loc7_.effectId)
                           {
                              case 138:
                                 _loc9_.damagesBonus = _loc9_.damagesBonus + _loc10_;
                                 _loc10_ = _loc10_ + (_loc7_ as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        if(_loc13_)
                        {
                           switch(_loc7_.effectId)
                           {
                              case 1040:
                                 _loc9_.shieldPoints = _loc9_.shieldPoints + _loc11_;
                                 _loc11_ = _loc11_ + (_loc7_ as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        _loc2_ = true;
                     }
                  }
               }
               _loc8_++;
            }
            _loc10_ = 0;
            _loc11_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc6_ = this.spellCriticalEffects[_loc8_];
               if(_loc6_.random == 0 && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,this.spellCriticalEffects,_loc6_,this.isWeapon,_loc3_.triggers,this.spellCenterCell)))
               {
                  for each(_loc7_ in _loc3_.spell.effects)
                  {
                     _loc12_ = DamageUtil.verifySpellEffectMask(_loc3_.spell.playerId,this.casterId,_loc7_,this.spellCenterCell,this.casterId);
                     _loc13_ = DamageUtil.verifySpellEffectMask(_loc3_.spell.playerId,_loc3_.spell.playerId,_loc7_,this.spellCenterCell,this.casterId);
                     if(DamageUtil.TRIGGERED_EFFECTS_IDS.indexOf(_loc7_.effectId) != -1)
                     {
                        if(!this._criticalEffectsModifications)
                        {
                           this._criticalEffectsModifications = new Vector.<EffectModification>(0);
                        }
                        _loc9_ = _loc8_ + 1 <= this._criticalEffectsModifications.length?this._criticalEffectsModifications[_loc8_]:null;
                        if(!_loc9_)
                        {
                           _loc9_ = new EffectModification(_loc6_.effectId);
                           this._criticalEffectsModifications.push(_loc9_);
                        }
                        if((Effect.getEffectById(_loc7_.effectId).active) && (_loc12_))
                        {
                           switch(_loc7_.effectId)
                           {
                              case 138:
                                 _loc9_.damagesBonus = _loc9_.damagesBonus + _loc10_;
                                 _loc10_ = _loc10_ + (_loc7_ as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        if(_loc13_)
                        {
                           switch(_loc7_.effectId)
                           {
                              case 1040:
                                 _loc9_.shieldPoints = _loc9_.shieldPoints + _loc11_;
                                 _loc11_ = _loc11_ + (_loc7_ as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        _loc2_ = true;
                     }
                  }
               }
               _loc8_++;
            }
         }
         return _loc2_;
      }
      
      public function getDamageSharingTargets() : Vector.<int>
      {
         var _loc1_:Vector.<int> = null;
         var _loc2_:BasicBuff = null;
         var _loc3_:BasicBuff = null;
         var _loc4_:Vector.<int> = null;
         var _loc5_:* = 0;
         var _loc6_:Array = null;
         for each(_loc2_ in this.targetBuffs)
         {
            if(_loc2_.actionId == 1061 && (DamageUtil.verifyBuffTriggers(this,_loc2_)))
            {
               _loc1_ = new Vector.<int>(0);
               _loc1_.push(this.targetId);
               _loc4_ = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntitiesIdsList();
               for each(_loc5_ in _loc4_)
               {
                  if(_loc5_ != this.targetId)
                  {
                     _loc6_ = BuffManager.getInstance().getAllBuff(_loc5_);
                     for each(_loc3_ in _loc6_)
                     {
                        if(_loc3_.actionId == 1061)
                        {
                           _loc1_.push(_loc5_);
                           break;
                        }
                     }
                  }
               }
               break;
            }
         }
         return _loc1_;
      }
   }
}
