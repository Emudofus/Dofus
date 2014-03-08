package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatSmileyRequestAction extends Object implements Action
   {
      
      public function ChatSmileyRequestAction() {
         super();
      }
      
      public static function create(param1:int) : ChatSmileyRequestAction {
         var _loc2_:ChatSmileyRequestAction = new ChatSmileyRequestAction();
         _loc2_.smileyId = param1;
         return _loc2_;
      }
      
      public var smileyId:int;
   }
}
