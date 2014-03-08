package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   
   public class Fight extends Object
   {
      
      public function Fight(param1:uint, param2:Vector.<FightTeam>) {
         super();
         this.fightId = param1;
         this.teams = param2;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Fight));
      
      public var fightId:uint;
      
      public var teams:Vector.<FightTeam>;
      
      public function getTeamByType(param1:uint) : FightTeam {
         var _loc2_:FightTeam = null;
         for each (_loc2_ in this.teams)
         {
            if(_loc2_.teamType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTeamById(param1:uint) : FightTeam {
         var _loc2_:FightTeam = null;
         for each (_loc2_ in this.teams)
         {
            if(_loc2_.teamInfos.teamId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
