package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseBuyAction extends Object implements Action
   {
      
      public function HouseBuyAction() {
         super();
      }
      
      public static function create(proposedPrice:uint) : HouseBuyAction {
         var action:HouseBuyAction = new HouseBuyAction();
         action.proposedPrice = proposedPrice;
         return action;
      }
      
      public var proposedPrice:uint;
   }
}
