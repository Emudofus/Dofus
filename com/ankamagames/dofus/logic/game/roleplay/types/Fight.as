package com.ankamagames.dofus.logic.game.roleplay.types
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Fight extends Object
    {
        public var fightId:uint;
        public var teams:Vector.<FightTeam>;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Fight));

        public function Fight(param1:uint, param2:Vector.<FightTeam>)
        {
            this.fightId = param1;
            this.teams = param2;
            return;
        }// end function

        public function getTeamByType(param1:uint) : FightTeam
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.teams)
            {
                
                if (_loc_2.teamType == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getTeamById(param1:uint) : FightTeam
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.teams)
            {
                
                if (_loc_2.teamInfos.teamId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

    }
}
