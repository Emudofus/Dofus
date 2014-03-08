package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.Constants;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.logic.game.fight.managers.FightersStateManager;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   
   public class TackleUtil extends Object
   {
      
      public function TackleUtil() {
         super();
      }
      
      public static function getTackle(param1:GameFightFighterInformations, param2:MapPoint) : Number {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:CharacterCharacteristicsInformations = null;
         var _loc7_:* = 0;
         var _loc8_:Array = null;
         var _loc9_:* = NaN;
         var _loc10_:IEntity = null;
         var _loc11_:GameFightFighterInformations = null;
         var _loc12_:* = 0;
         var _loc13_:* = NaN;
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(Constants.DETERMINIST_TACKLE)
         {
            if(!canBeTackled(param1,param2))
            {
               return 1;
            }
            _loc4_ = param2.x;
            _loc5_ = param2.y;
            _loc6_ = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
            _loc7_ = param1.stats.tackleEvade;
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
            _loc8_ = new Array();
            if(MapPoint.isInMap(_loc4_-1,_loc5_))
            {
               _loc8_.push(getTacklerOnCell(MapPoint.fromCoords(_loc4_-1,_loc5_).cellId));
            }
            if(MapPoint.isInMap(_loc4_ + 1,_loc5_))
            {
               _loc8_.push(getTacklerOnCell(MapPoint.fromCoords(_loc4_ + 1,_loc5_).cellId));
            }
            if(MapPoint.isInMap(_loc4_,_loc5_-1))
            {
               _loc8_.push(getTacklerOnCell(MapPoint.fromCoords(_loc4_,_loc5_-1).cellId));
            }
            if(MapPoint.isInMap(_loc4_,_loc5_ + 1))
            {
               _loc8_.push(getTacklerOnCell(MapPoint.fromCoords(_loc4_,_loc5_ + 1).cellId));
            }
            _loc9_ = 1;
            for each (_loc10_ in _loc8_)
            {
               if(_loc10_)
               {
                  _loc11_ = _loc3_.getEntityInfos(_loc10_.id) as GameFightFighterInformations;
                  if(canBeTackler(_loc11_,param1))
                  {
                     _loc12_ = _loc11_.stats.tackleBlock;
                     if(_loc12_ < 0)
                     {
                        _loc12_ = 0;
                     }
                     _loc13_ = (_loc7_ + 2) / (_loc12_ + 2) / 2;
                     if(_loc13_ < 1)
                     {
                        _loc9_ = _loc9_ * _loc13_;
                     }
                  }
               }
            }
            return _loc9_;
         }
         return 1;
      }
      
      public static function getTackleForFighter(param1:GameFightFighterInformations, param2:GameFightFighterInformations) : Number {
         if(!Constants.DETERMINIST_TACKLE)
         {
            return 1;
         }
         if(!canBeTackled(param2))
         {
            return 1;
         }
         if(!canBeTackler(param1,param2))
         {
            return 1;
         }
         var _loc3_:int = param2.stats.tackleEvade;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:int = param1.stats.tackleBlock;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         return (_loc3_ + 2) / (_loc4_ + 2) / 2;
      }
      
      public static function getTacklerOnCell(param1:int) : AnimatedCharacter {
         var _loc4_:AnimatedCharacter = null;
         var _loc5_:GameFightFighterInformations = null;
         var _loc2_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc3_:Array = EntitiesManager.getInstance().getEntitiesOnCell(param1,AnimatedCharacter);
         for each (_loc4_ in _loc3_)
         {
            _loc5_ = _loc2_.getEntityInfos(_loc4_.id) as GameFightFighterInformations;
            if(_loc5_.disposition is FightEntityDispositionInformations)
            {
               if(!FightersStateManager.getInstance().hasState(_loc4_.id,8))
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public static function canBeTackled(param1:GameFightFighterInformations, param2:MapPoint=null) : Boolean {
         var _loc3_:FightEntityDispositionInformations = null;
         if((FightersStateManager.getInstance().hasState(param1.contextualId,96)) || (FightersStateManager.getInstance().hasState(param1.contextualId,6)) || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
         {
            return false;
         }
         if(param1.disposition is FightEntityDispositionInformations)
         {
            _loc3_ = param1.disposition as FightEntityDispositionInformations;
            if((_loc3_.carryingCharacterId) && (!param2 || param1.disposition.cellId == param2.cellId))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function canBeTackler(param1:GameFightFighterInformations, param2:GameFightFighterInformations) : Boolean {
         var _loc5_:Monster = null;
         if((FightersStateManager.getInstance().hasState(param1.contextualId,8)) || (FightersStateManager.getInstance().hasState(param1.contextualId,6)) || (FightersStateManager.getInstance().hasState(param1.contextualId,95)) || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE || param1.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
         {
            return false;
         }
         var _loc3_:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var _loc4_:GameFightFighterInformations = _loc3_.getEntityInfos(param1.contextualId) as GameFightFighterInformations;
         if((_loc4_) && _loc4_.teamId == param2.teamId)
         {
            return false;
         }
         if(param1 is GameFightMonsterInformations)
         {
            _loc5_ = Monster.getMonsterById((param1 as GameFightMonsterInformations).creatureGenericId);
            if(!_loc5_.canTackle)
            {
               return false;
            }
         }
         if(!param1.alive)
         {
            return false;
         }
         return true;
      }
      
      public static function isTackling(param1:GameFightFighterInformations, param2:GameFightFighterInformations, param3:MovementPath) : Boolean {
         var _loc5_:PathElement = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:AnimatedCharacter = null;
         var _loc4_:* = false;
         if((param3) && (canBeTackler(param2,param1)))
         {
            for each (_loc5_ in param3.path)
            {
               if(canBeTackled(param1,_loc5_.step))
               {
                  _loc6_ = _loc5_.step.x;
                  _loc7_ = _loc5_.step.y;
                  _loc10_ = _loc6_-1;
                  while(_loc10_ <= _loc6_ + 1)
                  {
                     _loc11_ = _loc7_-1;
                     while(_loc11_ <= _loc7_ + 1)
                     {
                        _loc12_ = getTacklerOnCell(MapPoint.fromCoords(_loc10_,_loc11_).cellId);
                        if((_loc12_) && _loc12_.id == param2.contextualId)
                        {
                           _loc8_ = param1.stats.tackleEvade < 0?0:param1.stats.tackleEvade;
                           _loc9_ = param2.stats.tackleBlock < 0?0:param2.stats.tackleBlock;
                           return (_loc8_ + 2) / (_loc9_ + 2) / 2 < 1;
                        }
                        _loc11_++;
                     }
                     _loc10_++;
                  }
               }
            }
         }
         return _loc4_;
      }
   }
}
