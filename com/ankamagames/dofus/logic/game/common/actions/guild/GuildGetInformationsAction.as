package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildGetInformationsAction extends Object implements Action
   {
      
      public function GuildGetInformationsAction() {
         super();
      }
      
      public static function create(pInfoType:uint) : GuildGetInformationsAction {
         var action:GuildGetInformationsAction = new GuildGetInformationsAction();
         action.infoType = pInfoType;
         return action;
      }
      
      public var infoType:uint;
   }
}
