package com.ankamagames.dofus.logic.game.fight.miscs
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
    import com.ankamagames.jerakine.entities.interfaces.IEntity;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
    import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
    import com.ankamagames.jerakine.types.zones.IZone;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.managers.EntitiesManager;
    import com.ankamagames.dofus.types.entities.AnimatedCharacter;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.atouin.managers.InteractiveCellManager;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.jerakine.types.enums.DirectionsEnum;
    import com.ankamagames.dofus.datacenter.monsters.Monster;
    import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
    import __AS3__.vec.*;

    public class PushUtil 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PushUtil));
        private static const PUSH_EFFECT_ID:uint = 5;
        private static const PULL_EFFECT_ID:uint = 6;
        private static var _updatedEntitiesPositions:Dictionary = new Dictionary();
        private static var _pushSpells:Vector.<int> = new Vector.<int>(0);


        public static function reset():void
        {
            var entityId:*;
            for (entityId in _updatedEntitiesPositions)
            {
                delete _updatedEntitiesPositions[entityId];
            };
            _pushSpells.length = 0;
        }

        public static function getPushedEntities(pSpell:SpellWrapper, pCasterCell:int, pSpellImpactCell:int):Vector.<PushedEntity>
        {
            var pushedEntities:Vector.<PushedEntity>;
            var pushForce:int;
            var zoneShape:int;
            var effi:EffectInstance;
            var pushEffect:EffectInstanceDice;
            var origin:uint;
            var cellId:uint;
            var entity:IEntity;
            var direction:int;
            var entitiesInDirection:Vector.<IEntity>;
            var newSpell:Boolean;
            var force:int;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            for each (effi in pSpell.effects)
            {
                if (effi.effectId == PUSH_EFFECT_ID)
                {
                    pushEffect = (effi as EffectInstanceDice);
                    pushForce = pushEffect.diceNum;
                    zoneShape = pushEffect.zoneShape;
                    break;
                };
            };
            if (pushForce == 0)
            {
                return (null);
            };
            var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
            var spellZoneCells:Vector.<uint> = spellZone.getCells(pSpellImpactCell);
            origin = ((!(hasMinSize(zoneShape))) ? pCasterCell : pSpellImpactCell);
            var originPoint:MapPoint = MapPoint.fromCellId(origin);
            var directions:Dictionary = new Dictionary();
            if (_pushSpells.indexOf(pSpell.id) == -1)
            {
                _pushSpells.push(pSpell.id);
                newSpell = true;
            };
            for each (cellId in spellZoneCells)
            {
                if (((!((cellId == pCasterCell))) || (!((pCasterCell == pSpellImpactCell)))))
                {
                    entity = EntitiesManager.getInstance().getEntityOnCell(cellId, AnimatedCharacter);
                    if (entity)
                    {
                        direction = originPoint.advancedOrientationTo(entity.position, false);
                        if (!(directions[direction]))
                        {
                            entitiesInDirection = getEntitiesInDirection(originPoint.cellId, spellZone.radius, direction);
                            entity = ((entitiesInDirection) ? entitiesInDirection[0] : entity);
                            directions[direction] = true;
                            if (!(pushedEntities))
                            {
                                pushedEntities = new Vector.<PushedEntity>(0);
                            };
                            force = getPushForce(origin, (fightEntitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations), pSpell.effects, pushEffect);
                            pushedEntities = pushedEntities.concat(getPushedEntitiesInLine(pSpell, newSpell, pushEffect, pSpellImpactCell, entity.position.cellId, force, direction));
                        };
                    };
                };
            };
            return (pushedEntities);
        }

        private static function getPushedEntitiesInLine(pSpell:SpellWrapper, pNewSpell:Boolean, pPushEffect:EffectInstance, pSpellImpactCell:int, pStartCell:int, pPushForce:int, pDirection:int):Vector.<PushedEntity>
        {
            var pushedEntities:Vector.<PushedEntity>;
            var entity:IEntity;
            var i:int;
            var j:int;
            var k:int;
            var previousCell:MapPoint;
            var entities:Vector.<IEntity>;
            var entityInfo:GameFightFighterInformations;
            var entityPushable:Boolean;
            var nextCellEntity:IEntity;
            var nextCellEntityInfo:GameFightFighterInformations;
            var nextEntityPushable:Boolean;
            var pushedIndex:int;
            var pushingEntity:PushedEntity;
            var firstPushingEntity:PushedEntity;
            var pushedEntity:PushedEntity;
            var emptyCells:Vector.<int>;
            var entityInSpellZone:Boolean;
            var cell:MapPoint;
            var entityCell:uint;
            var forceReduction:int;
            pushedEntities = new Vector.<PushedEntity>(0);
            var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
            var nextCell:MapPoint = cellMp.getNearestCellInDirection(pDirection);
            var force:int = pPushForce;
            i = 0;
            while (i < pPushForce)
            {
                if (nextCell)
                {
                    if (isBlockingCell(nextCell.cellId, ((!(previousCell)) ? cellMp.cellId : previousCell.cellId)))
                    {
                        break;
                    };
                    force = (force - 1);
                    previousCell = nextCell;
                    nextCell = nextCell.getNearestCellInDirection(pDirection);
                };
                i = (i + 1);
            };
            previousCell = null;
            if (force <= 0)
            {
                return (pushedEntities);
            };
            entities = new Vector.<IEntity>(0);
            entities.push(EntitiesManager.getInstance().getEntityOnCell(pStartCell, AnimatedCharacter));
            var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
            var spellZoneCells:Vector.<uint> = spellZone.getCells(pSpellImpactCell);
            if (force == pPushForce)
            {
                while (cellMp)
                {
                    cellMp = cellMp.getNearestCellInDirection(pDirection);
                    if (cellMp)
                    {
                        entity = EntitiesManager.getInstance().getEntityOnCell(cellMp.cellId, AnimatedCharacter);
                        if (((entity) && (!((spellZoneCells.indexOf(cellMp.cellId) == -1)))))
                        {
                            entities.push(entity);
                        }
                        else
                        {
                            break;
                        };
                    };
                };
            };
            var getPushedEntity:Function = function (pEntityId:int):PushedEntity
            {
                var pe:PushedEntity;
                for each (pe in pushedEntities)
                {
                    if (pe.id == pEntityId)
                    {
                        return (pe);
                    };
                };
                return (null);
            };
            var isEntityInSpellZone:Function = function (pEntity:int):Boolean
            {
                var e:IEntity;
                for each (e in entities)
                {
                    if (e.id == pEntity)
                    {
                        return (true);
                    };
                };
                return (false);
            };
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            var nbEntities:int = entities.length;
            var casterInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pSpell.playerId) as GameFightFighterInformations);
            i = 0;
            for (;i < nbEntities;(i = (i + 1)))
            {
                entityCell = ((((pNewSpell) && (_updatedEntitiesPositions[entities[i].id]))) ? _updatedEntitiesPositions[entities[i].id] : entities[i].position.cellId);
                cellMp = MapPoint.fromCellId(entityCell);
                entityInfo = (fightEntitiesFrame.getEntityInfos(entities[i].id) as GameFightFighterInformations);
                entityPushable = isPushableEntity(entityInfo);
                pushedIndex = 0;
                if (((((entityPushable) && (DamageUtil.verifySpellEffectZone(entities[i].id, pPushEffect, pSpellImpactCell, casterInfos.disposition.cellId)))) && (DamageUtil.verifySpellEffectMask(pSpell.playerId, entities[i].id, pPushEffect))))
                {
                    pushingEntity = getPushedEntity(entities[i].id);
                    if (!(pushingEntity))
                    {
                        pushingEntity = new PushedEntity(entities[i].id, pushedIndex, pPushForce);
                        pushedEntities.push(pushingEntity);
                        if (!(firstPushingEntity))
                        {
                            firstPushingEntity = pushingEntity;
                        };
                    }
                    else
                    {
                        pushingEntity.pushedIndexes.push(pushedIndex);
                    };
                    pushedIndex = (pushedIndex + 1);
                }
                else
                {
                    continue;
                };
                j = 0;
                while (j < pPushForce)
                {
                    if (j == 0)
                    {
                        previousCell = cellMp;
                        nextCell = cellMp.getNearestCellInDirection(pDirection);
                    }
                    else
                    {
                        if (nextCell)
                        {
                            previousCell = nextCell;
                            nextCell = nextCell.getNearestCellInDirection(pDirection);
                        };
                    };
                    if (nextCell)
                    {
                        if (isBlockingCell(nextCell.cellId, previousCell.cellId))
                        {
                            nextCellEntity = EntitiesManager.getInstance().getEntityOnCell(nextCell.cellId, AnimatedCharacter);
                            if (nextCellEntity)
                            {
                                entityInSpellZone = isEntityInSpellZone(nextCellEntity.id);
                                nextCellEntityInfo = (fightEntitiesFrame.getEntityInfos(nextCellEntity.id) as GameFightFighterInformations);
                                nextEntityPushable = isPushableEntity(nextCellEntityInfo);
                                if (nextEntityPushable)
                                {
                                    if (((entityInSpellZone) && (!(isPathBlocked(nextCell.cellId, getCellIdInDirection(nextCell.cellId, pPushForce, pDirection), pDirection)))))
                                    {
                                        pushingEntity.force = 0;
                                        break;
                                    };
                                };
                                pushedEntity = getPushedEntity(nextCellEntity.id);
                                if (!(pushedEntity))
                                {
                                    pushedEntity = new PushedEntity(nextCellEntity.id, pushedIndex, pPushForce);
                                    pushedEntity.pushingEntity = firstPushingEntity;
                                    pushedEntities.push(pushedEntity);
                                }
                                else
                                {
                                    pushedEntity.pushedIndexes.push(pushedIndex);
                                };
                                pushedIndex = (pushedIndex + 1);
                            }
                            else
                            {
                                if (j == 0)
                                {
                                    break;
                                };
                            };
                            if (!(entityInSpellZone))
                            {
                                cell = nextCell.getNearestCellInDirection(pDirection);
                                if (((cell) && (!(isBlockingCell(cell.cellId, nextCell.cellId)))))
                                {
                                    break;
                                };
                            };
                        }
                        else
                        {
                            if (((((!((j == (pPushForce - 1)))) && (((!(nextCellEntity)) || (!((entities.indexOf(nextCellEntity) == -1))))))) && (isPathBlocked(nextCell.cellId, getCellIdInDirection(cellMp.cellId, pPushForce, pDirection), pDirection))))
                            {
                                if (!(emptyCells))
                                {
                                    emptyCells = new Vector.<int>(0);
                                };
                                if (emptyCells.indexOf(nextCell.cellId) == -1)
                                {
                                    emptyCells.push(nextCell.cellId);
                                };
                            }
                            else
                            {
                                if (!(isPathBlocked(cellMp.cellId, getCellIdInDirection(cellMp.cellId, pPushForce, pDirection), pDirection)))
                                {
                                    pushingEntity.force = 0;
                                };
                            };
                        };
                        if (pushingEntity.force == 0)
                        {
                            break;
                        };
                    };
                    j = (j + 1);
                };
                _updatedEntitiesPositions[entities[i].id] = previousCell.cellId;
            };
            if (emptyCells)
            {
                forceReduction = emptyCells.length;
                if (forceReduction > 0)
                {
                    for each (pushedEntity in pushedEntities)
                    {
                        pushedEntity.force = (pushedEntity.force - forceReduction);
                    };
                };
            };
            return (pushedEntities);
        }

        private static function getPushForce(pPushOriginCell:int, pTargetInfos:GameFightFighterInformations, pSpellEffects:Vector.<EffectInstance>, pPushEffect:EffectInstance):int
        {
            var pushForce:int;
            var pullEffect:EffectInstanceDice;
            var effect:EffectInstance;
            var pushEffectForce:int;
            var pullEffectForce:int;
            var targetCell:MapPoint;
            var originCell:MapPoint;
            var cell:MapPoint;
            var nextCell:MapPoint;
            var orientation:uint;
            var i:int;
            var pullDistance:uint;
            var pushEffectIndex:int = pSpellEffects.indexOf(pPushEffect);
            var pullEffectIndex:int = -1;
            for each (effect in pSpellEffects)
            {
                if (effect.effectId == PULL_EFFECT_ID)
                {
                    pullEffectIndex = pSpellEffects.indexOf(effect);
                    pullEffect = (effect as EffectInstanceDice);
                    break;
                };
            };
            pushEffectForce = (pPushEffect as EffectInstanceDice).diceNum;
            if (((((!((pullEffectIndex == -1))) && ((pullEffectIndex < pushEffectIndex)))) && (isPushableEntity(pTargetInfos))))
            {
                pullEffectForce = pullEffect.diceNum;
                targetCell = MapPoint.fromCellId(pTargetInfos.disposition.cellId);
                originCell = MapPoint.fromCellId(pPushOriginCell);
                cell = targetCell;
                orientation = targetCell.advancedOrientationTo(originCell);
                pullDistance = 0;
                i = 0;
                while (i < pullEffectForce)
                {
                    nextCell = cell.getNearestCellInDirection(orientation);
                    if (((nextCell) && (!(isBlockingCell(nextCell.cellId, cell.cellId)))))
                    {
                        pullDistance++;
                        cell = nextCell;
                    }
                    else
                    {
                        break;
                    };
                    i++;
                };
                pushForce = (pushEffectForce - pullDistance);
            }
            else
            {
                pushForce = pushEffectForce;
            };
            return (pushForce);
        }

        private static function hasMinSize(pZoneShape:int):Boolean
        {
            return ((((((((((pZoneShape == SpellShapeEnum.C)) || ((pZoneShape == SpellShapeEnum.X)))) || ((pZoneShape == SpellShapeEnum.Q)))) || ((pZoneShape == SpellShapeEnum.plus)))) || ((pZoneShape == SpellShapeEnum.sharp))));
        }

        public static function hasPushDamages(pCasterId:int, pTargetId:int, pSpellEffects:Vector.<EffectInstance>, pEffect:EffectInstance, pSpellImpactCell:int):Boolean
        {
            var casterInfos:GameFightFighterInformations;
            var origin:uint;
            var originPoint:MapPoint;
            var direction:int;
            var pushForce:int;
            var cellMp:MapPoint;
            var previousCell:MapPoint;
            var nextCell:MapPoint;
            var force:int;
            var i:int;
            var fightEntitiesFrame:FightEntitiesFrame = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame);
            if (((!((pEffect.effectId == PUSH_EFFECT_ID))) || (!(fightEntitiesFrame))))
            {
                return (false);
            };
            var targetInfos:GameFightFighterInformations = (fightEntitiesFrame.getEntityInfos(pTargetId) as GameFightFighterInformations);
            if (((targetInfos) && (isPushableEntity(targetInfos))))
            {
                casterInfos = (fightEntitiesFrame.getEntityInfos(pCasterId) as GameFightFighterInformations);
                origin = ((!(hasMinSize(pEffect.zoneShape))) ? casterInfos.disposition.cellId : pSpellImpactCell);
                originPoint = MapPoint.fromCellId(origin);
                direction = originPoint.advancedOrientationTo(MapPoint.fromCellId(targetInfos.disposition.cellId), false);
                pushForce = getPushForce(origin, targetInfos, pSpellEffects, pEffect);
                cellMp = MapPoint.fromCellId(targetInfos.disposition.cellId);
                nextCell = cellMp.getNearestCellInDirection(direction);
                force = pushForce;
                i = 0;
                while (i < pushForce)
                {
                    if (nextCell)
                    {
                        if (isBlockingCell(nextCell.cellId, ((!(previousCell)) ? cellMp.cellId : previousCell.cellId)))
                        {
                            break;
                        };
                        force--;
                        previousCell = nextCell;
                        nextCell = nextCell.getNearestCellInDirection(direction);
                    };
                    i++;
                };
                return ((force > 0));
            };
            return (false);
        }

        public static function isBlockingCell(pCell:int, pFromCell:int, pCheckDiag:Boolean=true):Boolean
        {
            var startCell:MapPoint;
            var destCell:MapPoint;
            var direction:uint;
            var c1:MapPoint;
            var c2:MapPoint;
            var gc:GraphicCell = InteractiveCellManager.getInstance().getCell(pCell);
            var blocking:Boolean = ((((gc) && (!(gc.visible)))) || (EntitiesManager.getInstance().getEntityOnCell(pCell, AnimatedCharacter)));
            if (((!(blocking)) && (pCheckDiag)))
            {
                startCell = MapPoint.fromCellId(pFromCell);
                destCell = MapPoint.fromCellId(pCell);
                direction = startCell.orientationTo(destCell);
                if ((direction % 2) == 0)
                {
                    switch (direction)
                    {
                        case DirectionsEnum.RIGHT:
                            c1 = destCell.getNearestCellInDirection(DirectionsEnum.UP_LEFT);
                            c2 = destCell.getNearestCellInDirection(DirectionsEnum.DOWN_LEFT);
                            break;
                        case DirectionsEnum.DOWN:
                            c1 = destCell.getNearestCellInDirection(DirectionsEnum.UP_LEFT);
                            c2 = destCell.getNearestCellInDirection(DirectionsEnum.UP_RIGHT);
                            break;
                        case DirectionsEnum.LEFT:
                            c1 = destCell.getNearestCellInDirection(DirectionsEnum.UP_RIGHT);
                            c2 = destCell.getNearestCellInDirection(DirectionsEnum.DOWN_RIGHT);
                            break;
                        case DirectionsEnum.UP:
                            c1 = destCell.getNearestCellInDirection(DirectionsEnum.DOWN_LEFT);
                            c2 = destCell.getNearestCellInDirection(DirectionsEnum.DOWN_RIGHT);
                            break;
                    };
                    blocking = ((((c1) && (isBlockingCell(c1.cellId, -1, false)))) || (((c2) && (isBlockingCell(c2.cellId, -1, false)))));
                };
            };
            return (blocking);
        }

        public static function isPathBlocked(pStartCell:int, pEndCell:int, pDirection:int):Boolean
        {
            var pathBlocked:Boolean;
            var previousCell:MapPoint;
            var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
            while (((cellMp) && (!(pathBlocked))))
            {
                previousCell = cellMp;
                cellMp = cellMp.getNearestCellInDirection(pDirection);
                if (cellMp)
                {
                    pathBlocked = isBlockingCell(cellMp.cellId, previousCell.cellId);
                    if (cellMp.cellId == pEndCell)
                    {
                        break;
                    };
                }
                else
                {
                    return (true);
                };
            };
            return (pathBlocked);
        }

        public static function getCellIdInDirection(pStartCell:int, pLength:int, pDirection:int):int
        {
            var finalCellId:int;
            var i:int;
            var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
            i = 0;
            while (i < pLength)
            {
                cellMp = cellMp.getNearestCellInDirection(pDirection);
                if (!(cellMp))
                {
                    return (-1);
                };
                i++;
            };
            return (cellMp.cellId);
        }

        public static function getEntitiesInDirection(pStartCell:int, pLength:int, pDirection:int):Vector.<IEntity>
        {
            var entities:Vector.<IEntity>;
            var entity:IEntity;
            var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
            var nextCell:MapPoint = cellMp.getNearestCellInDirection(pDirection);
            var i:int;
            while (((nextCell) && ((i < pLength))))
            {
                entity = EntitiesManager.getInstance().getEntityOnCell(nextCell.cellId, AnimatedCharacter);
                if (entity)
                {
                    if (!(entities))
                    {
                        entities = new Vector.<IEntity>(0);
                    };
                    entities.push(entity);
                };
                nextCell = nextCell.getNearestCellInDirection(pDirection);
                i++;
            };
            return (entities);
        }

        public static function isPushableEntity(pEntityInfo:GameFightFighterInformations):Boolean
        {
            var monster:Monster;
            var entityStates:Array = FightersStateManager.getInstance().getStates(pEntityInfo.contextualId);
            var buffPreventPush:Boolean = ((entityStates) && (((!((entityStates.indexOf(6) == -1))) || (!((entityStates.indexOf(97) == -1))))));
            var canBePushed:Boolean = true;
            if ((pEntityInfo is GameFightMonsterInformations))
            {
                monster = Monster.getMonsterById((pEntityInfo as GameFightMonsterInformations).creatureGenericId);
                canBePushed = monster.canBePushed;
            };
            return (((!(buffPreventPush)) && (canBePushed)));
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.miscs

