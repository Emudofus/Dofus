package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class DisplayContextualMenuAction implements Action 
    {

        public var playerId:uint;


        public static function create(playerId:uint):DisplayContextualMenuAction
        {
            var o:DisplayContextualMenuAction = new (DisplayContextualMenuAction)();
            o.playerId = playerId;
            return (o);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

