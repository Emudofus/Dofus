package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class EmotePlayRequestAction implements Action 
    {

        public var emoteId:uint;


        public static function create(emoteId:uint):EmotePlayRequestAction
        {
            var a:EmotePlayRequestAction = new (EmotePlayRequestAction)();
            a.emoteId = emoteId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

