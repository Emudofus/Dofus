package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightOptionsInformations;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.network.enums.FightOptionsEnum;


   public class FightTeam extends GameContextActorInformations
   {
         

      public function FightTeam(fight:Fight, teamType:uint, teamEntity:IEntity, teamInfos:FightTeamInformations, teamOptions:FightOptionsInformations) {
         super();
         this.fight=fight;
         this.teamType=teamType;
         this.teamEntity=teamEntity;
         this.teamInfos=teamInfos;
         this.look=EntityLookAdapter.toNetwork((teamEntity as AnimatedCharacter).look);
         this.teamOptions=new Array();
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP]=teamOptions.isAskingForHelp;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_CLOSED]=teamOptions.isClosed;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_SECRET]=teamOptions.isSecret;
         this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY]=teamOptions.isRestrictedToPartyOnly;
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTeam));

      public var fight:Fight;

      public var teamType:uint;

      public var teamEntity:IEntity;

      public var teamInfos:FightTeamInformations;

      public var teamOptions:Array;
   }

}