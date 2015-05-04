package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockBuyRequestAction extends Object implements Action
   {
      
      public function PaddockBuyRequestAction()
      {
         super();
      }
      
      public static function create(param1:uint) : PaddockBuyRequestAction
      {
         var _loc2_:PaddockBuyRequestAction = new PaddockBuyRequestAction();
         _loc2_.proposedPrice = param1;
         return _loc2_;
      }
      
      public var proposedPrice:uint;
   }
}
