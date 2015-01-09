package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopArticlesListRequestAction implements Action 
    {

        public var categoryId:int;
        public var pageId:int;


        public static function create(categoryId:int, pageId:int=1):ShopArticlesListRequestAction
        {
            var action:ShopArticlesListRequestAction = new (ShopArticlesListRequestAction)();
            action.categoryId = categoryId;
            action.pageId = pageId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

