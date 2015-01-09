package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.logic.game.fight.types.BasicBuff;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.dofus.logic.game.fight.managers.BuffManager;
    import com.ankamagames.dofus.datacenter.spells.SpellBomb;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.datacenter.spells.SpellLevel;
    import com.ankamagames.dofus.datacenter.effects.Effect;
    import com.ankamagames.dofus.logic.game.fight.types.SpellDamageInfo;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightCompanionInformations;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
    import com.ankamagames.jerakine.types.zones.IZone;
    import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
    import com.ankamagames.dofus.logic.game.fight.types.EffectDamage;
    import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
    import com.ankamagames.dofus.network.enums.CharacterSpellModificationTypeEnum;
    import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterSpellModification;
    import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
    import com.ankamagames.dofus.logic.game.fight.types.SplashDamage;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.logic.game.fight.types.StatBuff;
    import com.ankamagames.dofus.logic.game.fight.types.EffectModification;
    import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
    import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
    import com.ankamagames.dofus.network.enums.GameActionMarkTypeEnum;
    import com.ankamagames.dofus.logic.game.fight.types.TriggeredSpell;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import flash.utils.Dictionary;
    import __AS3__.vec.*;

    public class DamageUtil 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DamageUtil));
        private static const exclusiveTargetMasks:RegExp = new RegExp("\\*?[bBeEfFzZKoOPpTWUvV][0-9]*", "g");
        public static const NEUTRAL_ELEMENT:int = 0;
        public static const EARTH_ELEMENT:int = 1;
        public static const FIRE_ELEMENT:int = 2;
        public static const WATER_ELEMENT:int = 3;
        public static const AIR_ELEMENT:int = 4;
        public static const NONE_ELEMENT:int = 5;
        public static const EFFECTSHAPE_DEFAULT_AREA_SIZE:int = 1;
        public static const EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE:int = 0;
        public static const EFFECTSHAPE_DEFAULT_EFFICIENCY:int = 10;
        public static const EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY:int = 4;
        private static const DAMAGE_NOT_BOOSTED:int = 1;
        private static const UNLIMITED_ZONE_SIZE:int = 50;
        public static const DAMAGE_EFFECT_CATEGORY:int = 2;
        public static const EROSION_DAMAGE_EFFECTS_IDS:Array = [1092, 1093, 1094, 1095, 1096];
        public static const HEALING_EFFECTS_IDS:Array = [81, 108, 1109, 90];
        public static const IMMEDIATE_BOOST_EFFECTS_IDS:Array = [266, 268, 269, 271, 414];
        public static const BOMB_SPELLS_IDS:Array = [2796, 2797, 2808];
        public static const SPLASH_EFFECTS_IDS:Array = [1123, 1124, 1125, 1126, 1127, 1128];
        public static const MP_BASED_DAMAGE_EFFECTS_IDS:Array = [1012, 1013, 1014, 1015, 1016];
        public static const HP_BASED_DAMAGE_EFFECTS_IDS:Array = [672, 85, 86, 87, 88, 89];
        public static const TARGET_HP_BASED_DAMAGE_EFFECTS_IDS:Array = [1067, 1068, 1069, 1070, 1071];
        public static const TRIGGERED_EFFECTS_IDS:Array = [138, 1040];
        public static const NO_BOOST_EFFECTS_IDS:Array = [144, 82];


        public static function isDamagedOrHealedBySpell(pCasterId:int, pTargetId:int, pSpell:Object, pSpellImpactCell:int):Boolean
        {
            var affected:Boolean;
            var effi:EffectInstance;
            var targetBuffs:Array;
            var buff:BasicBuff;
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((!(pSpell)) || (!(fef))))
            {
                return (false);
            };
            var targetInfos:GameFightFighterInformations = (fef.getEntityInfos(pTargetId) as GameFightFighterInformations);
            if (!(targetInfos))
            {
                return (false);
            };
            var target:TiphonSprite = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var targetIsCaster:Boolean = (pTargetId == pCasterId);
            var targetIsCarried:Boolean = ((((target) && (target.parentSprite))) && ((target.parentSprite.carriedEntity == target)));
            if (((!((pSpell is SpellWrapper))) || ((pSpell.id == 0))))
            {
                if (((!(targetIsCaster)) && (!(targetIsCarried))))
                {
                    return (true);
                };
                return (false);
            };
            var targetCanBePushed:Boolean = PushUtil.isPushableEntity(targetInfos);
            if (BOMB_SPELLS_IDS.indexOf(pSpell.id) != -1)
            {
                pSpell = getBombDirectDamageSpellWrapper((pSpell as SpellWrapper));
            };
            var casterInfos:GameFightFighterInformations = (fef.getEntityInfos(pCasterId) as GameFightFighterInformations);
            for each (effi in pSpell.effects)
            {
                if ((((((((effi.triggers == "I")) && ((((((effi.category == 2)) || (!((HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1))))) || ((((effi.effectId == 5)) && (targetCanBePushed))))))) && (verifySpellEffectMask(pCasterId, pTargetId, effi)))) && (verifySpellEffectZone(pTargetId, effi, pSpellImpactCell, casterInfos.disposition.cellId))))
                {
                    affected = true;
                    break;
                };
            };
            if (!(affected))
            {
                for each (effi in pSpell.criticalEffect)
                {
                    if ((((((((effi.triggers == "I")) && ((((((effi.category == 2)) || (!((HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1))))) || ((((effi.effectId == 5)) && (targetCanBePushed))))))) && (verifySpellEffectMask(pCasterId, pTargetId, effi)))) && (verifySpellEffectZone(pTargetId, effi, pSpellImpactCell, casterInfos.disposition.cellId))))
                    {
                        affected = true;
                        break;
                    };
                };
            };
            if (!(affected))
            {
                targetBuffs = BuffManager.getInstance().getAllBuff(pTargetId);
                if (targetBuffs)
                {
                    for each (buff in targetBuffs)
                    {
                        if (buff.effects.category == DAMAGE_EFFECT_CATEGORY)
                        {
                            for each (effi in pSpell.effects)
                            {
                                if (verifyEffectTrigger(pCasterId, pTargetId, pSpell.effects, effi, (pSpell is SpellWrapper), buff.effects.triggers, pSpellImpactCell))
                                {
                                    affected = true;
                                    break;
                                };
                            };
                            for each (effi in pSpell.criticalEffect)
                            {
                                if (verifyEffectTrigger(pCasterId, pTargetId, pSpell.criticalEffect, effi, (pSpell is SpellWrapper), buff.effects.triggers, pSpellImpactCell))
                                {
                                    affected = true;
                                    break;
                                };
                            };
                        };
                    };
                };
            };
            return (affected);
        }

        public static function getBombDirectDamageSpellWrapper(pBombSummoningSpell:SpellWrapper):SpellWrapper
        {
            return (SpellWrapper.create(0, SpellBomb.getSpellBombById((pBombSummoningSpell.effects[0] as EffectInstanceDice).diceNum).instantSpellId, pBombSummoningSpell.spellLevel, true, pBombSummoningSpell.playerId));
        }

        public static function getBuffEffectElements(pBuff:BasicBuff):Vector.<int>
        {
            var elements:Vector.<int>;
            var effi:EffectInstance;
            var spellLevel:SpellLevel;
            var effect:Effect = Effect.getEffectById(pBuff.effects.effectId);
            if (effect.elementId == -1)
            {
                spellLevel = pBuff.castingSpell.spellRank;
                if (!(spellLevel))
                {
                    spellLevel = SpellLevel.getLevelById(pBuff.castingSpell.spell.spellLevels[0]);
                };
                for each (effi in spellLevel.effects)
                {
                    if (effi.effectId == pBuff.effects.effectId)
                    {
                        if (!(elements))
                        {
                            elements = new Vector.<int>(0);
                        };
                        if (((!((effi.triggers.indexOf("DA") == -1))) && ((elements.indexOf(AIR_ELEMENT) == -1))))
                        {
                            elements.push(AIR_ELEMENT);
                        };
                        if (((!((effi.triggers.indexOf("DE") == -1))) && ((elements.indexOf(EARTH_ELEMENT) == -1))))
                        {
                            elements.push(EARTH_ELEMENT);
                        };
                        if (((!((effi.triggers.indexOf("DF") == -1))) && ((elements.indexOf(FIRE_ELEMENT) == -1))))
                        {
                            elements.push(FIRE_ELEMENT);
                        };
                        if (((!((effi.triggers.indexOf("DN") == -1))) && ((elements.indexOf(NEUTRAL_ELEMENT) == -1))))
                        {
                            elements.push(NEUTRAL_ELEMENT);
                        };
                        if (((!((effi.triggers.indexOf("DW") == -1))) && ((elements.indexOf(WATER_ELEMENT) == -1))))
                        {
                            elements.push(WATER_ELEMENT);
                        };
                        break;
                    };
                };
            };
            return (elements);
        }

        public static function verifyBuffTriggers(pSpellInfo:SpellDamageInfo, pBuff:BasicBuff):Boolean
        {
            var triggersList:Array;
            var trigger:String;
            var eff:EffectInstance;
            var triggers:String = pBuff.effects.triggers;
            if (triggers)
            {
                triggersList = triggers.split("|");
                for each (trigger in triggersList)
                {
                    for each (eff in pSpellInfo.spellEffects)
                    {
                        if (verifyEffectTrigger(pSpellInfo.casterId, pSpellInfo.targetId, pSpellInfo.spellEffects, eff, pSpellInfo.isWeapon, trigger, pSpellInfo.spellCenterCell))
                        {
                            return (true);
                        };
                    };
                };
            };
            return (false);
        }

        public static function verifyEffectTrigger(pCasterId:int, pTargetId:int, pSpellEffects:Vector.<EffectInstance>, pEffect:EffectInstance, pWeaponEffect:Boolean, pTriggers:String, pSpellImpactCell:int):Boolean
        {
            var trigger:String;
            var verify:Boolean;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (!(fightEntitiesFrame))
            {
                return (false);
            };
            var triggersList:Array = pTriggers.split("|");
            var casterInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations);
            var targetInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations);
            var isTargetAlly:Boolean = (targetInfos.teamId == (fightEntitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations).teamId);
            var distance:uint = MapPoint.fromCellId(casterInfos.disposition.cellId).distanceTo(MapPoint.fromCellId(targetInfos.disposition.cellId));
            for each (trigger in triggersList)
            {
                switch (trigger)
                {
                    case "I":
                        verify = true;
                        break;
                    case "D":
                        verify = (pEffect.category == DAMAGE_EFFECT_CATEGORY);
                        break;
                    case "DA":
                        verify = (((pEffect.category == DAMAGE_EFFECT_CATEGORY)) && ((Effect.getEffectById(pEffect.effectId).elementId == AIR_ELEMENT)));
                        break;
                    case "DBA":
                        verify = isTargetAlly;
                        break;
                    case "DBE":
                        verify = !(isTargetAlly);
                        break;
                    case "DC":
                        verify = pWeaponEffect;
                        break;
                    case "DE":
                        verify = (((pEffect.category == DAMAGE_EFFECT_CATEGORY)) && ((Effect.getEffectById(pEffect.effectId).elementId == EARTH_ELEMENT)));
                        break;
                    case "DF":
                        verify = (((pEffect.category == DAMAGE_EFFECT_CATEGORY)) && ((Effect.getEffectById(pEffect.effectId).elementId == FIRE_ELEMENT)));
                        break;
                    case "DG":
                        break;
                    case "DI":
                        break;
                    case "DM":
                        verify = (distance <= 1);
                        break;
                    case "DN":
                        verify = (((pEffect.category == DAMAGE_EFFECT_CATEGORY)) && ((Effect.getEffectById(pEffect.effectId).elementId == NEUTRAL_ELEMENT)));
                        break;
                    case "DP":
                        break;
                    case "DR":
                        verify = (distance > 1);
                        break;
                    case "Dr":
                        break;
                    case "DS":
                        verify = !(pWeaponEffect);
                        break;
                    case "DTB":
                        break;
                    case "DTE":
                        break;
                    case "DW":
                        verify = (((pEffect.category == DAMAGE_EFFECT_CATEGORY)) && ((Effect.getEffectById(pEffect.effectId).elementId == WATER_ELEMENT)));
                        break;
                    case "MD":
                        verify = PushUtil.hasPushDamages(pCasterId, pTargetId, pSpellEffects, pEffect, pSpellImpactCell);
                        break;
                    case "MDM":
                        break;
                    case "MDP":
                        break;
                    case "A":
                        verify = (pEffect.effectId == 101);
                        break;
                    case "m":
                        verify = (pEffect.effectId == 127);
                        break;
                };
                if (verify)
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function verifySpellEffectMask(pCasterId:int, pTargetId:int, pEffect:EffectInstance, pTriggeringSpellCasterId:int=0):Boolean
        {
            var r:RegExp;
            var targetMaskPattern:String;
            var exclusiveMasks:Array;
            var exclusiveMask:String;
            var exclusiveMaskParam:String;
            var exclusiveMaskCasterOnly:Boolean;
            var verify:Boolean;
            var maskState:int;
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((((((!(pEffect)) || (!(fef)))) || ((pEffect.delay > 0)))) || (!(pEffect.targetMask))))
            {
                return (false);
            };
            var target:TiphonSprite = (DofusEntities.getEntity(pTargetId) as AnimatedCharacter);
            var targetIsCaster:Boolean = (pTargetId == pCasterId);
            var targetIsCarried:Boolean = ((((target) && (target.parentSprite))) && ((target.parentSprite.carriedEntity == target)));
            var targetInfos:GameFightFighterInformations = (fef.getEntityInfos(pTargetId) as GameFightFighterInformations);
            var monsterInfo:GameFightMonsterInformations = (targetInfos as GameFightMonsterInformations);
            var casterStates:Array = FightersStateManager.getInstance().getStates(pCasterId);
            var targetStates:Array = FightersStateManager.getInstance().getStates(pTargetId);
            var isTargetAlly:Boolean = (targetInfos.teamId == (fef.getEntityInfos(pCasterId) as GameFightFighterInformations).teamId);
            if ((((((pCasterId == CurrentPlayedFighterManager.getInstance().currentFighterId)) && ((pEffect.category == 0)))) && ((pEffect.targetMask == "C"))))
            {
                return (true);
            };
            if (targetIsCaster)
            {
                if (pEffect.effectId == 90)
                {
                    return (true);
                };
                if (pEffect.targetMask.indexOf("g") == -1)
                {
                    targetMaskPattern = "caC";
                }
                else
                {
                    return (false);
                };
            }
            else
            {
                if (((((targetIsCarried) && (!((pEffect.zoneShape == SpellShapeEnum.A))))) && (!((pEffect.zoneShape == SpellShapeEnum.a)))))
                {
                    return (false);
                };
                if (((((targetInfos.stats.summoned) && (monsterInfo))) && (!(Monster.getMonsterById(monsterInfo.creatureGenericId).canPlay))))
                {
                    targetMaskPattern = ((isTargetAlly) ? "agsj" : "ASJ");
                }
                else
                {
                    if (targetInfos.stats.summoned)
                    {
                        targetMaskPattern = ((isTargetAlly) ? "agij" : "AIJ");
                    }
                    else
                    {
                        if ((targetInfos is GameFightCompanionInformations))
                        {
                            targetMaskPattern = ((isTargetAlly) ? "agdl" : "ADL");
                        }
                        else
                        {
                            if ((targetInfos is GameFightMonsterInformations))
                            {
                                targetMaskPattern = ((isTargetAlly) ? "agm" : "AM");
                            }
                            else
                            {
                                targetMaskPattern = ((isTargetAlly) ? "gahl" : "AHL");
                            };
                        };
                    };
                };
            };
            r = new RegExp((("[" + targetMaskPattern) + "]"), "g");
            verify = (pEffect.targetMask.match(r).length > 0);
            if (verify)
            {
                exclusiveMasks = pEffect.targetMask.match(exclusiveTargetMasks);
                if (exclusiveMasks.length > 0)
                {
                    verify = false;
                    for each (exclusiveMask in exclusiveMasks)
                    {
                        exclusiveMaskCasterOnly = (exclusiveMask.charAt(0) == "*");
                        exclusiveMask = ((exclusiveMaskCasterOnly) ? exclusiveMask.substr(1, (exclusiveMask.length - 1)) : exclusiveMask);
                        exclusiveMaskParam = (((exclusiveMask.length > 1)) ? exclusiveMask.substr(1, (exclusiveMask.length - 1)) : null);
                        exclusiveMask = exclusiveMask.charAt(0);
                        switch (exclusiveMask)
                        {
                            case "b":
                                break;
                            case "B":
                                break;
                            case "e":
                                maskState = parseInt(exclusiveMaskParam);
                                if (exclusiveMaskCasterOnly)
                                {
                                    verify = ((!(casterStates)) || ((casterStates.indexOf(maskState) == -1)));
                                }
                                else
                                {
                                    verify = ((!(targetStates)) || ((targetStates.indexOf(maskState) == -1)));
                                };
                                break;
                            case "E":
                                maskState = parseInt(exclusiveMaskParam);
                                if (exclusiveMaskCasterOnly)
                                {
                                    verify = ((casterStates) && (!((casterStates.indexOf(maskState) == -1))));
                                }
                                else
                                {
                                    verify = ((targetStates) && (!((targetStates.indexOf(maskState) == -1))));
                                };
                                break;
                            case "f":
                                verify = ((!(monsterInfo)) || (!((monsterInfo.creatureGenericId == parseInt(exclusiveMaskParam)))));
                                break;
                            case "F":
                                verify = ((monsterInfo) && ((monsterInfo.creatureGenericId == parseInt(exclusiveMaskParam))));
                                break;
                            case "z":
                                break;
                            case "Z":
                                break;
                            case "K":
                                break;
                            case "o":
                                break;
                            case "O":
                                verify = ((!((pTriggeringSpellCasterId == 0))) && ((pTargetId == pTriggeringSpellCasterId)));
                                break;
                            case "p":
                                break;
                            case "P":
                                break;
                            case "T":
                                break;
                            case "W":
                                break;
                            case "U":
                                break;
                            case "v":
                                verify = (((targetInfos.stats.lifePoints / targetInfos.stats.maxLifePoints) * 100) > parseInt(exclusiveMaskParam));
                                break;
                            case "V":
                                verify = (((targetInfos.stats.lifePoints / targetInfos.stats.maxLifePoints) * 100) <= parseInt(exclusiveMaskParam));
                                break;
                        };
                        if (!(verify))
                        {
                            return (false);
                        };
                    };
                };
            };
            return (verify);
        }

        public static function verifySpellEffectZone(pTargetId:int, pEffect:EffectInstance, pSpellImpactCell:int, pCasterCell:int):Boolean
        {
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (!(fef))
            {
                return (false);
            };
            var targetInfos:GameFightFighterInformations = (fef.getEntityInfos(pTargetId) as GameFightFighterInformations);
            var effectZone:IZone = SpellZoneManager.getInstance().getZone(pEffect.zoneShape, uint(pEffect.zoneSize), uint(pEffect.zoneMinSize));
            effectZone.direction = MapPoint(MapPoint.fromCellId(pCasterCell)).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell), false);
            var effectZoneCells:Vector.<uint> = effectZone.getCells(pSpellImpactCell);
            return (((effectZoneCells) ? !((effectZoneCells.indexOf(targetInfos.disposition.cellId) == -1)) : false));
        }

        public static function getSpellElementDamage(pSpell:Object, pElementType:int, pCasterId:int=0, pTargetId:int=0):SpellDamage
        {
            var ed:EffectDamage;
            var effi:EffectInstance;
            var effid:EffectInstanceDice;
            var i:int;
            var effectTriggersBuff:Boolean;
            var j:int;
            var sw:SpellWrapper;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (!(fightEntitiesFrame))
            {
                return (null);
            };
            var targetInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations);
            var sd:SpellDamage = new SpellDamage();
            var numEffects:int = pSpell.effects.length;
            var isWeapon:Boolean = ((!((pSpell is SpellWrapper))) || ((pSpell.id == 0)));
            i = 0;
            while (i < numEffects)
            {
                effi = pSpell.effects[i];
                effectTriggersBuff = ((((!((HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) == -1))) && ((effi.targetMask == "C")))) && (!((effi.triggers == "I"))));
                if ((((((((((((effi.category == DAMAGE_EFFECT_CATEGORY)) && (((isWeapon) || ((effi.triggers == "I")))))) && ((HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)))) && ((Effect.getEffectById(effi.effectId).elementId == pElementType)))) && (((((!(effi.targetMask)) || (isWeapon))) || (((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId, pTargetId, effi)))))))) && (!(effectTriggersBuff))))
                {
                    ed = new EffectDamage(effi.effectId, pElementType, effi.random);
                    sd.addEffectDamage(ed);
                    if (EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
                    {
                        effid = (effi as EffectInstanceDice);
                        ed.minErosionPercent = (ed.maxErosionPercent = effid.diceNum);
                    }
                    else
                    {
                        if (!((effi is EffectInstanceDice)))
                        {
                            if ((effi is EffectInstanceInteger))
                            {
                                ed.minDamage = (ed.minDamage + (effi as EffectInstanceInteger).value);
                                ed.maxDamage = (ed.maxDamage + (effi as EffectInstanceInteger).value);
                            }
                            else
                            {
                                if ((effi is EffectInstanceMinMax))
                                {
                                    ed.minDamage = (ed.minDamage + (effi as EffectInstanceMinMax).min);
                                    ed.maxDamage = (ed.maxDamage + (effi as EffectInstanceMinMax).max);
                                };
                            };
                        }
                        else
                        {
                            effid = (effi as EffectInstanceDice);
                            ed.minDamage = (ed.minDamage + effid.diceNum);
                            ed.maxDamage = (ed.maxDamage + (((effid.diceSide == 0)) ? effid.diceNum : effid.diceSide));
                        };
                    };
                };
                i++;
            };
            var numEffectDamages:int = sd.effectDamages.length;
            var numCriticalEffects:int = ((pSpell.criticalEffect) ? pSpell.criticalEffect.length : 0);
            i = 0;
            while (i < numCriticalEffects)
            {
                effi = pSpell.criticalEffect[i];
                effectTriggersBuff = ((((!((HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) == -1))) && ((effi.targetMask == "C")))) && (!((effi.triggers == "I"))));
                if ((((((((((((effi.category == DAMAGE_EFFECT_CATEGORY)) && (((isWeapon) || ((effi.triggers == "I")))))) && ((HEALING_EFFECTS_IDS.indexOf(effi.effectId) == -1)))) && ((Effect.getEffectById(effi.effectId).elementId == pElementType)))) && (((((!(effi.targetMask)) || (isWeapon))) || (((effi.targetMask) && (DamageUtil.verifySpellEffectMask(pCasterId, pTargetId, effi)))))))) && (!(effectTriggersBuff))))
                {
                    if (j < numEffectDamages)
                    {
                        ed = sd.effectDamages[j];
                    }
                    else
                    {
                        ed = new EffectDamage(effi.effectId, pElementType, effi.random);
                        sd.addEffectDamage(ed);
                    };
                    if (EROSION_DAMAGE_EFFECTS_IDS.indexOf(effi.effectId) != -1)
                    {
                        effid = (effi as EffectInstanceDice);
                        ed.minCriticalErosionPercent = (ed.maxCriticalErosionPercent = effid.diceNum);
                    }
                    else
                    {
                        if (!((effi is EffectInstanceDice)))
                        {
                            if ((effi is EffectInstanceInteger))
                            {
                                ed.minCriticalDamage = (ed.minCriticalDamage + (effi as EffectInstanceInteger).value);
                                ed.maxCriticalDamage = (ed.maxCriticalDamage + (effi as EffectInstanceInteger).value);
                            }
                            else
                            {
                                if ((effi is EffectInstanceMinMax))
                                {
                                    ed.minCriticalDamage = (ed.minCriticalDamage + (effi as EffectInstanceMinMax).min);
                                    ed.maxCriticalDamage = (ed.maxCriticalDamage + (effi as EffectInstanceMinMax).max);
                                };
                            };
                        }
                        else
                        {
                            effid = (effi as EffectInstanceDice);
                            ed.minCriticalDamage = (ed.minCriticalDamage + effid.diceNum);
                            ed.maxCriticalDamage = (ed.maxCriticalDamage + (((effid.diceSide == 0)) ? effid.diceNum : effid.diceSide));
                        };
                    };
                    sd.hasCriticalDamage = (ed.hasCritical = true);
                    j++;
                };
                i++;
            };
            if (pCasterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
            {
                sw = (pSpell as SpellWrapper);
                for each (ed in sd.effectDamages)
                {
                    applySpellModificationsOnEffect(ed, sw);
                };
            };
            return (sd);
        }

        public static function applySpellModificationsOnEffect(pEffectDamage:EffectDamage, pSpellW:SpellWrapper):void
        {
            if (!(pSpellW))
            {
                return;
            };
            var baseDamageModif:CharacterSpellModification = CurrentPlayedFighterManager.getInstance().getSpellModifications(pSpellW.id, CharacterSpellModificationTypeEnum.BASE_DAMAGE);
            if (baseDamageModif)
            {
                pEffectDamage.minDamage = (pEffectDamage.minDamage + (((pEffectDamage.minDamage > 0)) ? baseDamageModif.value.contextModif : 0));
                pEffectDamage.maxDamage = (pEffectDamage.maxDamage + (((pEffectDamage.maxDamage > 0)) ? baseDamageModif.value.contextModif : 0));
                if (pEffectDamage.hasCritical)
                {
                    pEffectDamage.minCriticalDamage = (pEffectDamage.minCriticalDamage + (((pEffectDamage.minCriticalDamage > 0)) ? baseDamageModif.value.contextModif : 0));
                    pEffectDamage.maxCriticalDamage = (pEffectDamage.maxCriticalDamage + (((pEffectDamage.maxCriticalDamage > 0)) ? baseDamageModif.value.contextModif : 0));
                };
            };
        }

        public static function getSpellDamage(pSpellDamageInfo:SpellDamageInfo, pWithTargetBuffs:Boolean=true, pWithTargetResists:Boolean=true):SpellDamage
        {
            var finalNeutralDmg:EffectDamage;
            var finalEarthDmg:EffectDamage;
            var finalWaterDmg:EffectDamage;
            var finalAirDmg:EffectDamage;
            var finalFireDmg:EffectDamage;
            var erosion:EffectDamage;
            var splashEffectDamages:Vector.<EffectDamage>;
            var targetHpBasedBuffDamages:Vector.<SpellDamage>;
            var dmgMultiplier:Number;
            var sharedDamageEffect:EffectDamage;
            var pushDamages:EffectDamage;
            var pushedEntity:PushedEntity;
            var pushIndex:uint;
            var hasPushedDamage:Boolean;
            var pushDmg:int;
            var criticalPushDmg:int;
            var splashEffectDmg:EffectDamage;
            var splashDmg:SplashDamage;
            var splashCasterCell:uint;
            var buff:BasicBuff;
            var buffDamage:EffectDamage;
            var buffEffectDamage:EffectDamage;
            var buffSpellDamage:SpellDamage;
            var effid:EffectInstanceDice;
            var finalBuffDmg:EffectDamage;
            var currentCasterLifePoints:int;
            var currentTargetLifePoints:int;
            var targetHpBasedBuffDamage:SpellDamage;
            var finalTargetHpBasedBuffDmg:EffectDamage;
            var minShieldDiff:int;
            var maxShieldDiff:int;
            var minCriticalShieldDiff:int;
            var maxCriticalShieldDiff:int;
            var finalDamage:SpellDamage = new SpellDamage();
            if (pSpellDamageInfo.sharedDamage)
            {
                sharedDamageEffect = computeDamage(pSpellDamageInfo.sharedDamage, pSpellDamageInfo, 1, true);
                finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
                finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
                finalDamage.addEffectDamage(sharedDamageEffect);
                finalDamage.updateDamage();
                return (finalDamage);
            };
            var shapeSize:int = ((!((pSpellDamageInfo.spellShapeSize == null))) ? (int(pSpellDamageInfo.spellShapeSize)) : EFFECTSHAPE_DEFAULT_AREA_SIZE);
            var shapeMinSize:int = ((!((pSpellDamageInfo.spellShapeMinSize == null))) ? (int(pSpellDamageInfo.spellShapeMinSize)) : EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE);
            var shapeEfficiencyPercent:int = ((!((pSpellDamageInfo.spellShapeEfficiencyPercent == null))) ? (int(pSpellDamageInfo.spellShapeEfficiencyPercent)) : EFFECTSHAPE_DEFAULT_EFFICIENCY);
            var shapeMaxEfficiency:int = ((!((pSpellDamageInfo.spellShapeMaxEfficiency == null))) ? (int(pSpellDamageInfo.spellShapeMaxEfficiency)) : EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY);
            var efficiencyMultiplier:Number = getShapeEfficiency(pSpellDamageInfo.spellShape, pSpellDamageInfo.spellCenterCell, pSpellDamageInfo.targetCell, shapeSize, shapeMinSize, shapeEfficiencyPercent, shapeMaxEfficiency);
            efficiencyMultiplier = (efficiencyMultiplier * pSpellDamageInfo.portalsSpellEfficiencyBonus);
            finalNeutralDmg = computeDamage(pSpellDamageInfo.neutralDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
            finalEarthDmg = computeDamage(pSpellDamageInfo.earthDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
            finalWaterDmg = computeDamage(pSpellDamageInfo.waterDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
            finalAirDmg = computeDamage(pSpellDamageInfo.airDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
            finalFireDmg = computeDamage(pSpellDamageInfo.fireDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
            var finalFixedDmg:EffectDamage = computeDamage(pSpellDamageInfo.fixedDamage, pSpellDamageInfo, 1, true, true, true);
            var totalMinErosionDamage:int = ((((finalNeutralDmg.minErosionDamage + finalEarthDmg.minErosionDamage) + finalWaterDmg.minErosionDamage) + finalAirDmg.minErosionDamage) + finalFireDmg.minErosionDamage);
            var totalMaxErosionDamage:int = ((((finalNeutralDmg.maxErosionDamage + finalEarthDmg.maxErosionDamage) + finalWaterDmg.maxErosionDamage) + finalAirDmg.maxErosionDamage) + finalFireDmg.maxErosionDamage);
            var totalMinCriticaErosionDamage:int = ((((finalNeutralDmg.minCriticalErosionDamage + finalEarthDmg.minCriticalErosionDamage) + finalWaterDmg.minCriticalErosionDamage) + finalAirDmg.minCriticalErosionDamage) + finalFireDmg.minCriticalErosionDamage);
            var totalMaxCriticaErosionlDamage:int = ((((finalNeutralDmg.maxCriticalErosionDamage + finalEarthDmg.maxCriticalErosionDamage) + finalWaterDmg.maxCriticalErosionDamage) + finalAirDmg.maxCriticalErosionDamage) + finalFireDmg.maxCriticalErosionDamage);
            var casterIntelligence:int = (((pSpellDamageInfo.casterIntelligence <= 0)) ? 1 : pSpellDamageInfo.casterIntelligence);
            var totalMinLifePointsAdded:int = ((Math.floor(((pSpellDamageInfo.healDamage.minLifePointsAdded * (100 + casterIntelligence)) / 100)) + (((pSpellDamageInfo.healDamage.minLifePointsAdded > 0)) ? pSpellDamageInfo.casterHealBonus : 0)) * efficiencyMultiplier);
            var totalMaxLifePointsAdded:int = ((Math.floor(((pSpellDamageInfo.healDamage.maxLifePointsAdded * (100 + casterIntelligence)) / 100)) + (((pSpellDamageInfo.healDamage.maxLifePointsAdded > 0)) ? pSpellDamageInfo.casterHealBonus : 0)) * efficiencyMultiplier);
            var totalMinCriticalLifePointsAdded:int = ((Math.floor(((pSpellDamageInfo.healDamage.minCriticalLifePointsAdded * (100 + casterIntelligence)) / 100)) + (((pSpellDamageInfo.healDamage.minCriticalLifePointsAdded > 0)) ? pSpellDamageInfo.casterHealBonus : 0)) * efficiencyMultiplier);
            var totalMaxCriticalLifePointsAdded:int = ((Math.floor(((pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded * (100 + casterIntelligence)) / 100)) + (((pSpellDamageInfo.healDamage.maxCriticalLifePointsAdded > 0)) ? pSpellDamageInfo.casterHealBonus : 0)) * efficiencyMultiplier);
            totalMinLifePointsAdded = (totalMinLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent);
            totalMaxLifePointsAdded = (totalMaxLifePointsAdded + pSpellDamageInfo.healDamage.lifePointsAddedBasedOnLifePercent);
            totalMinCriticalLifePointsAdded = (totalMinCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent);
            totalMaxCriticalLifePointsAdded = (totalMaxCriticalLifePointsAdded + pSpellDamageInfo.healDamage.criticalLifePointsAddedBasedOnLifePercent);
            finalDamage.hasHeal = (((((((totalMinLifePointsAdded > 0)) || ((totalMaxLifePointsAdded > 0)))) || ((totalMinCriticalLifePointsAdded > 0)))) || ((totalMaxCriticalLifePointsAdded > 0)));
            var targetLostLifePoints:int = (pSpellDamageInfo.targetInfos.stats.maxLifePoints - pSpellDamageInfo.targetInfos.stats.lifePoints);
            if ((((targetLostLifePoints > 0)) || (pSpellDamageInfo.isHealingSpell)))
            {
                totalMinLifePointsAdded = (((totalMinLifePointsAdded > targetLostLifePoints)) ? targetLostLifePoints : totalMinLifePointsAdded);
                totalMaxLifePointsAdded = (((totalMaxLifePointsAdded > targetLostLifePoints)) ? targetLostLifePoints : totalMaxLifePointsAdded);
                totalMinCriticalLifePointsAdded = (((totalMinCriticalLifePointsAdded > targetLostLifePoints)) ? targetLostLifePoints : totalMinCriticalLifePointsAdded);
                totalMaxCriticalLifePointsAdded = (((totalMaxCriticalLifePointsAdded > targetLostLifePoints)) ? targetLostLifePoints : totalMaxCriticalLifePointsAdded);
            };
            var heal:EffectDamage = new EffectDamage(-1, -1, -1);
            heal.minLifePointsAdded = totalMinLifePointsAdded;
            heal.maxLifePointsAdded = totalMaxLifePointsAdded;
            heal.minCriticalLifePointsAdded = totalMinCriticalLifePointsAdded;
            heal.maxCriticalLifePointsAdded = totalMaxCriticalLifePointsAdded;
            erosion = new EffectDamage(-1, -1, -1);
            erosion.minDamage = totalMinErosionDamage;
            erosion.maxDamage = totalMaxErosionDamage;
            erosion.minCriticalDamage = totalMinCriticaErosionDamage;
            erosion.maxCriticalDamage = totalMaxCriticaErosionlDamage;
            if (((pSpellDamageInfo.pushedEntities) && ((pSpellDamageInfo.pushedEntities.length > 0))))
            {
                pushDamages = new EffectDamage(5, -1, -1);
                for each (pushedEntity in pSpellDamageInfo.pushedEntities)
                {
                    if (pushedEntity.id == pSpellDamageInfo.targetId)
                    {
                        pushedEntity.damage = 0;
                        for each (pushIndex in pushedEntity.pushedIndexes)
                        {
                            pushDmg = (((((pSpellDamageInfo.casterLevel / 2) + (pSpellDamageInfo.casterPushDamageBonus - pSpellDamageInfo.targetPushDamageFixedResist)) + 32) * pushedEntity.force) / (4 * Math.pow(2, pushIndex)));
                            pushedEntity.damage = (pushedEntity.damage + (((pushDmg > 0)) ? pushDmg : 0));
                            criticalPushDmg = (((((pSpellDamageInfo.casterLevel / 2) + (pSpellDamageInfo.casterCriticalPushDamageBonus - pSpellDamageInfo.targetPushDamageFixedResist)) + 32) * pushedEntity.force) / (4 * Math.pow(2, pushIndex)));
                            pushedEntity.criticalDamage = (pushedEntity.criticalDamage + (((criticalPushDmg > 0)) ? criticalPushDmg : 0));
                        };
                        hasPushedDamage = true;
                        break;
                    };
                };
                if (hasPushedDamage)
                {
                    pushDamages.minDamage = (pushDamages.maxDamage = pushedEntity.damage);
                    if (pSpellDamageInfo.spellHasCriticalDamage)
                    {
                        pushDamages.minCriticalDamage = (pushDamages.maxCriticalDamage = pushedEntity.criticalDamage);
                    };
                };
                finalDamage.addEffectDamage(pushDamages);
            };
            if (pSpellDamageInfo.splashDamages)
            {
                splashEffectDamages = new Vector.<EffectDamage>(0);
                for each (splashDmg in pSpellDamageInfo.splashDamages)
                {
                    if (splashDmg.targets.indexOf(pSpellDamageInfo.targetId) != -1)
                    {
                        splashCasterCell = EntitiesManager.getInstance().getEntity(splashDmg.casterId).position.cellId;
                        efficiencyMultiplier = getShapeEfficiency(splashDmg.spellShape, splashCasterCell, pSpellDamageInfo.targetCell, ((!((splashDmg.spellShapeSize == null))) ? int(splashDmg.spellShapeSize) : (EFFECTSHAPE_DEFAULT_AREA_SIZE)), ((!((splashDmg.spellShapeMinSize == null))) ? int(splashDmg.spellShapeMinSize) : (EFFECTSHAPE_DEFAULT_MIN_AREA_SIZE)), ((!((splashDmg.spellShapeEfficiencyPercent == null))) ? int(splashDmg.spellShapeEfficiencyPercent) : (EFFECTSHAPE_DEFAULT_EFFICIENCY)), ((!((splashDmg.spellShapeMaxEfficiency == null))) ? int(splashDmg.spellShapeMaxEfficiency) : EFFECTSHAPE_DEFAULT_MAX_EFFICIENCY_APPLY));
                        splashEffectDmg = computeDamage(splashDmg.damage, pSpellDamageInfo, efficiencyMultiplier, true, !(splashDmg.hasCritical));
                        splashEffectDamages.push(splashEffectDmg);
                        finalDamage.addEffectDamage(splashEffectDmg);
                    };
                };
            };
            var applyDamageMultiplier:Function = function (pMultiplier:Number):void
            {
                var ed:EffectDamage;
                erosion.applyDamageMultiplier(pMultiplier);
                finalNeutralDmg.applyDamageMultiplier(pMultiplier);
                finalEarthDmg.applyDamageMultiplier(pMultiplier);
                finalWaterDmg.applyDamageMultiplier(pMultiplier);
                finalAirDmg.applyDamageMultiplier(pMultiplier);
                finalFireDmg.applyDamageMultiplier(pMultiplier);
                if (splashEffectDamages)
                {
                    for each (ed in splashEffectDamages)
                    {
                        ed.applyDamageMultiplier(pMultiplier);
                    };
                };
            };
            if (pWithTargetBuffs)
            {
                for each (buff in pSpellDamageInfo.targetBuffs)
                {
                    if (((((((!(buff.hasOwnProperty("delay"))) || ((buff["delay"] == 0)))) && (((!((buff is StatBuff))) || (!((buff as StatBuff).statName)))))) && (verifyBuffTriggers(pSpellDamageInfo, buff))))
                    {
                        switch (buff.actionId)
                        {
                            case 1163:
                                (applyDamageMultiplier((buff.param1 / 100)));
                                break;
                            case 1164:
                                erosion.convertDamageToHeal();
                                finalNeutralDmg.convertDamageToHeal();
                                finalEarthDmg.convertDamageToHeal();
                                finalWaterDmg.convertDamageToHeal();
                                finalAirDmg.convertDamageToHeal();
                                finalFireDmg.convertDamageToHeal();
                                pSpellDamageInfo.spellHasCriticalHeal = pSpellDamageInfo.spellHasCriticalDamage;
                                break;
                        };
                        if (((((!((buff.targetId == pSpellDamageInfo.casterId))) && ((buff.effects.category == DAMAGE_EFFECT_CATEGORY)))) && ((HEALING_EFFECTS_IDS.indexOf(buff.effects.effectId) == -1))))
                        {
                            buffSpellDamage = new SpellDamage();
                            buffEffectDamage = new EffectDamage(buff.effects.effectId, Effect.getEffectById(buff.effects.effectId).elementId, -1);
                            if ((buff.effects is EffectInstanceDice))
                            {
                                effid = (buff.effects as EffectInstanceDice);
                                buffEffectDamage.minDamage = (buffEffectDamage.minCriticalDamage = (effid.value + effid.diceNum));
                                buffEffectDamage.maxDamage = (buffEffectDamage.maxCriticalDamage = (effid.value + effid.diceSide));
                            }
                            else
                            {
                                if ((buff.effects is EffectInstanceMinMax))
                                {
                                    buffEffectDamage.minDamage = (buffEffectDamage.minCriticalDamage = (buff.effects as EffectInstanceMinMax).min);
                                    buffEffectDamage.maxDamage = (buffEffectDamage.maxCriticalDamage = (buff.effects as EffectInstanceMinMax).max);
                                }
                                else
                                {
                                    if ((buff.effects is EffectInstanceInteger))
                                    {
                                        buffEffectDamage.minDamage = (buffEffectDamage.minCriticalDamage = (buffEffectDamage.maxDamage = (buffEffectDamage.maxCriticalDamage = (buff.effects as EffectInstanceInteger).value)));
                                    };
                                };
                            };
                            buffSpellDamage.addEffectDamage(buffEffectDamage);
                            if (TARGET_HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(buff.actionId) == -1)
                            {
                                buffDamage = computeDamage(buffSpellDamage, pSpellDamageInfo, 1);
                                finalDamage.addEffectDamage(buffDamage);
                            }
                            else
                            {
                                if (!(targetHpBasedBuffDamages))
                                {
                                    targetHpBasedBuffDamages = new Vector.<SpellDamage>(0);
                                };
                                targetHpBasedBuffDamages.push(buffSpellDamage);
                            };
                        };
                    };
                };
            };
            if (pSpellDamageInfo.casterDamageBoostPercent > 0)
            {
                (applyDamageMultiplier(((100 + pSpellDamageInfo.casterDamageBoostPercent) / 100)));
            };
            if (pSpellDamageInfo.casterDamageDeboostPercent > 0)
            {
                dmgMultiplier = (100 - pSpellDamageInfo.casterDamageDeboostPercent);
                (applyDamageMultiplier((((dmgMultiplier < 0)) ? 0 : (dmgMultiplier / 100))));
            };
            if (pSpellDamageInfo.originalTargetsIds.indexOf(pSpellDamageInfo.targetId) != -1)
            {
                finalDamage.addEffectDamage(heal);
                finalDamage.addEffectDamage(erosion);
                finalDamage.addEffectDamage(finalNeutralDmg);
                finalDamage.addEffectDamage(finalEarthDmg);
                finalDamage.addEffectDamage(finalWaterDmg);
                finalDamage.addEffectDamage(finalAirDmg);
                finalDamage.addEffectDamage(finalFireDmg);
                finalDamage.addEffectDamage(finalFixedDmg);
                if (pSpellDamageInfo.buffDamage)
                {
                    finalDamage.updateDamage();
                    currentCasterLifePoints = ((Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(pSpellDamageInfo.casterId) as GameFightFighterInformations).stats.lifePoints;
                    pSpellDamageInfo.casterLifePointsAfterNormalMinDamage = (currentCasterLifePoints - finalDamage.minDamage);
                    pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage = (currentCasterLifePoints - finalDamage.maxDamage);
                    pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage = (currentCasterLifePoints - finalDamage.minCriticalDamage);
                    pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage = (currentCasterLifePoints - finalDamage.maxCriticalDamage);
                    finalBuffDmg = computeDamage(pSpellDamageInfo.buffDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
                };
                if (finalBuffDmg)
                {
                    finalDamage.addEffectDamage(finalBuffDmg);
                };
                if (targetHpBasedBuffDamages)
                {
                    finalDamage.updateDamage();
                    currentTargetLifePoints = ((Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(pSpellDamageInfo.targetId) as GameFightFighterInformations).stats.lifePoints;
                    pSpellDamageInfo.targetLifePointsAfterNormalMinDamage = ((((currentTargetLifePoints - finalDamage.minDamage) < 0)) ? 0 : (currentTargetLifePoints - finalDamage.minDamage));
                    pSpellDamageInfo.targetLifePointsAfterNormalMaxDamage = ((((currentTargetLifePoints - finalDamage.maxDamage) < 0)) ? 0 : (currentTargetLifePoints - finalDamage.maxDamage));
                    pSpellDamageInfo.targetLifePointsAfterCriticalMinDamage = ((((currentTargetLifePoints - finalDamage.minCriticalDamage) < 0)) ? 0 : (currentTargetLifePoints - finalDamage.minCriticalDamage));
                    pSpellDamageInfo.targetLifePointsAfterCriticalMaxDamage = ((((currentTargetLifePoints - finalDamage.maxCriticalDamage) < 0)) ? 0 : (currentTargetLifePoints - finalDamage.maxCriticalDamage));
                    for each (targetHpBasedBuffDamage in targetHpBasedBuffDamages)
                    {
                        finalTargetHpBasedBuffDmg = computeDamage(targetHpBasedBuffDamage, pSpellDamageInfo, efficiencyMultiplier, false, !(pWithTargetResists), !(pWithTargetResists));
                        finalDamage.addEffectDamage(finalTargetHpBasedBuffDmg);
                    };
                };
            };
            finalDamage.hasCriticalDamage = pSpellDamageInfo.spellHasCriticalDamage;
            finalDamage.updateDamage();
            pSpellDamageInfo.targetShieldPoints = (pSpellDamageInfo.targetShieldPoints + pSpellDamageInfo.targetTriggeredShieldPoints);
            if (pSpellDamageInfo.targetShieldPoints > 0)
            {
                minShieldDiff = (finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints);
                if (minShieldDiff < 0)
                {
                    finalDamage.minShieldPointsRemoved = finalDamage.minDamage;
                    finalDamage.minDamage = 0;
                }
                else
                {
                    finalDamage.minDamage = (finalDamage.minDamage - pSpellDamageInfo.targetShieldPoints);
                    finalDamage.minShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
                };
                maxShieldDiff = (finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints);
                if (maxShieldDiff < 0)
                {
                    finalDamage.maxShieldPointsRemoved = finalDamage.maxDamage;
                    finalDamage.maxDamage = 0;
                }
                else
                {
                    finalDamage.maxDamage = (finalDamage.maxDamage - pSpellDamageInfo.targetShieldPoints);
                    finalDamage.maxShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
                };
                minCriticalShieldDiff = (finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints);
                if (minCriticalShieldDiff < 0)
                {
                    finalDamage.minCriticalShieldPointsRemoved = finalDamage.minCriticalDamage;
                    finalDamage.minCriticalDamage = 0;
                }
                else
                {
                    finalDamage.minCriticalDamage = (finalDamage.minCriticalDamage - pSpellDamageInfo.targetShieldPoints);
                    finalDamage.minCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
                };
                maxCriticalShieldDiff = (finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints);
                if (maxCriticalShieldDiff < 0)
                {
                    finalDamage.maxCriticalShieldPointsRemoved = finalDamage.maxCriticalDamage;
                    finalDamage.maxCriticalDamage = 0;
                }
                else
                {
                    finalDamage.maxCriticalDamage = (finalDamage.maxCriticalDamage - pSpellDamageInfo.targetShieldPoints);
                    finalDamage.maxCriticalShieldPointsRemoved = pSpellDamageInfo.targetShieldPoints;
                };
                if (pSpellDamageInfo.spellHasCriticalDamage)
                {
                    finalDamage.hasCriticalShieldPointsRemoved = true;
                };
            };
            if (((pSpellDamageInfo.casterStates) && (!((pSpellDamageInfo.casterStates.indexOf(218) == -1)))))
            {
                finalDamage.minDamage = (finalDamage.maxDamage = (finalDamage.minCriticalDamage = (finalDamage.maxCriticalDamage = 0)));
            };
            finalDamage.hasCriticalLifePointsAdded = pSpellDamageInfo.spellHasCriticalHeal;
            finalDamage.invulnerableState = pSpellDamageInfo.targetIsInvulnerable;
            finalDamage.unhealableState = pSpellDamageInfo.targetIsUnhealable;
            finalDamage.isHealingSpell = pSpellDamageInfo.isHealingSpell;
            return (finalDamage);
        }

        private static function computeDamage(pRawDamage:SpellDamage, pSpellDamageInfo:SpellDamageInfo, pEfficiencyMultiplier:Number, pIgnoreCasterStats:Boolean=false, pIgnoreCriticalResist:Boolean=false, pIgnoreTargetResists:Boolean=false):EffectDamage
        {
            var stat:int;
            var statBonus:int;
            var criticalStatBonus:int;
            var resistPercent:int;
            var efficiencyPercent:int;
            var elementReduction:int;
            var elementBonus:int;
            var efm:EffectModification;
            var triggeredDamagesBonus:int;
            var ed:EffectDamage;
            var totalMinBaseDmg:int;
            var totalMinCriticalBaseDmg:int;
            var totalMaxBaseDmg:int;
            var totalMaxCriticalBaseDmg:int;
            var minBaseDmg:int;
            var minCriticalBaseDmg:int;
            var maxBaseDmg:int;
            var maxCriticalBaseDmg:int;
            var i:int;
            var elementStat:int;
            var spellModifBonus:int;
            var _local_47:int;
            var _local_48:int;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (!(fightEntitiesFrame))
            {
                return (null);
            };
            var allDamagesBonus:int = pSpellDamageInfo.casterAllDamagesBonus;
            var casterCriticalDamageBonus:int = pSpellDamageInfo.casterCriticalDamageBonus;
            var targetCriticalDamageFixedResist:int = pSpellDamageInfo.targetCriticalDamageFixedResist;
            var effectId:int = -1;
            var casterInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pSpellDamageInfo.casterId) as GameFightFighterInformations);
            var casterMovementPointsRatio:Number = (casterInfos.stats.movementPoints / casterInfos.stats.maxMovementPoints);
            var lifePointsMin:uint = (((pSpellDamageInfo.casterLifePointsAfterNormalMinDamage > 0)) ? pSpellDamageInfo.casterLifePointsAfterNormalMinDamage : casterInfos.stats.lifePoints);
            var lifePointsMax:uint = (((pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage > 0)) ? pSpellDamageInfo.casterLifePointsAfterNormalMaxDamage : casterInfos.stats.lifePoints);
            var criticalLifePointsMin:uint = (((pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage > 0)) ? pSpellDamageInfo.casterLifePointsAfterCriticalMinDamage : casterInfos.stats.lifePoints);
            var criticalLifePointsMax:uint = (((pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage > 0)) ? pSpellDamageInfo.casterLifePointsAfterCriticalMaxDamage : casterInfos.stats.lifePoints);
            var targetLifePointsMin:uint = (((pSpellDamageInfo.targetLifePointsAfterNormalMinDamage > 0)) ? pSpellDamageInfo.targetLifePointsAfterNormalMinDamage : pSpellDamageInfo.targetInfos.stats.lifePoints);
            var targetLifePointsMax:uint = (((pSpellDamageInfo.targetLifePointsAfterNormalMaxDamage > 0)) ? pSpellDamageInfo.targetLifePointsAfterNormalMaxDamage : pSpellDamageInfo.targetInfos.stats.lifePoints);
            var targetCriticalLifePointsMin:uint = (((pSpellDamageInfo.targetLifePointsAfterCriticalMinDamage > 0)) ? pSpellDamageInfo.targetLifePointsAfterCriticalMinDamage : pSpellDamageInfo.targetInfos.stats.lifePoints);
            var targetCriticalLifePointsMax:uint = (((pSpellDamageInfo.targetLifePointsAfterCriticalMaxDamage > 0)) ? pSpellDamageInfo.targetLifePointsAfterCriticalMaxDamage : pSpellDamageInfo.targetInfos.stats.lifePoints);
            var isSharedDamage:Boolean = (pRawDamage == pSpellDamageInfo.sharedDamage);
            var damageSharingMultiplicator:Number = 1;
            if (isSharedDamage)
            {
                targetCriticalDamageFixedResist = getAverageStat("criticalDamageFixedResist", pSpellDamageInfo.damageSharingTargets);
                damageSharingMultiplicator = (1 / pSpellDamageInfo.damageSharingTargets.length);
            };
            var numEffectsDamages:int = pRawDamage.effectDamages.length;
            i = 0;
            while (i < numEffectsDamages)
            {
                ed = pRawDamage.effectDamages[i];
                effectId = ed.effectId;
                resistPercent = 0;
                if (NO_BOOST_EFFECTS_IDS.indexOf(ed.effectId) != -1)
                {
                    pIgnoreCasterStats = true;
                };
                efm = pSpellDamageInfo.getEffectModification(ed.effectId, i, ed.hasCritical);
                if (efm)
                {
                    triggeredDamagesBonus = efm.damagesBonus;
                    if (efm.shieldPoints > pSpellDamageInfo.targetTriggeredShieldPoints)
                    {
                        pSpellDamageInfo.targetTriggeredShieldPoints = efm.shieldPoints;
                    };
                };
                if (isSharedDamage)
                {
                    resistPercent = getAverageElementResistance(ed.element, pSpellDamageInfo.damageSharingTargets);
                    elementReduction = getAverageElementReduction(ed.element, pSpellDamageInfo.damageSharingTargets);
                    elementReduction = (elementReduction + getAverageBuffElementReduction(pSpellDamageInfo, ed, pSpellDamageInfo.damageSharingTargets));
                }
                else
                {
                    switch (ed.element)
                    {
                        case NEUTRAL_ELEMENT:
                            if (!(pIgnoreCasterStats))
                            {
                                elementStat = (((pSpellDamageInfo.casterStrength > 0)) ? pSpellDamageInfo.casterStrength : 0);
                                stat = (((elementStat + pSpellDamageInfo.casterDamagesBonus) + triggeredDamagesBonus) + ((pSpellDamageInfo.isWeapon) ? pSpellDamageInfo.casterWeaponDamagesBonus : pSpellDamageInfo.casterSpellDamagesBonus));
                                statBonus = pSpellDamageInfo.casterStrengthBonus;
                                criticalStatBonus = pSpellDamageInfo.casterCriticalStrengthBonus;
                            };
                            if (!(pIgnoreTargetResists))
                            {
                                resistPercent = pSpellDamageInfo.targetNeutralElementResistPercent;
                                elementReduction = pSpellDamageInfo.targetNeutralElementReduction;
                            };
                            elementBonus = pSpellDamageInfo.casterNeutralDamageBonus;
                            break;
                        case EARTH_ELEMENT:
                            if (!(pIgnoreCasterStats))
                            {
                                elementStat = (((pSpellDamageInfo.casterStrength > 0)) ? pSpellDamageInfo.casterStrength : 0);
                                stat = (((elementStat + pSpellDamageInfo.casterDamagesBonus) + triggeredDamagesBonus) + ((pSpellDamageInfo.isWeapon) ? pSpellDamageInfo.casterWeaponDamagesBonus : pSpellDamageInfo.casterSpellDamagesBonus));
                                statBonus = pSpellDamageInfo.casterStrengthBonus;
                                criticalStatBonus = pSpellDamageInfo.casterCriticalStrengthBonus;
                            };
                            if (!(pIgnoreTargetResists))
                            {
                                resistPercent = pSpellDamageInfo.targetEarthElementResistPercent;
                                elementReduction = pSpellDamageInfo.targetEarthElementReduction;
                            };
                            elementBonus = pSpellDamageInfo.casterEarthDamageBonus;
                            break;
                        case FIRE_ELEMENT:
                            if (!(pIgnoreCasterStats))
                            {
                                elementStat = (((pSpellDamageInfo.casterIntelligence > 0)) ? pSpellDamageInfo.casterIntelligence : 0);
                                stat = (((elementStat + pSpellDamageInfo.casterDamagesBonus) + triggeredDamagesBonus) + ((pSpellDamageInfo.isWeapon) ? pSpellDamageInfo.casterWeaponDamagesBonus : pSpellDamageInfo.casterSpellDamagesBonus));
                                statBonus = pSpellDamageInfo.casterIntelligenceBonus;
                                criticalStatBonus = pSpellDamageInfo.casterCriticalIntelligenceBonus;
                            };
                            if (!(pIgnoreTargetResists))
                            {
                                resistPercent = pSpellDamageInfo.targetFireElementResistPercent;
                                elementReduction = pSpellDamageInfo.targetFireElementReduction;
                            };
                            elementBonus = pSpellDamageInfo.casterFireDamageBonus;
                            break;
                        case WATER_ELEMENT:
                            if (!(pIgnoreCasterStats))
                            {
                                elementStat = (((pSpellDamageInfo.casterChance > 0)) ? pSpellDamageInfo.casterChance : 0);
                                stat = (((elementStat + pSpellDamageInfo.casterDamagesBonus) + triggeredDamagesBonus) + ((pSpellDamageInfo.isWeapon) ? pSpellDamageInfo.casterWeaponDamagesBonus : pSpellDamageInfo.casterSpellDamagesBonus));
                                statBonus = pSpellDamageInfo.casterChanceBonus;
                                criticalStatBonus = pSpellDamageInfo.casterCriticalChanceBonus;
                            };
                            if (!(pIgnoreTargetResists))
                            {
                                resistPercent = pSpellDamageInfo.targetWaterElementResistPercent;
                                elementReduction = pSpellDamageInfo.targetWaterElementReduction;
                            };
                            elementBonus = pSpellDamageInfo.casterWaterDamageBonus;
                            break;
                        case AIR_ELEMENT:
                            if (!(pIgnoreCasterStats))
                            {
                                elementStat = (((pSpellDamageInfo.casterAgility > 0)) ? pSpellDamageInfo.casterAgility : 0);
                                stat = (((elementStat + pSpellDamageInfo.casterDamagesBonus) + triggeredDamagesBonus) + ((pSpellDamageInfo.isWeapon) ? pSpellDamageInfo.casterWeaponDamagesBonus : pSpellDamageInfo.casterSpellDamagesBonus));
                                statBonus = pSpellDamageInfo.casterAgilityBonus;
                                criticalStatBonus = pSpellDamageInfo.casterCriticalAgilityBonus;
                            };
                            if (!(pIgnoreTargetResists))
                            {
                                resistPercent = pSpellDamageInfo.targetAirElementResistPercent;
                                elementReduction = pSpellDamageInfo.targetAirElementReduction;
                            };
                            elementBonus = pSpellDamageInfo.casterAirDamageBonus;
                            break;
                    };
                    if (!(pIgnoreTargetResists))
                    {
                        elementReduction = (elementReduction + getBuffElementReduction(pSpellDamageInfo, ed, pSpellDamageInfo.targetId));
                    };
                };
                resistPercent = (100 - resistPercent);
                efficiencyPercent = (((isNaN(ed.efficiencyMultiplier)) ? pEfficiencyMultiplier : ed.efficiencyMultiplier) * 100);
                if ((((HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) == -1)) && ((TARGET_HP_BASED_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) == -1))))
                {
                    if (pIgnoreCasterStats)
                    {
                        casterCriticalDamageBonus = 0;
                        allDamagesBonus = casterCriticalDamageBonus;
                        elementBonus = allDamagesBonus;
                    };
                    if (pIgnoreCriticalResist)
                    {
                        targetCriticalDamageFixedResist = 0;
                    };
                    spellModifBonus = ((pSpellDamageInfo.spellDamageModification) ? pSpellDamageInfo.spellDamageModification.value.objectsAndMountBonus : 0);
                    minBaseDmg = getDamage(ed.minDamage, pIgnoreCasterStats, stat, statBonus, elementBonus, allDamagesBonus, spellModifBonus, elementReduction, resistPercent, efficiencyPercent, damageSharingMultiplicator);
                    minCriticalBaseDmg = getDamage(((!((pSpellDamageInfo.spellWeaponCriticalBonus == 0))) ? (((ed.minDamage > 0)) ? (ed.minDamage + pSpellDamageInfo.spellWeaponCriticalBonus) : 0) : ed.minCriticalDamage), pIgnoreCasterStats, stat, criticalStatBonus, (elementBonus + casterCriticalDamageBonus), allDamagesBonus, spellModifBonus, (elementReduction + targetCriticalDamageFixedResist), resistPercent, efficiencyPercent, damageSharingMultiplicator);
                    maxBaseDmg = getDamage(ed.maxDamage, pIgnoreCasterStats, stat, statBonus, elementBonus, allDamagesBonus, spellModifBonus, elementReduction, resistPercent, efficiencyPercent, damageSharingMultiplicator);
                    maxCriticalBaseDmg = getDamage(((!((pSpellDamageInfo.spellWeaponCriticalBonus == 0))) ? (((ed.maxDamage > 0)) ? (ed.maxDamage + pSpellDamageInfo.spellWeaponCriticalBonus) : 0) : ed.maxCriticalDamage), pIgnoreCasterStats, stat, criticalStatBonus, (elementBonus + casterCriticalDamageBonus), allDamagesBonus, spellModifBonus, (elementReduction + targetCriticalDamageFixedResist), resistPercent, efficiencyPercent, damageSharingMultiplicator);
                }
                else
                {
                    switch (ed.effectId)
                    {
                        case 672:
                            _local_47 = (((((ed.maxDamage * casterInfos.stats.baseMaxLifePoints) * getMidLifeDamageMultiplier(Math.min(100, Math.max(0, ((100 * casterInfos.stats.lifePoints) / casterInfos.stats.maxLifePoints))))) / 100) * efficiencyPercent) / 100);
                            maxBaseDmg = (((_local_47 - elementReduction) * resistPercent) / 100);
                            minBaseDmg = maxBaseDmg;
                            _local_48 = (((((ed.maxCriticalDamage * casterInfos.stats.baseMaxLifePoints) * getMidLifeDamageMultiplier(Math.min(100, Math.max(0, ((100 * casterInfos.stats.lifePoints) / casterInfos.stats.maxLifePoints))))) / 100) * efficiencyPercent) / 100);
                            maxCriticalBaseDmg = (((_local_48 - elementReduction) * resistPercent) / 100);
                            minCriticalBaseDmg = maxCriticalBaseDmg;
                            break;
                        case 85:
                        case 86:
                        case 87:
                        case 88:
                        case 89:
                            _local_47 = ((((ed.minDamage * lifePointsMin) / 100) * efficiencyPercent) / 100);
                            minBaseDmg = (((_local_47 - elementReduction) * resistPercent) / 100);
                            _local_47 = ((((ed.maxDamage * lifePointsMax) / 100) * efficiencyPercent) / 100);
                            maxBaseDmg = (((_local_47 - elementReduction) * resistPercent) / 100);
                            _local_48 = ((((ed.minCriticalDamage * criticalLifePointsMin) / 100) * efficiencyPercent) / 100);
                            minCriticalBaseDmg = (((_local_48 - elementReduction) * resistPercent) / 100);
                            _local_48 = ((((ed.maxCriticalDamage * criticalLifePointsMax) / 100) * efficiencyPercent) / 100);
                            maxCriticalBaseDmg = (((_local_48 - elementReduction) * resistPercent) / 100);
                            lifePointsMin = (lifePointsMin - minBaseDmg);
                            lifePointsMax = (lifePointsMax - maxBaseDmg);
                            criticalLifePointsMin = (criticalLifePointsMin - minCriticalBaseDmg);
                            criticalLifePointsMax = (criticalLifePointsMax - maxCriticalBaseDmg);
                            break;
                        case 1067:
                        case 1068:
                        case 1069:
                        case 1070:
                        case 1071:
                            _local_47 = ((((ed.minDamage * targetLifePointsMin) / 100) * efficiencyPercent) / 100);
                            minBaseDmg = (((_local_47 - elementReduction) * resistPercent) / 100);
                            _local_47 = ((((ed.maxDamage * targetLifePointsMax) / 100) * efficiencyPercent) / 100);
                            maxBaseDmg = (((_local_47 - elementReduction) * resistPercent) / 100);
                            _local_48 = ((((ed.minCriticalDamage * targetCriticalLifePointsMin) / 100) * efficiencyPercent) / 100);
                            minCriticalBaseDmg = (((_local_48 - elementReduction) * resistPercent) / 100);
                            _local_48 = ((((ed.maxCriticalDamage * targetCriticalLifePointsMax) / 100) * efficiencyPercent) / 100);
                            maxCriticalBaseDmg = (((_local_48 - elementReduction) * resistPercent) / 100);
                            targetLifePointsMin = (targetLifePointsMin - minBaseDmg);
                            targetLifePointsMax = (targetLifePointsMax - maxBaseDmg);
                            targetCriticalLifePointsMin = (targetCriticalLifePointsMin - minCriticalBaseDmg);
                            targetCriticalLifePointsMax = (targetCriticalLifePointsMax - maxCriticalBaseDmg);
                            break;
                    };
                };
                minBaseDmg = (((minBaseDmg < 0)) ? 0 : minBaseDmg);
                maxBaseDmg = (((maxBaseDmg < 0)) ? 0 : maxBaseDmg);
                minCriticalBaseDmg = (((minCriticalBaseDmg < 0)) ? 0 : minCriticalBaseDmg);
                maxCriticalBaseDmg = (((maxCriticalBaseDmg < 0)) ? 0 : maxCriticalBaseDmg);
                if (MP_BASED_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) != -1)
                {
                    minBaseDmg = (minBaseDmg * casterMovementPointsRatio);
                    maxBaseDmg = (maxBaseDmg * casterMovementPointsRatio);
                    minCriticalBaseDmg = (minCriticalBaseDmg * casterMovementPointsRatio);
                    maxCriticalBaseDmg = (maxCriticalBaseDmg * casterMovementPointsRatio);
                };
                if (DamageUtil.EROSION_DAMAGE_EFFECTS_IDS.indexOf(ed.effectId) != -1)
                {
                    ed.minErosionDamage = (ed.minErosionDamage + (((pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMinErosionLifePoints) * ed.minErosionPercent) / 100));
                    ed.maxErosionDamage = (ed.maxErosionDamage + (((pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMaxErosionLifePoints) * ed.maxErosionPercent) / 100));
                    if (ed.hasCritical)
                    {
                        ed.minCriticalErosionDamage = (ed.minCriticalErosionDamage + (((pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints) * ed.minCriticalErosionPercent) / 100));
                        ed.maxCriticalErosionDamage = (ed.maxCriticalErosionDamage + (((pSpellDamageInfo.targetErosionLifePoints + pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints) * ed.maxCriticalErosionPercent) / 100));
                    };
                }
                else
                {
                    pSpellDamageInfo.targetSpellMinErosionLifePoints = (pSpellDamageInfo.targetSpellMinErosionLifePoints + ((minBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus)) / 100));
                    pSpellDamageInfo.targetSpellMaxErosionLifePoints = (pSpellDamageInfo.targetSpellMaxErosionLifePoints + ((maxBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus)) / 100));
                    pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints = (pSpellDamageInfo.targetSpellMinCriticalErosionLifePoints + ((minCriticalBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus)) / 100));
                    pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints = (pSpellDamageInfo.targetSpellMaxCriticalErosionLifePoints + ((maxCriticalBaseDmg * (10 + pSpellDamageInfo.targetErosionPercentBonus)) / 100));
                };
                totalMinBaseDmg = (totalMinBaseDmg + minBaseDmg);
                totalMaxBaseDmg = (totalMaxBaseDmg + maxBaseDmg);
                totalMinCriticalBaseDmg = (totalMinCriticalBaseDmg + minCriticalBaseDmg);
                totalMaxCriticalBaseDmg = (totalMaxCriticalBaseDmg + maxCriticalBaseDmg);
                i++;
            };
            var finalDamage:EffectDamage = new EffectDamage(effectId, pRawDamage.element, pRawDamage.random);
            finalDamage.minDamage = totalMinBaseDmg;
            finalDamage.maxDamage = totalMaxBaseDmg;
            finalDamage.minCriticalDamage = totalMinCriticalBaseDmg;
            finalDamage.maxCriticalDamage = totalMaxCriticalBaseDmg;
            finalDamage.minErosionDamage = ((pRawDamage.minErosionDamage * efficiencyPercent) / 100);
            finalDamage.minErosionDamage = ((finalDamage.minErosionDamage * resistPercent) / 100);
            finalDamage.maxErosionDamage = ((pRawDamage.maxErosionDamage * efficiencyPercent) / 100);
            finalDamage.maxErosionDamage = ((finalDamage.maxErosionDamage * resistPercent) / 100);
            finalDamage.minCriticalErosionDamage = ((pRawDamage.minCriticalErosionDamage * efficiencyPercent) / 100);
            finalDamage.minCriticalErosionDamage = ((finalDamage.minCriticalErosionDamage * resistPercent) / 100);
            finalDamage.maxCriticalErosionDamage = ((pRawDamage.maxCriticalErosionDamage * efficiencyPercent) / 100);
            finalDamage.maxCriticalErosionDamage = ((finalDamage.maxCriticalErosionDamage * resistPercent) / 100);
            finalDamage.hasCritical = pRawDamage.hasCriticalDamage;
            return (finalDamage);
        }

        private static function getDamage(pBaseDmg:int, pIgnoreStats:Boolean, pStat:int, pStatBonus:int, pDamageBonus:int, pAllDamagesBonus:int, pSpellModifBonus:int, pDamageReduction:int, pResistPercent:int, pEfficiencyPercent:int, pDamageSharingMultiplicator:Number=1):int
        {
            if (((!(pIgnoreStats)) && (((pStat + pStatBonus) <= 0))))
            {
                pStat = 1;
                pStatBonus = 0;
            };
            var dmg:int = (((pBaseDmg > 0)) ? ((Math.floor(((pBaseDmg * ((100 + pStat) + pStatBonus)) / 100)) + pDamageBonus) + pAllDamagesBonus) : 0);
            var dmgWithEfficiency:int = (((dmg > 0)) ? (((dmg + pSpellModifBonus) * pEfficiencyPercent) / 100) : 0);
            var dmgWithDamageReduction:int = (((dmgWithEfficiency > 0)) ? (dmgWithEfficiency - pDamageReduction) : 0);
            dmgWithDamageReduction = (((dmgWithDamageReduction < 0)) ? 0 : dmgWithDamageReduction);
            return ((((dmgWithDamageReduction * pResistPercent) / 100) * pDamageSharingMultiplicator));
        }

        private static function getMidLifeDamageMultiplier(pLifePercent:int):Number
        {
            return ((Math.pow((Math.cos(((2 * Math.PI) * ((pLifePercent * 0.01) - 0.5))) + 1), 2) / 4));
        }

        private static function getDistance(pCellA:uint, pCellB:uint):int
        {
            return (MapPoint.fromCellId(pCellA).distanceToCell(MapPoint.fromCellId(pCellB)));
        }

        private static function getSquareDistance(pCellA:uint, pCellB:uint):int
        {
            var pt1:MapPoint = MapPoint.fromCellId(pCellA);
            var pt2:MapPoint = MapPoint.fromCellId(pCellB);
            return (Math.max(Math.abs((pt1.x - pt2.x)), Math.abs((pt1.y - pt2.y))));
        }

        public static function getShapeEfficiency(pShape:uint, pSpellImpactCell:uint, pTargetCell:uint, pShapeSize:int, pShapeMinSize:int, pShapeEfficiencyPercent:int, pShapeMaxEfficiency:int):Number
        {
            var distance:int;
            switch (pShape)
            {
                case SpellShapeEnum.A:
                case SpellShapeEnum.a:
                case SpellShapeEnum.Z:
                case SpellShapeEnum.I:
                case SpellShapeEnum.O:
                case SpellShapeEnum.semicolon:
                case SpellShapeEnum.empty:
                case SpellShapeEnum.P:
                    return (DAMAGE_NOT_BOOSTED);
                case SpellShapeEnum.B:
                case SpellShapeEnum.V:
                case SpellShapeEnum.G:
                case SpellShapeEnum.W:
                    distance = getSquareDistance(pSpellImpactCell, pTargetCell);
                    break;
                case SpellShapeEnum.minus:
                case SpellShapeEnum.plus:
                case SpellShapeEnum.U:
                    distance = (getDistance(pSpellImpactCell, pTargetCell) / 2);
                    break;
                default:
                    distance = getDistance(pSpellImpactCell, pTargetCell);
            };
            return (getSimpleEfficiency(distance, pShapeSize, pShapeMinSize, pShapeEfficiencyPercent, pShapeMaxEfficiency));
        }

        public static function getSimpleEfficiency(pDistance:int, pShapeSize:int, pShapeMinSize:int, pShapeEfficiencyPercent:int, pShapeMaxEfficiency:int):Number
        {
            if (pShapeEfficiencyPercent == 0)
            {
                return (DAMAGE_NOT_BOOSTED);
            };
            if ((((pShapeSize <= 0)) || ((pShapeSize >= UNLIMITED_ZONE_SIZE))))
            {
                return (DAMAGE_NOT_BOOSTED);
            };
            if (pDistance > pShapeSize)
            {
                return (DAMAGE_NOT_BOOSTED);
            };
            if (pShapeEfficiencyPercent <= 0)
            {
                return (DAMAGE_NOT_BOOSTED);
            };
            if (pShapeMinSize != 0)
            {
                if (pDistance <= pShapeMinSize)
                {
                    return (DAMAGE_NOT_BOOSTED);
                };
                return (Math.max(0, (DAMAGE_NOT_BOOSTED - ((0.01 * Math.min((pDistance - pShapeMinSize), pShapeMaxEfficiency)) * pShapeEfficiencyPercent))));
            };
            return (Math.max(0, (DAMAGE_NOT_BOOSTED - ((0.01 * Math.min(pDistance, pShapeMaxEfficiency)) * pShapeEfficiencyPercent))));
        }

        public static function getPortalsSpellEfficiencyBonus(pSpellImpactCell:int, pTeamId:uint):Number
        {
            var portal:MarkInstance;
            var previousPortal:MarkInstance;
            var usingPortals:Boolean;
            var bonus:int;
            var dist:int;
            var bonusCoeff:Number = 1;
            var portals:Vector.<MarkInstance> = MarkedCellsManager.getInstance().getMarks(GameActionMarkTypeEnum.PORTAL, pTeamId);
            if (portals.length > 1)
            {
                for each (portal in portals)
                {
                    if (portal.cells[0] == pSpellImpactCell)
                    {
                        usingPortals = true;
                    };
                    bonus = Math.max(bonus, int(portal.associatedSpellLevel.effects[0].parameter2));
                    if (previousPortal)
                    {
                        dist = (dist + MapPoint.fromCellId(portal.cells[0]).distanceToCell(MapPoint.fromCellId(previousPortal.cells[0])));
                    };
                    previousPortal = portal;
                };
                if (usingPortals)
                {
                    bonusCoeff = (1 + ((bonus + (portals.length * dist)) / 100));
                };
            };
            return (bonusCoeff);
        }

        public static function getSplashDamages(pTriggeredSpells:Vector.<TriggeredSpell>, pSourceSpellInfo:SpellDamageInfo):Vector.<SplashDamage>
        {
            var splashDamages:Vector.<SplashDamage>;
            var ts:TriggeredSpell;
            var sw:SpellWrapper;
            var effi:EffectInstance;
            var spellZone:IZone;
            var spellZoneCells:Vector.<uint>;
            var cell:uint;
            var splashTargetsIds:Vector.<int>;
            var sourceSpellDamage:SpellDamage;
            var cellEntities:Array;
            var cellEntity:IEntity;
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            for each (ts in pTriggeredSpells)
            {
                sw = ts.spell;
                for each (effi in sw.effects)
                {
                    if (SPLASH_EFFECTS_IDS.indexOf(effi.effectId) != -1)
                    {
                        spellZone = SpellZoneManager.getInstance().getSpellZone(sw);
                        spellZoneCells = spellZone.getCells(pSourceSpellInfo.targetCell);
                        splashTargetsIds = null;
                        for each (cell in spellZoneCells)
                        {
                            cellEntities = EntitiesManager.getInstance().getEntitiesOnCell(cell, AnimatedCharacter);
                            for each (cellEntity in cellEntities)
                            {
                                if (((fef.getEntityInfos(cellEntity.id)) && (verifySpellEffectMask(sw.playerId, cellEntity.id, effi))))
                                {
                                    if (!(splashDamages))
                                    {
                                        splashDamages = new Vector.<SplashDamage>(0);
                                    };
                                    if (!(splashTargetsIds))
                                    {
                                        splashTargetsIds = new Vector.<int>(0);
                                    };
                                    splashTargetsIds.push(cellEntity.id);
                                };
                            };
                        };
                        if (splashTargetsIds)
                        {
                            splashDamages.push(new SplashDamage(sw.id, sw.playerId, splashTargetsIds, DamageUtil.getSpellDamage(pSourceSpellInfo, false, false), (effi as EffectInstanceDice).diceNum, Effect.getEffectById(effi.effectId).elementId, effi.random, effi.rawZone.charCodeAt(0), effi.zoneSize, effi.zoneMinSize, effi.zoneEfficiencyPercent, effi.zoneMaxEfficiency, ts.hasCritical));
                        };
                    };
                };
            };
            return (splashDamages);
        }

        public static function getAverageElementResistance(pElement:uint, pEntitiesIds:Vector.<int>):int
        {
            var statName:String;
            switch (pElement)
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
            };
            return (getAverageStat(statName, pEntitiesIds));
        }

        public static function getAverageElementReduction(pElement:uint, pEntitiesIds:Vector.<int>):int
        {
            var statName:String;
            switch (pElement)
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
            };
            return (getAverageStat(statName, pEntitiesIds));
        }

        public static function getAverageBuffElementReduction(pSpellInfo:SpellDamageInfo, pEffectDamage:EffectDamage, pEntitiesIds:Vector.<int>):int
        {
            var totalBuffReduction:int;
            var targetId:int;
            for each (targetId in pEntitiesIds)
            {
                totalBuffReduction = (totalBuffReduction + getBuffElementReduction(pSpellInfo, pEffectDamage, targetId));
            };
            return ((totalBuffReduction / pEntitiesIds.length));
        }

        public static function getBuffElementReduction(pSpellInfo:SpellDamageInfo, pEffectDamage:EffectDamage, pTargetId:int):int
        {
            var buff:BasicBuff;
            var trigger:String;
            var triggers:String;
            var triggersList:Array;
            var effect:EffectInstance;
            var reduction:int;
            var targetBuffs:Array = BuffManager.getInstance().getAllBuff(pTargetId);
            var buffSpellElementsReduced:Dictionary = new Dictionary(true);
            effect = new EffectInstance();
            effect.effectId = pEffectDamage.effectId;
            for each (buff in targetBuffs)
            {
                triggers = buff.effects.triggers;
                if (triggers)
                {
                    triggersList = triggers.split("|");
                    if (!(buffSpellElementsReduced[buff.castingSpell.spell.id]))
                    {
                        buffSpellElementsReduced[buff.castingSpell.spell.id] = new Vector.<int>(0);
                    };
                    for each (trigger in triggersList)
                    {
                        if ((((buff.actionId == 265)) && (verifyEffectTrigger(pSpellInfo.casterId, pTargetId, null, effect, pSpellInfo.isWeapon, trigger, pSpellInfo.spellCenterCell))))
                        {
                            if (buffSpellElementsReduced[buff.castingSpell.spell.id].indexOf(pEffectDamage.element) != -1)
                            {
                            }
                            else
                            {
                                reduction = (reduction + (((pSpellInfo.targetLevel / 20) + 1) * (buff.effects as EffectInstanceInteger).value));
                                if (buffSpellElementsReduced[buff.castingSpell.spell.id].indexOf(pEffectDamage.element) == -1)
                                {
                                    buffSpellElementsReduced[buff.castingSpell.spell.id].push(pEffectDamage.element);
                                };
                            };
                        };
                    };
                };
            };
            return (reduction);
        }

        public static function getAverageStat(pStatName:String, pEntitiesIds:Vector.<int>):int
        {
            var entityId:int;
            var fightEntityInfo:GameFightFighterInformations;
            var totalStat:int;
            var fef:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((((!(fef)) || (!(pEntitiesIds)))) || ((pEntitiesIds.length == 0))))
            {
                return (-1);
            };
            if (pStatName)
            {
                for each (entityId in pEntitiesIds)
                {
                    fightEntityInfo = (fef.getEntityInfos(entityId) as GameFightFighterInformations);
                    totalStat = (totalStat + fightEntityInfo.stats[pStatName]);
                };
            };
            return ((totalStat / pEntitiesIds.length));
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.miscs

