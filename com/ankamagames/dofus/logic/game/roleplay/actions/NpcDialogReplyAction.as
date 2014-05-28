package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NpcDialogReplyAction extends Object implements Action
   {
      
      public function NpcDialogReplyAction() {
         super();
      }
      
      public static function create(replyId:int) : NpcDialogReplyAction {
         var a:NpcDialogReplyAction = new NpcDialogReplyAction();
         a.replyId = replyId;
         return a;
      }
      
      public var replyId:uint;
   }
}
