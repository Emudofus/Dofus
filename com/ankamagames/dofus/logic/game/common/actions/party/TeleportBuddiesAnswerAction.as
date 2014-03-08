package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TeleportBuddiesAnswerAction extends Object implements Action
   {
      
      public function TeleportBuddiesAnswerAction() {
         super();
      }
      
      public static function create(param1:Boolean) : TeleportBuddiesAnswerAction {
         var _loc2_:TeleportBuddiesAnswerAction = new TeleportBuddiesAnswerAction();
         _loc2_.accept = param1;
         return _loc2_;
      }
      
      public var accept:Boolean;
   }
}
