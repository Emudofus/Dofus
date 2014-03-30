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
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.datacenter.spells.SpellBomb;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
   import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
   import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
   import com.ankamagames.dofus.logic.game.fight.types.SplashDamage;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.logic.game.fight.types.EffectModification;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.dofus.logic.game.fight.types.TriggeredSpell;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DamageUtil extends Object
   {
      
      public function DamageUtil() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DamageUtil));
      
      private static const exclusiveTargetMasks:RegExp = new RegExp("\\*?[bBeEfFzZKoOPpTWUvV][0-9]*","g");
      
      public static const NEUTRAL_ELEMENT:int = 0;
      
      public static const EARTH_ELEMENT:int = 1;
      
      public static const FIRE_ELEMENT:int = 2;
      
      public static const WATER_ELEMENT:int = 3;
      
      public static const AIR_ELEMENT:int = 4;
      
      public static const NONE_ELEMENT:int = 5;
      
      private static const EFFECTSHAPE_DEFAULT_AREA_SIZE:int = 1;
      
      private static const EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE:int = 0;
      
      private static const EFFECTSHAPE_DEFAULT_EFFICIENCY:int = 10;
      
      private static const EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY:int = 4;
      
      private static const DAMAGE_NOT_BOOSTED:int = 1;
      
      private static const UNLIMITED_ZONE_SIZE:int = 50;
      
      public static const DAMAGE_EFFECT_CATEGORY:int = 2;
      
      public static const EROSION_DAMAGE_EFFECTS_IDS:Array = [1092,1093,1094,1095,1096];
      
      public static const HEALING_EFFECTS_IDS:Array = [81,108,1109];
      
      public static const IMMEDIATE_BOOST_EFFECTS_IDS:Array = [266,268,269,271,414];
      
      public static const BOMB_SPELLS_IDS:Array = [2796,2797,2808];
      
      public static const SPLASH_EFFECTS_IDS:Array = [1123,1124,1125,1126,1127,1128];
      
      public static const MP_BASED_DAMAGE_EFFECTS_IDS:Array = [1012,1013,1014,1015,1016];
      
      public static const HP_BASED_DAMAGE_EFFECTS_IDS:Array = [672];
      
      public static const TRIGGERED_EFFECTS_IDS:Array = [138,1040];
      
      public static const NO_BOOST_EFFECTS_IDS:Array = [144];
      
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
         if((!(pSpell is SpellWrapper)) || (pSpell.id == 0))
         {
            if((!targetIsCaster) && (!targetIsCarried))
            {
               return true;
            }
            return false;
         }
         var targetCanBePushed:Boolean = PushUtil.isPushableEntity(fef.getEntityInfos(pTargetId) as GameFightFighterInformations);
         if(BOMB_SPELLS_IDS.indexOf(pSpell.id) != -1)
         {
            pSpell = getBombDirectDamageSpellWrapper(pSpell as SpellWrapper);
         }
         for each (effi in pSpell.effects)
         {
            if(((effi.category == 2) || (!(HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)) || (effi.effectId == 5) && (targetCanBePushed)) && (verifySpellEffectMask(pCasterId,pTargetId,effi)))
            {
               affected = true;
               break;
            }
         }
         return affected;
      }
      
      public static function getBombDirectDamageSpellWrapper(pBombSummoningSpell:SpellWrapper) : SpellWrapper {
         return SpellWrapper.create(0,SpellBomb.getSpellBombById((pBombSummoningSpell.effects[0] as EffectInstanceDice).diceNum).instantSpellId,pBombSummoningSpell.spellLevel,true,pBombSummoningSpell.playerId);
      }
      
      public static function getBuffEffectElements(pBuff:BasicBuff) : Vector.<int> {
         var elements:Vector.<int> = null;
         var effi:EffectInstance = null;
         var spellLevel:SpellLevel = null;
         var effect:Effect = Effect.getEffectById(pBuff.effects.effectId);
         if(effect.elementId == -1)
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
                  if(!elements)
                  {
                     elements = new Vector.<int>(0);
                  }
                  if((!(effi.triggers.indexOf("DA") == -1)) && (elements.indexOf(AIR_ELEMENT) == -1))
                  {
                     elements.push(AIR_ELEMENT);
                  }
                  if((!(effi.triggers.indexOf("DE") == -1)) && (elements.indexOf(EARTH_ELEMENT) == -1))
                  {
                     elements.push(EARTH_ELEMENT);
                  }
                  if((!(effi.triggers.indexOf("DF") == -1)) && (elements.indexOf(FIRE_ELEMENT) == -1))
                  {
                     elements.push(FIRE_ELEMENT);
                  }
                  if((!(effi.triggers.indexOf("DN") == -1)) && (elements.indexOf(NEUTRAL_ELEMENT) == -1))
                  {
                     elements.push(NEUTRAL_ELEMENT);
                  }
                  if((!(effi.triggers.indexOf("DW") == -1)) && (elements.indexOf(WATER_ELEMENT) == -1))
                  {
                     elements.push(WATER_ELEMENT);
                  }
                  break;
               }
            }
         }
         return elements;
      }
      
      public static function getBuffTriggers(pBuff:BasicBuff) : String {
         var effi:EffectInstance = null;
         var buffSpellLevel:SpellLevel = pBuff.castingSpell.spellRank;
         if(!buffSpellLevel)
         {
            buffSpellLevel = SpellLevel.getLevelById(pBuff.castingSpell.spell.spellLevels[0]);
         }
         var effects:Vector.<EffectInstanceDice> = buffSpellLevel.effects;
         for each (effi in effects)
         {
            if(effi.effectId == 1091)
            {
               effects = SpellWrapper.create(0,int(effi.parameter0),int(effi.parameter1),false).spellLevelInfos.effects;
               break;
            }
         }
         for each (effi in effects)
         {
            if((effi.order == pBuff.effects.order) && (effi.effectId == pBuff.effects.effectId))
            {
               return effi.triggers;
            }
         }
         return null;
      }
      
      public static function verifyBuffTriggers(pSpellInfo:SpellDamageInfo, pBuff:BasicBuff) : Boolean {
         var triggersList:Array = null;
         var trigger:String = null;
         var eff:EffectInstance = null;
         var triggers:String = getBuffTriggers(pBuff);
         if(triggers)
         {
            triggersList = triggers.split("|");
            for each (trigger in triggersList)
            {
               for each (eff in pSpellInfo.spellEffects)
               {
                  if(verifyEffectTrigger(pSpellInfo.casterId,pSpellInfo.targetId,eff,pSpellInfo.isWeapon,trigger))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function verifyEffectTrigger(pCasterId:int, pTargetId:int, pEffect:EffectInstance, pWeaponEffect:Boolean, pTriggers:String) : Boolean {
         var trigger:String = null;
         var verify:* = false;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fightEntitiesFrame)
         {
            return false;
         }
         var triggersList:Array = pTriggers.split("|");
         var casterInfos:GameFightFighterInformations = fightEntitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations;
         var targetInfos:GameFightFighterInformations = fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var isTargetAlly:Boolean = targetInfos.teamId == (fightEntitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations).teamId;
         var distance:uint = MapPoint.fromCellId(casterInfos.disposition.cellId).distanceTo(MapPoint.fromCellId(targetInfos.disposition.cellId));
         for each (_loc16_ in triggersList)
         {
            switch(trigger)
            {
               case "I":
                  verify = true;
                  break;
               case "D":
                  verify = pEffect.category == DAMAGE_EFFECT_CATEGORY;
                  break;
               case "DA":
                  verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY) && (Effect.getEffectById(pEffect.effectId).elementId == AIR_ELEMENT);
                  break;
               case "DBA":
                  verify = isTargetAlly;
                  break;
               case "DBE":
                  verify = !isTargetAlly;
                  break;
               case "DC":
                  verify = pWeaponEffect;
                  break;
               case "DE":
                  verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY) && (Effect.getEffectById(pEffect.effectId).elementId == EARTH_ELEMENT);
                  break;
               case "DF":
                  verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY) && (Effect.getEffectById(pEffect.effectId).elementId == FIRE_ELEMENT);
                  break;
               case "DG":
                  break;
               case "DI":
                  break;
               case "DM":
                  verify = distance <= 1;
                  break;
               case "DN":
                  verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY) && (Effect.getEffectById(pEffect.effectId).elementId == NEUTRAL_ELEMENT);
                  break;
               case "DP":
                  break;
               case "DR":
                  verify = distance > 1;
                  break;
               case "Dr":
                  break;
               case "DS":
                  verify = !pWeaponEffect;
                  break;
               case "DTB":
                  break;
               case "DTE":
                  break;
               case "DW":
                  verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY) && (Effect.getEffectById(pEffect.effectId).elementId == WATER_ELEMENT);
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
      
      public static function verifySpellEffectMask(pCasterId:int, pTargetId:int, pEffect:EffectInstance, pTriggeringSpellCasterId:int=0) : Boolean {
         var r:RegExp = null;
         var targetMaskPattern:String = null;
         var exclusiveMasks:Array = null;
         var exclusiveMask:String = null;
         var exclusiveMaskParam:String = null;
         var exclusiveMaskCasterOnly:* = false;
         var verify:* = false;
         var maskState:* = 0;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if((!pEffect) || (!fef) || (pEffect.delay > 0) || (!pEffect.targetMask))
         {
            return false;
         }
         var target:TiphonSprite = DofusEntities.getEntity(pTargetId) as AnimatedCharacter;
         var targetIsCaster:Boolean = pTargetId == pCasterId;
         var targetIsCarried:Boolean = (target) && (target.parentSprite) && (target.parentSprite.carriedEntity == target);
         var targetInfos:GameFightFighterInformations = fef.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var monsterInfo:GameFightMonsterInformations = targetInfos as GameFightMonsterInformations;
         var casterStates:Array = FightersStateManager.getInstance().getStates(pCasterId);
         var targetStates:Array = FightersStateManager.getInstance().getStates(pTargetId);
         var isTargetAlly:Boolean = targetInfos.teamId == (fef.getEntityInfos(pCasterId) as GameFightFighterInformations).teamId;
         if((pCasterId == CurrentPlayedFighterManager.getInstance().currentFighterId) && (pEffect.category == 0) && (pEffect.targetMask == "C"))
         {
            return true;
         }
         if(targetIsCaster)
         {
            if(pEffect.targetMask.indexOf("g") == -1)
            {
               targetMaskPattern = "caC";
            }
            else
            {
               return false;
            }
         }
         else
         {
            if((targetInfos.stats.summoned) && (monsterInfo) && (!Monster.getMonsterById(monsterInfo.creatureGenericId).canPlay))
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
                        verify = (!monsterInfo) || (!(monsterInfo.creatureGenericId == parseInt(exclusiveMaskParam)));
                        continue;
                     case "F":
                        verify = (monsterInfo) && (monsterInfo.creatureGenericId == parseInt(exclusiveMaskParam));
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
                        verify = (!(pTriggeringSpellCasterId == 0)) && (pTargetId == pTriggeringSpellCasterId);
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
                        verify = targetInfos.stats.lifePoints / targetInfos.stats.maxLifePoints * 100 > parseInt(exclusiveMaskParam);
                        continue;
                     case "V":
                        verify = targetInfos.stats.lifePoints / targetInfos.stats.maxLifePoints * 100 <= parseInt(exclusiveMaskParam);
                        continue;
                  }
               }
            }
         }
         return verify;
      }
      
      public static function verifySpellEffectZone(pTargetId:int, pEffect:EffectInstance, pSpellImpactCell:int) : Boolean {
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fef)
         {
            return false;
         }
         var targetInfos:GameFightFighterInformations = fef.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var effectZone:IZone = SpellZoneManager.getInstance().getZone(pEffect.zoneShape,uint(pEffect.zoneSize),uint(pEffect.zoneMinSize));
         var effectZoneCells:Vector.<uint> = effectZone.getCells(pSpellImpactCell);
         return effectZoneCells?!(effectZoneCells.indexOf(targetInfos.disposition.cellId) == -1):false;
      }
      
      public static function getSpellElementDamage(pSpell:Object, pElementType:int, pCasterId:int=0, pTargetId:int=0) : SpellDamage {
         var ed:EffectDamage = null;
         var effi:EffectInstance = null;
         var effid:EffectInstanceDice = null;
         var i:* = 0;
         var sw:SpellWrapper = null;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fightEntitiesFrame)
         {
            return null;
         }
         var targetInfos:GameFightFighterInformations = fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations;
         var sd:SpellDamage = new SpellDamage();
         var numEffects:int = pSpell.effects.length;
         var isWeapon:Boolean = (!(pSpell is SpellWrapper)) || (pSpell.id == 0);
         i = 0;
         while(i < numEffects)
         {
            effi = pSpell.effects[i];
            if((effi.category == DAMAGE_EFFECT_CATEGORY) && (HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1) && (Effect.getEffectById(effi.effectId).elementId == pElementType) && ((!effi.targetMask || isWeapon) || ((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))))
            {
               ed = new EffectDamage(effi.effectId,pElementType,effi.random);
               sd.addEffectDamage(ed);
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  effid = effi as EffectInstanceDice;
                  ed.minErosionPercent = ed.maxErosionPercent = effid.diceNum;
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
            i++;
         }
         var numEffectDamages:int = sd.effectDamages.length;
         var numCriticalEffects:int = pSpell.criticalEffect?pSpell.criticalEffect.length:0;
         i = 0;
         while(i < numCriticalEffects)
         {
            effi = pSpell.criticalEffect[i];
            if((effi.category == DAMAGE_EFFECT_CATEGORY) && (HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1) && (Effect.getEffectById(effi.effectId).elementId == pElementType) && ((!effi.targetMask || isWeapon) || ((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))))
            {
               if(i < numEffectDamages)
               {
                  ed = sd.effectDamages[i];
               }
               else
               {
                  ed = new EffectDamage(effi.effectId,pElementType,effi.random);
                  sd.addEffectDamage(ed);
               }
               if(EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  effid = effi as EffectInstanceDice;
                  ed.minCriticalErosionPercent = ed.maxCriticalErosionPercent = effid.diceNum;
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
            i++;
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
            pEffectDamage.minDamage = pEffectDamage.minDamage + (pEffectDamage.minDamage > 0?baseDamageModif.value.contextModif:0);
            pEffectDamage.maxDamage = pEffectDamage.maxDamage + (pEffectDamage.maxDamage > 0?baseDamageModif.value.contextModif:0);
            if(pEffectDamage.hasCritical)
            {
               pEffectDamage.minCriticalDamage = pEffectDamage.minCriticalDamage + (pEffectDamage.minCriticalDamage > 0?baseDamageModif.value.contextModif:0);
               pEffectDamage.maxCriticalDamage = pEffectDamage.maxCriticalDamage + (pEffectDamage.maxCriticalDamage > 0?baseDamageModif.value.contextModif:0);
            }
         }
      }
      
      public static function getSpellDamage(pSpellDamageInfo:SpellDamageInfo, pWithTargetBuffs:Boolean=true, pWithTargetResists:Boolean=true) : SpellDamage {
         var finalNeutralDmg:EffectDamage = null;
         var finalEarthDmg:EffectDamage = null;
         var finalWaterDmg:EffectDamage = null;
         var finalAirDmg:EffectDamage = null;
         var finalFireDmg:EffectDamage = null;
         var erosion:EffectDamage = null;
         var dmgMultiplier:Number = NaN;
         var sharedDamageEffect:EffectDamage = null;
         var pushDamages:EffectDamage = null;
         var pushedEntity:PushedEntity = null;
         var pushIndex:uint = 0;
         var hasPushedDamage:Boolean = false;
         var splashEffectDmg:EffectDamage = null;
         var splashDmg:SplashDamage = null;
         var splashCasterCell:uint = 0;
         var buff:BasicBuff = null;
         var minShieldDiff:int = 0;
         var maxShieldDiff:int = 0;
         var minCriticalShieldDiff:int = 0;
         var maxCriticalShieldDiff:int = 0;
         var finalDamage:SpellDamage = new SpellDamage();
         if(pSpellDamageInfo.sharedDamage)
         {
            sharedDamageEffect = computeDamage(pSpellDamageInfo.sharedDamage,pSpellDamageInfo,1,true);
            finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
            finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
            finalDamage.addEffectDamage(sharedDamageEffect);
            finalDamage.updateDamage();
            return finalDamage;
         }
         var shapeSize:int = !(pSpellDamageInfo.spellShapeSize == null)?int(pSpellDamageInfo.spellShapeSize):EFFECTSHAPE_DEFAULT_AREA_SIZE;
         var shapeMinSize:int = !(pSpellDamageInfo.spellShapeMinSize == null)?int(pSpellDamageInfo.spellShapeMinSize):EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE;
         var shapeEfficiencyPercent:int = !(pSpellDamageInfo.spellShapeEfficiencyPercent == null)?int(pSpellDamageInfo.spellShapeEfficiencyPercent):EFFECTSHAPE_DEFAULT_EFFICIENCY;
         var shapeMaxEfficiency:int = !(pSpellDamageInfo.spellShapeMaxEfficiency == null)?int(pSpellDamageInfo.spellShapeMaxEfficiency):EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY;
         var efficiencyMultiplier:Number = getShapeEfficiency(pSpellDamageInfo.spellShape,pSpellDamageInfo.spellCenterCell,pSpellDamageInfo.targetCell,shapeSize,shapeMinSize,shapeEfficiencyPercent,shapeMaxEfficiency);
         finalNeutralDmg = computeDamage(pSpellDamageInfo.neutralDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalEarthDmg = computeDamage(pSpellDamageInfo.earthDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalWaterDmg = computeDamage(pSpellDamageInfo.waterDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalAirDmg = computeDamage(pSpellDamageInfo.airDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         finalFireDmg = computeDamage(pSpellDamageInfo.fireDamage,pSpellDamageInfo,efficiencyMultiplier,false,!pWithTargetResists,!pWithTargetResists);
         var totalMinErosionDamage:int = finalNeutralDmg.minErosionDamage + finalEarthDmg.minErosionDamage + finalWaterDmg.minErosionDamage + finalAirDmg.minErosionDamage + finalFireDmg.minErosionDamage;
         var totalMaxErosionDamage:int = finalNeutralDmg.maxErosionDamage + finalEarthDmg.maxErosionDamage + finalWaterDmg.maxErosionDamage + finalAirDmg.maxErosionDamage + finalFireDmg.maxErosionDamage;
         var totalMinCriticaErosionDamage:int = finalNeutralDmg.minCriticalErosionDamage + finalEarthDmg.minCriticalErosionDamage + finalWaterDmg.minCriticalErosionDamage + finalAirDmg.minCriticalErosionDamage + finalFireDmg.minCriticalErosionDamage;
         var totalMaxCriticaErosionlDamage:int = finalNeutralDmg.maxCriticalErosionDamage + finalEarthDmg.maxCriticalErosionDamage + finalWaterDmg.maxCriticalErosionDamage + finalAirDmg.maxCriticalErosionDamage + finalFireDmg.maxCriticalErosionDamage;
         finalDamage.hasHeal = (!(pSpellDamageInfo.healDamage.minLifePointsAdded == 0)) && (!(pSpellDamageInfo.healDamage.maxLifePointsAdded == 0));
         var totalMinLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.minLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMaxLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.maxLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMinCriticalLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.minCriticalLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.minCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         var totalMaxCriticalLifePointsAdded:int = (Math.floor(pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded * (100 + pSpellDamageInfo.casterIntelligence) / 100) + (pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded > 0?pSpellDamageInfo.casterHealBonus:0)) * efficiencyMultiplier;
         totalMinLifePointsAdded = totalMinLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMaxLifePointsAdded = totalMaxLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent;
         totalMinCriticalLifePointsAdded = totalMinCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         totalMaxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent;
         var targetLostLifePoints:int = pSpellDamageInfo.targetInfos.stats.maxLifePoints - pSpellDamageInfo.targetInfos.stats.lifePoints;
         totalMinLifePointsAdded = totalMinLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMinLifePointsAdded;
         totalMaxLifePointsAdded = totalMaxLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMaxLifePointsAdded;
         totalMinCriticalLifePointsAdded = totalMinCriticalLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMinCriticalLifePointsAdded;
         totalMaxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded > targetLostLifePoints?targetLostLifePoints:totalMaxCriticalLifePointsAdded;
         var heal:EffectDamage = new EffectDamage(-1,-1,-1);
         heal.minLifePointsAdded = totalMinLifePointsAdded;
         heal.maxLifePointsAdded = totalMaxLifePointsAdded;
         heal.minCriticalLifePointsAdded = totalMinCriticalLifePointsAdded;
         heal.maxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded;
         erosion = new EffectDamage(-1,-1,-1);
         erosion.minDamage = totalMinErosionDamage;
         erosion.maxDamage = totalMaxErosionDamage;
         erosion.minCriticalDamage = totalMinCriticaErosionDamage;
         erosion.maxCriticalDamage = totalMaxCriticaErosionlDamage;
         if((pSpellDamageInfo.pushedEntities) && (pSpellDamageInfo.pushedEntities.length > 0))
         {
            pushDamages = new EffectDamage(5,-1,-1);
            for each (pushedEntity in pSpellDamageInfo.pushedEntities)
            {
               if(pushedEntity.id == pSpellDamageInfo.targetId)
               {
                  pushedEntity.damage = 0;
                  for each (pushIndex in pushedEntity.pushedIndexes)
                  {
                     pushedEntity.damage = pushedEntity.damage + (pSpellDamageInfo.casterLevel / 2 + (pSpellDamageInfo.casterPushDamageBonus - pSpellDamageInfo.targetPushDamageFixedResist) + 32) * pushedEntity.force / (4 * Math.pow(2,pushIndex));
                  }
                  hasPushedDamage = true;
                  break;
               }
            }
            if(hasPushedDamage)
            {
               pushDamages.minDamage = pushDamages.maxDamage = pushedEntity.damage;
               if(pSpellDamageInfo.spellHasCriticalDamage)
               {
                  pushDamages.minCriticalDamage = pushDamages.maxCriticalDamage = pushedEntity.damage;
               }
            }
            finalDamage.addEffectDamage(pushDamages);
         }
         if(pSpellDamageInfo.splashDamages)
         {
            for each (splashDmg in pSpellDamageInfo.splashDamages)
            {
               if(splashDmg.targets.indexOf(pSpellDamageInfo.targetId) != -1)
               {
                  splashCasterCell = EntitiesManager.getInstance().getEntity(splashDmg.casterId).position.cellId;
                  efficiencyMultiplier = getShapeEfficiency(splashDmg.spellShape,splashCasterCell,pSpellDamageInfo.targetCell,!(splashDmg.spellShapeSize == null)?int(splashDmg.spellShapeSize):EFFECTSHAPE_DEFAULT_AREA_SIZE,!(splashDmg.spellShapeMinSize == null)?int(splashDmg.spellShapeMinSize):EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE,!(splashDmg.spellShapeEfficiencyPercent == null)?int(splashDmg.spellShapeEfficiencyPercent):EFFECTSHAPE_DEFAULT_EFFICIENCY,!(splashDmg.spellShapeMaxEfficiency == null)?int(splashDmg.spellShapeMaxEfficiency):EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY);
                  splashEffectDmg = computeDamage(splashDmg.damage,pSpellDamageInfo,efficiencyMultiplier,true,!splashDmg.hasCritical);
                  finalDamage.addEffectDamage(splashEffectDmg);
               }
            }
         }
         var applyDamageMultiplier:Function = function(pMultiplier:Number):void
         {
            erosion.applyDamageMultiplier(pMultiplier);
            finalNeutralDmg.applyDamageMultiplier(pMultiplier);
            finalEarthDmg.applyDamageMultiplier(pMultiplier);
            finalWaterDmg.applyDamageMultiplier(pMultiplier);
            finalAirDmg.applyDamageMultiplier(pMultiplier);
            finalFireDmg.applyDamageMultiplier(pMultiplier);
         };
         if(pWithTargetBuffs)
         {
            for each (buff in pSpellDamageInfo.targetBuffs)
            {
               if(((!buff.hasOwnProperty("delay")) || (buff["delay"] == 0)) && (verifyBuffTriggers(pSpellDamageInfo,buff)))
               {
                  switch(buff.actionId)
                  {
                     case 1163:
                        applyDamageMultiplier(buff.param1 / 100);
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
                  }
               }
               else
               {
                  continue;
               }
            }
         }
         if(pSpellDamageInfo.casterDamageBoostPercent > 0)
         {
            applyDamageMultiplier((100 + pSpellDamageInfo.casterDamageBoostPercent) / 100);
         }
         if(pSpellDamageInfo.casterDamageDeboostPercent > 0)
         {
            dmgMultiplier = 100 - pSpellDamageInfo.casterDamageDeboostPercent;
            applyDamageMultiplier(dmgMultiplier < 0?0:dmgMultiplier / 100);
         }
         if(pSpellDamageInfo.originalTargetsIds.indexOf(pSpellDamageInfo.targetId) != -1)
         {
            finalDamage.addEffectDamage(heal);
            finalDamage.addEffectDamage(erosion);
            finalDamage.addEffectDamage(finalNeutralDmg);
            finalDamage.addEffectDamage(finalEarthDmg);
            finalDamage.addEffectDamage(finalWaterDmg);
            finalDamage.addEffectDamage(finalAirDmg);
            finalDamage.addEffectDamage(finalFireDmg);
         }
         finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
         finalDamage.updateDamage();
         pSpellDamageInfo.targetShieldPoints = pSpellDamageInfo.targetShieldPoints + pSpellDamageInfo.targetTriggeredShieldPoints;
         if(pSpellDamageInfo.targetShieldPoints > 0)
         {
            minShieldDiff = finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints;
            if(minShieldDiff < 0)
            {
               finalDamage.minShieldPointsRemoved = finalDamage.minDamage;
               finalDamage.minDamage = 0;
            }
            else
            {
               finalDamage.minDamage = finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.minShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            maxShieldDiff = finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints;
            if(maxShieldDiff < 0)
            {
               finalDamage.maxShieldPointsRemoved = finalDamage.maxDamage;
               finalDamage.maxDamage = 0;
            }
            else
            {
               finalDamage.maxDamage = finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.maxShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            minCriticalShieldDiff = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints;
            if(minCriticalShieldDiff < 0)
            {
               finalDamage.minCriticalShieldPointsRemoved = finalDamage.minCriticalDamage;
               finalDamage.minCriticalDamage = 0;
            }
            else
            {
               finalDamage.minCriticalDamage = finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.minCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            maxCriticalShieldDiff = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints;
            if(maxCriticalShieldDiff < 0)
            {
               finalDamage.maxCriticalShieldPointsRemoved = finalDamage.maxCriticalDamage;
               finalDamage.maxCriticalDamage = 0;
            }
            else
            {
               finalDamage.maxCriticalDamage = finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints;
               finalDamage.maxCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
            }
            if(pSpellDamageInfo.spellHasCriticalDamage)
            {
               finalDamage.hasCriticalShieldPointsRemoved = true;
            }
         }
         finalDamage.hasCriticalLifePointsAdded = pSpellDamageInfo.spellHasCriticalHeal;
         finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
         finalDamage.unhealableState = pSpellDamageInfo.targetIsUnhealable;
         finalDamage.isHealingSpell = pSpellDamageInfo.isHealingSpell;
         return finalDamage;
      }
      
      private static function computeDamage(pRawDamage:SpellDamage, pSpellDamageInfo:SpellDamageInfo, pEfficiencyMultiplier:Number, pIgnoreCasterStats:Boolean=false, pIgnoreCriticalResist:Boolean=false, pIgnoreTargetResists:Boolean=false) : EffectDamage {
         var stat:* = 0;
         var statBonus:* = 0;
         var criticalStatBonus:* = 0;
         var resistPercent:* = 0;
         var efficiencyPercent:* = 0;
         var elementReduction:* = 0;
         var elementBonus:* = 0;
         var efm:EffectModification = null;
         var triggeredDamagesBonus:* = 0;
         var ed:EffectDamage = null;
         var totalMinBaseDmg:* = 0;
         var totalMinCriticalBaseDmg:* = 0;
         var totalMaxBaseDmg:* = 0;
         var totalMaxCriticalBaseDmg:* = 0;
         var minBaseDmg:* = 0;
         var minCriticalBaseDmg:* = 0;
         var maxBaseDmg:* = 0;
         var maxCriticalBaseDmg:* = 0;
         var i:* = 0;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!fightEntitiesFrame)
         {
            return null;
         }
         var allDamagesBonus:int = pSpellDamageInfo.casterAllDamagesBonus;
         var casterCriticalDamageBonus:int = pSpellDamageInfo.casterCriticalDamageBonus;
         var targetCriticalDamageFixedResist:int = pSpellDamageInfo.targetCriticalDamageFixedResist;
         var effectId:int = -1;
         var casterInfos:GameFightFighterInformations = fightEntitiesFrame.getEntityInfos(pSpellDamageInfo.casterId) as GameFightFighterInformations;
         var casterMovementPointsRatio:Number = casterInfos.stats.movementPoints / casterInfos.stats.maxMovementPoints;
         var isSharedDamage:Boolean = pRawDamage == pSpellDamageInfo.sharedDamage;
         var damageSharingMultiplicator:Number = 1;
         if(isSharedDamage)
         {
            targetCriticalDamageFixedResist = getAverageStat("criticalDamageFixedResist",pSpellDamageInfo.damageSharingTargets);
            damageSharingMultiplicator = 1 / pSpellDamageInfo.damageSharingTargets.length;
         }
         var numEffectsDamages:int = pRawDamage.effectDamages.length;
         i = 0;
         while(i < numEffectsDamages)
         {
            ed = pRawDamage.effectDamages[i];
            effectId = ed.effectId;
            resistPercent = 0;
            if(NO_BOOST_EFFECTS_IDS.indexOf(ed.effectId) != -1)
            {
               pIgnoreCasterStats = true;
            }
            efm = pSpellDamageInfo.getEffectModification(ed.effectId,i,ed.hasCritical);
            if(efm)
            {
               triggeredDamagesBonus = efm.damagesBonus;
               if(efm.shieldPoints > pSpellDamageInfo.targetTriggeredShieldPoints)
               {
                  pSpellDamageInfo.targetTriggeredShieldPoints = efm.shieldPoints;
               }
            }
            if(isSharedDamage)
            {
               resistPercent = getAverageElementResistance(ed.element,pSpellDamageInfo.damageSharingTargets);
               elementReduction = getAverageElementReduction(ed.element,pSpellDamageInfo.damageSharingTargets);
               elementReduction = elementReduction + getAverageBuffElementReduction(pSpellDamageInfo,ed,pSpellDamageInfo.damageSharingTargets);
            }
            else
            {
               switch(ed.element)
               {
                  case NEUTRAL_ELEMENT:
                     if(!pIgnoreCasterStats)
                     {
                        stat = pSpellDamageInfo.casterStrength + pSpellDamageInfo.casterDamagesBonus + triggeredDamagesBonus + (pSpellDamageInfo.isWeapon?pSpellDamageInfo.casterWeaponDamagesBonus:pSpellDamageInfo.casterSpellDamagesBonus);
                        statBonus = pSpellDamageInfo.casterStrengthBonus;
                        criticalStatBonus = pSpellDamageInfo.casterCriticalStrengthBonus;
                     }
                     if(!pIgnoreTargetResists)
                     {
                        resistPercent = pSpellDamageInfo.targetNeutralElementResistPercent;
                        elementReduction = pSpellDamageInfo.targetNeutralElementReduction;
                     }
                     elementBonus = pSpellDamageInfo.casterNeutralDamageBonus;
                     break;
                  case EARTH_ELEMENT:
                     if(!pIgnoreCasterStats)
                     {
                        stat = pSpellDamageInfo.casterStrength + pSpellDamageInfo.casterDamagesBonus + triggeredDamagesBonus + (pSpellDamageInfo.isWeapon?pSpellDamageInfo.casterWeaponDamagesBonus:pSpellDamageInfo.casterSpellDamagesBonus);
                        statBonus = pSpellDamageInfo.casterStrengthBonus;
                        criticalStatBonus = pSpellDamageInfo.casterCriticalStrengthBonus;
                     }
                     if(!pIgnoreTargetResists)
                     {
                        resistPercent = pSpellDamageInfo.targetEarthElementResistPercent;
                        elementReduction = pSpellDamageInfo.targetEarthElementReduction;
                     }
                     elementBonus = pSpellDamageInfo.casterEarthDamageBonus;
                     break;
                  case FIRE_ELEMENT:
                     if(!pIgnoreCasterStats)
                     {
                        stat = pSpellDamageInfo.casterIntelligence + pSpellDamageInfo.casterDamagesBonus + triggeredDamagesBonus + (pSpellDamageInfo.isWeapon?pSpellDamageInfo.casterWeaponDamagesBonus:pSpellDamageInfo.casterSpellDamagesBonus);
                        statBonus = pSpellDamageInfo.casterIntelligenceBonus;
                        criticalStatBonus = pSpellDamageInfo.casterCriticalIntelligenceBonus;
                     }
                     if(!pIgnoreTargetResists)
                     {
                        resistPercent = pSpellDamageInfo.targetFireElementResistPercent;
                        elementReduction = pSpellDamageInfo.targetFireElementReduction;
                     }
                     elementBonus = pSpellDamageInfo.casterFireDamageBonus;
                     break;
                  case WATER_ELEMENT:
                     if(!pIgnoreCasterStats)
                     {
                        stat = pSpellDamageInfo.casterChance + pSpellDamageInfo.casterDamagesBonus + triggeredDamagesBonus + (pSpellDamageInfo.isWeapon?pSpellDamageInfo.casterWeaponDamagesBonus:pSpellDamageInfo.casterSpellDamagesBonus);
                        statBonus = pSpellDamageInfo.casterChanceBonus;
                        criticalStatBonus = pSpellDamageInfo.casterCriticalChanceBonus;
                     }
                     if(!pIgnoreTargetResists)
                     {
                        resistPercent = pSpellDamageInfo.targetWaterElementResistPercent;
                        elementReduction = pSpellDamageInfo.targetWaterElementReduction;
                     }
                     elementBonus = pSpellDamageInfo.casterWaterDamageBonus;
                     break;
                  case AIR_ELEMENT:
                     if(!pIgnoreCasterStats)
                     {
                        stat = pSpellDamageInfo.casterAgility + pSpellDamageInfo.casterDamagesBonus + triggeredDamagesBonus + (pSpellDamageInfo.isWeapon?pSpellDamageInfo.casterWeaponDamagesBonus:pSpellDamageInfo.casterSpellDamagesBonus);
                        statBonus = pSpellDamageInfo.casterAgilityBonus;
                        criticalStatBonus = pSpellDamageInfo.casterCriticalAgilityBonus;
                     }
                     if(!pIgnoreTargetResists)
                     {
                        resistPercent = pSpellDamageInfo.targetAirElementResistPercent;
                        elementReduction = pSpellDamageInfo.targetAirElementReduction;
                     }
                     elementBonus = pSpellDamageInfo.casterAirDamageBonus;
                     break;
               }
               if(!pIgnoreTargetResists)
               {
                  elementReduction = elementReduction + getBuffElementReduction(pSpellDamageInfo,ed,pSpellDamageInfo.targetId);
               }
            }
            resistPercent = 100 - resistPercent;
            efficiencyPercent = pEfficiencyMultiplier * 100;
            if(HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) == -1)
            {
               if(pIgnoreCasterStats)
               {
                  elementBonus = allDamagesBonus = casterCriticalDamageBonus = 0;
               }
               if(pIgnoreCriticalResist)
               {
                  targetCriticalDamageFixedResist = 0;
               }
               minBaseDmg = getDamage(ed.minDamage,stat,statBonus,elementBonus,allDamagesBonus,elementReduction,resistPercent,efficiencyPercent,damageSharingMultiplicator);
               minCriticalBaseDmg = getDamage(!(pSpellDamageInfo.spellWeaponCriticalBonus == 0)?ed.minDamage > 0?ed.minDamage + pSpellDamageInfo.spellWeaponCriticalBonus:0:ed.minCriticalDamage,stat,criticalStatBonus,elementBonus + casterCriticalDamageBonus,allDamagesBonus,elementReduction + targetCriticalDamageFixedResist,resistPercent,efficiencyPercent,damageSharingMultiplicator);
               maxBaseDmg = getDamage(ed.maxDamage,stat,statBonus,elementBonus,allDamagesBonus,elementReduction,resistPercent,efficiencyPercent,damageSharingMultiplicator);
               maxCriticalBaseDmg = getDamage(!(pSpellDamageInfo.spellWeaponCriticalBonus == 0)?ed.maxDamage > 0?ed.maxDamage + pSpellDamageInfo.spellWeaponCriticalBonus:0:ed.maxCriticalDamage,stat,criticalStatBonus,elementBonus + casterCriticalDamageBonus,allDamagesBonus,elementReduction + targetCriticalDamageFixedResist,resistPercent,efficiencyPercent,damageSharingMultiplicator);
            }
            else
            {
               if(ed.effectId == 672)
               {
                  minBaseDmg = maxBaseDmg = (ed.maxDamage * casterInfos.stats.baseMaxLifePoints * getMidLifeDamageMultiplier(Math.min(100,Math.max(0,100 * casterInfos.stats.lifePoints / casterInfos.stats.maxLifePoints))) / 100 - elementReduction) * resistPercent / 100 * efficiencyPercent / 100;
                  minCriticalBaseDmg = maxCriticalBaseDmg = (ed.maxCriticalDamage * casterInfos.stats.baseMaxLifePoints * getMidLifeDamageMultiplier(Math.min(100,Math.max(0,100 * casterInfos.stats.lifePoints / casterInfos.stats.maxLifePoints))) / 100 - elementReduction) * resistPercent / 100 * efficiencyPercent / 100;
               }
            }
            minBaseDmg = minBaseDmg < 0?0:minBaseDmg;
            maxBaseDmg = maxBaseDmg < 0?0:maxBaseDmg;
            minCriticalBaseDmg = minCriticalBaseDmg < 0?0:minCriticalBaseDmg;
            maxCriticalBaseDmg = maxCriticalBaseDmg < 0?0:maxCriticalBaseDmg;
            if(MP_BASED_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) != -1)
            {
               minBaseDmg = minBaseDmg * casterMovementPointsRatio;
               maxBaseDmg = maxBaseDmg * casterMovementPointsRatio;
               minCriticalBaseDmg = minCriticalBaseDmg * casterMovementPointsRatio;
               maxCriticalBaseDmg = maxCriticalBaseDmg * casterMovementPointsRatio;
            }
            if(DamageUtil.EROSION_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) != -1)
            {
               ed.minErosionDamage = ed.minErosionDamage + (pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMinErosionLifePoints) * ed.minErosionPercent / 100;
               ed.maxErosionDamage = ed.maxErosionDamage + (pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMaxErosionLifePoints) * ed.maxErosionPercent / 100;
               if(ed.hasCritical)
               {
                  ed.minCriticalErosionDamage = ed.minCriticalErosionDamage + (pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints) * ed.minCriticalErosionPercent / 100;
                  ed.maxCriticalErosionDamage = ed.maxCriticalErosionDamage + (pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints) * ed.maxCriticalErosionPercent / 100;
               }
            }
            else
            {
               pSpellDamageInfo.targetSpellMinErosionLifePoints = pSpellDamageInfo.targetSpellMinErosionLifePoints + minBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus) / 100;
               pSpellDamageInfo.targetSpellMaxErosionLifePoints = pSpellDamageInfo.targetSpellMaxErosionLifePoints + maxBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus) / 100;
               pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints = pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints + minCriticalBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus) / 100;
               pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints = pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints + maxCriticalBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus) / 100;
            }
            totalMinBaseDmg = totalMinBaseDmg + minBaseDmg;
            totalMaxBaseDmg = totalMaxBaseDmg + maxBaseDmg;
            totalMinCriticalBaseDmg = totalMinCriticalBaseDmg + minCriticalBaseDmg;
            totalMaxCriticalBaseDmg = totalMaxCriticalBaseDmg + maxCriticalBaseDmg;
            i++;
         }
         var finalDamage:EffectDamage = new EffectDamage(effectId,pRawDamage.element,pRawDamage.random);
         finalDamage.minDamage = totalMinBaseDmg;
         finalDamage.maxDamage = totalMaxBaseDmg;
         finalDamage.minCriticalDamage = totalMinCriticalBaseDmg;
         finalDamage.maxCriticalDamage = totalMaxCriticalBaseDmg;
         finalDamage.minErosionDamage = pRawDamage.minErosionDamage * efficiencyPercent / 100;
         finalDamage.minErosionDamage = finalDamage.minErosionDamage * resistPercent / 100;
         finalDamage.maxErosionDamage = pRawDamage.maxErosionDamage * efficiencyPercent / 100;
         finalDamage.maxErosionDamage = finalDamage.maxErosionDamage * resistPercent / 100;
         finalDamage.minCriticalErosionDamage = pRawDamage.minCriticalErosionDamage * efficiencyPercent / 100;
         finalDamage.minCriticalErosionDamage = finalDamage.minCriticalErosionDamage * resistPercent / 100;
         finalDamage.maxCriticalErosionDamage = pRawDamage.maxCriticalErosionDamage * efficiencyPercent / 100;
         finalDamage.maxCriticalErosionDamage = finalDamage.maxCriticalErosionDamage * resistPercent / 100;
         finalDamage.hasCritical = pRawDamage.hasCriticalDamage;
         return finalDamage;
      }
      
      private static function getDamage(pBaseDmg:int, pStat:int, pStatBonus:int, pDamageBonus:int, pAllDamagesBonus:int, pDamageReduction:int, pResistPercent:int, pEfficiencyPercent:int, pDamageSharingMultiplicator:Number=1) : int {
         var dmgWithEfficiency:int = pBaseDmg > 0?(Math.floor(pBaseDmg * (100 + pStat + pStatBonus) / 100) + pDamageBonus + pAllDamagesBonus) * pEfficiencyPercent / 100:0;
         var dmgWithDamageReduction:int = dmgWithEfficiency > 0?dmgWithEfficiency - pDamageReduction:0;
         dmgWithDamageReduction = dmgWithDamageReduction < 0?0:dmgWithDamageReduction;
         return dmgWithDamageReduction * pResistPercent / 100 * pDamageSharingMultiplicator;
      }
      
      private static function getMidLifeDamageMultiplier(pLifePercent:int) : Number {
         return Math.pow(Math.cos(2 * Math.PI * (pLifePercent * 0.01 - 0.5)) + 1,2) / 4;
      }
      
      private static function getDistance(pCellA:uint, pCellB:uint) : int {
         return MapPoint.fromCellId(pCellA).distanceToCell(MapPoint.fromCellId(pCellB));
      }
      
      private static function getSquareDistance(pCellA:uint, pCellB:uint) : int {
         var pt1:MapPoint = MapPoint.fromCellId(pCellA);
         var pt2:MapPoint = MapPoint.fromCellId(pCellB);
         return Math.max(Math.abs(pt1.x - pt2.x),Math.abs(pt1.y - pt2.y));
      }
      
      public static function getShapeEfficiency(pShape:uint, pSpellImpactCell:uint, pTargetCell:uint, pShapeSize:int, pShapeMinSize:int, pShapeEfficiencyPercent:int, pShapeMaxEfficiency:int) : Number {
         var distance:* = 0;
         switch(pShape)
         {
            case SpellShapeEnum.A:
            case SpellShapeEnum.Z:
            case SpellShapeEnum.I:
            case SpellShapeEnum.O:
            case SpellShapeEnum.semicolon:
            case SpellShapeEnum.empty:
            case SpellShapeEnum.P:
               return DAMAGE_NOT_BOOSTED;
            case SpellShapeEnum.B:
            case SpellShapeEnum.V:
            case SpellShapeEnum.G:
            case SpellShapeEnum.W:
               distance = getSquareDistance(pSpellImpactCell,pTargetCell);
               break;
            case SpellShapeEnum.minus:
            case SpellShapeEnum.U:
               distance = getDistance(pSpellImpactCell,pTargetCell) / 2;
               break;
         }
         return getSimpleEfficiency(distance,pShapeSize,pShapeMinSize,pShapeEfficiencyPercent,pShapeMaxEfficiency);
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
      
      public static function getSplashDamages(pTriggeredSpells:Vector.<TriggeredSpell>, pSourceSpellInfo:SpellDamageInfo) : Vector.<SplashDamage> {
         var splashDamages:Vector.<SplashDamage> = null;
         var ts:TriggeredSpell = null;
         var sw:SpellWrapper = null;
         var effi:EffectInstance = null;
         var spellZone:IZone = null;
         var spellZoneCells:Vector.<uint> = null;
         var cell:uint = 0;
         var entity:IEntity = null;
         var splashTargetsIds:Vector.<int> = null;
         var sourceSpellDamage:SpellDamage = null;
         for each (ts in pTriggeredSpells)
         {
            sw = ts.spell;
            for each (effi in sw.effects)
            {
               if(SPLASH_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  spellZone = SpellZoneManager.getInstance().getSpellZone(sw);
                  spellZoneCells = spellZone.getCells(pSourceSpellInfo.targetCell);
                  splashTargetsIds = null;
                  for each (cell in spellZoneCells)
                  {
                     entity = EntitiesManager.getInstance().getEntityOnCell(cell,AnimatedCharacter);
                     if((entity) && (verifySpellEffectMask(sw.playerId,entity.id,effi)))
                     {
                        if(!splashDamages)
                        {
                           splashDamages = new Vector.<SplashDamage>(0);
                        }
                        if(!splashTargetsIds)
                        {
                           splashTargetsIds = new Vector.<int>(0);
                        }
                        splashTargetsIds.push(entity.id);
                     }
                  }
                  if(splashTargetsIds)
                  {
                     splashDamages.push(new SplashDamage(sw.id,sw.playerId,splashTargetsIds,DamageUtil.getSpellDamage(pSourceSpellInfo,false,false),(effi as EffectInstanceDice).diceNum,Effect.getEffectById(effi.effectId).elementId,effi.rawZone.charCodeAt(0),effi.zoneSize,effi.zoneMinSize,effi.zoneEfficiencyPercent,effi.zoneMaxEfficiency,ts.hasCritical));
                  }
               }
            }
         }
         return splashDamages;
      }
      
      public static function getAverageElementResistance(pElement:uint, pEntitiesIds:Vector.<int>) : int {
         var statName:String = null;
         switch(pElement)
         {
            case NEUTRAL_ELEMENT:
               statName = "neutralElementResistPercent";
               break;
            case EARTH_ELEMENT:
               statName = "earthElementResistPercent";
               break;
            case FIRE_ELEMENT:
               statName = "fireElementResistPercent";
               break;
            case WATER_ELEMENT:
               statName = "waterElementResistPercent";
               break;
            case AIR_ELEMENT:
               statName = "airElementResistPercent";
               break;
         }
         return getAverageStat(statName,pEntitiesIds);
      }
      
      public static function getAverageElementReduction(pElement:uint, pEntitiesIds:Vector.<int>) : int {
         var statName:String = null;
         switch(pElement)
         {
            case NEUTRAL_ELEMENT:
               statName = "neutralElementReduction";
               break;
            case EARTH_ELEMENT:
               statName = "earthElementReduction";
               break;
            case FIRE_ELEMENT:
               statName = "fireElementReduction";
               break;
            case WATER_ELEMENT:
               statName = "waterElementReduction";
               break;
            case AIR_ELEMENT:
               statName = "airElementReduction";
               break;
         }
         return getAverageStat(statName,pEntitiesIds);
      }
      
      public static function getAverageBuffElementReduction(pSpellInfo:SpellDamageInfo, pEffectDamage:EffectDamage, pEntitiesIds:Vector.<int>) : int {
         var totalBuffReduction:* = 0;
         var targetId:* = 0;
         for each (targetId in pEntitiesIds)
         {
            totalBuffReduction = totalBuffReduction + getBuffElementReduction(pSpellInfo,pEffectDamage,targetId);
         }
         return totalBuffReduction / pEntitiesIds.length;
      }
      
      public static function getBuffElementReduction(pSpellInfo:SpellDamageInfo, pEffectDamage:EffectDamage, pTargetId:int) : int {
         var buff:BasicBuff = null;
         var trigger:String = null;
         var triggers:String = null;
         var triggersList:Array = null;
         var effect:EffectInstance = null;
         var reduction:* = 0;
         var targetBuffs:Array = BuffManager.getInstance().getAllBuff(pTargetId);
         var buffSpellElementsReduced:Dictionary = new Dictionary(true);
         effect = new EffectInstance();
         effect.effectId = pEffectDamage.effectId;
         for each (buff in targetBuffs)
         {
            triggers = getBuffTriggers(buff);
            if(triggers)
            {
               triggersList = triggers.split("|");
               if(!buffSpellElementsReduced[buff.castingSpell.spell.id])
               {
                  buffSpellElementsReduced[buff.castingSpell.spell.id] = new Vector.<int>(0);
               }
               for each (trigger in triggersList)
               {
                  if((buff.actionId == 265) && (verifyEffectTrigger(pSpellInfo.casterId,pTargetId,effect,pSpellInfo.isWeapon,trigger)))
                  {
                     if(buffSpellElementsReduced[buff.castingSpell.spell.id].indexOf(pEffectDamage.element) == -1)
                     {
                        reduction = reduction + (pSpellInfo.targetLevel / 20 + 1) * (buff.effects as EffectInstanceInteger).value;
                        if(buffSpellElementsReduced[buff.castingSpell.spell.id].indexOf(pEffectDamage.element) == -1)
                        {
                           buffSpellElementsReduced[buff.castingSpell.spell.id].push(pEffectDamage.element);
                        }
                     }
                  }
               }
            }
         }
         return reduction;
      }
      
      public static function getAverageStat(pStatName:String, pEntitiesIds:Vector.<int>) : int {
         var entityId:* = 0;
         var fightEntityInfo:GameFightFighterInformations = null;
         var totalStat:* = 0;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if((!fef) || (!pEntitiesIds) || (pEntitiesIds.length == 0))
         {
            return -1;
         }
         if(pStatName)
         {
            for each (entityId in pEntitiesIds)
            {
               fightEntityInfo = fef.getEntityInfos(entityId) as GameFightFighterInformations;
               totalStat = totalStat + fightEntityInfo.stats[pStatName];
            }
         }
         return totalStat / pEntitiesIds.length;
      }
   }
}
