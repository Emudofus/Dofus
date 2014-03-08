package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeSetCraftRecipeAction extends Object implements Action
   {
      
      public function ExchangeSetCraftRecipeAction() {
         super();
      }
      
      public static function create(param1:uint) : ExchangeSetCraftRecipeAction {
         var _loc2_:ExchangeSetCraftRecipeAction = new ExchangeSetCraftRecipeAction();
         _loc2_.recipeId = param1;
         return _loc2_;
      }
      
      public var recipeId:uint;
   }
}
