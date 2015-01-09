package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class FriendsListRequestAction implements Action 
    {


        public static function create():FriendsListRequestAction
        {
            var a:FriendsListRequestAction = new (FriendsListRequestAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.social

