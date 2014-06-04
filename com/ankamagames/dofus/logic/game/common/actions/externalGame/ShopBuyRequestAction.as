package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopBuyRequestAction extends Object implements Action
   {
      
      public function ShopBuyRequestAction() {
         super();
      }
      
      public static function create(articleId:int, quantity:int) : ShopBuyRequestAction {
         var action:ShopBuyRequestAction = new ShopBuyRequestAction();
         action.articleId = articleId;
         action.quantity = quantity;
         return action;
      }
      
      public var articleId:int;
      
      public var quantity:int;
   }
}
