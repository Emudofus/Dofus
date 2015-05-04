package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopFrontPageRequestAction extends Object implements Action
   {
      
      public function ShopFrontPageRequestAction()
      {
         super();
      }
      
      public static function create() : ShopFrontPageRequestAction
      {
         var _loc1_:ShopFrontPageRequestAction = new ShopFrontPageRequestAction();
         return _loc1_;
      }
   }
}
