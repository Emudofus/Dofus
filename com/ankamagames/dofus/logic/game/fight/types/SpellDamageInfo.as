package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.datacenter.effects.Effect;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   
   public class SpellDamageInfo extends Object
   {
      
      public function SpellDamageInfo() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellDamageInfo));
      
      public static function fromCurrentPlayer(pSpell:Object, pTargetId:int) : SpellDamageInfo {
         var sdi:SpellDamageInfo = null;
         var cellId:uint = 0;
         var e:IEntity = null;
         var charStats:CharacterCharacteristicsInformations = null;
         var effi:EffectInstance = null;
         var effid:EffectInstanceDice = null;
         var ed:EffectDamage = null;
         var isHealingSpell:* = false;
         var firstDamageEffectOrder:* = 0;
         var i:* = 0;
         var numEffects:* = 0;
         var spellShapeEfficiencyPercent:* = 0;
         var casterBuffs:Array = null;
         var buff:BasicBuff = null;
         var groupedBuffs:Dictionary = null;
         var buffs:Vector.<BasicBuff> = null;
         var spellId:* = undefined;
         var sw:SpellWrapper = null;
         var stackedBuffs:* = false;
         var firstCastingSpellId:* = 0;
         var castingSpellId:* = 0;
         var nbStacks:* = 0;
         var weapon:WeaponWrapper = null;
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!fightContextFrame)
         {
            return sdi;
         }
         sdi = new SpellDamageInfo();
         sdi._originalTargetsIds = new Vector.<int>(0);
         sdi.targetId = pTargetId;
         sdi.casterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
         sdi.casterLevel = fightContextFrame.getFighterLevel(sdi.casterId);
         sdi.spellEffects = pSpell.effects;
         sdi.spellCriticalEffects = pSpell.criticalEffect;
         sdi.isWeapon = !(pSpell is SpellWrapper);
         var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
         spellZone.direction = MapPoint.fromCellId(EntitiesManager.getInstance().getEntity(sdi.casterId).position.cellId).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell));
         var spellZoneCells:Vector.<uint> = spellZone.getCells(FightContextFrame.currentCell);
         for each (cellId in spellZoneCells)
         {
            e = EntitiesManager.getInstance().getEntityOnCell(cellId,AnimatedCharacter);
            if((e) && (sdi._originalTargetsIds.indexOf(e.id) == -1) && (DamageUtil.isDamagedOrHealedBySpell(sdi.casterId,e.id,pSpell)))
            {
               sdi._originalTargetsIds.push(e.id);
            }
         }
         charStats = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
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
         sdi.neutralDamage = DamageUtil.getSpellElementDamage(pSpell,DamageUtil.NEUTRAL_ELEMENT,sdi.casterId,pTargetId);
         sdi.earthDamage = DamageUtil.getSpellElementDamage(pSpell,DamageUtil.EARTH_ELEMENT,sdi.casterId,pTargetId);
         sdi.fireDamage = DamageUtil.getSpellElementDamage(pSpell,DamageUtil.FIRE_ELEMENT,sdi.casterId,pTargetId);
         sdi.waterDamage = DamageUtil.getSpellElementDamage(pSpell,DamageUtil.WATER_ELEMENT,sdi.casterId,pTargetId);
         sdi.airDamage = DamageUtil.getSpellElementDamage(pSpell,DamageUtil.AIR_ELEMENT,sdi.casterId,pTargetId);
         sdi.spellHasCriticalDamage = (sdi.isWeapon) || (sdi.neutralDamage.hasCriticalDamage) || (sdi.earthDamage.hasCriticalDamage) || (sdi.fireDamage.hasCriticalDamage) || (sdi.waterDamage.hasCriticalDamage) || (sdi.airDamage.hasCriticalDamage);
         sdi.healDamage = new SpellDamage();
         for each (effi in pSpell.effects)
         {
            if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) != -1)
            {
               if(DamageUtil.verifySpellEffectMask(sdi.casterId,pTargetId,effi))
               {
                  isHealingSpell = true;
               }
            }
            else
            {
               if((isHealingSpell) && (effi.category == DamageUtil.DAMAGE_EFFECT_CATEGORY))
               {
                  isHealingSpell = false;
                  break;
               }
            }
         }
         sdi.isHealingSpell = isHealingSpell;
         firstDamageEffectOrder = getMinimumDamageEffectOrder(sdi.casterId,pTargetId,pSpell.effects);
         numEffects = pSpell.effects.length;
         i = 0;
         while(i < numEffects)
         {
            effi = pSpell.effects[i];
            if(DamageUtil.verifySpellEffectMask(sdi.casterId,pTargetId,effi))
            {
               effid = effi as EffectInstanceDice;
               if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  ed = new EffectDamage(effi.effectId,-1,effi.random);
                  sdi.healDamage.addEffectDamage(ed);
                  if(effi.effectId == 1109)
                  {
                     if(sdi.targetInfos)
                     {
                        ed.lifePointsAddedBasedOnLifePercent = ed.lifePointsAddedBasedOnLifePercent + effid.diceNum * sdi.targetInfos.stats.maxLifePoints / 100;
                     }
                  }
                  else
                  {
                     ed.minLifePointsAdded = ed.minLifePointsAdded + effid.diceNum;
                     ed.maxLifePointsAdded = ed.maxLifePointsAdded + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
                  }
               }
               else
               {
                  if((!(DamageUtil.IMMEDIATE_BOOST_EFFECTS_IDS.indexOf(effi.effectId) == -1)) && (effi.order < firstDamageEffectOrder))
                  {
                     switch(effi.effectId)
                     {
                        case 266:
                           sdi.casterChanceBonus = sdi.casterChanceBonus + effid.diceNum;
                           break;
                        case 268:
                           sdi.casterAgilityBonus = sdi.casterAgilityBonus + effid.diceNum;
                           break;
                        case 269:
                           sdi.casterIntelligenceBonus = sdi.casterIntelligenceBonus + effid.diceNum;
                           break;
                        case 271:
                           sdi.casterStrengthBonus = sdi.casterStrengthBonus + effid.diceNum;
                           break;
                        case 414:
                           sdi.casterPushDamageBonus = sdi.casterPushDamageBonus + effid.diceNum;
                           break;
                     }
                  }
               }
            }
            i++;
         }
         var numHealingEffectDamages:int = sdi.healDamage.effectDamages.length;
         var numCriticalEffects:int = pSpell.criticalEffect?pSpell.criticalEffect.length:0;
         var criticalFirstDamageEffectOrder:int = numCriticalEffects > 0?getMinimumDamageEffectOrder(sdi.casterId,pTargetId,pSpell.criticalEffect):0;
         i = 0;
         while(i < numCriticalEffects)
         {
            effi = pSpell.criticalEffect[i];
            if(DamageUtil.verifySpellEffectMask(sdi.casterId,pTargetId,effi))
            {
               effid = effi as EffectInstanceDice;
               if(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) != -1)
               {
                  if(i < numHealingEffectDamages)
                  {
                     ed = sdi.healDamage.effectDamages[i];
                  }
                  else
                  {
                     ed = new EffectDamage(effi.effectId,-1,effi.random);
                     sdi.healDamage.addEffectDamage(ed);
                  }
                  if(effi.effectId == 1109)
                  {
                     if(sdi.targetInfos)
                     {
                        ed.criticalLifePointsAddedBasedOnLifePercent = ed.criticalLifePointsAddedBasedOnLifePercent + effid.diceNum * sdi.targetInfos.stats.maxLifePoints / 100;
                     }
                  }
                  else
                  {
                     ed.minCriticalLifePointsAdded = ed.minCriticalLifePointsAdded + effid.diceNum;
                     ed.maxCriticalLifePointsAdded = ed.maxCriticalLifePointsAdded + (effid.diceSide == 0?effid.diceNum:effid.diceSide);
                  }
                  sdi.spellHasCriticalHeal = true;
               }
               else
               {
                  if((!(DamageUtil.IMMEDIATE_BOOST_EFFECTS_IDS.indexOf(effi.effectId) == -1)) && (effi.order < criticalFirstDamageEffectOrder))
                  {
                     switch(effi.effectId)
                     {
                        case 266:
                           sdi.casterCriticalChanceBonus = sdi.casterCriticalChanceBonus + effid.diceNum;
                           break;
                        case 268:
                           sdi.casterCriticalAgilityBonus = sdi.casterCriticalAgilityBonus + effid.diceNum;
                           break;
                        case 269:
                           sdi.casterCriticalIntelligenceBonus = sdi.casterCriticalIntelligenceBonus + effid.diceNum;
                           break;
                        case 271:
                           sdi.casterCriticalStrengthBonus = sdi.casterCriticalStrengthBonus + effid.diceNum;
                           break;
                     }
                  }
               }
            }
            i++;
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
         sdi.spellCenterCell = FightContextFrame.currentCell;
         for each (effi in pSpell.effects)
         {
            if(effi.category == DamageUtil.DAMAGE_EFFECT_CATEGORY)
            {
               if(effi.rawZone)
               {
                  sdi.spellShape = effi.rawZone.charCodeAt(0);
                  sdi.spellShapeSize = effi.zoneSize;
                  sdi.spellShapeMinSize = effi.zoneMinSize;
                  sdi.spellShapeEfficiencyPercent = effi.zoneEfficiencyPercent;
                  sdi.spellShapeMaxEfficiency = effi.zoneMaxEfficiency;
                  break;
               }
            }
         }
         casterBuffs = BuffManager.getInstance().getAllBuff(sdi.casterId);
         groupedBuffs = groupBuffsBySpell(casterBuffs);
         castingSpellId = -1;
         nbStacks = 0;
         for (spellId in groupedBuffs)
         {
            buffs = groupedBuffs[spellId];
            if(spellId == pSpell.id)
            {
               sw = pSpell as SpellWrapper;
               stackedBuffs = false;
               for each (buff in buffs)
               {
                  if((buff.stack) && (buff.stack.length == sw.spellLevelInfos.maxStack))
                  {
                     applyBuffModification(sdi,buff.stack[0].actionId,-buff.stack[0].param1);
                     stackedBuffs = true;
                  }
               }
               if(!stackedBuffs)
               {
                  nbStacks = 1;
                  castingSpellId = firstCastingSpellId = buffs[0].castingSpell.castingSpellId;
                  for each (buff in buffs)
                  {
                     if(castingSpellId != buff.castingSpell.castingSpellId)
                     {
                        castingSpellId = buff.castingSpell.castingSpellId;
                        nbStacks++;
                     }
                  }
                  if(nbStacks == sw.spellLevelInfos.maxStack)
                  {
                     for each (buff in buffs)
                     {
                        if(buff.castingSpell.castingSpellId == firstCastingSpellId)
                        {
                           applyBuffModification(sdi,buff.actionId,-buff.param1);
                           continue;
                        }
                        break;
                     }
                  }
               }
            }
            for each (buff in buffs)
            {
               switch(buff.actionId)
               {
                  case 1054:
                     sdi.casterSpellDamagesBonus = sdi.casterSpellDamagesBonus + buff.param1;
                     continue;
                  case 1144:
                     sdi.casterWeaponDamagesBonus = sdi.casterWeaponDamagesBonus + buff.param1;
                     continue;
                  case 1171:
                     sdi.casterDamageBoostPercent = sdi.casterDamageBoostPercent + buff.param1;
                     continue;
                  case 1172:
                     sdi.casterDamageDeboostPercent = sdi.casterDamageDeboostPercent + buff.param1;
                     continue;
               }
            }
         }
         for each (buff in sdi.targetBuffs)
         {
            if((!buff.trigger) && (buff.effects.effectId == 952))
            {
               switch(buff.effects.parameter0)
               {
                  case 56:
                     sdi.targetIsInvulnerable = false;
                     break;
                  case 76:
                     sdi.targetIsUnhealable = false;
                     break;
               }
            }
            if(buff.actionId == 776)
            {
               sdi.targetErosionPercentBonus = sdi.targetErosionPercentBonus + buff.param1;
            }
         }
         return sdi;
      }
      
      private static function applyBuffModification(pSpellInfo:SpellDamageInfo, pBuffActionId:int, pModif:int) : void {
         switch(pBuffActionId)
         {
            case 118:
               pSpellInfo.casterStrength = pSpellInfo.casterStrength + pModif;
               break;
            case 119:
               pSpellInfo.casterAgility = pSpellInfo.casterAgility + pModif;
               break;
            case 123:
               pSpellInfo.casterChance = pSpellInfo.casterChance + pModif;
               break;
            case 126:
               pSpellInfo.casterIntelligence = pSpellInfo.casterIntelligence + pModif;
               break;
            case 414:
               pSpellInfo.casterPushDamageBonus = pSpellInfo.casterPushDamageBonus + pModif;
               break;
         }
      }
      
      private static function groupBuffsBySpell(pBuffs:Array) : Dictionary {
         var spellBuffs:Dictionary = null;
         var buff:BasicBuff = null;
         for each (buff in pBuffs)
         {
            if(!spellBuffs)
            {
               spellBuffs = new Dictionary();
            }
            if(!spellBuffs[buff.castingSpell.spell.id])
            {
               spellBuffs[buff.castingSpell.spell.id] = new Vector.<BasicBuff>(0);
            }
            spellBuffs[buff.castingSpell.spell.id].push(buff);
         }
         return spellBuffs;
      }
      
      private static function getMinimumDamageEffectOrder(pCasterId:int, pTargetId:int, pEffects:Vector.<EffectInstance>) : int {
         var effi:EffectInstance = null;
         var minOrder:int = -1;
         for each (effi in pEffects)
         {
            if(((effi.category == 2) || (!(DamageUtil.HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)) || (effi.effectId == 5)) && (DamageUtil.verifySpellEffectMask(pCasterId,pTargetId,effi)))
            {
               if(minOrder == -1)
               {
                  minOrder = effi.order;
               }
               else
               {
                  minOrder = effi.order < minOrder?effi.order:minOrder;
               }
            }
         }
         return minOrder;
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
      
      public var casterCriticalDamageBonus:int;
      
      public var casterNeutralDamageBonus:int;
      
      public var casterEarthDamageBonus:int;
      
      public var casterWaterDamageBonus:int;
      
      public var casterAirDamageBonus:int;
      
      public var casterFireDamageBonus:int;
      
      public var casterDamageBoostPercent:int;
      
      public var casterDamageDeboostPercent:int;
      
      public var spellEffects:Vector.<EffectInstance>;
      
      public var spellCriticalEffects:Vector.<EffectInstance>;
      
      public var spellCenterCell:int;
      
      public var neutralDamage:SpellDamage;
      
      public var earthDamage:SpellDamage;
      
      public var fireDamage:SpellDamage;
      
      public var waterDamage:SpellDamage;
      
      public var airDamage:SpellDamage;
      
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
      
      public function getEffectModification(pEffectId:int, pEffectOrder:int, pHasCritical:Boolean) : EffectModification {
         var i:* = 0;
         var numEffectsModifications:int = this._effectsModifications?this._effectsModifications.length:0;
         var numCriticalEffectsModifications:int = this._criticalEffectsModifications?this._criticalEffectsModifications.length:0;
         var remainingEffects:int = pEffectOrder;
         if((!pHasCritical) && (this._effectsModifications))
         {
            i = 0;
            while(i < numEffectsModifications)
            {
               if(this._effectsModifications[i].effectId == pEffectId)
               {
                  if(remainingEffects == 0)
                  {
                     return this._effectsModifications[i];
                  }
                  remainingEffects--;
               }
               i++;
            }
         }
         else
         {
            if(this._criticalEffectsModifications)
            {
               i = 0;
               while(i < numCriticalEffectsModifications)
               {
                  if(this._criticalEffectsModifications[i].effectId == pEffectId)
                  {
                     if(remainingEffects == 0)
                     {
                        return this._criticalEffectsModifications[i];
                     }
                     remainingEffects--;
                  }
                  i++;
               }
            }
         }
         return null;
      }
      
      public function get targetId() : int {
         return this._targetId;
      }
      
      public function set targetId(pTargetId:int) : void {
         var fightContextFrame:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(!fightContextFrame)
         {
            return;
         }
         this._targetId = pTargetId;
         this.targetLevel = fightContextFrame.getFighterLevel(this._targetId);
         this._targetInfos = fightContextFrame.entitiesFrame.getEntityInfos(this._targetId) as GameFightFighterInformations;
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
         this.targetStates = FightersStateManager.getInstance().getStates(pTargetId);
         if(this.targetStates)
         {
            this.targetIsInvulnerable = !(this.targetStates.indexOf(56) == -1);
            this.targetIsUnhealable = !(this.targetStates.indexOf(76) == -1);
         }
      }
      
      public function get targetInfos() : GameFightFighterInformations {
         return this._targetInfos;
      }
      
      public function get originalTargetsIds() : Vector.<int> {
         return this._originalTargetsIds;
      }
      
      public function get triggeredSpellsByCasterOnTarget() : Vector.<TriggeredSpell> {
         var triggeredSpellsByCaster:Vector.<TriggeredSpell> = null;
         var spellId:* = 0;
         var spellLevel:* = 0;
         var eff:EffectInstance = null;
         var criticalEff:EffectInstance = null;
         var criticalSpellLevel:* = 0;
         for each (eff in this.spellEffects)
         {
            if((eff.effectId == 1160) && (DamageUtil.verifySpellEffectMask(this.casterId,this.targetId,eff)) && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,eff,false,eff.triggers)))
            {
               if(!triggeredSpellsByCaster)
               {
                  triggeredSpellsByCaster = new Vector.<TriggeredSpell>();
               }
               spellId = int(eff.parameter0);
               spellLevel = int(eff.parameter1);
               criticalSpellLevel = 0;
               for each (criticalEff in this.spellCriticalEffects)
               {
                  if((criticalEff.effectId == 1160) && (int(criticalEff.parameter0) == spellId))
                  {
                     criticalSpellLevel = int(criticalEff.parameter1);
                     break;
                  }
               }
               triggeredSpellsByCaster.push(TriggeredSpell.create(eff.triggers,spellId,spellLevel,criticalSpellLevel,this.casterId,this.targetId));
            }
         }
         return triggeredSpellsByCaster;
      }
      
      public function get targetTriggeredSpells() : Vector.<TriggeredSpell> {
         var buff:BasicBuff = null;
         var triggeredSpells:Vector.<TriggeredSpell> = null;
         var spellId:* = 0;
         var criticalEff:EffectInstance = null;
         var criticalSpellLevel:* = 0;
         for each (buff in this.targetBuffs)
         {
            if(((!this._buffsWithSpellsTriggered) || (this._buffsWithSpellsTriggered.indexOf(buff.uid) == -1)) && ((buff.effects.effectId == 793) || (buff.effects.effectId == 792)) && (DamageUtil.verifyBuffTriggers(this,buff)))
            {
               spellId = int(buff.effects.parameter0);
               criticalSpellLevel = 0;
               if(!this._buffsWithSpellsTriggered)
               {
                  this._buffsWithSpellsTriggered = new Vector.<uint>(0);
               }
               this._buffsWithSpellsTriggered.push(buff.uid);
               if((buff.castingSpell.spellRank) && (buff.castingSpell.spellRank.criticalEffect))
               {
                  for each (criticalEff in buff.castingSpell.spellRank.criticalEffect)
                  {
                     if(((criticalEff.effectId == 793) || (criticalEff.effectId == 792)) && (int(criticalEff.parameter0) == spellId))
                     {
                        criticalSpellLevel = int(criticalEff.parameter1);
                        break;
                     }
                  }
               }
               if(!triggeredSpells)
               {
                  triggeredSpells = new Vector.<TriggeredSpell>(0);
               }
               triggeredSpells.push(TriggeredSpell.create(DamageUtil.getBuffTriggers(buff),spellId,int(buff.effects.parameter1),criticalSpellLevel,this.targetId,this.targetId));
            }
         }
         return triggeredSpells;
      }
      
      public function addTriggeredSpellsEffects(pTriggeredSpells:Vector.<TriggeredSpell>) : Boolean {
         var damageModifications:* = false;
         var ts:TriggeredSpell = null;
         var effect:EffectInstance = null;
         var triggeredEffect:EffectInstance = null;
         var i:* = 0;
         var efm:EffectModification = null;
         var damagesBonus:* = 0;
         var shieldPoints:* = 0;
         var effectOnCaster:* = false;
         var effectOnTarget:* = false;
         var numEffects:int = this.spellEffects.length;
         var numCriticalEffects:int = this.spellCriticalEffects?this.spellCriticalEffects.length:0;
         for each (ts in pTriggeredSpells)
         {
            damagesBonus = 0;
            shieldPoints = 0;
            i = 0;
            while(i < numEffects)
            {
               effect = this.spellEffects[i];
               if((effect.random == 0) && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,effect,this.isWeapon,ts.triggers)))
               {
                  for each (triggeredEffect in ts.spell.effects)
                  {
                     effectOnCaster = DamageUtil.verifySpellEffectMask(ts.spell.playerId,this.casterId,triggeredEffect,this.casterId);
                     effectOnTarget = DamageUtil.verifySpellEffectMask(ts.spell.playerId,ts.spell.playerId,triggeredEffect,this.casterId);
                     if(DamageUtil.TRIGGERED_EFFECTS_IDS.indexOf(triggeredEffect.effectId) != -1)
                     {
                        if(!this._effectsModifications)
                        {
                           this._effectsModifications = new Vector.<EffectModification>(0);
                        }
                        efm = i + 1 <= this._effectsModifications.length?this._effectsModifications[i]:null;
                        if(!efm)
                        {
                           efm = new EffectModification(effect.effectId);
                           this._effectsModifications.push(efm);
                        }
                        if((Effect.getEffectById(triggeredEffect.effectId).active) && (effectOnCaster))
                        {
                           switch(triggeredEffect.effectId)
                           {
                              case 138:
                                 efm.damagesBonus = efm.damagesBonus + damagesBonus;
                                 damagesBonus = damagesBonus + (triggeredEffect as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        if(effectOnTarget)
                        {
                           switch(triggeredEffect.effectId)
                           {
                              case 1040:
                                 efm.shieldPoints = efm.shieldPoints + shieldPoints;
                                 shieldPoints = shieldPoints + (triggeredEffect as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        damageModifications = true;
                     }
                  }
               }
               i++;
            }
            damagesBonus = 0;
            shieldPoints = 0;
            i = 0;
            while(i < numCriticalEffects)
            {
               effect = this.spellCriticalEffects[i];
               if((effect.random == 0) && (DamageUtil.verifyEffectTrigger(this.casterId,this.targetId,effect,this.isWeapon,ts.triggers)))
               {
                  for each (triggeredEffect in ts.spell.effects)
                  {
                     effectOnCaster = DamageUtil.verifySpellEffectMask(ts.spell.playerId,this.casterId,triggeredEffect,this.casterId);
                     effectOnTarget = DamageUtil.verifySpellEffectMask(ts.spell.playerId,ts.spell.playerId,triggeredEffect,this.casterId);
                     if(DamageUtil.TRIGGERED_EFFECTS_IDS.indexOf(triggeredEffect.effectId) != -1)
                     {
                        if(!this._criticalEffectsModifications)
                        {
                           this._criticalEffectsModifications = new Vector.<EffectModification>(0);
                        }
                        efm = i + 1 <= this._criticalEffectsModifications.length?this._criticalEffectsModifications[i]:null;
                        if(!efm)
                        {
                           efm = new EffectModification(effect.effectId);
                           this._criticalEffectsModifications.push(efm);
                        }
                        if((Effect.getEffectById(triggeredEffect.effectId).active) && (effectOnCaster))
                        {
                           switch(triggeredEffect.effectId)
                           {
                              case 138:
                                 efm.damagesBonus = efm.damagesBonus + damagesBonus;
                                 damagesBonus = damagesBonus + (triggeredEffect as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        if(effectOnTarget)
                        {
                           switch(triggeredEffect.effectId)
                           {
                              case 1040:
                                 efm.shieldPoints = efm.shieldPoints + shieldPoints;
                                 shieldPoints = shieldPoints + (triggeredEffect as EffectInstanceDice).diceNum;
                                 break;
                           }
                        }
                        damageModifications = true;
                     }
                  }
               }
               i++;
            }
         }
         return damageModifications;
      }
      
      public function getDamageSharingTargets() : Vector.<int> {
         var targets:Vector.<int> = null;
         var targetBuff:BasicBuff = null;
         var entityBuff:BasicBuff = null;
         var fightEntities:Vector.<int> = null;
         var entityId:* = 0;
         var buffs:Array = null;
         for each (targetBuff in this.targetBuffs)
         {
            if((targetBuff.actionId == 1061) && (DamageUtil.verifyBuffTriggers(this,targetBuff)))
            {
               targets = new Vector.<int>(0);
               targets.push(this.targetId);
               fightEntities = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntitiesIdsList();
               for each (entityId in fightEntities)
               {
                  if(entityId != this.targetId)
                  {
                     buffs = BuffManager.getInstance().getAllBuff(entityId);
                     for each (entityBuff in buffs)
                     {
                        if(entityBuff.actionId == 1061)
                        {
                           targets.push(entityId);
                           break;
                        }
                     }
                  }
               }
               break;
            }
         }
         return targets;
      }
   }
}
