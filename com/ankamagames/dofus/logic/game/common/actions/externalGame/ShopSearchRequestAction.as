package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopSearchRequestAction extends Object implements Action
   {
      
      public function ShopSearchRequestAction()
      {
         super();
      }
      
      public static function create(param1:String, param2:int = 1) : ShopSearchRequestAction
      {
         var _loc3_:ShopSearchRequestAction = new ShopSearchRequestAction();
         _loc3_.text = param1;
         _loc3_.pageId = param2;
         return _loc3_;
      }
      
      public var text:String;
      
      public var pageId:int;
   }
}
