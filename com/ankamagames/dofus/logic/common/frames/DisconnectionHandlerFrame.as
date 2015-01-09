package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.network.messages.ServerConnectionClosedMessage;
    import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
    import com.ankamagames.jerakine.network.messages.UnexpectedSocketClosureMessage;
    import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
    import com.ankamagames.dofus.kernel.net.DisconnectionReason;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.kernel.sound.SoundManager;
    import com.ankamagames.dofus.logic.common.actions.OpenPopupAction;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.jerakine.messages.Message;

    public class DisconnectionHandlerFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DisconnectionHandlerFrame));
        public static var messagesAfterReset:Array = new Array();


        public function get priority():int
        {
            return (Priority.LOW);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ServerConnectionClosedMessage;
            var _local_3:WrongSocketClosureReasonMessage;
            var _local_4:UnexpectedSocketClosureMessage;
            var _local_5:ResetGameAction;
            var _local_6:Object;
            var reason:DisconnectionReason;
            var tabMsg:Array;
            switch (true)
            {
                case (msg is ServerConnectionClosedMessage):
                    _local_2 = (msg as ServerConnectionClosedMessage);
                    if (_local_2.closedConnection == ConnectionsHandler.getConnection().getSubConnection(_local_2))
                    {
                        _log.trace("The connection was closed. Checking reasons.");
                        if (ConnectionsHandler.hasReceivedMsg)
                        {
                            reason = ConnectionsHandler.handleDisconnection();
                            if (!(reason.expected))
                            {
                                _log.warn("The connection was closed unexpectedly. Reseting.");
                                if (messagesAfterReset.length == 0)
                                {
                                    messagesAfterReset.unshift(new UnexpectedSocketClosureMessage());
                                };
                                Kernel.getInstance().reset();
                            }
                            else
                            {
                                _log.trace((("The connection closure was expected (reason: " + reason.reason) + "). Dispatching the message."));
                                if ((((reason.reason == DisconnectionReasonEnum.DISCONNECTED_BY_POPUP)) || ((reason.reason == DisconnectionReasonEnum.SWITCHING_TO_HUMAN_VENDOR))))
                                {
                                    Kernel.getInstance().reset();
                                }
                                else
                                {
                                    Kernel.getWorker().process(new ExpectedSocketClosureMessage(reason.reason));
                                };
                            };
                        }
                        else
                        {
                            _log.warn("The connection hasn't even start.");
                            KernelEventsManager.getInstance().processCallback(HookList.ServerConnectionFailed, DisconnectionReasonEnum.NEVER_CONNECTED);
                        };
                    };
                    return (true);
                case (msg is WrongSocketClosureReasonMessage):
                    _local_3 = (msg as WrongSocketClosureReasonMessage);
                    _log.error((((("Expecting socket closure for reason " + _local_3.expectedReason) + ", got reason ") + _local_3.gotReason) + "! Reseting."));
                    Kernel.getInstance().reset([new UnexpectedSocketClosureMessage()]);
                    return (true);
                case (msg is UnexpectedSocketClosureMessage):
                    _local_4 = (msg as UnexpectedSocketClosureMessage);
                    _log.debug("go hook UnexpectedSocketClosure");
                    KernelEventsManager.getInstance().processCallback(HookList.UnexpectedSocketClosure);
                    return (true);
                case (msg is ResetGameAction):
                    _local_5 = (msg as ResetGameAction);
                    _log.fatal("ResetGameAction");
                    SoundManager.getInstance().manager.removeAllSounds();
                    ConnectionsHandler.closeConnection();
                    if (_local_5.messageToShow != "")
                    {
                        tabMsg = [OpenPopupAction.create(_local_5.messageToShow)];
                        Kernel.getInstance().reset(tabMsg);
                    }
                    else
                    {
                        Kernel.getInstance().reset();
                    };
                    return (true);
                case (msg is OpenPopupAction):
                    _local_6 = UiModuleManager.getInstance().getModule("Ankama_Common");
                    if (_local_6 == null)
                    {
                        messagesAfterReset.push(msg);
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.InformationPopup, [(msg as OpenPopupAction).messageToShow]);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

