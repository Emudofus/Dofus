package com.ankamagames.dofus.logic.game.common.actions.chat
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class ChatSmileyRequestAction implements Action 
    {

        public var smileyId:int;


        public static function create(id:int):ChatSmileyRequestAction
        {
            var a:ChatSmileyRequestAction = new (ChatSmileyRequestAction)();
            a.smileyId = id;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.chat

