package com.ankamagames.dofus.logic.game.common.actions.craft
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ExchangeSetCraftRecipeAction implements Action 
    {

        public var recipeId:uint;


        public static function create(recipeId:uint):ExchangeSetCraftRecipeAction
        {
            var action:ExchangeSetCraftRecipeAction = new (ExchangeSetCraftRecipeAction)();
            action.recipeId = recipeId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.craft

