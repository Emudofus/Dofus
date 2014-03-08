package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ClearChatAction extends Object implements Action
   {
      
      public function ClearChatAction() {
         super();
      }
      
      public static function create(channel:Array) : ClearChatAction {
         var a:ClearChatAction = new ClearChatAction();
         a.channel = channel;
         return a;
      }
      
      public var channel:Array;
   }
}
