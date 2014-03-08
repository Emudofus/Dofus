package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseSellFromInsideAction extends Object implements Action
   {
      
      public function HouseSellFromInsideAction() {
         super();
      }
      
      public static function create(amount:uint) : HouseSellFromInsideAction {
         var action:HouseSellFromInsideAction = new HouseSellFromInsideAction();
         action.amount = amount;
         return action;
      }
      
      public var amount:uint;
   }
}
