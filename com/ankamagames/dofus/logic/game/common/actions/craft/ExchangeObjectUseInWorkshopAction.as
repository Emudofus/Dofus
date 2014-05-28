package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeObjectUseInWorkshopAction extends Object implements Action
   {
      
      public function ExchangeObjectUseInWorkshopAction() {
         super();
      }
      
      public static function create(pObjectUID:uint, pQuantity:uint) : ExchangeObjectUseInWorkshopAction {
         var action:ExchangeObjectUseInWorkshopAction = new ExchangeObjectUseInWorkshopAction();
         action.objectUID = pObjectUID;
         action.quantity = pQuantity;
         return action;
      }
      
      public var objectUID:uint;
      
      public var quantity:uint;
   }
}
