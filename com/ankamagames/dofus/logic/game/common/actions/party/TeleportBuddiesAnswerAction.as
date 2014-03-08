package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportBuddiesAnswerAction extends Object implements Action
   {
      
      public function TeleportBuddiesAnswerAction() {
         super();
      }
      
      public static function create(accept:Boolean) : TeleportBuddiesAnswerAction {
         var a:TeleportBuddiesAnswerAction = new TeleportBuddiesAnswerAction();
         a.accept = accept;
         return a;
      }
      
      public var accept:Boolean;
   }
}
