package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopSearchRequestAction implements Action 
    {

        public var text:String;
        public var pageId:int;


        public static function create(text:String, pageId:int=1):ShopSearchRequestAction
        {
            var action:ShopSearchRequestAction = new (ShopSearchRequestAction)();
            action.text = text;
            action.pageId = pageId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

