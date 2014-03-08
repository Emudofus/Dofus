package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationEmblemValidAction extends Object implements Action
   {
      
      public function GuildModificationEmblemValidAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint) : GuildModificationEmblemValidAction {
         var _loc5_:GuildModificationEmblemValidAction = new GuildModificationEmblemValidAction();
         _loc5_.upEmblemId = param1;
         _loc5_.upColorEmblem = param2;
         _loc5_.backEmblemId = param3;
         _loc5_.backColorEmblem = param4;
         return _loc5_;
      }
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
