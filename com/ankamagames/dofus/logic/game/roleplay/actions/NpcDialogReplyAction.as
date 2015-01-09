package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class NpcDialogReplyAction implements Action 
    {

        public var replyId:uint;


        public static function create(replyId:int):NpcDialogReplyAction
        {
            var a:NpcDialogReplyAction = new (NpcDialogReplyAction)();
            a.replyId = replyId;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions

