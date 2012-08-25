package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.roleplay.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.spell.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class SpellForgetDialogFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellForgetDialogFrame));

        public function SpellForgetDialogFrame()
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
            var _loc_2:ValidateSpellForgetAction = null;
            var _loc_3:ValidateSpellForgetMessage = null;
            switch(true)
            {
                case param1 is ValidateSpellForgetAction:
                {
                    _loc_2 = param1 as ValidateSpellForgetAction;
                    _loc_3 = new ValidateSpellForgetMessage();
                    _loc_3.initValidateSpellForgetMessage(_loc_2.spellId);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is LeaveDialogMessage:
                {
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                    Kernel.getWorker().removeFrame(this);
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
