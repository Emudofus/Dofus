package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class PushUtil extends Object
   {
      
      public function PushUtil() {
         super();
      }
      
      protected static const _log:Logger;
      
      private static var _updatedEntitiesPositions:Dictionary;
      
      private static var _pushSpells:Vector.<int>;
      
      public static function reset() : void {
         var entityId:* = undefined;
         for(entityId in _updatedEntitiesPositions)
         {
            delete _updatedEntitiesPositions[entityId];
         }
         _pushSpells.length = 0;
      }
      
      public static function getPushedEntities(pSpell:SpellWrapper, pCasterCell:int, pSpellImpactCell:int) : Vector.<PushedEntity> {
         var pushedEntities:Vector.<PushedEntity> = null;
         var pushForce:* = 0;
         var zoneShape:* = 0;
         var effi:EffectInstance = null;
         var pushEffect:EffectInstanceDice = null;
         var origin:uint = 0;
         var cellId:uint = 0;
         var entity:IEntity = null;
         var direction:* = 0;
         var entitiesInDirection:Vector.<IEntity> = null;
         var newSpell:* = false;
         for each(effi in pSpell.effects)
         {
            if(effi.effectId == 5)
            {
               pushEffect = effi as EffectInstanceDice;
               pushForce = pushEffect.diceNum;
               zoneShape = pushEffect.zoneShape;
               break;
            }
         }
         if(pushForce == 0)
         {
            return null;
         }
         var hasMinSize:Boolean = (zoneShape == SpellShapeEnum.C) || (zoneShape == SpellShapeEnum.X) || (zoneShape == SpellShapeEnum.Q) || (zoneShape == SpellShapeEnum.plus) || (zoneShape == SpellShapeEnum.sharp);
         var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
         var spellZoneCells:Vector.<uint> = spellZone.getCells(pSpellImpactCell);
         origin = !hasMinSize?pCasterCell:pSpellImpactCell;
         var originPoint:MapPoint = MapPoint.fromCellId(origin);
         var directions:Dictionary = new Dictionary();
         if(_pushSpells.indexOf(pSpell.id) == -1)
         {
            _pushSpells.push(pSpell.id);
            newSpell = true;
         }
         for each(cellId in spellZoneCells)
         {
            if((!(cellId == pCasterCell)) || (!(pCasterCell == pSpellImpactCell)))
            {
               entity = EntitiesManager.getInstance().getEntityOnCell(cellId,AnimatedCharacter);
               if(entity)
               {
                  direction = originPoint.advancedOrientationTo(entity.position,false);
                  if(!directions[direction])
                  {
                     entitiesInDirection = getEntitiesInDirection(originPoint.cellId,spellZone.radius,direction);
                     entity = entitiesInDirection?entitiesInDirection[0]:entity;
                     directions[direction] = true;
                     if(!pushedEntities)
                     {
                        pushedEntities = new Vector.<PushedEntity>(0);
                     }
                     pushedEntities = pushedEntities.concat(getPushedEntitiesInLine(pSpell,newSpell,pushEffect,pSpellImpactCell,entity.position.cellId,pushForce,direction));
                  }
               }
            }
         }
         return pushedEntities;
      }
      
      private static function getPushedEntitiesInLine(pSpell:SpellWrapper, pNewSpell:Boolean, pPushEffect:EffectInstance, pSpellImpactCell:int, pStartCell:int, pPushForce:int, pDirection:int) : Vector.<PushedEntity> {
         var pushedEntities:Vector.<PushedEntity> = null;
         var entity:IEntity = null;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var previousCell:MapPoint = null;
         var entities:Vector.<IEntity> = null;
         var entityInfo:GameFightFighterInformations = null;
         var entityPushable:Boolean = false;
         var nextCellEntity:IEntity = null;
         var nextCellEntityInfo:GameFightFighterInformations = null;
         var nextEntityPushable:Boolean = false;
         var pushedIndex:int = 0;
         var pushingEntity:PushedEntity = null;
         var firstPushingEntity:PushedEntity = null;
         var pushedEntity:PushedEntity = null;
         var emptyCells:Vector.<int> = null;
         var entityInSpellZone:Boolean = false;
         var cell:MapPoint = null;
         var entityCell:uint = 0;
         var forceReduction:int = 0;
         pushedEntities = new Vector.<PushedEntity>(0);
         var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
         var nextCell:MapPoint = cellMp.getNearestCellInDirection(pDirection);
         var force:int = pPushForce;
         i = 0;
         while(i < pPushForce)
         {
            if(nextCell)
            {
               if(isBlockingCell(nextCell.cellId))
               {
                  break;
               }
               force--;
               nextCell = nextCell.getNearestCellInDirection(pDirection);
            }
            i++;
         }
         if(force <= 0)
         {
            return pushedEntities;
         }
         entities = new Vector.<IEntity>(0);
         entities.push(EntitiesManager.getInstance().getEntityOnCell(pStartCell,AnimatedCharacter));
         var spellZone:IZone = SpellZoneManager.getInstance().getSpellZone(pSpell);
         var spellZoneCells:Vector.<uint> = spellZone.getCells(pSpellImpactCell);
         if(force == pPushForce)
         {
            while(cellMp)
            {
               cellMp = cellMp.getNearestCellInDirection(pDirection);
               if(cellMp)
               {
                  entity = EntitiesManager.getInstance().getEntityOnCell(cellMp.cellId,AnimatedCharacter);
                  if((entity) && (!(spellZoneCells.indexOf(cellMp.cellId) == -1)))
                  {
                     entities.push(entity);
                     continue;
                  }
                  break;
               }
            }
         }
         var getPushedEntity:Function = function(pEntityId:int):PushedEntity
         {
            var pe:PushedEntity = null;
            for each(pe in pushedEntities)
            {
               if(pe.id == pEntityId)
               {
                  return pe;
               }
            }
            return null;
         };
         var isEntityInSpellZone:Function = function(pEntity:int):Boolean
         {
            var e:IEntity = null;
            for each(e in entities)
            {
               if(e.id == pEntity)
               {
                  return true;
               }
            }
            return false;
         };
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var nbEntities:int = entities.length;
         i = 0;
         while(i < nbEntities)
         {
            entityCell = (pNewSpell) && (_updatedEntitiesPositions[entities[i].id])?_updatedEntitiesPositions[entities[i].id]:entities[i].position.cellId;
            cellMp = MapPoint.fromCellId(entityCell);
            entityInfo = fightEntitiesFrame.getEntityInfos(entities[i].id) as GameFightFighterInformations;
            entityPushable = isPushableEntity(entityInfo);
            pushedIndex = 0;
            if((entityPushable) && (DamageUtil.verifySpellEffectZone(entities[i].id,pPushEffect,pSpellImpactCell)) && (DamageUtil.verifySpellEffectMask(pSpell.playerId,entities[i].id,pPushEffect)))
            {
               pushingEntity = getPushedEntity(entities[i].id);
               if(!pushingEntity)
               {
                  pushingEntity = new PushedEntity(entities[i].id,pushedIndex,pPushForce);
                  pushedEntities.push(pushingEntity);
                  if(!firstPushingEntity)
                  {
                     firstPushingEntity = pushingEntity;
                  }
               }
               else
               {
                  pushingEntity.pushedIndexes.push(pushedIndex);
               }
               pushedIndex++;
               j = 0;
               while(j < pPushForce)
               {
                  if(j == 0)
                  {
                     previousCell = cellMp;
                     nextCell = cellMp.getNearestCellInDirection(pDirection);
                  }
                  else if(nextCell)
                  {
                     previousCell = nextCell;
                     nextCell = nextCell.getNearestCellInDirection(pDirection);
                  }
                  
                  if(nextCell)
                  {
                     if(isBlockingCell(nextCell.cellId))
                     {
                        nextCellEntity = EntitiesManager.getInstance().getEntityOnCell(nextCell.cellId,AnimatedCharacter);
                        if(nextCellEntity)
                        {
                           entityInSpellZone = isEntityInSpellZone(nextCellEntity.id);
                           nextCellEntityInfo = fightEntitiesFrame.getEntityInfos(nextCellEntity.id) as GameFightFighterInformations;
                           nextEntityPushable = isPushableEntity(nextCellEntityInfo);
                           if(nextEntityPushable)
                           {
                              if((entityInSpellZone) && (!isPathBlocked(nextCell.cellId,getCellIdInDirection(nextCell.cellId,pPushForce,pDirection),pDirection)))
                              {
                                 pushingEntity.force = 0;
                                 break;
                              }
                           }
                           pushedEntity = getPushedEntity(nextCellEntity.id);
                           if(!pushedEntity)
                           {
                              pushedEntity = new PushedEntity(nextCellEntity.id,pushedIndex,pPushForce);
                              pushedEntity.pushingEntity = firstPushingEntity;
                              pushedEntities.push(pushedEntity);
                           }
                           else
                           {
                              pushedEntity.pushedIndexes.push(pushedIndex);
                           }
                           pushedIndex++;
                        }
                        else if(j == 0)
                        {
                           break;
                        }
                        
                        if(!entityInSpellZone)
                        {
                           cell = nextCell.getNearestCellInDirection(pDirection);
                           if((cell) && (!isBlockingCell(cell.cellId)))
                           {
                              break;
                           }
                        }
                     }
                     else if((!(j == pPushForce - 1)) && ((!nextCellEntity) || (!(entities.indexOf(nextCellEntity) == -1))) && (isPathBlocked(nextCell.cellId,getCellIdInDirection(cellMp.cellId,pPushForce,pDirection),pDirection)))
                     {
                        if(!emptyCells)
                        {
                           emptyCells = new Vector.<int>(0);
                        }
                        if(emptyCells.indexOf(nextCell.cellId) == -1)
                        {
                           emptyCells.push(nextCell.cellId);
                        }
                     }
                     else if(!isPathBlocked(cellMp.cellId,getCellIdInDirection(cellMp.cellId,pPushForce,pDirection),pDirection))
                     {
                        pushingEntity.force = 0;
                     }
                     
                     
                     if(pushingEntity.force == 0)
                     {
                        break;
                     }
                  }
                  j++;
               }
               _updatedEntitiesPositions[entities[i].id] = previousCell.cellId;
            }
            i++;
         }
         if(emptyCells)
         {
            forceReduction = emptyCells.length;
            if(forceReduction > 0)
            {
               for each(pushedEntity in pushedEntities)
               {
                  pushedEntity.force = pushedEntity.force - forceReduction;
               }
            }
         }
         return pushedEntities;
      }
      
      public static function isBlockingCell(pCell:int) : Boolean {
         var gc:GraphicCell = InteractiveCellManager.getInstance().getCell(pCell);
         return (gc) && (!gc.visible) || (EntitiesManager.getInstance().getEntityOnCell(pCell,AnimatedCharacter));
      }
      
      public static function isPathBlocked(pStartCell:int, pEndCell:int, pDirection:int) : Boolean {
         var pathBlocked:* = false;
         var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
         while(true)
         {
            if((cellMp) && (!pathBlocked))
            {
               cellMp = cellMp.getNearestCellInDirection(pDirection);
               if(cellMp)
               {
                  pathBlocked = isBlockingCell(cellMp.cellId);
                  if(cellMp.cellId != pEndCell)
                  {
                     continue;
                  }
               }
               else
               {
                  break;
               }
            }
            return pathBlocked;
         }
         return true;
      }
      
      public static function getCellIdInDirection(pStartCell:int, pLength:int, pDirection:int) : int {
         var finalCellId:* = 0;
         var i:* = 0;
         var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
         i = 0;
         while(i < pLength)
         {
            cellMp = cellMp.getNearestCellInDirection(pDirection);
            if(!cellMp)
            {
               return -1;
            }
            i++;
         }
         return cellMp.cellId;
      }
      
      public static function getEntitiesInDirection(pStartCell:int, pLength:int, pDirection:int) : Vector.<IEntity> {
         var entities:Vector.<IEntity> = null;
         var entity:IEntity = null;
         var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
         var nextCell:MapPoint = cellMp.getNearestCellInDirection(pDirection);
         var i:int = 0;
         while((nextCell) && (i < pLength))
         {
            entity = EntitiesManager.getInstance().getEntityOnCell(nextCell.cellId,AnimatedCharacter);
            if(entity)
            {
               if(!entities)
               {
                  entities = new Vector.<IEntity>(0);
               }
               entities.push(entity);
            }
            nextCell = nextCell.getNearestCellInDirection(pDirection);
            i++;
         }
         return entities;
      }
      
      public static function isPushableEntity(pEntityInfo:GameFightFighterInformations) : Boolean {
         var monster:Monster = null;
         var entityStates:Array = FightersStateManager.getInstance().getStates(pEntityInfo.contextualId);
         var buffPreventPush:Boolean = (entityStates) && ((!(entityStates.indexOf(6) == -1)) || (!(entityStates.indexOf(97) == -1)));
         var canBePushed:Boolean = true;
         if(pEntityInfo is GameFightMonsterInformations)
         {
            monster = Monster.getMonsterById((pEntityInfo as GameFightMonsterInformations).creatureGenericId);
            canBePushed = monster.canBePushed;
         }
         return (!buffPreventPush) && (canBePushed);
      }
   }
}
