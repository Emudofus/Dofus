package com.ankamagames.dofus.logic.game.roleplay.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.npc.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class NpcDialogFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(NpcDialogFrame));

        public function NpcDialogFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(true)
            {
                case param1 is NpcDialogQuestionMessage:
                {
                    _loc_2 = param1 as NpcDialogQuestionMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.NpcDialogQuestion, _loc_2.messageId, _loc_2.dialogParams, _loc_2.visibleReplies);
                    return true;
                }
                case param1 is NpcDialogReplyAction:
                {
                    _loc_3 = param1 as NpcDialogReplyAction;
                    _loc_4 = new NpcDialogReplyMessage();
                    _loc_4.initNpcDialogReplyMessage(_loc_3.replyId);
                    ConnectionsHandler.getConnection().send(_loc_4);
                    return true;
                }
                case param1 is LeaveDialogRequestAction:
                {
                    ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
                    return true;
                }
                case param1 is LeaveDialogMessage:
                {
                    _loc_5 = param1 as LeaveDialogMessage;
                    if (_loc_5.dialogType == DialogTypeEnum.DIALOG_DIALOG)
                    {
                        Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                        Kernel.getWorker().removeFrame(this);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return true;
        }// end function

    }
}
