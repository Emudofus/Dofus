package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseSellAction extends Object implements Action
   {
      
      public function HouseSellAction() {
         super();
      }
      
      public static function create(amount:uint) : HouseSellAction {
         var action:HouseSellAction = new HouseSellAction();
         action.amount = amount;
         return action;
      }
      
      public var amount:uint;
   }
}
