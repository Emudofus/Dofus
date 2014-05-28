package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseTypeAction extends Object implements Action
   {
      
      public function ExchangeBidHouseTypeAction() {
         super();
      }
      
      public static function create(pType:uint) : ExchangeBidHouseTypeAction {
         var a:ExchangeBidHouseTypeAction = new ExchangeBidHouseTypeAction();
         a.type = pType;
         return a;
      }
      
      public var type:uint;
   }
}
