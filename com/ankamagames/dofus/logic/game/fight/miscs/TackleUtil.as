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
      
      public static function getTackle(playerInfos:GameFightFighterInformations, position:MapPoint) : Number {
         var x:* = 0;
         var y:* = 0;
         var characteristics:CharacterCharacteristicsInformations = null;
         var evade:* = 0;
         var entities:Array = null;
         var evadePercent:* = NaN;
         var entity:IEntity = null;
         var infos:GameFightFighterInformations = null;
         var tackle:* = 0;
         var mod:* = NaN;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(Constants.DETERMINIST_TACKLE)
         {
            if(!canBeTackled(playerInfos,position))
            {
               return 1;
            }
            x = position.x;
            y = position.y;
            characteristics = CurrentPlayedFighterManager.getInstance().getCharacteristicsInformations();
            evade = playerInfos.stats.tackleEvade;
            if(evade < 0)
            {
               evade = 0;
            }
            entities = new Array();
            if(MapPoint.isInMap(x - 1,y))
            {
               entities.push(getTacklerOnCell(MapPoint.fromCoords(x - 1,y).cellId));
            }
            if(MapPoint.isInMap(x + 1,y))
            {
               entities.push(getTacklerOnCell(MapPoint.fromCoords(x + 1,y).cellId));
            }
            if(MapPoint.isInMap(x,y - 1))
            {
               entities.push(getTacklerOnCell(MapPoint.fromCoords(x,y - 1).cellId));
            }
            if(MapPoint.isInMap(x,y + 1))
            {
               entities.push(getTacklerOnCell(MapPoint.fromCoords(x,y + 1).cellId));
            }
            evadePercent = 1;
            for each(entity in entities)
            {
               if(entity)
               {
                  infos = entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
                  if(canBeTackler(infos,playerInfos))
                  {
                     tackle = infos.stats.tackleBlock;
                     if(tackle < 0)
                     {
                        tackle = 0;
                     }
                     mod = (evade + 2) / (tackle + 2) / 2;
                     if(mod < 1)
                     {
                        evadePercent = evadePercent * mod;
                     }
                  }
               }
            }
            return evadePercent;
         }
         return 1;
      }
      
      public static function getTackleForFighter(tackler:GameFightFighterInformations, tackled:GameFightFighterInformations) : Number {
         if(!Constants.DETERMINIST_TACKLE)
         {
            return 1;
         }
         if(!canBeTackled(tackled))
         {
            return 1;
         }
         if(!canBeTackler(tackler,tackled))
         {
            return 1;
         }
         var evade:int = tackled.stats.tackleEvade;
         if(evade < 0)
         {
            evade = 0;
         }
         var tackle:int = tackler.stats.tackleBlock;
         if(tackle < 0)
         {
            tackle = 0;
         }
         return (evade + 2) / (tackle + 2) / 2;
      }
      
      public static function getTacklerOnCell(cellId:int) : AnimatedCharacter {
         var entity:AnimatedCharacter = null;
         var infos:GameFightFighterInformations = null;
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId,AnimatedCharacter);
         for each(entity in entities)
         {
            infos = entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
            if(infos.disposition is FightEntityDispositionInformations)
            {
               if(!FightersStateManager.getInstance().hasState(entity.id,8))
               {
                  return entity;
               }
            }
         }
         return null;
      }
      
      public static function canBeTackled(fighter:GameFightFighterInformations, position:MapPoint = null) : Boolean {
         var fedi:FightEntityDispositionInformations = null;
         if((FightersStateManager.getInstance().hasState(fighter.contextualId,96)) || (FightersStateManager.getInstance().hasState(fighter.contextualId,6)) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED))
         {
            return false;
         }
         if(fighter.disposition is FightEntityDispositionInformations)
         {
            fedi = fighter.disposition as FightEntityDispositionInformations;
            if((fedi.carryingCharacterId) && ((!position) || (fighter.disposition.cellId == position.cellId)))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function canBeTackler(fighter:GameFightFighterInformations, target:GameFightFighterInformations) : Boolean {
         var monster:Monster = null;
         if((FightersStateManager.getInstance().hasState(fighter.contextualId,8)) || (FightersStateManager.getInstance().hasState(fighter.contextualId,6)) || (FightersStateManager.getInstance().hasState(fighter.contextualId,95)) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.INVISIBLE) || (fighter.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED))
         {
            return false;
         }
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var infos:GameFightFighterInformations = entitiesFrame.getEntityInfos(fighter.contextualId) as GameFightFighterInformations;
         if((infos) && (infos.teamId == target.teamId))
         {
            return false;
         }
         if(fighter is GameFightMonsterInformations)
         {
            monster = Monster.getMonsterById((fighter as GameFightMonsterInformations).creatureGenericId);
            if(!monster.canTackle)
            {
               return false;
            }
         }
         if(!fighter.alive)
         {
            return false;
         }
         return true;
      }
      
      public static function isTackling(pPlayer:GameFightFighterInformations, pTackler:GameFightFighterInformations, pPlayerPath:MovementPath) : Boolean {
         var pe:PathElement = null;
         var x:* = 0;
         var y:* = 0;
         var playerEvasion:* = 0;
         var tacklerBlock:* = 0;
         var i:* = 0;
         var j:* = 0;
         var ac:AnimatedCharacter = null;
         var tackling:Boolean = false;
         if((pPlayerPath) && (canBeTackler(pTackler,pPlayer)))
         {
            for each(pe in pPlayerPath.path)
            {
               if(canBeTackled(pPlayer,pe.step))
               {
                  x = pe.step.x;
                  y = pe.step.y;
                  i = x - 1;
                  while(i <= x + 1)
                  {
                     j = y - 1;
                     while(j <= y + 1)
                     {
                        ac = getTacklerOnCell(MapPoint.fromCoords(i,j).cellId);
                        if((ac) && (ac.id == pTackler.contextualId))
                        {
                           playerEvasion = pPlayer.stats.tackleEvade < 0?0:pPlayer.stats.tackleEvade;
                           tacklerBlock = pTackler.stats.tackleBlock < 0?0:pTackler.stats.tackleBlock;
                           return (playerEvasion + 2) / (tacklerBlock + 2) / 2 < 1;
                        }
                        j++;
                     }
                     i++;
                  }
               }
            }
         }
         return tackling;
      }
   }
}
