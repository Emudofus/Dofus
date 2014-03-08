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
      
      public static function fromCurrentPlayer(pSpell:Object, pTargetId:int) : SpellDamageInfo {
         var effi:EffectInstance = null;
         var effid:EffectInstanceDice = null;
         var ed:EffectDamage = null;
         var spellShapeEfficiencyPercent:* = 0;
         var casterBuffs:Array = null;
         var buff:BasicBuff = null;
         var targetStates:Array = null;
         var weapon:WeaponWrapper = null;
         var targetStats:GameFightMinimalStats = null;
         var sdi:SpellDamageInfo = new SpellDamageInfo();
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!fightContextFrame)
         {
            return sdi;
         }
         sdi.casterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
         sdi.casterLevel = fightContextFrame.getFighterLevel(CurrentPlayedFighterManager.getInstance().currentFighterId);
         sdi.targetId = pTargetId;
         sdi.targetLevel = fightContextFrame.getFighterLevel(pTargetId);
         sdi.spellEffects = pSpell.effects;
         sdi.isWeapon = !(pSpell is SpellWrapper);
         var charStats:CharacterCharacteristicsInformations = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
         var targetInfos:GameFightFighterInformations = fightContextFrame.entitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations;
         sdi.casterStrength = charStats.strength.base + charStats.strength.objectsAndMountBonus + charStats.strength.alignGiftBonus + charStats.strength.contextModif;
         sdi.casterChance = charStats.chance.base + charStats.chance.objectsAndMountBonus + charStats.chance.alignGiftBonus + charStats.chance.contextModif;
         sdi.casterAgility = charStats.agility.base + charStats.agility.objectsAndMountBonus + charStats.agility.alignGiftBonus + charStats.agility.contextModif;
         sdi.casterIntelligence = charStats.intelligence.base + charStats.intelligence.objectsAndMountBonus + charStats.intelligence.alignGiftBonus + charStats.intelligence.contextModif;
         sdi.casterCriticalHit = charStats.criticalHit.base + charStats.criticalHit.objectsAndMountBonus + charStats.criticalHit.alignGiftBonus + charStats.criticalHit.contextModif;
         sdi.casterCriticalHitWeapon = charStats.criticalHitWeapon;
         sdi.casterHealBonus = charStats.healBonus.base + charStats.healBonus.objectsAndMountBonus + charStats.healBonus.alignGiftBonus + charStats.healBonus.contextModif;
         sdi.casterAllDamagesBonus = charStats.allDamagesBonus.base + charStats.allDamagesBonus.objectsAndMountBonus + charStats.allDamagesBonus.alignGiftBonus + charStats.allDamagesBonus.contextModif;
         sdi.casterDamagesBonus = charStats.damagesBonusPercent.base + charStats.damagesBonusPercent.objectsAndMountBonus + charStats.damagesBonusPercent.alignGiftBonus + charStats.damagesBonusPercent.contextModif;
         sdi.casterTrapBonus = charStats.trapBonus.base + charStats.trapBonus.objectsAndMountBonus + charStats.trapBonus.alignGiftBonus + charStats.trapBonus.contextModif;
         sdi.casterTrapBonusPercent = charStats.trapBonusPercent.base + charStats.trapBonusPercent.objectsAndMountBonus + charStats.trapBonusPercent.alignGiftBonus + charStats.trapBonusPercent.contextModif;
         sdi.casterGlyphBonusPercent = charStats.glyphBonusPercent.base + charStats.glyphBonusPercent.objectsAndMountBonus + charStats.glyphBonusPercent.alignGiftBonus + charStats.glyphBonusPercent.contextModif;
         sdi.casterPermanentDamagePercent = charStats.permanentDamagePercent.base + charStats.permanentDamagePercent.objectsAndMountBonus + charStats.permanentDamagePercent.alignGiftBonus + charStats.permanentDamagePercent.contextModif;
         sdi.casterPushDamageBonus = charStats.pushDamageBonus.base + charStats.pushDamageBonus.objectsAndMountBonus + charStats.pushDamageBonus.alignGiftBonus + charStats.pushDamageBonus.contextModif;
         sdi.casterCriticalDamageBonus = charStats.criticalDamageBonus.base + charStats.criticalDamageBonus.objectsAndMountBonus + charStats.criticalDamageBonus.alignGiftBonus + charStats.criticalDamageBonus.contextModif;
         sdi.casterNeutralDamageBonus = charStats.neutralDamageBonus.base + charStats.neutralDamageBonus.objectsAndMountBonus + charStats.neutralDamageBonus.alignGiftBonus + charStats.neutralDamageBonus.contextModif;
         sdi.casterEarthDamageBonus = charStats.earthDamageBonus.base + charStats.earthDamageBonus.objectsAndMountBonus + charStats.earthDamageBonus.alignGiftBonus + charStats.earthDamageBonus.contextModif;
         sdi.casterWaterDamageBonus = charStats.waterDamageBonus.base + charStats.waterDamageBonus.objectsAndMountBonus + charStats.waterDamageBonus.alignGiftBonus + charStats.waterDamageBonus.contextModif;
         sdi.casterAirDamageBonus = charStats.airDamageBonus.base + charStats.airDamageBonus.objectsAndMountBonus + charStats.airDamageBonus.alignGiftBonus + charStats.airDamageBonus.contextModif;
         sdi.casterFireDamageBonus = charStats.fireDamageBonus.base + charStats.fireDamageBonus.objectsAndMountBonus + charStats.fireDamageBonus.alignGiftBonus + charStats.fireDamageBonus.contextModif;
         sdi.neutralDamage = DamageUtil.getSpellElementDamage(pSpell,NEUTRAL_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId);
         sdi.earthDamage = DamageUtil.getSpellElementDamage(pSpell,EARTH_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId);
         sdi.fireDamage = DamageUtil.getSpellElementDamage(pSpell,FIRE_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId);
         sdi.waterDamage = DamageUtil.getSpellElementDamage(pSpell,WATER_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId);
         sdi.airDamage = DamageUtil.getSpellElementDamage(pSpell,AIR_ELEMENT,CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId);
         sdi.spellHasCriticalDamage = (sdi.isWeapon) || (sdi.neutralDamage.hasCriticalDamage) || (sdi.earthDamage.hasCriticalDamage) || (sdi.fireDamage.hasCriticalDamage) || (sdi.waterDamage.hasCriticalDamage) || (sdi.airDamage.hasCriticalDamage);
         sdi.healDamage = new SpellDamage();
         for each (effi in pSpell.effects)
         {
            if((!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)) && (DamageUtil.verifySpellEffectMask(CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId,effi)))
            {
               effid = effi as EffectInstanceDice;
               ed = DamageUtil.getEffectDamageByEffectId(sdi.healDamage,effid.effectId);
               if(!ed)
               {
                  ed = new EffectDamage(effi.effectId,-1,effi.random);
                  sdi.healDamage.addEffectDamage(ed);
               }
               if(effi.effectId == 1109)
               {
                  if(targetInfos)
                  {
                     ed.lifePointsAddedBasedOnLifePercent = ed.lifePointsAddedBasedOnLifePercent + effid.diceNum * targetInfos.stats.maxLifePoints / 100;
                  }
               }
               else
               {
                  ed.minLifePointsAdded = ed.minLifePointsAdded + effid.diceNum;
                  ed.maxLifePointsAdded = ed.maxLifePointsAdded + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
               }
            }
         }
         for each (effi in pSpell.criticalEffect)
         {
            if((!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)) && (DamageUtil.verifySpellEffectMask(CurrentPlayedFighterManager.getInstance().currentFighterId,pTargetId,effi)))
            {
               effid = effi as EffectInstanceDice;
               ed = DamageUtil.getEffectDamageByEffectId(sdi.healDamage,effid.effectId);
               if(!ed)
               {
                  ed = new EffectDamage(effi.effectId,-1,effi.random);
                  sdi.healDamage.addEffectDamage(ed);
               }
               if(effi.effectId == 1109)
               {
                  if(targetInfos)
                  {
                     ed.criticalLifePointsAddedBasedOnLifePercent = ed.criticalLifePointsAddedBasedOnLifePercent + effid.diceNum * targetInfos.stats.maxLifePoints / 100;
                  }
               }
               else
               {
                  ed.minCriticalLifePointsAdded = ed.minCriticalLifePointsAdded + effid.diceNum;
                  ed.maxCriticalLifePointsAdded = ed.maxCriticalLifePointsAdded + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
               }
               sdi.spellHasCriticalHeal = true;
            }
         }
         sdi.spellHasRandomEffects = (sdi.neutralDamage.hasRandomEffects) || (sdi.earthDamage.hasRandomEffects) || (sdi.fireDamage.hasRandomEffects) || (sdi.waterDamage.hasRandomEffects) || (sdi.airDamage.hasRandomEffects) || (sdi.healDamage.hasRandomEffects);
         if(sdi.isWeapon)
         {
            weapon = PlayedCharacterManager.getInstance().currentWeapon;
            sdi.spellWeaponCriticalBonus = weapon.criticalHitBonus;
            if(weapon.type.id == 7)
            {
               sdi.spellShapeEfficiencyPercent = 25;
            }
         }
         if(targetInfos)
         {
            targetStats = targetInfos.stats;
            sdi.targetShieldsPoints = targetStats.shieldPoints;
            sdi.targetNeutralElementResistPercent = targetStats.neutralElementResistPercent;
            sdi.targetEarthElementResistPercent = targetStats.earthElementResistPercent;
            sdi.targetWaterElementResistPercent = targetStats.waterElementResistPercent;
            sdi.targetAirElementResistPercent = targetStats.airElementResistPercent;
            sdi.targetFireElementResistPercent = targetStats.fireElementResistPercent;
            sdi.targetNeutralElementReduction = targetStats.neutralElementReduction;
            sdi.targetEarthElementReduction = targetStats.earthElementReduction;
            sdi.targetWaterElementReduction = targetStats.waterElementReduction;
            sdi.targetAirElementReduction = targetStats.airElementReduction;
            sdi.targetFireElementReduction = targetStats.fireElementReduction;
            sdi.targetCriticalDamageFixedResist = targetStats.criticalDamageFixedResist;
            sdi.targetPushDamageFixedResist = targetStats.pushDamageFixedResist;
            sdi.targetCell = targetInfos.disposition.cellId;
         }
         sdi.spellCenterCell = FightContextFrame.currentCell;
         for each (effi in pSpell.effects)
         {
            if(effi.category == DamageUtil.DAMAGE_EFFECT_CATEGORY)
            {
               if(effi.rawZone)
               {
                  sdi.spellShapeSize = effi.zoneSize;
                  sdi.spellShapeMinSize = effi.zoneMinSize;
                  sdi.spellShapeEfficiencyPercent = effi.zoneEfficiencyPercent;
                  sdi.spellShapeMaxEfficiency = effi.zoneMaxEfficiency;
                  break;
               }
            }
         }
         casterBuffs = BuffManager.getInstance().getAllBuff(CurrentPlayedFighterManager.getInstance().currentFighterId);
         for each (buff in casterBuffs)
         {
            if(buff.actionId == 1144)
            {
               sdi.casterDamagesBonus = sdi.casterDamagesBonus + buff.param1;
            }
         }
         sdi.targetBuffs = BuffManager.getInstance().getAllBuff(pTargetId);
         targetStates = FightersStateManager.getInstance().getStates(pTargetId);
         if(targetStates)
         {
            sdi.targetIsInvulnerable = !(targetStates.indexOf(56) == -1);
         }
         return sdi;
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
