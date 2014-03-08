package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatRefreshChatAction extends Object implements Action
   {
      
      public function ChatRefreshChatAction() {
         super();
      }
      
      public static function create(currentTab:uint) : ChatRefreshChatAction {
         var a:ChatRefreshChatAction = new ChatRefreshChatAction();
         a.currentTab = currentTab;
         return a;
      }
      
      public var currentTab:uint;
   }
}
