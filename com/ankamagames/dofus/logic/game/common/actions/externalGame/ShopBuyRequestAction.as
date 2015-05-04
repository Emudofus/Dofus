package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopBuyRequestAction extends Object implements Action
   {
      
      public function ShopBuyRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:int) : ShopBuyRequestAction
      {
         var _loc3_:ShopBuyRequestAction = new ShopBuyRequestAction();
         _loc3_.articleId = param1;
         _loc3_.quantity = param2;
         return _loc3_;
      }
      
      public var articleId:int;
      
      public var quantity:int;
   }
}
