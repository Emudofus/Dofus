package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopArticlesListRequestAction extends Object implements Action
   {
      
      public function ShopArticlesListRequestAction() {
         super();
      }
      
      public static function create(categoryId:int, pageId:int = 1) : ShopArticlesListRequestAction {
         var action:ShopArticlesListRequestAction = new ShopArticlesListRequestAction();
         action.categoryId = categoryId;
         action.pageId = pageId;
         return action;
      }
      
      public var categoryId:int;
      
      public var pageId:int;
   }
}
