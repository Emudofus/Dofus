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
      
      protected static const _log:Logger;
      
      private static const exclusiveTargetMasks:RegExp;
      
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
      
      public static const EROSION_DAMAGE_EFFECTS_IDS:Array;
      
      public static const HEALING_EFFECTS_IDS:Array;
      
      public static const IMMEDIATE_BOOST_EFFECTS_IDS:Array;
      
      public static const BOMB_SPELLS_IDS:Array;
      
      public static const SPLASH_EFFECTS_IDS:Array;
      
      public static const MP_BASED_DAMAGE_EFFECTS_IDS:Array;
      
      public static const HP_BASED_DAMAGE_EFFECTS_IDS:Array;
      
      public static const TRIGGERED_EFFECTS_IDS:Array;
      
      public static const NO_BOOST_EFFECTS_IDS:Array;
      
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
         for each(effi in pSpell.effects)
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
            for each(effi in spellLevel.effects)
            {
               if(effi.effectId == pBuff.effects.effectId)
               {
                  elements = new Vector.<int>(0);
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
         for each(effi in effects)
         {
            if(effi.effectId == 1091)
            {
               effects = SpellWrapper.create(0,int(effi.parameter0),int(effi.parameter1),false).spellLevelInfos.effects;
               break;
            }
         }
         for each(effi in effects)
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
            for each(trigger in triggersList)
            {
               for each(eff in pSpellInfo.spellEffects)
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
         for each(_loc16_ in triggersList)
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
      
      public static function verifySpellEffectMask(pCasterId:int, pTargetId:int, pEffect:EffectInstance, pTriggeringSpellCasterId:int = 0) : Boolean {
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
         else if((targetInfos.stats.summoned) && (monsterInfo) && (!Monster.getMonsterById(monsterInfo.creatureGenericId).canPlay))
         {
            targetMaskPattern = isTargetAlly?"agsj":"ASJ";
         }
         else if(targetInfos.stats.summoned)
         {
            targetMaskPattern = isTargetAlly?"agij":"AIJ";
         }
         else if(targetInfos is GameFightCompanionInformations)
         {
            targetMaskPattern = isTargetAlly?"agdl":"ADL";
         }
         else if(targetInfos is GameFightMonsterInformations)
         {
            targetMaskPattern = isTargetAlly?"agm":"AM";
         }
         else
         {
            targetMaskPattern = isTargetAlly?"gahl":"AHL";
         }
         
         
         
         
         r = new RegExp("[" + targetMaskPattern + "]","g");
         verify = pEffect.targetMask.match(r).length > 0;
         if(verify)
         {
            exclusiveMasks = pEffect.targetMask.match(exclusiveTargetMasks);
            if(exclusiveMasks.length > 0)
            {
               verify = false;
               for each(exclusiveMask in exclusiveMasks)
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
                     default:
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
      
      public static function getSpellElementDamage(pSpell:Object, pElementType:int, pCasterId:int = 0, pTargetId:int = 0) : SpellDamage {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
      
      public static function getSpellDamage(pSpellDamageInfo:SpellDamageInfo, pWithTargetBuffs:Boolean = true, pWithTargetResists:Boolean = true) : SpellDamage {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function computeDamage(pRawDamage:SpellDamage, pSpellDamageInfo:SpellDamageInfo, pEfficiencyMultiplier:Number, pIgnoreCasterStats:Boolean = false, pIgnoreCriticalResist:Boolean = false, pIgnoreTargetResists:Boolean = false) : EffectDamage {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private static function getDamage(pBaseDmg:int, pStat:int, pStatBonus:int, pDamageBonus:int, pAllDamagesBonus:int, pDamageReduction:int, pResistPercent:int, pEfficiencyPercent:int, pDamageSharingMultiplicator:Number = 1) : int {
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
            default:
               distance = getDistance(pSpellImpactCell,pTargetCell);
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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
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
         for each(targetId in pEntitiesIds)
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
         for each(buff in targetBuffs)
         {
            triggers = getBuffTriggers(buff);
            if(triggers)
            {
               triggersList = triggers.split("|");
               if(!buffSpellElementsReduced[buff.castingSpell.spell.id])
               {
                  buffSpellElementsReduced[buff.castingSpell.spell.id] = new Vector.<int>(0);
               }
               for each(trigger in triggersList)
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
            for each(entityId in pEntitiesIds)
            {
               fightEntityInfo = fef.getEntityInfos(entityId) as GameFightFighterInformations;
               totalStat = totalStat + fightEntityInfo.stats[pStatName];
            }
         }
         return totalStat / pEntitiesIds.length;
      }
   }
}
