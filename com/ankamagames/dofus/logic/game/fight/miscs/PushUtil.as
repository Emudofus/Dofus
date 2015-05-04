package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.logic.game.fight.types.PushedEntity;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
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
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class PushUtil extends Object
   {
      
      public function PushUtil()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(PushUtil));
      
      private static const PUSH_EFFECT_ID:uint = 5;
      
      private static const PULL_EFFECT_ID:uint = 6;
      
      private static var _updatedEntitiesPositions:Dictionary = new Dictionary();
      
      private static var _pushSpells:Vector.<int> = new Vector.<int>(0);
      
      public static function reset() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in _updatedEntitiesPositions)
         {
            delete _updatedEntitiesPositions[_loc1_];
            true;
         }
         _pushSpells.length = 0;
      }
      
      public static function getPushedEntities(param1:SpellWrapper, param2:int, param3:int) : Vector.<PushedEntity>
      {
         var _loc5_:Vector.<PushedEntity> = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:EffectInstance = null;
         var _loc9_:EffectInstanceDice = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:IEntity = null;
         var _loc16_:* = 0;
         var _loc18_:Vector.<IEntity> = null;
         var _loc19_:* = false;
         var _loc20_:* = 0;
         var _loc4_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         for each(_loc8_ in param1.effects)
         {
            if(_loc8_.effectId == PUSH_EFFECT_ID)
            {
               _loc9_ = _loc8_ as EffectInstanceDice;
               _loc6_ = _loc9_.diceNum;
               _loc7_ = _loc9_.zoneShape;
               break;
            }
         }
         if(_loc6_ == 0)
         {
            return null;
         }
         var _loc10_:IZone = SpellZoneManager.getInstance().getSpellZone(param1);
         var _loc11_:Vector.<uint> = _loc10_.getCells(param3);
         _loc12_ = !hasMinSize(_loc7_)?param2:param3;
         var _loc15_:MapPoint = MapPoint.fromCellId(_loc12_);
         var _loc17_:Dictionary = new Dictionary();
         if(_pushSpells.indexOf(param1.id) == -1)
         {
            _pushSpells.push(param1.id);
            _loc19_ = true;
         }
         for each(_loc13_ in _loc11_)
         {
            if(!(_loc13_ == param2) || !(param2 == param3))
            {
               _loc14_ = EntitiesManager.getInstance().getEntityOnCell(_loc13_,AnimatedCharacter);
               if(_loc14_)
               {
                  _loc16_ = _loc15_.advancedOrientationTo(_loc14_.position,false);
                  if(!_loc17_[_loc16_])
                  {
                     _loc18_ = getEntitiesInDirection(_loc15_.cellId,_loc10_.radius,_loc16_);
                     _loc14_ = _loc18_?_loc18_[0]:_loc14_;
                     _loc17_[_loc16_] = true;
                     if(!_loc5_)
                     {
                        _loc5_ = new Vector.<PushedEntity>(0);
                     }
                     _loc20_ = getPushForce(_loc12_,_loc4_.getEntityInfos(_loc14_.id) as GameFightFighterInformations,param1.effects,_loc9_);
                     _loc5_ = _loc5_.concat(getPushedEntitiesInLine(param1,_loc19_,_loc9_,param3,_loc14_.position.cellId,_loc20_,_loc16_));
                  }
               }
            }
         }
         return _loc5_;
      }
      
      private static function getPushedEntitiesInLine(param1:SpellWrapper, param2:Boolean, param3:EffectInstance, param4:int, param5:int, param6:int, param7:int) : Vector.<PushedEntity>
      {
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
         var pSpell:SpellWrapper = param1;
         var pNewSpell:Boolean = param2;
         var pPushEffect:EffectInstance = param3;
         var pSpellImpactCell:int = param4;
         var pStartCell:int = param5;
         var pPushForce:int = param6;
         var pDirection:int = param7;
         pushedEntities = new Vector.<PushedEntity>(0);
         var cellMp:MapPoint = MapPoint.fromCellId(pStartCell);
         var nextCell:MapPoint = cellMp.getNearestCellInDirection(pDirection);
         var force:int = pPushForce;
         i = 0;
         while(i < pPushForce)
         {
            if(nextCell)
            {
               if(isBlockingCell(nextCell.cellId,!previousCell?cellMp.cellId:previousCell.cellId))
               {
                  break;
               }
               force--;
               previousCell = nextCell;
               nextCell = nextCell.getNearestCellInDirection(pDirection);
            }
            i++;
         }
         previousCell = null;
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
                  if((entity) && !(spellZoneCells.indexOf(cellMp.cellId) == -1))
                  {
                     entities.push(entity);
                     continue;
                  }
                  break;
               }
            }
         }
         var getPushedEntity:Function = function(param1:int):PushedEntity
         {
            var _loc2_:PushedEntity = null;
            for each(_loc2_ in pushedEntities)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
            return null;
         };
         var isEntityInSpellZone:Function = function(param1:int):Boolean
         {
            var _loc2_:IEntity = null;
            for each(_loc2_ in entities)
            {
               if(_loc2_.id == param1)
               {
                  return true;
               }
            }
            return false;
         };
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var nbEntities:int = entities.length;
         var casterInfos:GameFightFighterInformations = fightEntitiesFrame.getEntityInfos(pSpell.playerId) as GameFightFighterInformations;
         i = 0;
         while(i < nbEntities)
         {
            entityCell = (pNewSpell) && (_updatedEntitiesPositions[entities[i].id])?_updatedEntitiesPositions[entities[i].id]:entities[i].position.cellId;
            cellMp = MapPoint.fromCellId(entityCell);
            entityInfo = fightEntitiesFrame.getEntityInfos(entities[i].id) as GameFightFighterInformations;
            entityPushable = isPushableEntity(entityInfo);
            pushedIndex = 0;
            if((entityPushable) && (DamageUtil.verifySpellEffectZone(entities[i].id,pPushEffect,pSpellImpactCell,casterInfos.disposition.cellId)) && (DamageUtil.verifySpellEffectMask(pSpell.playerId,entities[i].id,pPushEffect,pSpellImpactCell)))
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
                     if(isBlockingCell(nextCell.cellId,previousCell.cellId))
                     {
                        nextCellEntity = EntitiesManager.getInstance().getEntityOnCell(nextCell.cellId,AnimatedCharacter);
                        if(nextCellEntity)
                        {
                           entityInSpellZone = isEntityInSpellZone(nextCellEntity.id);
                           nextCellEntityInfo = fightEntitiesFrame.getEntityInfos(nextCellEntity.id) as GameFightFighterInformations;
                           nextEntityPushable = isPushableEntity(nextCellEntityInfo);
                           if(nextEntityPushable)
                           {
                              if((entityInSpellZone) && !isPathBlocked(nextCell.cellId,getCellIdInDirection(nextCell.cellId,pPushForce,pDirection),pDirection))
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
                           if((cell) && !isBlockingCell(cell.cellId,nextCell.cellId))
                           {
                              break;
                           }
                        }
                     }
                     else if(!(j == pPushForce - 1) && (!nextCellEntity || !(entities.indexOf(nextCellEntity) == -1)) && (isPathBlocked(nextCell.cellId,getCellIdInDirection(cellMp.cellId,pPushForce,pDirection),pDirection)))
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
      
      private static function getPushForce(param1:int, param2:GameFightFighterInformations, param3:Vector.<EffectInstance>, param4:EffectInstance) : int
      {
         var _loc5_:* = 0;
         var _loc8_:EffectInstanceDice = null;
         var _loc9_:EffectInstance = null;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:MapPoint = null;
         var _loc13_:MapPoint = null;
         var _loc14_:MapPoint = null;
         var _loc15_:MapPoint = null;
         var _loc16_:uint = 0;
         var _loc17_:* = 0;
         var _loc18_:uint = 0;
         var _loc6_:int = param3.indexOf(param4);
         var _loc7_:* = -1;
         for each(_loc9_ in param3)
         {
            if(_loc9_.effectId == PULL_EFFECT_ID)
            {
               _loc7_ = param3.indexOf(_loc9_);
               _loc8_ = _loc9_ as EffectInstanceDice;
               break;
            }
         }
         _loc10_ = (param4 as EffectInstanceDice).diceNum;
         if(!(_loc7_ == -1) && _loc7_ < _loc6_ && (isPushableEntity(param2)))
         {
            _loc11_ = _loc8_.diceNum;
            _loc12_ = MapPoint.fromCellId(param2.disposition.cellId);
            _loc13_ = MapPoint.fromCellId(param1);
            _loc14_ = _loc12_;
            _loc16_ = _loc12_.advancedOrientationTo(_loc13_);
            _loc18_ = 0;
            _loc17_ = 0;
            while(_loc17_ < _loc11_)
            {
               _loc15_ = _loc14_.getNearestCellInDirection(_loc16_);
               if((_loc15_) && !isBlockingCell(_loc15_.cellId,_loc14_.cellId))
               {
                  _loc18_++;
                  _loc14_ = _loc15_;
                  _loc17_++;
                  continue;
               }
               break;
            }
            _loc5_ = _loc10_ - _loc18_;
         }
         else
         {
            _loc5_ = _loc10_;
         }
         return _loc5_;
      }
      
      private static function hasMinSize(param1:int) : Boolean
      {
         return param1 == SpellShapeEnum.C || param1 == SpellShapeEnum.X || param1 == SpellShapeEnum.Q || param1 == SpellShapeEnum.plus || param1 == SpellShapeEnum.sharp;
      }
      
      public static function hasPushDamages(param1:int, param2:int, param3:Vector.<EffectInstance>, param4:EffectInstance, param5:int) : Boolean
      {
         var _loc8_:GameFightFighterInformations = null;
         var _loc9_:uint = 0;
         var _loc10_:MapPoint = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:MapPoint = null;
         var _loc14_:MapPoint = null;
         var _loc15_:MapPoint = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc6_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(!(param4.effectId == PUSH_EFFECT_ID) || !_loc6_)
         {
            return false;
         }
         var _loc7_:GameFightFighterInformations = _loc6_.getEntityInfos(param2) as GameFightFighterInformations;
         if((_loc7_) && (isPushableEntity(_loc7_)))
         {
            _loc8_ = _loc6_.getEntityInfos(param1) as GameFightFighterInformations;
            _loc9_ = !hasMinSize(param4.zoneShape)?_loc8_.disposition.cellId:param5;
            _loc10_ = MapPoint.fromCellId(_loc9_);
            _loc11_ = _loc10_.advancedOrientationTo(MapPoint.fromCellId(_loc7_.disposition.cellId),false);
            _loc12_ = getPushForce(_loc9_,_loc7_,param3,param4);
            _loc13_ = MapPoint.fromCellId(_loc7_.disposition.cellId);
            _loc15_ = _loc13_.getNearestCellInDirection(_loc11_);
            _loc16_ = _loc12_;
            _loc17_ = 0;
            while(_loc17_ < _loc12_)
            {
               if(_loc15_)
               {
                  if(isBlockingCell(_loc15_.cellId,!_loc14_?_loc13_.cellId:_loc14_.cellId))
                  {
                     break;
                  }
                  _loc16_--;
                  _loc14_ = _loc15_;
                  _loc15_ = _loc15_.getNearestCellInDirection(_loc11_);
               }
               _loc17_++;
            }
            return _loc16_ > 0;
         }
         return false;
      }
      
      public static function isBlockingCell(param1:int, param2:int, param3:Boolean = true) : Boolean
      {
         var _loc6_:MapPoint = null;
         var _loc7_:MapPoint = null;
         var _loc8_:uint = 0;
         var _loc9_:MapPoint = null;
         var _loc10_:MapPoint = null;
         var _loc4_:GraphicCell = InteractiveCellManager.getInstance().getCell(param1);
         var _loc5_:Boolean = (_loc4_) && !_loc4_.visible || (EntitiesManager.getInstance().getEntityOnCell(param1,AnimatedCharacter));
         if(!_loc5_ && (param3))
         {
            _loc6_ = MapPoint.fromCellId(param2);
            _loc7_ = MapPoint.fromCellId(param1);
            _loc8_ = _loc6_.orientationTo(_loc7_);
            if(_loc8_ % 2 == 0)
            {
               switch(_loc8_)
               {
                  case DirectionsEnum.RIGHT:
                     _loc9_ = _loc7_.getNearestCellInDirection(DirectionsEnum.UP_LEFT);
                     _loc10_ = _loc7_.getNearestCellInDirection(DirectionsEnum.DOWN_LEFT);
                     break;
                  case DirectionsEnum.DOWN:
                     _loc9_ = _loc7_.getNearestCellInDirection(DirectionsEnum.UP_LEFT);
                     _loc10_ = _loc7_.getNearestCellInDirection(DirectionsEnum.UP_RIGHT);
                     break;
                  case DirectionsEnum.LEFT:
                     _loc9_ = _loc7_.getNearestCellInDirection(DirectionsEnum.UP_RIGHT);
                     _loc10_ = _loc7_.getNearestCellInDirection(DirectionsEnum.DOWN_RIGHT);
                     break;
                  case DirectionsEnum.UP:
                     _loc9_ = _loc7_.getNearestCellInDirection(DirectionsEnum.DOWN_LEFT);
                     _loc10_ = _loc7_.getNearestCellInDirection(DirectionsEnum.DOWN_RIGHT);
                     break;
               }
               _loc5_ = (_loc9_) && (isBlockingCell(_loc9_.cellId,-1,false)) || (_loc10_) && (isBlockingCell(_loc10_.cellId,-1,false));
            }
         }
         return _loc5_;
      }
      
      public static function isPathBlocked(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:* = false;
         var _loc5_:MapPoint = null;
         var _loc6_:MapPoint = MapPoint.fromCellId(param1);
         while(true)
         {
            if((_loc6_) && !_loc4_)
            {
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.getNearestCellInDirection(param3);
               if(_loc6_)
               {
                  _loc4_ = isBlockingCell(_loc6_.cellId,_loc5_.cellId);
                  if(_loc6_.cellId != param2)
                  {
                     continue;
                  }
               }
               else
               {
                  break;
               }
            }
            return _loc4_;
         }
         return true;
      }
      
      public static function getCellIdInDirection(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:MapPoint = MapPoint.fromCellId(param1);
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc4_ = _loc4_.getNearestCellInDirection(param3);
            if(!_loc4_)
            {
               return -1;
            }
            _loc6_++;
         }
         return _loc4_.cellId;
      }
      
      public static function getEntitiesInDirection(param1:int, param2:int, param3:int) : Vector.<IEntity>
      {
         var _loc4_:Vector.<IEntity> = null;
         var _loc5_:IEntity = null;
         var _loc6_:MapPoint = MapPoint.fromCellId(param1);
         var _loc7_:MapPoint = _loc6_.getNearestCellInDirection(param3);
         var _loc8_:* = 0;
         while((_loc7_) && _loc8_ < param2)
         {
            _loc5_ = EntitiesManager.getInstance().getEntityOnCell(_loc7_.cellId,AnimatedCharacter);
            if(_loc5_)
            {
               if(!_loc4_)
               {
                  _loc4_ = new Vector.<IEntity>(0);
               }
               _loc4_.push(_loc5_);
            }
            _loc7_ = _loc7_.getNearestCellInDirection(param3);
            _loc8_++;
         }
         return _loc4_;
      }
      
      public static function isPushableEntity(param1:GameFightFighterInformations) : Boolean
      {
         var _loc5_:Monster = null;
         var _loc2_:Array = FightersStateManager.getInstance().getStates(param1.contextualId);
         var _loc3_:Boolean = (_loc2_) && (!(_loc2_.indexOf(6) == -1) || !(_loc2_.indexOf(97) == -1));
         var _loc4_:* = true;
         if(param1 is GameFightMonsterInformations)
         {
            _loc5_ = Monster.getMonsterById((param1 as GameFightMonsterInformations).creatureGenericId);
            _loc4_ = _loc5_.canBePushed;
         }
         return !_loc3_ && (_loc4_);
      }
   }
}
