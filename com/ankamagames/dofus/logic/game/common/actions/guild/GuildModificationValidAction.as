package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationValidAction extends Object implements Action
   {
      
      public function GuildModificationValidAction() {
         super();
      }
      
      public static function create(param1:String, param2:uint, param3:uint, param4:uint, param5:uint) : GuildModificationValidAction {
         var _loc6_:GuildModificationValidAction = new GuildModificationValidAction();
         _loc6_.guildName = param1;
         _loc6_.upEmblemId = param2;
         _loc6_.upColorEmblem = param3;
         _loc6_.backEmblemId = param4;
         _loc6_.backColorEmblem = param5;
         return _loc6_;
      }
      
      public var guildName:String;
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
