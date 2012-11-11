package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NpcDialogReplyAction extends Object implements Action
    {
        public var replyId:uint;

        public function NpcDialogReplyAction()
        {
            return;
        }// end function

        public static function create(param1:int) : NpcDialogReplyAction
        {
            var _loc_2:* = new NpcDialogReplyAction;
            _loc_2.replyId = param1;
            return _loc_2;
        }// end function

    }
}
