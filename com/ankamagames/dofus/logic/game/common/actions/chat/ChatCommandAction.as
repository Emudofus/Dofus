package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatCommandAction extends Object implements Action
   {
      
      public function ChatCommandAction() {
         super();
      }
      
      public static function create(command:String) : ChatCommandAction {
         var a:ChatCommandAction = new ChatCommandAction();
         a.command = command;
         return a;
      }
      
      public var command:String;
   }
}
