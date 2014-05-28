package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatSmileyRequestAction extends Object implements Action
   {
      
      public function ChatSmileyRequestAction() {
         super();
      }
      
      public static function create(id:int) : ChatSmileyRequestAction {
         var a:ChatSmileyRequestAction = new ChatSmileyRequestAction();
         a.smileyId = id;
         return a;
      }
      
      public var smileyId:int;
   }
}
