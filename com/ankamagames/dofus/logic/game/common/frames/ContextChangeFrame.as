package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.logic.game.fight.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.context.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class ContextChangeFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ContextChangeFrame));

        public function ContextChangeFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.LOW;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:GameContextCreateMessage = null;
            var _loc_3:GameContextQuitMessage = null;
            switch(true)
            {
                case param1 is GameContextCreateMessage:
                {
                    _loc_2 = param1 as GameContextCreateMessage;
                    switch(_loc_2.context)
                    {
                        case GameContextEnum.ROLE_PLAY:
                        {
                            Kernel.getWorker().addFrame(new RoleplayContextFrame());
                            KernelEventsManager.getInstance().processCallback(HookList.ContextChanged, GameContextEnum.ROLE_PLAY);
                            break;
                        }
                        case GameContextEnum.FIGHT:
                        {
                            Kernel.getWorker().addFrame(new FightContextFrame());
                            KernelEventsManager.getInstance().processCallback(HookList.ContextChanged, GameContextEnum.FIGHT);
                            break;
                        }
                        default:
                        {
                            Kernel.panic(PanicMessages.WRONG_CONTEXT_CREATED, [_loc_2.context]);
                            break;
                            break;
                        }
                    }
                    return true;
                }
                case param1 is GameContextQuitAction:
                {
                    _loc_3 = new GameContextQuitMessage();
                    ConnectionsHandler.getConnection().send(_loc_3);
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
            return true;
        }// end function

    }
}
