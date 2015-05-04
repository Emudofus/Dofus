package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopAuthentificationRequestAction extends Object implements Action
   {
      
      public function ShopAuthentificationRequestAction()
      {
         super();
      }
      
      public static function create() : ShopAuthentificationRequestAction
      {
         var _loc1_:ShopAuthentificationRequestAction = new ShopAuthentificationRequestAction();
         return _loc1_;
      }
   }
}
