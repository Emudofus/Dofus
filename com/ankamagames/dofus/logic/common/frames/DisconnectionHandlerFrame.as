package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class DisconnectionHandlerFrame extends Object implements Frame
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DisconnectionHandlerFrame));
        public static var messagesAfterReset:Array = new Array();

        public function DisconnectionHandlerFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.LOWEST;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:ServerConnectionClosedMessage = null;
            var _loc_3:WrongSocketClosureReasonMessage = null;
            var _loc_4:UnexpectedSocketClosureMessage = null;
            var _loc_5:DisconnectionReason = null;
            switch(true)
            {
                case param1 is ServerConnectionClosedMessage:
                {
                    _loc_2 = param1 as ServerConnectionClosedMessage;
                    if (_loc_2.closedConnection == ConnectionsHandler.getConnection())
                    {
                        _log.trace("The connection was closed. Checking reasons.");
                        if (ConnectionsHandler.hasReceivedMsg)
                        {
                            _loc_5 = ConnectionsHandler.handleDisconnection();
                            if (!_loc_5.expected)
                            {
                                _log.warn("The connection was closed unexpectedly. Reseting.");
                                if (messagesAfterReset.length == 0)
                                {
                                    messagesAfterReset.unshift(new UnexpectedSocketClosureMessage());
                                }
                                Kernel.getInstance().reset();
                            }
                            else
                            {
                                _log.trace("The connection closure was expected (reason: " + _loc_5.reason + "). Dispatching the message.");
                                if (_loc_5.reason == DisconnectionReasonEnum.DISCONNECTED_BY_POPUP || _loc_5.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR)
                                {
                                    Kernel.getInstance().reset();
                                }
                                else
                                {
                                    Kernel.getWorker().process(new ExpectedSocketClosureMessage(_loc_5.reason));
                                }
                            }
                        }
                        else
                        {
                            _log.warn("The connection hasn\'t even start.");
                            KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed, DisconnectionReasonEnum.NEVER_CONNECTED);
                        }
                    }
                    return true;
                }
                case param1 is WrongSocketClosureReasonMessage:
                {
                    _loc_3 = param1 as WrongSocketClosureReasonMessage;
                    _log.error("Expecting socket closure for reason " + _loc_3.expectedReason + ", got reason " + _loc_3.gotReason + "! Reseting.");
                    Kernel.getInstance().reset([new UnexpectedSocketClosureMessage()]);
                    return true;
                }
                case param1 is UnexpectedSocketClosureMessage:
                {
                    _loc_4 = param1 as UnexpectedSocketClosureMessage;
                    _log.debug("go hook UnexpectedSocketClosure");
                    KernelEventsManager.getInstance().processCallback(HookList.UnexpectedSocketClosure);
                    return true;
                }
                case param1 is ResetGameAction:
                {
                    _log.fatal("ResetGameAction");
                    SoundManager.getInstance().manager.removeAllSounds();
                    ConnectionsHandler.closeConnection();
                    Kernel.getInstance().reset();
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
