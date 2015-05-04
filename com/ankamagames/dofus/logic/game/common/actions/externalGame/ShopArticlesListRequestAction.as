package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopArticlesListRequestAction extends Object implements Action
   {
      
      public function ShopArticlesListRequestAction()
      {
         super();
      }
      
      public static function create(param1:int, param2:int = 1) : ShopArticlesListRequestAction
      {
         var _loc3_:ShopArticlesListRequestAction = new ShopArticlesListRequestAction();
         _loc3_.categoryId = param1;
         _loc3_.pageId = param2;
         return _loc3_;
      }
      
      public var categoryId:int;
      
      public var pageId:int;
   }
}
