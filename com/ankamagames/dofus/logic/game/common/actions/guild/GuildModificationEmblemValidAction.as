package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildModificationEmblemValidAction extends Object implements Action
   {
      
      public function GuildModificationEmblemValidAction() {
         super();
      }
      
      public static function create(pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint) : GuildModificationEmblemValidAction {
         var action:GuildModificationEmblemValidAction = new GuildModificationEmblemValidAction();
         action.upEmblemId = pUpEmblemId;
         action.upColorEmblem = pUpColorEmblem;
         action.backEmblemId = pBackEmblemId;
         action.backColorEmblem = pBackColorEmblem;
         return action;
      }
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
   }
}
