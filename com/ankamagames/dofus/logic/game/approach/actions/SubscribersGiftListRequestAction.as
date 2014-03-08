package com.ankamagames.dofus.logic.game.approach.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SubscribersGiftListRequestAction extends Object implements Action
   {
      
      public function SubscribersGiftListRequestAction() {
         super();
      }
      
      public static function create() : SubscribersGiftListRequestAction {
         var _loc1_:SubscribersGiftListRequestAction = new SubscribersGiftListRequestAction();
         return _loc1_;
      }
   }
}
