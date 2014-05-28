package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeSetCraftRecipeAction extends Object implements Action
   {
      
      public function ExchangeSetCraftRecipeAction() {
         super();
      }
      
      public static function create(recipeId:uint) : ExchangeSetCraftRecipeAction {
         var action:ExchangeSetCraftRecipeAction = new ExchangeSetCraftRecipeAction();
         action.recipeId = recipeId;
         return action;
      }
      
      public var recipeId:uint;
   }
}
