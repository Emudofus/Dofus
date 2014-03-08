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
      
      public static function isDamagedOrHealedBySpell(pCasterId:int, pTargetId:int, pSpell:Object) : Boolean {
         var affected:* = false;
         var effi:EffectInstance = null;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if((!pSpell) || (!fef))
         {
            return false;
         }
         var target:TiphonSprite = DofusEntities.getEntity(pTargetId) as AnimatedCharacter;
         var targetIsCaster:Boolean = pTargetId == pCasterId;
         var targetIsCarried:Boolean = (target) && (target.parentSprite) && (target.parentSprite.carriedEntity == target);
         if(!(pSpell is SpellWrapper))
         {
            if((!targetIsCaster) && (!targetIsCarried))
            {
               return true;
            }
            return false;
         }
         for each (effi in pSpell.effects)
         {
            if(((effi.category == 2) || (!(HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1))) && (verifySpellEffectMask(pCasterId,pTargetId,effi)))
            {
               affected = true;
               break;
            }
         }
         return affected;
      }
      
      public static function getBuffEffectElement(pBuff:BasicBuff) : int {
         var element:* = 0;
         var effi:EffectInstance = null;
         var spellLevel:SpellLevel = null;
         var effect:Effect = Effect.getEffectById(pBuff.effects.effectId);
         element = effect.elementId;
         if(element == -1)
         {
            spellLevel = pBuff.castingSpell.spellRank;
            if(!spellLevel)
            {
               spellLevel = SpellLevel.getLevelById(pBuff.castingSpell.spell.spellLevels[0]);
            }
            for each (effi in spellLevel.effects)
            {
               if(effi.effectId == pBuff.effects.effectId)
               {
                  if(effi.triggers.indexOf("DA") != -1)
                  {
                     element = 4;
                  }
                  else
                  {
                     if(effi.triggers.indexOf("DE") != -1)
                     {
                        element = 1;
                     }
                     else
                     {
                        if(effi.triggers.indexOf("DF") != -1)
                        {
                           element = 2;
                        }
                        else
                        {
                           if(effi.triggers.indexOf("DN") != -1)
                           {
                              element = 0;
                           }
                           else
                           {
                              if(effi.triggers.indexOf("DW") != -1)
                              {
                                 element = 3;
                              }
                           }
                        }
                     }
                  }
                  break;
               }
            }
         }
         return element;
      }
      
      public static function verifyBuffEffectTrigger(pSpellInfo:SpellDamageInfo, pBuff:BasicBuff) : Boolean {
         var verify:* = false;
         var triggers:Array = null;
         var trigger:String = null;
         var effi:EffectInstance = null;
         var targetInfos:GameFightFighterInformations = null;
         var isTargetAlly:* = false;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fightEntitiesFrame)
         {
            return false;
         }
         var buffSpellLevel:SpellLevel = pBuff.castingSpell.spellRank;
         if(!buffSpellLevel)
         {
            buffSpellLevel = SpellLevel.getLevelById(pBuff.castingSpell.spell.spellLevels[0]);
         }
         for each (effi in buffSpellLevel.effects)
         {
            if(effi.effectId == pBuff.effects.effectId)
            {
               triggers = effi.triggers.split(",");
               break;
            }
         }
         targetInfos = fightEntitiesFrame.getEntityInfos(pSpellInfo.targetId) as GameFightFighterInformations;
         isTargetAlly = targetInfos.teamId == (fightEntitiesFrame.getEntityInfos(pSpellInfo.casterId) as GameFightFighterInformations).teamId;
         for each (_loc13_ in triggers)
         {
            switch(trigger)
            {
               case "I":
                  verify = true;
                  break;
               case "D":
                  verify = (pSpellInfo.airDamage.minDamage > 0) || (pSpellInfo.earthDamage.minDamage > 0) || (pSpellInfo.fireDamage.minDamage > 0) || (pSpellInfo.neutralDamage.minDamage > 0) || (pSpellInfo.waterDamage.minDamage > 0);
                  break;
               case "DA":
                  verify = pSpellInfo.airDamage.minDamage > 0;
                  break;
               case "DBA":
                  verify = isTargetAlly;
                  break;
               case "DBE":
                  verify = !isTargetAlly;
                  break;
               case "DC":
                  verify = pSpellInfo.isWeapon;
                  break;
               case "DE":
                  verify = pSpellInfo.earthDamage.minDamage > 0;
                  break;
               case "DF":
                  verify = pSpellInfo.fireDamage.minDamage > 0;
                  break;
               case "DG":
                  break;
               case "DI":
                  break;
               case "DM":
                  break;
               case "DN":
                  verify = pSpellInfo.neutralDamage.minDamage > 0;
                  break;
               case "DP":
                  break;
               case "DR":
                  break;
               case "Dr":
                  break;
               case "DS":
                  verify = !pSpellInfo.isWeapon;
                  break;
               case "DTB":
                  break;
               case "DTE":
                  break;
               case "DW":
                  verify = pSpellInfo.waterDamage.minDamage > 0;
                  break;
               case "MD":
                  break;
               case "MDM":
                  break;
               case "MDP":
                  break;
            }
            if(verify)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function verifySpellEffectMask(pCasterId:int, pTargetId:int, pEffect:EffectInstance) : Boolean {
         var r:RegExp = null;
         var targetMaskPattern:String = null;
         var exclusiveMasks:Array = null;
         var exclusiveMask:String = null;
         var exclusiveMaskParam:String = null;
         var exclusiveMaskCasterOnly:* = false;
         var verify:* = false;
         var maskState:* = 0;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if((!pEffect) || (!fef) || (pEffect.delay > 0))
         {
            return false;
         }
         var target:TiphonSprite = DofusEntities.getEntity(pTargetId) as AnimatedCharacter;
         var targetIsCaster:Boolean = pTargetId == pCasterId;
         var targetIsCarried:Boolean = (target) && (target.parentSprite) && (target.parentSprite.carriedEntity == target);
         var targetInfos:GameFightFighterInformations = fef.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var casterStates:Array = FightersStateManager.getInstance().getStates(pCasterId);
         var targetStates:Array = FightersStateManager.getInstance().getStates(pTargetId);
         var isTargetAlly:Boolean = targetInfos.teamId == (fef.getEntityInfos(pCasterId) as GameFightFighterInformations).teamId;
         if(targetIsCaster)
         {
            targetMaskPattern = "caC";
         }
         else
         {
            if((targetInfos.stats.summoned) && (targetInfos.stats.maxMovementPoints == 0))
            {
               targetMaskPattern = isTargetAlly?"agsj":"ASJ";
            }
            else
            {
               if(targetInfos.stats.summoned)
               {
                  targetMaskPattern = isTargetAlly?"agij":"AIJ";
               }
               else
               {
                  if(targetInfos is GameFightCompanionInformations)
                  {
                     targetMaskPattern = isTargetAlly?"agdl":"ADL";
                  }
                  else
                  {
                     if(targetInfos is GameFightMonsterInformations)
                     {
                        targetMaskPattern = isTargetAlly?"agm":"AM";
                     }
                     else
                     {
                        targetMaskPattern = isTargetAlly?"gahl":"AHL";
                     }
                  }
               }
            }
         }
         r = new RegExp("[" + targetMaskPattern + "]","g");
         verify = pEffect.targetMask.match(r).length > 0;
         if(verify)
         {
            exclusiveMasks = pEffect.targetMask.match(exclusiveTargetMasks);
            if(exclusiveMasks.length > 0)
            {
               verify = false;
               for each (exclusiveMask in exclusiveMasks)
               {
                  exclusiveMaskCasterOnly = exclusiveMask.charAt(0) == "*";
                  exclusiveMask = exclusiveMaskCasterOnly?exclusiveMask.substr(1,exclusiveMask.length - 1):exclusiveMask;
                  exclusiveMaskParam = exclusiveMask.length > 1?exclusiveMask.substr(1,exclusiveMask.length - 1):null;
                  exclusiveMask = exclusiveMask.charAt(0);
                  switch(exclusiveMask)
                  {
                     case "b":
                        continue;
                     case "B":
                        continue;
                     case "e":
                        maskState = parseInt(exclusiveMaskParam);
                        if(exclusiveMaskCasterOnly)
                        {
                           verify = (!casterStates) || (casterStates.indexOf(maskState) == -1);
                        }
                        else
                        {
                           verify = (!targetStates) || (targetStates.indexOf(maskState) == -1);
                        }
                        continue;
                     case "E":
                        maskState = parseInt(exclusiveMaskParam);
                        if(exclusiveMaskCasterOnly)
                        {
                           verify = (casterStates) && (!(casterStates.indexOf(maskState) == -1));
                        }
                        else
                        {
                           verify = (targetStates) && (!(targetStates.indexOf(maskState) == -1));
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
                  }
               }
            }
         }
         return verify;
      }
      
      public static function getSpellElementDamage(pSpell:Object, pElementType:int, pCasterId:int=0, pTargetId:int=0) : SpellDamage {
         var targetInfos:GameFightFighterInformations = null;
         var ed:EffectDamage = null;
         var effi:EffectInstance = null;
         var effid:EffectInstanceDice = null;
         var sw:SpellWrapper = null;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fightEntitiesFrame)
         {
            return null;
         }
         var targetErosionLifePoints:int = targetInfos?targetInfos.stats.baseMaxLifePoints - targetInfos.stats.maxLifePoints:0;
         targetInfos = fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var sd:SpellDamage = new SpellDamage();
         for each (effi in pSpell.effects)
         {
            if((effi.category == DAMAGE_EFFECT_CATEGORY) && (HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1) && (Effect.getEffectById(effi.effectId).elementId == pElementType) && ((!effi.targetMask) || ((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))))
            {
               ed = getEffectDamageByEffectId(sd,effi.effectId);
               if(!ed)
               {
                  ed = new EffectDamage(effi.effectId,pElementType,effi.random);
                  sd.addEffectDamage(ed);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  effid = effi as EffectInstanceDice;
                  ed.minErosionDamage = ed.minErosionDamage + targetErosionLifePoints * effid.diceNum / 100;
                  ed.maxErosionDamage = ed.maxErosionDamage + targetErosionLifePoints * effid.diceNum / 100;
               }
               else
               {
                  if(!(effi is EffectInstanceDice))
                  {
                     if(effi is EffectInstanceInteger)
                     {
                        ed.minDamage = ed.minDamage + (effi as EffectInstanceInteger).value;
                        ed.maxDamage = ed.maxDamage + (effi as EffectInstanceInteger).value;
                     }
                     else
                     {
                        if(effi is EffectInstanceMinMax)
                        {
                           ed.minDamage = ed.minDamage + (effi as EffectInstanceMinMax).min;
                           ed.maxDamage = ed.maxDamage + (effi as EffectInstanceMinMax).max;
                        }
                     }
                  }
                  else
                  {
                     effid = effi as EffectInstanceDice;
                     ed.minDamage = ed.minDamage + effid.diceNum;
                     ed.maxDamage = ed.maxDamage + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
                  }
               }
            }
         }
         for each (effi in pSpell.criticalEffect)
         {
            if((effi.category == DAMAGE_EFFECT_CATEGORY) && (HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1) && (Effect.getEffectById(effi.effectId).elementId == pElementType) && ((!effi.targetMask) || ((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))))
            {
               ed = getEffectDamageByEffectId(sd,effi.effectId);
               if(!ed)
               {
                  ed = new EffectDamage(effi.effectId,pElementType,effi.random);
                  sd.addEffectDamage(ed);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  effid = effi as EffectInstanceDice;
                  ed.minCriticalErosionDamage = ed.minCriticalErosionDamage + targetErosionLifePoints * effid.diceNum / 100;
                  ed.maxCriticalErosionDamage = ed.maxCriticalErosionDamage + targetErosionLifePoints * effid.diceNum / 100;
               }
               else
               {
                  if(!(effi is EffectInstanceDice))
                  {
                     if(effi is EffectInstanceInteger)
                     {
                        ed.minCriticalDamage = ed.minCriticalDamage + (effi as EffectInstanceInteger).value;
                        ed.maxCriticalDamage = ed.maxCriticalDamage + (effi as EffectInstanceInteger).value;
                     }
                     else
                     {
                        if(effi is EffectInstanceMinMax)
                        {
                           ed.minCriticalDamage = ed.minCriticalDamage + (effi as EffectInstanceMinMax).min;
                           ed.maxCriticalDamage = ed.maxCriticalDamage + (effi as EffectInstanceMinMax).max;
                        }
                     }
                  }
                  else
                  {
                     effid = effi as EffectInstanceDice;
                     ed.minCriticalDamage = ed.minCriticalDamage + effid.diceNum;
                     ed.maxCriticalDamage = ed.maxCriticalDamage + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
                  }
               }
               sd.hasCriticalDamage = ed.hasCritical = true;
            }
         }
         if(pCasterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
         {
            sw = pSpell as SpellWrapper;
            for each (ed in sd.effectDamages)
            {
               applySpellModificationsOnEffect(ed,sw);
            }
         }
         return sd;
      }
      
      public static function applySpellModificationsOnEffect(pEffectDamage:EffectDamage, pSpellW:SpellWrapper) : void {
         if(!pSpellW)
         {
            return;
         }
         var baseDamageModif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(pSpellW.id,CharacterSpellModificationTypeEnum.BASE_DAMAGE);
         if(baseDamageModif)
         {
            pEffectDamage.minDamage = pEffectDamage.minDamage + baseDamageModif.value.contextModif;
            pEffectDamage.maxDamage = pEffectDamage.maxDamage + baseDamageModif.value.contextModif;
            if(pEffectDamage.hasCritical)
            {
               pEffectDamage.minCriticalDamage = pEffectDamage.minCriticalDamage + baseDamageModif.value.contextModif;
               pEffectDamage.maxCriticalDamage = pEffectDamage.maxCriticalDamage + baseDamageModif.value.contextModif;
            }
         }
      }
      
      public static function getEffectDamageByEffectId(pSpellDamage:SpellDamage, pEffectId:int) : EffectDamage {
         var foundEffect:EffectDamage = null;
         var ed:EffectDamage = null;
         for each (ed in pSpellDamage.effectDamages)
         {
            if(ed.effectId == pEffectId)
            {
               foundEffect = ed;
               break;
            }
         }
         return foundEffect;
      }
      
      public static function getSpellDamage(pSpellDamageInfo:SpellDamageInfo) : SpellDamage {
         var minDmg:* = 0;
         var buff:BasicBuff = null;
         var dmgMultiplier:* = NaN;
         var element:* = 0;
         var dmgReduction:* = 0;
         var minShieldDiff:* = 0;
         var maxShieldDiff:* = 0;
         var minCriticalShieldDiff:* = 0;
         var maxCriticalShieldDiff:* = 0;
         var finalDamage:SpellDamage = new SpellDamage();
         pSpellDamageInfo.casterStrength = pSpellDamageInfo.casterStrength + pSpellDamageInfo.casterDamagesBonus;
         pSpellDamageInfo.casterChance = pSpellDamageInfo.casterChance + pSpellDamageInfo.casterDamagesBonus;
         pSpellDamageInfo.casterAgility = pSpellDamageInfo.casterAgility + pSpellDamageInfo.casterDamagesBonus;
         pSpellDamageInfo.casterIntelligence = pSpellDamageInfo.casterIntelligence + pSpellDamageInfo.casterDamagesBonus;
         var distance:uint = MapPoint.fromCellId(pSpellDamageInfo.targetCell).distanceToCell(MapPoint.fromCellId(pSpellDamageInfo.spellCenterCell));
         var shapeSize:int = !(pSpellDamageInfo.spellShapeSize == 0)?pSpellDamageInfo.spellShapeSize:EFFECTSHAPE_DEFAULT_AREA_SIZE;
         var shapeMinSize:int = !(pSpellDamageInfo.spellShapeMinSize == 0)?pSpellDamageInfo.spellShapeMinSize:EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE;
         var shapeEfficiencyPercent:int = !(pSpellDamageInfo.spellShapeEfficiencyPercent == 0)?pSpellDamageInfo.spellShapeEfficiencyPercent:EFFECTSHAPE_DEFAULT_EFFICIENCY;
         var shapeMaxEfficiency:int = !(pSpellDamageInfo.spellShapeMaxEfficiency == 0)?pSpellDamageInfo.spellShapeMaxEfficiency:EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY;
         var efficiencyMultiplier:Number = getSimpleEfficiency(distance,shapeSize,shapeMinSize,shapeEfficiencyPercent,shapeMaxEfficiency);
         var finalNeutralDmg:EffectDamage = computeDamage(pSpellDamageInfo.neutralDamage,pSpellDamageInfo,efficiencyMultiplier);
         var finalEarthDmg:EffectDamage = computeDamage(pSpellDamageInfo.earthDamage,pSpellDamageInfo,efficiencyMultiplier);
         var finalWaterDmg:EffectDamage = computeDamage(pSpellDamageInfo.waterDamage,pSpellDamageInfo,efficiencyMultiplier);
         var finalAirDmg:EffectDamage = computeDamage(pSpellDamageInfo.airDamage,pSpellDamageInfo,efficiencyMultiplier);
         var finalFireDmg:EffectDamage = computeDamage(pSpellDamageInfo.fireDamage,pSpellDamageInfo,efficiencyMultiplier);
         var totalMinErosionDamage:int = finalNeutralDmg.minErosionDamage + finalEarthDmg.minErosionDamage + finalWaterDmg.minErosionDamage + finalAirDmg.minErosionDamage + finalFireDmg.minErosionDamage;
         var totalMaxErosionDamage:int = finalNeutralDmg.maxErosionDamage + finalEarthDmg.maxErosionDamage + finalWaterDmg.maxErosionDamage + finalAirDmg.maxErosionDamage + finalFireDmg.maxErosionDamage;
         var totalMinCriticaErosionDamage:int = finalNeutralDmg.minCriticalErosionDamage + finalEarthDmg.minCriticalErosionDamage + finalWaterDmg.minCriticalErosionDamage + finalAirDmg.minCriticalErosionDamage + finalFireDmg.minCriticalErosionDamage;
         var totalMaxCriticaErosionlDamage:int = finalNeutralDmg.maxCriticalErosionDamage + finalEarthDmg.maxCriticalErosionDamage + finalWaterDmg.maxCriticalErosionDamage + finalAirDmg.maxCriticalErosionDamage + finalFireDmg.maxCriticalErosionDamage;
         var totalMinLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.minLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMaxLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.maxLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMinCriticalLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.minCriticalLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMaxCriticalLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         totalMinLifePointsAdded = totalMinLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMaxLifePointsAdded = totalMaxLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMinCriticalLifePointsAdded = totalMinCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         totalMaxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         var heal:EffectDamage = new EffectDamage(-1,-1,-1);
         heal.minLifePointsAdded = totalMinLifePointsAdded;
         heal.maxLifePointsAdded = totalMaxLifePointsAdded;
         heal.minCriticalLifePointsAdded = totalMinCriticalLifePointsAdded;
         heal.maxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded;
         finalDamage.addEffectDamage(heal);
         var erosion:EffectDamage = new EffectDamage(-1,-1,-1);
         erosion.minDamage = totalMinErosionDamage;
         erosion.maxDamage = totalMaxErosionDamage;
         erosion.minCriticalDamage = totalMinCriticaErosionDamage;
         erosion.maxCriticalDamage = totalMaxCriticaErosionlDamage;
         for each (buff in pSpellDamageInfo.targetBuffs)
         {
            if(((!buff.hasOwnProperty("delay")) || (buff["delay"] == 0)) && (verifyBuffEffectTrigger(pSpellDamageInfo,buff)))
            {
               switch(buff.actionId)
               {
                  case 1163:
                     dmgMultiplier = buff.param1 / 100;
                     erosion.applyDamageMultiplier(dmgMultiplier);
                     finalNeutralDmg.applyDamageMultiplier(dmgMultiplier);
                     finalEarthDmg.applyDamageMultiplier(dmgMultiplier);
                     finalWaterDmg.applyDamageMultiplier(dmgMultiplier);
                     finalAirDmg.applyDamageMultiplier(dmgMultiplier);
                     finalFireDmg.applyDamageMultiplier(dmgMultiplier);
                     continue;
                  case 1164:
                     erosion.convertDamageToHeal();
                     finalNeutralDmg.convertDamageToHeal();
                     finalEarthDmg.convertDamageToHeal();
                     finalWaterDmg.convertDamageToHeal();
                     finalAirDmg.convertDamageToHeal();
                     finalFireDmg.convertDamageToHeal();
                     pSpellDamageInfo.spellHasCriticalHeal = pSpellDamageInfo.spellHasCriticalDamage;
                     continue;
                  case 265:
                     element = getBuffEffectElement(buff);
                     dmgReduction = -(pSpellDamageInfo.targetLevel / 20 + 1) * (buff.effects as EffectInstanceInteger).value;
                     switch(element)
                     {
                        case 0:
                           finalNeutralDmg.applyDamageModification(dmgReduction);
                           break;
                        case 1:
                           finalEarthDmg.applyDamageModification(dmgReduction);
                           break;
                        case 2:
                           finalFireDmg.applyDamageModification(dmgReduction);
                           break;
                        case 3:
                           finalWaterDmg.applyDamageModification(dmgReduction);
                           break;
                        case 4:
                           finalAirDmg.applyDamageModification(dmgReduction);
                           break;
                        case -1:
                           finalNeutralDmg.applyDamageModification(dmgReduction);
                           finalEarthDmg.applyDamageModification(dmgReduction);
                           finalFireDmg.applyDamageModification(dmgReduction);
                           finalWaterDmg.applyDamageModification(dmgReduction);
                           finalAirDmg.applyDamageModification(dmgReduction);
                           break;
                     }
                     continue;
               }
            }
            else
            {
               continue;
            }
         }
         finalDamage.addEffectDamage(erosion);
         finalDamage.addEffectDamage(finalNeutralDmg);
         finalDamage.addEffectDamage(finalEarthDmg);
         finalDamage.addEffectDamage(finalWaterDmg);
         finalDamage.addEffectDamage(finalAirDmg);
         finalDamage.addEffectDamage(finalFireDmg);
         finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
         finalDamage.updateDamage();
         if(pSpellDamageInfo.targetShieldsPoints > 0)
         {
            minShieldDiff = finalDamage.minDamage - pSpellDamageInfo.targetShieldsPoints;
            if(minShieldDiff < 0)
            {
               finalDamage.minShieldPointsRemoved = finalDamage.minDamage;
               finalDamage.minDamage = 0;
            }
            else
            {
               finalDamage.minDamage = finalDamage.minDamage - pSpellDamageInfo.targetShieldsPoints;
               finalDamage.minShieldPointsRemoved = pSpellDamageInfo.targetShieldsPoints;
            }
            maxShieldDiff = finalDamage.maxDamage - pSpellDamageInfo.targetShieldsPoints;
            if(maxShieldDiff < 0)
            {
               finalDamage.maxShieldPointsRemoved = finalDamage.maxDamage;
               finalDamage.maxDamage = 0;
            }
            else
            {
               finalDamage.maxDamage = finalDamage.maxDamage - pSpellDamageInfo.targetShieldsPoints;
               finalDamage.maxShieldPointsRemoved = pSpellDamageInfo.targetShieldsPoints;
            }
            minCriticalShieldDiff = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldsPoints;
            if(minCriticalShieldDiff < 0)
            {
               finalDamage.minCriticalShieldPointsRemoved = finalDamage.minCriticalDamage;
               finalDamage.minCriticalDamage = 0;
            }
            else
            {
               finalDamage.minCriticalDamage = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldsPoints;
               finalDamage.minCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldsPoints;
            }
            maxCriticalShieldDiff = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldsPoints;
            if(maxCriticalShieldDiff < 0)
            {
               finalDamage.maxCriticalShieldPointsRemoved = finalDamage.maxCriticalDamage;
               finalDamage.maxCriticalDamage = 0;
            }
            else
            {
               finalDamage.maxCriticalDamage = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldsPoints;
               finalDamage.maxCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldsPoints;
            }
            if(pSpellDamageInfo.spellHasCriticalDamage)
            {
               finalDamage.hasCriticalShieldPointsRemoved = true;
            }
         }
         finalDamage.hasCriticalLifePointsAdded = pSpellDamageInfo.spellHasCriticalHeal;
         finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
         return finalDamage;
      }
      
      private static function computeDamage(pRawDamage:SpellDamage, pSpellDamageInfo:SpellDamageInfo, pEfficiencyMultiplier:Number) : EffectDamage {
         var stat:* = 0;
         var resistPercent:* = 0;
         var elementReduction:* = 0;
         var elementBonus:* = 0;
         var minCriticalBaseDmg:* = NaN;
         var maxCriticalBaseDmg:* = NaN;
         switch(pRawDamage.element)
         {
            case 0:
               stat = pSpellDamageInfo.casterStrength;
               resistPercent = pSpellDamageInfo.targetNeutralElementResistPercent;
               elementReduction = pSpellDamageInfo.targetNeutralElementReduction;
               elementBonus = pSpellDamageInfo.casterNeutralDamageBonus;
               break;
            case 1:
               stat = pSpellDamageInfo.casterStrength;
               resistPercent = pSpellDamageInfo.targetEarthElementResistPercent;
               elementReduction = pSpellDamageInfo.targetEarthElementReduction;
               elementBonus = pSpellDamageInfo.casterEarthDamageBonus;
               break;
            case 2:
               stat = pSpellDamageInfo.casterIntelligence;
               resistPercent = pSpellDamageInfo.targetFireElementResistPercent;
               elementReduction = pSpellDamageInfo.targetFireElementReduction;
               elementBonus = pSpellDamageInfo.casterFireDamageBonus;
               break;
            case 3:
               stat = pSpellDamageInfo.casterChance;
               resistPercent = pSpellDamageInfo.targetWaterElementResistPercent;
               elementReduction = pSpellDamageInfo.targetWaterElementReduction;
               elementBonus = pSpellDamageInfo.casterWaterDamageBonus;
               break;
            case 4:
               stat = pSpellDamageInfo.casterAgility;
               resistPercent = pSpellDamageInfo.targetAirElementResistPercent;
               elementReduction = pSpellDamageInfo.targetAirElementReduction;
               elementBonus = pSpellDamageInfo.casterAirDamageBonus;
               break;
         }
         var minBaseDmg:Number = Math.floor(pRawDamage.minDamage * (100 + stat) / 100);
         if(pSpellDamageInfo.spellWeaponCriticalBonus != 0)
         {
            minCriticalBaseDmg = pRawDamage.minDamage > 0?Math.floor((pRawDamage.minDamage + pSpellDamageInfo.spellWeaponCriticalBonus) * (100 + stat) / 100):0;
         }
         else
         {
            minCriticalBaseDmg = Math.floor(pRawDamage.minCriticalDamage * (100 + stat) / 100);
         }
         var maxBaseDmg:Number = Math.floor(pRawDamage.maxDamage * (100 + stat) / 100);
         if(pSpellDamageInfo.spellWeaponCriticalBonus != 0)
         {
            maxCriticalBaseDmg = pRawDamage.maxDamage > 0?Math.floor((pRawDamage.maxDamage + pSpellDamageInfo.spellWeaponCriticalBonus) * (100 + stat) / 100):0;
         }
         else
         {
            maxCriticalBaseDmg = Math.floor(pRawDamage.maxCriticalDamage * (100 + stat) / 100);
         }
         if(minBaseDmg > 0)
         {
            minBaseDmg = minBaseDmg + (elementBonus + pSpellDamageInfo.casterAllDamagesBonus);
         }
         if(maxBaseDmg > 0)
         {
            maxBaseDmg = maxBaseDmg + (elementBonus + pSpellDamageInfo.casterAllDamagesBonus);
         }
         if(minCriticalBaseDmg > 0)
         {
            minCriticalBaseDmg = minCriticalBaseDmg + (elementBonus + pSpellDamageInfo.casterAllDamagesBonus);
         }
         if(maxCriticalBaseDmg > 0)
         {
            maxCriticalBaseDmg = maxCriticalBaseDmg + (elementBonus + pSpellDamageInfo.casterAllDamagesBonus);
         }
         var targetResistMultiplier:Number = (100 - resistPercent) / 100;
         minBaseDmg = minBaseDmg * targetResistMultiplier - elementReduction;
         maxBaseDmg = maxBaseDmg * targetResistMultiplier - elementReduction;
         minCriticalBaseDmg = minCriticalBaseDmg * targetResistMultiplier - elementReduction;
         maxCriticalBaseDmg = maxCriticalBaseDmg * targetResistMultiplier - elementReduction;
         var finalDamage:EffectDamage = new EffectDamage(-1,pRawDamage.element,pRawDamage.random);
         finalDamage.minDamage = pSpellDamageInfo.isWeapon?Math.floor(minBaseDmg * pEfficiencyMultiplier):minBaseDmg * pEfficiencyMultiplier;
         finalDamage.maxDamage = pSpellDamageInfo.isWeapon?Math.floor(maxBaseDmg * pEfficiencyMultiplier):maxBaseDmg * pEfficiencyMultiplier;
         finalDamage.minCriticalDamage = pSpellDamageInfo.isWeapon?Math.floor(minCriticalBaseDmg * pEfficiencyMultiplier):minCriticalBaseDmg * pEfficiencyMultiplier;
         finalDamage.maxCriticalDamage = pSpellDamageInfo.isWeapon?Math.floor(maxCriticalBaseDmg * pEfficiencyMultiplier):maxCriticalBaseDmg * pEfficiencyMultiplier;
         finalDamage.minErosionDamage = pRawDamage.minErosionDamage * targetResistMultiplier * pEfficiencyMultiplier;
         finalDamage.maxErosionDamage = pRawDamage.maxErosionDamage * targetResistMultiplier * pEfficiencyMultiplier;
         finalDamage.minCriticalErosionDamage = pRawDamage.minCriticalErosionDamage * targetResistMultiplier * pEfficiencyMultiplier;
         finalDamage.maxCriticalErosionDamage = pRawDamage.maxCriticalErosionDamage * targetResistMultiplier * pEfficiencyMultiplier;
         finalDamage.hasCritical = pRawDamage.hasCriticalDamage;
         return finalDamage;
      }
      
      public static function getSimpleEfficiency(pDistance:int, pShapeSize:int, pShapeMinSize:int, pShapeEfficiencyPercent:int, pShapeMaxEfficiency:int) : Number {
         if(pShapeEfficiencyPercent == 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if((pShapeSize <= 0) || (pShapeSize >= UNLIMITED_ZONE_SIZE))
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(pDistance > pShapeSize)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(pShapeEfficiencyPercent <= 0)
         {
            return DAMAGE_NOT_BOOSTED;
         }
         if(pShapeMinSize != 0)
         {
            if(pDistance <= pShapeMinSize)
            {
               return DAMAGE_NOT_BOOSTED;
            }
            return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(pDistance - pShapeMinSize,pShapeMaxEfficiency) * pShapeEfficiencyPercent);
         }
         return Math.max(0,DAMAGE_NOT_BOOSTED - 0.01 * Math.min(pDistance,pShapeMaxEfficiency) * pShapeEfficiencyPercent);
      }
   }
}
