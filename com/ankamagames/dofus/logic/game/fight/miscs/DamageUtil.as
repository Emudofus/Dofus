package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
   import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DamageUtil extends Object
   {
      
      public function DamageUtil() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DamageUtil));
      
      private static const exclusiveTargetMasks:RegExp = new RegExp("\\*?[bBeEfFzZKoOPpTWUvV][0-9]*","g");
      
      private static const EFFECTSHAPE_DEFAULT_AREA_SIZE:int = 1;
      
      private static const EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE:int = 0;
      
      private static const EFFECTSHAPE_DEFAULT_EFFICIENCY:int = 10;
      
      private static const EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY:int = 4;
      
      private static const DAMAGE_NOT_BOOSTED:int = 1;
      
      private static const UNLIMITED_ZONE_SIZE:int = 50;
      
      public static const DAMAGE_EFFECT_CATEGORY:int = 2;
      
      public static const EROSION_DAMAGE_EFFECTS_IDS:Array = [1092,1093,1094,1095,1096];
      
      public static const HEALING_EFFECTS_IDS:Array = [81,108,1109];
      
      public static function isDamagedOrHealedBySpell(param1:int, param2:int, param3:Object) : Boolean {
         var _loc8_:* = false;
         var _loc9_:EffectInstance = null;
         var _loc4_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!param3 || !_loc4_)
         {
            return false;
         }
         var _loc5_:TiphonSprite = DofusEntities.getEntity(param2) as AnimatedCharacter;
         var _loc6_:* = param2 == param1;
         var _loc7_:Boolean = (_loc5_) && (_loc5_.parentSprite) && _loc5_.parentSprite.carriedEntity == _loc5_;
         if(!(param3 is SpellWrapper))
         {
            if(!_loc6_ && !_loc7_)
            {
               return true;
            }
            return false;
         }
         for each (_loc9_ in param3.effects)
         {
            if((_loc9_.category == 2 || !(HEALING_EFFECTS_IDS.indexOf(_loc9_.effectId) == -1)) && (verifySpellEffectMask(param1,param2,_loc9_)))
            {
               _loc8_ = true;
               break;
            }
         }
         return _loc8_;
      }
      
      public static function getBuffEffectElement(param1:BasicBuff) : int {
         var _loc2_:* = 0;
         var _loc4_:EffectInstance = null;
         var _loc5_:SpellLevel = null;
         var _loc3_:Effect = Effect.getEffectById(param1.effects.effectId);
         _loc2_ = _loc3_.elementId;
         if(_loc2_ == -1)
         {
            _loc5_ = param1.castingSpell.spellRank;
            if(!_loc5_)
            {
               _loc5_ = SpellLevel.getLevelById(param1.castingSpell.spell.spellLevels[0]);
            }
            for each (_loc4_ in _loc5_.effects)
            {
               if(_loc4_.effectId == param1.effects.effectId)
               {
                  if(_loc4_.triggers.indexOf("DA") != -1)
                  {
                     _loc2_ = 4;
                  }
                  else
                  {
                     if(_loc4_.triggers.indexOf("DE") != -1)
                     {
                        _loc2_ = 1;
                     }
                     else
                     {
                        if(_loc4_.triggers.indexOf("DF") != -1)
                        {
                           _loc2_ = 2;
                        }
                        else
                        {
                           if(_loc4_.triggers.indexOf("DN") != -1)
                           {
                              _loc2_ = 0;
                           }
                           else
                           {
                              if(_loc4_.triggers.indexOf("DW") != -1)
                              {
                                 _loc2_ = 3;
                              }
                           }
                        }
                     }
                  }
                  break;
               }
            }
         }
         return _loc2_;
      }
      
      public static function verifyBuffEffectTrigger(param1:SpellDamageInfo, param2:BasicBuff) : Boolean {
         var _loc4_:* = false;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:EffectInstance = null;
         var _loc9_:GameFightFighterInformations = null;
         var _loc10_:* = false;
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc3_)
         {
            return false;
         }
         var _loc8_:SpellLevel = param2.castingSpell.spellRank;
         if(!_loc8_)
         {
            _loc8_ = SpellLevel.getLevelById(param2.castingSpell.spell.spellLevels[0]);
         }
         for each (_loc7_ in _loc8_.effects)
         {
            if(_loc7_.effectId == param2.effects.effectId)
            {
               _loc5_ = _loc7_.triggers.split(",");
               break;
            }
         }
         _loc9_ = _loc3_.getEntityInfos(param1.targetId) as GameFightFighterInformations;
         _loc10_ = _loc9_.teamId == (_loc3_.getEntityInfos(param1.casterId) as GameFightFighterInformations).teamId;
         for each (_loc13_ in _loc5_)
         {
            switch(_loc6_)
            {
               case "I":
                  _loc4_ = true;
                  break;
               case "D":
                  _loc4_ = param1.airDamage.minDamage > 0 || param1.earthDamage.minDamage > 0 || param1.fireDamage.minDamage > 0 || param1.neutralDamage.minDamage > 0 || param1.waterDamage.minDamage > 0;
                  break;
               case "DA":
                  _loc4_ = param1.airDamage.minDamage > 0;
                  break;
               case "DBA":
                  _loc4_ = _loc10_;
                  break;
               case "DBE":
                  _loc4_ = !_loc10_;
                  break;
               case "DC":
                  _loc4_ = param1.isWeapon;
                  break;
               case "DE":
                  _loc4_ = param1.earthDamage.minDamage > 0;
                  break;
               case "DF":
                  _loc4_ = param1.fireDamage.minDamage > 0;
                  break;
               case "DG":
                  break;
               case "DI":
                  break;
               case "DM":
                  break;
               case "DN":
                  _loc4_ = param1.neutralDamage.minDamage > 0;
                  break;
               case "DP":
                  break;
               case "DR":
                  break;
               case "Dr":
                  break;
               case "DS":
                  _loc4_ = !param1.isWeapon;
                  break;
               case "DTB":
                  break;
               case "DTE":
                  break;
               case "DW":
                  _loc4_ = param1.waterDamage.minDamage > 0;
                  break;
               case "MD":
                  break;
               case "MDM":
                  break;
               case "MDP":
                  break;
            }
            if(_loc4_)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function verifySpellEffectMask(param1:int, param2:int, param3:EffectInstance) : Boolean {
         var _loc12_:RegExp = null;
         var _loc13_:String = null;
         var _loc14_:Array = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:* = false;
         var _loc18_:* = false;
         var _loc19_:* = 0;
         var _loc4_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!param3 || !_loc4_ || param3.delay > 0)
         {
            return false;
         }
         var _loc5_:TiphonSprite = DofusEntities.getEntity(param2) as AnimatedCharacter;
         var _loc6_:* = param2 == param1;
         var _loc7_:Boolean = (_loc5_) && (_loc5_.parentSprite) && _loc5_.parentSprite.carriedEntity == _loc5_;
         var _loc8_:GameFightFighterInformations = _loc4_.getEntityInfos(param2) as GameFightFighterInformations;
         var _loc9_:Array = FightersStateManager.getInstance().getStates(param1);
         var _loc10_:Array = FightersStateManager.getInstance().getStates(param2);
         var _loc11_:* = _loc8_.teamId == (_loc4_.getEntityInfos(param1) as GameFightFighterInformations).teamId;
         if(_loc6_)
         {
            _loc13_ = "caC";
         }
         else
         {
            if((_loc8_.stats.summoned) && _loc8_.stats.maxMovementPoints == 0)
            {
               _loc13_ = _loc11_?"agsj":"ASJ";
            }
            else
            {
               if(_loc8_.stats.summoned)
               {
                  _loc13_ = _loc11_?"agij":"AIJ";
               }
               else
               {
                  if(_loc8_ is GameFightCompanionInformations)
                  {
                     _loc13_ = _loc11_?"agdl":"ADL";
                  }
                  else
                  {
                     if(_loc8_ is GameFightMonsterInformations)
                     {
                        _loc13_ = _loc11_?"agm":"AM";
                     }
                     else
                     {
                        _loc13_ = _loc11_?"gahl":"AHL";
                     }
                  }
               }
            }
         }
         _loc12_ = new RegExp("[" + _loc13_ + "]","g");
         _loc18_ = param3.targetMask.match(_loc12_).length > 0;
         if(_loc18_)
         {
            _loc14_ = param3.targetMask.match(exclusiveTargetMasks);
            if(_loc14_.length > 0)
            {
               _loc18_ = false;
               for each (_loc15_ in _loc14_)
               {
                  _loc17_ = _loc15_.charAt(0) == "*";
                  _loc15_ = _loc17_?_loc15_.substr(1,_loc15_.length-1):_loc15_;
                  _loc16_ = _loc15_.length > 1?_loc15_.substr(1,_loc15_.length-1):null;
                  _loc15_ = _loc15_.charAt(0);
                  switch(_loc15_)
                  {
                     case "b":
                        continue;
                     case "B":
                        continue;
                     case "e":
                        _loc19_ = parseInt(_loc16_);
                        if(_loc17_)
                        {
                           _loc18_ = !_loc9_ || _loc9_.indexOf(_loc19_) == -1;
                        }
                        else
                        {
                           _loc18_ = !_loc10_ || _loc10_.indexOf(_loc19_) == -1;
                        }
                        continue;
                     case "E":
                        _loc19_ = parseInt(_loc16_);
                        if(_loc17_)
                        {
                           _loc18_ = (_loc9_) && !(_loc9_.indexOf(_loc19_) == -1);
                        }
                        else
                        {
                           _loc18_ = (_loc10_) && !(_loc10_.indexOf(_loc19_) == -1);
                        }
                        continue;
                     case "f":
                        continue;
                     case "F":
                        continue;
                     case "z":
                        continue;
                     case "Z":
                        continue;
                     case "K":
                        continue;
                     case "o":
                        continue;
                     case "O":
                        continue;
                     case "p":
                        continue;
                     case "P":
                        continue;
                     case "T":
                        continue;
                     case "W":
                        continue;
                     case "U":
                        continue;
                     case "v":
                        continue;
                     case "V":
                        continue;
                     default:
                        continue;
                  }
               }
            }
         }
         return _loc18_;
      }
      
      public static function getSpellElementDamage(param1:Object, param2:int, param3:int=0, param4:int=0) : SpellDamage {
         var _loc7_:GameFightFighterInformations = null;
         var _loc9_:EffectDamage = null;
         var _loc10_:EffectInstance = null;
         var _loc11_:EffectInstanceDice = null;
         var _loc12_:SpellWrapper = null;
         var _loc5_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!_loc5_)
         {
            return null;
         }
         var _loc6_:int = _loc7_?_loc7_.stats.baseMaxLifePoints - _loc7_.stats.maxLifePoints:0;
         _loc7_ = _loc5_.getEntityInfos(param4) as GameFightFighterInformations;
         var _loc8_:SpellDamage = new SpellDamage();
         for each (_loc10_ in param1.effects)
         {
            if(_loc10_.category == DAMAGE_EFFECT_CATEGORY && HEALING_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1 && Effect.getEffectById(_loc10_.effectId).elementId == param2 && ((!_loc10_.targetMask) || ((_loc10_.targetMask) && (DamageUtil.verifySpellEffectMask(param3,param4,_loc10_)))))
            {
               _loc9_ = getEffectDamageByEffectId(_loc8_,_loc10_.effectId);
               if(!_loc9_)
               {
                  _loc9_ = new EffectDamage(_loc10_.effectId,param2,_loc10_.random);
                  _loc8_.addEffectDamage(_loc9_);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) != -1)
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minErosionDamage = _loc9_.minErosionDamage + _loc6_ * _loc11_.diceNum / 100;
                  _loc9_.maxErosionDamage = _loc9_.maxErosionDamage + _loc6_ * _loc11_.diceNum / 100;
               }
               else
               {
                  if(!(_loc10_ is EffectInstanceDice))
                  {
                     if(_loc10_ is EffectInstanceInteger)
                     {
                        _loc9_.minDamage = _loc9_.minDamage + (_loc10_ as EffectInstanceInteger).value;
                        _loc9_.maxDamage = _loc9_.maxDamage + (_loc10_ as EffectInstanceInteger).value;
                     }
                     else
                     {
                        if(_loc10_ is EffectInstanceMinMax)
                        {
                           _loc9_.minDamage = _loc9_.minDamage + (_loc10_ as EffectInstanceMinMax).min;
                           _loc9_.maxDamage = _loc9_.maxDamage + (_loc10_ as EffectInstanceMinMax).max;
                        }
                     }
                  }
                  else
                  {
                     _loc11_ = _loc10_ as EffectInstanceDice;
                     _loc9_.minDamage = _loc9_.minDamage + _loc11_.diceNum;
                     _loc9_.maxDamage = _loc9_.maxDamage + (_loc11_.diceSide == 0?_loc11_.diceNum:_loc11_.diceSide);
                  }
               }
            }
         }
         for each (_loc10_ in param1.criticalEffect)
         {
            if(_loc10_.category == DAMAGE_EFFECT_CATEGORY && HEALING_EFFECTS_IDS.indexOf(_loc10_.effectId) == -1 && Effect.getEffectById(_loc10_.effectId).elementId == param2 && ((!_loc10_.targetMask) || ((_loc10_.targetMask) && (DamageUtil.verifySpellEffectMask(param3,param4,_loc10_)))))
            {
               _loc9_ = getEffectDamageByEffectId(_loc8_,_loc10_.effectId);
               if(!_loc9_)
               {
                  _loc9_ = new EffectDamage(_loc10_.effectId,param2,_loc10_.random);
                  _loc8_.addEffectDamage(_loc9_);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(_loc10_.effectId) != -1)
               {
                  _loc11_ = _loc10_ as EffectInstanceDice;
                  _loc9_.minCriticalErosionDamage = _loc9_.minCriticalErosionDamage + _loc6_ * _loc11_.diceNum / 100;
                  _loc9_.maxCriticalErosionDamage = _loc9_.maxCriticalErosionDamage + _loc6_ * _loc11_.diceNum / 100;
               }
               else
               {
                  if(!(_loc10_ is EffectInstanceDice))
                  {
                     if(_loc10_ is EffectInstanceInteger)
                     {
                        _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + (_loc10_ as EffectInstanceInteger).value;
                        _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc10_ as EffectInstanceInteger).value;
                     }
                     else
                     {
                        if(_loc10_ is EffectInstanceMinMax)
                        {
                           _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + (_loc10_ as EffectInstanceMinMax).min;
                           _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc10_ as EffectInstanceMinMax).max;
                        }
                     }
                  }
                  else
                  {
                     _loc11_ = _loc10_ as EffectInstanceDice;
                     _loc9_.minCriticalDamage = _loc9_.minCriticalDamage + _loc11_.diceNum;
                     _loc9_.maxCriticalDamage = _loc9_.maxCriticalDamage + (_loc11_.diceSide == 0?_loc11_.diceNum:_loc11_.diceSide);
                  }
               }
               _loc8_.hasCriticalDamage = _loc9_.hasCritical = true;
            }
         }
         if(param3 == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            _loc12_ = param1 as SpellWrapper;
            for each (_loc9_ in _loc8_.effectDamages)
            {
               applySpellModificationsOnEffect(_loc9_,_loc12_);
            }
         }
         return _loc8_;
      }
      
      public static function applySpellModificationsOnEffect(param1:EffectDamage, param2:SpellWrapper) : void {
         if(!param2)
         {
            return;
         }
         var _loc3_:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(param2.id,CharacterSpellModificationTypeEnum.BASE_DAMAGE);
         if(_loc3_)
         {
            param1.minDamage = param1.minDamage + _loc3_.value.contextModif;
            param1.maxDamage = param1.maxDamage + _loc3_.value.contextModif;
            if(param1.hasCritical)
            {
               param1.minCriticalDamage = param1.minCriticalDamage + _loc3_.value.contextModif;
               param1.maxCriticalDamage = param1.maxCriticalDamage + _loc3_.value.contextModif;
            }
         }
      }
      
      public static function getEffectDamageByEffectId(param1:SpellDamage, param2:int) : EffectDamage {
         var _loc3_:EffectDamage = null;
         var _loc4_:EffectDamage = null;
         for each (_loc4_ in param1.effectDamages)
         {
            if(_loc4_.effectId == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public static function getSpellDamage(param1:SpellDamageInfo) : SpellDamage {
         var _loc3_:* = 0;
         var _loc25_:BasicBuff = null;
         var _loc26_:* = NaN;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc2_:SpellDamage = new SpellDamage();
         param1.casterStrength = param1.casterStrength + param1.casterDamagesBonus;
         param1.casterChance = param1.casterChance + param1.casterDamagesBonus;
         param1.casterAgility = param1.casterAgility + param1.casterDamagesBonus;
         param1.casterIntelligence = param1.casterIntelligence + param1.casterDamagesBonus;
         var _loc4_:uint = MapPoint.fromCellId(param1.targetCell).distanceToCell(MapPoint.fromCellId(param1.spellCenterCell));
         var _loc5_:int = param1.spellShapeSize != 0?param1.spellShapeSize:EFFECTSHAPE_DEFAULT_AREA_SIZE;
         var _loc6_:int = param1.spellShapeMinSize != 0?param1.spellShapeMinSize:EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE;
         var _loc7_:int = param1.spellShapeEfficiencyPercent != 0?param1.spellShapeEfficiencyPercent:EFFECTSHAPE_DEFAULT_EFFICIENCY;
         var _loc8_:int = param1.spellShapeMaxEfficiency != 0?param1.spellShapeMaxEfficiency:EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY;
         var _loc9_:Number = getSimpleEfficiency(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         var _loc10_:EffectDamage = computeDamage(param1.neutralDamage,param1,_loc9_);
         var _loc11_:EffectDamage = computeDamage(param1.earthDamage,param1,_loc9_);
         var _loc12_:EffectDamage = computeDamage(param1.waterDamage,param1,_loc9_);
         var _loc13_:EffectDamage = computeDamage(param1.airDamage,param1,_loc9_);
         var _loc14_:EffectDamage = computeDamage(param1.fireDamage,param1,_loc9_);
         var _loc15_:int = _loc10_.minErosionDamage + _loc11_.minErosionDamage + _loc12_.minErosionDamage + _loc13_.minErosionDamage + _loc14_.minErosionDamage;
         var _loc16_:int = _loc10_.maxErosionDamage + _loc11_.maxErosionDamage + _loc12_.maxErosionDamage + _loc13_.maxErosionDamage + _loc14_.maxErosionDamage;
         var _loc17_:int = _loc10_.minCriticalErosionDamage + _loc11_.minCriticalErosionDamage + _loc12_.minCriticalErosionDamage + _loc13_.minCriticalErosionDamage + _loc14_.minCriticalErosionDamage;
         var _loc18_:int = _loc10_.maxCriticalErosionDamage + _loc11_.maxCriticalErosionDamage + _loc12_.maxCriticalErosionDamage + _loc13_.maxCriticalErosionDamage + _loc14_.maxCriticalErosionDamage;
         var _loc19_:int = (Math.floor(param1.healDamage.minLifePointsAdded * (100 + param1.casterIntelligence) / 100) + (param1.healDamage.minLifePointsAdded > 0?param1.casterHealBonus:0)) * _loc9_;
         var _loc20_:int = (Math.floor(param1.healDamage.maxLifePointsAdded * (100 + param1.casterIntelligence) / 100) + (param1.healDamage.maxLifePointsAdded > 0?param1.casterHealBonus:0)) * _loc9_;
         var _loc21_:int = (Math.floor(param1.healDamage.minCriticalLifePointsAdded * (100 + param1.casterIntelligence) / 100) + (param1.healDamage.minCriticalLifePointsAdded > 0?param1.casterHealBonus:0)) * _loc9_;
         var _loc22_:int = (Math.floor(param1.healDamage.maxCriticalLifePointsAdded * (100 + param1.casterIntelligence) / 100) + (param1.healDamage.maxCriticalLifePointsAdded > 0?param1.casterHealBonus:0)) * _loc9_;
         _loc19_ = _loc19_ + param1.healDamage.lifePointsAddedBasedOnLifePercent;
         _loc20_ = _loc20_ + param1.healDamage.lifePointsAddedBasedOnLifePercent;
         _loc21_ = _loc21_ + param1.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         _loc22_ = _loc22_ + param1.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         var _loc23_:EffectDamage = new EffectDamage(-1,-1,-1);
         _loc23_.minLifePointsAdded = _loc19_;
         _loc23_.maxLifePointsAdded = _loc20_;
         _loc23_.minCriticalLifePointsAdded = _loc21_;
         _loc23_.maxCriticalLifePointsAdded = _loc22_;
         _loc2_.addEffectDamage(_loc23_);
         var _loc24_:EffectDamage = new EffectDamage(-1,-1,-1);
         _loc24_.minDamage = _loc15_;
         _loc24_.maxDamage = _loc16_;
         _loc24_.minCriticalDamage = _loc17_;
         _loc24_.maxCriticalDamage = _loc18_;
         for each (_loc25_ in param1.targetBuffs)
         {
            if((!_loc25_.hasOwnProperty("delay") || _loc25_["delay"] == 0) && (verifyBuffEffectTrigger(param1,_loc25_)))
            {
               switch(_loc25_.actionId)
               {
                  case 1163:
                     _loc26_ = _loc25_.param1 / 100;
                     _loc24_.applyDamageMultiplier(_loc26_);
                     _loc10_.applyDamageMultiplier(_loc26_);
                     _loc11_.applyDamageMultiplier(_loc26_);
                     _loc12_.applyDamageMultiplier(_loc26_);
                     _loc13_.applyDamageMultiplier(_loc26_);
                     _loc14_.applyDamageMultiplier(_loc26_);
                     continue;
                  case 1164:
                     _loc24_.convertDamageToHeal();
                     _loc10_.convertDamageToHeal();
                     _loc11_.convertDamageToHeal();
                     _loc12_.convertDamageToHeal();
                     _loc13_.convertDamageToHeal();
                     _loc14_.convertDamageToHeal();
                     param1.spellHasCriticalHeal = param1.spellHasCriticalDamage;
                     continue;
                  case 265:
                     _loc27_ = getBuffEffectElement(_loc25_);
                     _loc28_ = -(param1.targetLevel / 20 + 1) * (_loc25_.effects as EffectInstanceInteger).value;
                     switch(_loc27_)
                     {
                        case 0:
                           _loc10_.applyDamageModification(_loc28_);
                           break;
                        case 1:
                           _loc11_.applyDamageModification(_loc28_);
                           break;
                        case 2:
                           _loc14_.applyDamageModification(_loc28_);
                           break;
                        case 3:
                           _loc12_.applyDamageModification(_loc28_);
                           break;
                        case 4:
                           _loc13_.applyDamageModification(_loc28_);
                           break;
                        case -1:
                           _loc10_.applyDamageModification(_loc28_);
                           _loc11_.applyDamageModification(_loc28_);
                           _loc14_.applyDamageModification(_loc28_);
                           _loc12_.applyDamageModification(_loc28_);
                           _loc13_.applyDamageModification(_loc28_);
                           break;
                     }
                     continue;
                  default:
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         _loc2_.addEffectDamage(_loc24_);
         _loc2_.addEffectDamage(_loc10_);
         _loc2_.addEffectDamage(_loc11_);
         _loc2_.addEffectDamage(_loc12_);
         _loc2_.addEffectDamage(_loc13_);
         _loc2_.addEffectDamage(_loc14_);
         _loc2_.hasCriticalDamage = param1.spellHasCriticalDamage;
         _loc2_.updateDamage();
         if(param1.targetShieldsPoints > 0)
         {
            _loc29_ = _loc2_.minDamage - param1.targetShieldsPoints;
            if(_loc29_ < 0)
            {
               _loc2_.minShieldPointsRemoved = _loc2_.minDamage;
               _loc2_.minDamage = 0;
            }
            else
            {
               _loc2_.minDamage = _loc2_.minDamage - param1.targetShieldsPoints;
               _loc2_.minShieldPointsRemoved = param1.targetShieldsPoints;
            }
            _loc30_ = _loc2_.maxDamage - param1.targetShieldsPoints;
            if(_loc30_ < 0)
            {
               _loc2_.maxShieldPointsRemoved = _loc2_.maxDamage;
               _loc2_.maxDamage = 0;
            }
            else
            {
               _loc2_.maxDamage = _loc2_.maxDamage - param1.targetShieldsPoints;
               _loc2_.maxShieldPointsRemoved = param1.targetShieldsPoints;
            }
            _loc31_ = _loc2_.minCriticalDamage - param1.targetShieldsPoints;
            if(_loc31_ < 0)
            {
               _loc2_.minCriticalShieldPointsRemoved = _loc2_.minCriticalDamage;
               _loc2_.minCriticalDamage = 0;
            }
            else
            {
               _loc2_.minCriticalDamage = _loc2_.minCriticalDamage - param1.targetShieldsPoints;
               _loc2_.minCriticalShieldPointsRemoved = param1.targetShieldsPoints;
            }
            _loc32_ = _loc2_.maxCriticalDamage - param1.targetShieldsPoints;
            if(_loc32_ < 0)
            {
               _loc2_.maxCriticalShieldPointsRemoved = _loc2_.maxCriticalDamage;
               _loc2_.maxCriticalDamage = 0;
            }
            else
            {
               _loc2_.maxCriticalDamage = _loc2_.maxCriticalDamage - param1.targetShieldsPoints;
               _loc2_.maxCriticalShieldPointsRemoved = param1.targetShieldsPoints;
            }
            if(param1.spellHasCriticalDamage)
            {
               _loc2_.hasCriticalShieldPointsRemoved = true;
            }
         }
         _loc2_.hasCriticalLifePointsAdded = param1.spellHasCriticalHeal;
         _loc2_.invulnerableState = param1.targetIsInvulnerable;
         return _loc2_;
      }
      
      private static function computeDamage(param1:SpellDamage, param2:SpellDamageInfo, param3:Number) : EffectDamage {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc9_:* = NaN;
         var _loc11_:* = NaN;
         switch(param1.element)
         {
            case 0:
               _loc4_ = param2.casterStrength;
               _loc5_ = param2.targetNeutralElementResistPercent;
               _loc6_ = param2.targetNeutralElementReduction;
               _loc7_ = param2.casterNeutralDamageBonus;
               break;
            case 1:
               _loc4_ = param2.casterStrength;
               _loc5_ = param2.targetEarthElementResistPercent;
               _loc6_ = param2.targetEarthElementReduction;
               _loc7_ = param2.casterEarthDamageBonus;
               break;
            case 2:
               _loc4_ = param2.casterIntelligence;
               _loc5_ = param2.targetFireElementResistPercent;
               _loc6_ = param2.targetFireElementReduction;
               _loc7_ = param2.casterFireDamageBonus;
               break;
            case 3:
               _loc4_ = param2.casterChance;
               _loc5_ = param2.targetWaterElementResistPercent;
               _loc6_ = param2.targetWaterElementReduction;
               _loc7_ = param2.casterWaterDamageBonus;
               break;
            case 4:
               _loc4_ = param2.casterAgility;
               _loc5_ = param2.targetAirElementResistPercent;
               _loc6_ = param2.targetAirElementReduction;
               _loc7_ = param2.casterAirDamageBonus;
               break;
         }
         var _loc8_:Number = Math.floor(param1.minDamage * (100 + _loc4_) / 100);
         if(param2.spellWeaponCriticalBonus != 0)
         {
            _loc9_ = param1.minDamage > 0?Math.floor((param1.minDamage + param2.spellWeaponCriticalBonus) * (100 + _loc4_) / 100):0;
         }
         else
         {
            _loc9_ = Math.floor(param1.minCriticalDamage * (100 + _loc4_) / 100);
         }
         var _loc10_:Number = Math.floor(param1.maxDamage * (100 + _loc4_) / 100);
         if(param2.spellWeaponCriticalBonus != 0)
         {
            _loc11_ = param1.maxDamage > 0?Math.floor((param1.maxDamage + param2.spellWeaponCriticalBonus) * (100 + _loc4_) / 100):0;
         }
         else
         {
            _loc11_ = Math.floor(param1.maxCriticalDamage * (100 + _loc4_) / 100);
         }
         if(_loc8_ > 0)
         {
            _loc8_ = _loc8_ + (_loc7_ + param2.casterAllDamagesBonus);
         }
         if(_loc10_ > 0)
         {
            _loc10_ = _loc10_ + (_loc7_ + param2.casterAllDamagesBonus);
         }
         if(_loc9_ > 0)
         {
            _loc9_ = _loc9_ + (_loc7_ + param2.casterAllDamagesBonus);
         }
         if(_loc11_ > 0)
         {
            _loc11_ = _loc11_ + (_loc7_ + param2.casterAllDamagesBonus);
         }
         var _loc12_:Number = (100 - _loc5_) / 100;
         _loc8_ = _loc8_ * _loc12_ - _loc6_;
         _loc10_ = _loc10_ * _loc12_ - _loc6_;
         _loc9_ = _loc9_ * _loc12_ - _loc6_;
         _loc11_ = _loc11_ * _loc12_ - _loc6_;
         var _loc13_:EffectDamage = new EffectDamage(-1,param1.element,param1.random);
         _loc13_.minDamage = param2.isWeapon?Math.floor(_loc8_ * param3):_loc8_ * param3;
         _loc13_.maxDamage = param2.isWeapon?Math.floor(_loc10_ * param3):_loc10_ * param3;
         _loc13_.minCriticalDamage = param2.isWeapon?Math.floor(_loc9_ * param3):_loc9_ * param3;
         _loc13_.maxCriticalDamage = param2.isWeapon?Math.floor(_loc11_ * param3):_loc11_ * param3;
         _loc13_.minErosionDamage = param1.minErosionDamage * _loc12_ * param3;
         _loc13_.maxErosionDamage = param1.maxErosionDamage * _loc12_ * param3;
         _loc13_.minCriticalErosionDamage = param1.minCriticalErosionDamage * _loc12_ * param3;
         _loc13_.maxCriticalErosionDamage = param1.maxCriticalErosionDamage * _loc12_ * param3;
         _loc13_.hasCritical = param1.hasCriticalDamage;
         return _loc13_;
      }
      
      public static function getSimpleEfficiency(param1:int, param2:int, param3:int, param4:int, param5:int) : Number {
         if(param4 == 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param2 <= 0 || param2 >= UNLIMITED_ZONE_SIZE)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param1 > param2)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param4 <= 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(param3 != 0)
         {
            if(param1 <= param3)
            {
               return DAMAGE_NOT_BOOSTED;
            }
            return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(param1 - param3,param5) * param4);
         }
         return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(param1,param5) * param4);
      }
   }
}
