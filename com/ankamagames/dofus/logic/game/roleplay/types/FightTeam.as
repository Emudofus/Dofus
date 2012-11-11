package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class FightTeam extends GameContextActorInformations
    {
        public var fight:Fight;
        public var teamType:uint;
        public var teamEntity:IEntity;
        public var teamInfos:FightTeamInformations;
        public var teamOptions:Array;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FightTeam));

        public function FightTeam(param1:Fight, param2:uint, param3:IEntity, param4:FightTeamInformations, param5:FightOptionsInformations)
        {
            this.fight = param1;
            this.teamType = param2;
            this.teamEntity = param3;
            this.teamInfos = param4;
            this.teamOptions = new Array();
            this.teamOptions[FightOptionsEnum.FIGHT_OPTION_ASK_FOR_HELP] = param5.isAskingForHelp;
            this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_CLOSED] = param5.isClosed;
            this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_SECRET] = param5.isSecret;
            this.teamOptions[FightOptionsEnum.FIGHT_OPTION_SET_TO_PARTY_ONLY] = param5.isRestrictedToPartyOnly;
            return;
        }// end function

    }
}
