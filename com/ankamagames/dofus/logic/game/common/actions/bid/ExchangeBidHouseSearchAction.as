package com.ankamagames.dofus.logic.game.common.actions.bid
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeBidHouseSearchAction extends Object implements Action
   {
      
      public function ExchangeBidHouseSearchAction() {
         super();
      }
      
      public static function create(pType:uint, pGenId:uint) : ExchangeBidHouseSearchAction {
         var a:ExchangeBidHouseSearchAction = new ExchangeBidHouseSearchAction();
         a.type = pType;
         a.genId = pGenId;
         return a;
      }
      
      public var type:uint;
      
      public var genId:uint;
   }
}
