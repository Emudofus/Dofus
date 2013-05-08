package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;


   public class GuildModificationValidAction extends Object implements Action
   {
         

      public function GuildModificationValidAction() {
         super();
      }

      public static function create(pGuildName:String, pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint) : GuildModificationValidAction {
         var action:GuildModificationValidAction = new GuildModificationValidAction();
         action.guildName=pGuildName;
         action.upEmblemId=pUpEmblemId;
         action.upColorEmblem=pUpColorEmblem;
         action.backEmblemId=pBackEmblemId;
         action.backColorEmblem=pBackColorEmblem;
         return action;
      }

      public var guildName:String;

      public var upEmblemId:uint;

      public var upColorEmblem:uint;

      public var backEmblemId:uint;

      public var backColorEmblem:uint;
   }

}