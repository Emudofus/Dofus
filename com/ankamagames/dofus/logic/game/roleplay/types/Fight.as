package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;

    public class Fight 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Fight));

        public var fightId:uint;
        public var teams:Vector.<FightTeam>;

        public function Fight(fightId:uint, teams:Vector.<FightTeam>)
        {
            this.fightId = fightId;
            this.teams = teams;
        }

        public function getTeamByType(teamType:uint):FightTeam
        {
            var team:FightTeam;
            for each (team in this.teams)
            {
                if (team.teamType == teamType)
                {
                    return (team);
                };
            };
            return (null);
        }

        public function getTeamById(teamId:uint):FightTeam
        {
            var team:FightTeam;
            for each (team in this.teams)
            {
                if (team.teamInfos.teamId == teamId)
                {
                    return (team);
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.types

