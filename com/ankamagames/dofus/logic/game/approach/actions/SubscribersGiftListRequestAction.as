package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SubscribersGiftListRequestAction extends Object implements Action
   {
      
      public function SubscribersGiftListRequestAction() {
         super();
      }
      
      public static function create() : SubscribersGiftListRequestAction {
         var action:SubscribersGiftListRequestAction = new SubscribersGiftListRequestAction();
         return action;
      }
   }
}
