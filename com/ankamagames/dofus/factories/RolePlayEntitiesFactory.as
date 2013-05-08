package com.ankamagames.dofus.factories
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.context.fight.FightCommonInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.network.enums.TeamTypeEnum;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.enums.FightTypeEnum;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;


   public class RolePlayEntitiesFactory extends Object
   {
         

      public function RolePlayEntitiesFactory() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RolePlayEntitiesFactory));

      private static const TEAM_CHALLENGER_LOOK:String = "{19}";

      private static const TEAM_DEFENDER_LOOK:String = "{20}";

      private static const TEAM_TAX_COLLECTOR_LOOK:String = "{21}";

      private static const TEAM_ANGEL_LOOK:String = "{32}";

      private static const TEAM_DEMON_LOOK:String = "{33}";

      private static const TEAM_NEUTRAL_LOOK:String = "{1237}";

      private static const TEAM_BAD_ANGEL_LOOK:String = "{1235}";

      private static const TEAM_BAD_DEMON_LOOK:String = "{1236}";

      public static function createFightEntity(fightInfos:FightCommonInformations, teamInfos:FightTeamInformations, position:MapPoint) : IEntity {
         var teamLook:String = null;
         var entityId:int = EntitiesManager.getInstance().getFreeEntityId();
         switch(fightInfos.fightType)
         {
            case FightTypeEnum.FIGHT_TYPE_AGRESSION:
            case FightTypeEnum.FIGHT_TYPE_PvMA:
               switch(teamInfos.teamSide)
               {
                  case AlignmentSideEnum.ALIGNMENT_ANGEL:
                     if(teamInfos.teamTypeId==TeamTypeEnum.TEAM_TYPE_BAD_PLAYER)
                     {
                        teamLook=TEAM_BAD_ANGEL_LOOK;
                     }
                     else
                     {
                        teamLook=TEAM_ANGEL_LOOK;
                     }
                     break;
                  case AlignmentSideEnum.ALIGNMENT_EVIL:
                     if(teamInfos.teamTypeId==TeamTypeEnum.TEAM_TYPE_BAD_PLAYER)
                     {
                        teamLook=TEAM_BAD_DEMON_LOOK;
                     }
                     else
                     {
                        teamLook=TEAM_DEMON_LOOK;
                     }
                     break;
                  case AlignmentSideEnum.ALIGNMENT_NEUTRAL:
                  case AlignmentSideEnum.ALIGNMENT_MERCENARY:
                     teamLook=TEAM_NEUTRAL_LOOK;
                     break;
                  case AlignmentSideEnum.ALIGNMENT_WITHOUT:
                     teamLook=TEAM_CHALLENGER_LOOK;
                     break;
               }
               break;
            case FightTypeEnum.FIGHT_TYPE_PvT:
               switch(teamInfos.teamId)
               {
                  case TeamEnum.TEAM_DEFENDER:
                     teamLook=TEAM_TAX_COLLECTOR_LOOK;
                     break;
                  case TeamEnum.TEAM_CHALLENGER:
                     teamLook=TEAM_CHALLENGER_LOOK;
                     break;
               }
               break;
            case FightTypeEnum.FIGHT_TYPE_CHALLENGE:
               teamLook=TEAM_CHALLENGER_LOOK;
               break;
            default:
               switch(teamInfos.teamId)
               {
                  case TeamEnum.TEAM_CHALLENGER:
                     teamLook=TEAM_CHALLENGER_LOOK;
                     break;
                  case TeamEnum.TEAM_DEFENDER:
                     teamLook=TEAM_DEFENDER_LOOK;
                     break;
               }
         }
         var challenger:IEntity = new AnimatedCharacter(entityId,TiphonEntityLook.fromString(teamLook));
         challenger.position=position;
         IAnimated(challenger).setDirection(0);
         return challenger;
      }


   }

}