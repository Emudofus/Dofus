package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ShopFrontPageRequestAction implements Action 
    {


        public static function create():ShopFrontPageRequestAction
        {
            var a:ShopFrontPageRequestAction = new (ShopFrontPageRequestAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.externalGame

