package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildChangeMemberParametersAction extends Object implements Action
   {
      
      public function GuildChangeMemberParametersAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:Array) : GuildChangeMemberParametersAction {
         var _loc5_:GuildChangeMemberParametersAction = new GuildChangeMemberParametersAction();
         _loc5_.memberId = param1;
         _loc5_.rank = param2;
         _loc5_.experienceGivenPercent = param3;
         _loc5_.rights = param4;
         return _loc5_;
      }
      
      public var memberId:uint;
      
      public var rank:uint;
      
      public var experienceGivenPercent:uint;
      
      public var rights:Array;
   }
}
