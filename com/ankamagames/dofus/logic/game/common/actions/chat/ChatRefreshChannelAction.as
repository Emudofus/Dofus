package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatRefreshChannelAction extends Object implements Action
   {
      
      public function ChatRefreshChannelAction() {
         super();
      }
      
      public static function create() : ChatRefreshChannelAction {
         var a:ChatRefreshChannelAction = new ChatRefreshChannelAction();
         return a;
      }
   }
}
