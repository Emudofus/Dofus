package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.MoveBehavior;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.InteractiveElementBehavior;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.ChangeMapBehavior;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.AbstractBehavior;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.dofus.types.entities.CheckPointEntity;
    import com.ankamagames.jerakine.utils.display.KeyPoll;
    import flash.events.Event;
    import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
    import com.ankamagames.dofus.types.enums.StackActionEnum;
    import com.ankamagames.dofus.kernel.Kernel;
    import flash.events.KeyboardEvent;
    import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
    import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
    import com.ankamagames.atouin.messages.CellClickMessage;
    import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.atouin.managers.EntitiesDisplayManager;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.enums.Priority;
    import __AS3__.vec.*;

    public class StackManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StackManagementFrame));
        private static const LIMIT:int = 100;
        private static const KEY_CODE:uint = 16;
        private static const BEHAVIOR_LIST:Array = [MoveBehavior, InteractiveElementBehavior, ChangeMapBehavior];
        private static const ACTION_MESSAGES:Array = ["InteractiveElementActivationMessage", "CellClickMessage", "AdjacentMapClickMessage"];

        private var _stackInputMessage:Vector.<AbstractBehavior>;
        private var _stackOutputMessage:Vector.<AbstractBehavior>;
        private var _stopMessages:Vector.<String>;
        private var _ignoredMsg:Vector.<Message>;
        private var _checkPointList:Vector.<CheckPointEntity>;
        private var _currentMode:String;
        private var _ignoreAllMessages:Boolean = false;
        private var _limitReached:Boolean = false;
        private var _keyDown:Boolean = false;
        private var _paused:Boolean = false;
        private var _waitingMessage:Message;

        public function StackManagementFrame()
        {
            this.initStackInputMessages(AbstractBehavior.ALWAYS);
            this._checkPointList = new Vector.<CheckPointEntity>();
            this._ignoredMsg = new Vector.<Message>();
            this._stackOutputMessage = new Vector.<AbstractBehavior>();
            this.initStopMessages();
        }

        private function onActivate(pEvt:Event):void
        {
            if (((!(KeyPoll.getInstance().isDown(KEY_CODE))) && (this._keyDown)))
            {
                this.onKeyUp(null);
            };
        }

        public function onKeyDown(pEvt:KeyboardEvent):void
        {
            var m:AddBehaviorToStackAction;
            if (((!(this._keyDown)) && ((pEvt.keyCode == KEY_CODE))))
            {
                this._keyDown = true;
                this.initStackInputMessages(AbstractBehavior.NORMAL);
                m = new AddBehaviorToStackAction();
                m.behavior = [StackActionEnum.MOVE, StackActionEnum.HARVEST];
                Kernel.getWorker().process(m);
            };
        }

        public function onKeyUp(pEvt:KeyboardEvent=null):void
        {
            var m:RemoveBehaviorToStackAction;
            var keyCode:uint = (((pEvt == null)) ? KEY_CODE : pEvt.keyCode);
            if (((this._keyDown) && ((keyCode == KEY_CODE))))
            {
                this._keyDown = false;
                m = new RemoveBehaviorToStackAction();
                m.behavior = StackActionEnum.REMOVE_ALL;
                Kernel.getWorker().process(m);
            };
        }

        private function getInputMessageAlreadyWatched(vector:Vector.<AbstractBehavior>, inpt:Class):AbstractBehavior
        {
            var oldInput:AbstractBehavior;
            var behaviorStr:String = getQualifiedClassName(inpt);
            for each (oldInput in vector)
            {
                if (getQualifiedClassName(oldInput) == behaviorStr)
                {
                    return (oldInput);
                };
            };
            return (null);
        }

        private function initStackInputMessages(newMode:String):void
        {
            var c:Class;
            var b:AbstractBehavior;
            var tmp:AbstractBehavior;
            var tmpVector:Vector.<AbstractBehavior> = new Vector.<AbstractBehavior>();
            if (this._stackInputMessage != null)
            {
                tmpVector = this._stackInputMessage.concat();
            };
            this._stackInputMessage = new Vector.<AbstractBehavior>();
            for each (c in BEHAVIOR_LIST)
            {
                b = new (c)();
                if ((((newMode == AbstractBehavior.NORMAL)) || ((((newMode == AbstractBehavior.ALWAYS)) && ((b.type == AbstractBehavior.ALWAYS))))))
                {
                    tmp = this.getInputMessageAlreadyWatched(tmpVector, c);
                    if (tmp != null)
                    {
                        this._stackInputMessage.push(tmp);
                    }
                    else
                    {
                        this.addBehaviorToInputStack(b, true);
                    };
                }
                else
                {
                    this.addBehaviorToInputStack(b, false);
                };
            };
            this._currentMode = newMode;
        }

        private function initStopMessages():void
        {
            this._stopMessages = new Vector.<String>();
            this._stopMessages.push("NpcDialogCreationMessage");
            this._stopMessages.push("CurrentMapMessage");
            this._stopMessages.push("GameFightStartingMessage");
            this._stopMessages.push("DocumentReadingBeginMessage");
            this._stopMessages.push("LockableShowCodeDialogMessage");
            this._stopMessages.push("PaddockSellBuyDialogMessage");
            this._stopMessages.push("ExchangeStartedMessage");
            this._stopMessages.push("ExchangeStartOkCraftWithInformationMessage");
            this._stopMessages.push("ExchangeStartOkJobIndexMessage");
            this._stopMessages.push("EmotePlayMessage");
            this._stopMessages.push("GameMapNoMovementMessage");
        }

        public function pushed():Boolean
        {
            StageShareManager.stage.addEventListener(Event.ACTIVATE, this.onActivate);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return (true);
        }

        public function pulled():Boolean
        {
            StageShareManager.stage.removeEventListener(Event.ACTIVATE, this.onActivate);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:AddBehaviorToStackAction;
            var _local_3:RemoveBehaviorToStackAction;
            var _local_4:AbstractBehavior;
            var _local_5:String;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:Boolean;
            var b:String;
            var behavior:AbstractBehavior;
            var _local_11:MoveBehavior;
            var _local_12:ChangeMapBehavior;
            var _local_13:InteractiveElementBehavior;
            var ieBehaviorIndex:int;
            var ieam:InteractiveElementActivationMessage;
            var stop:Boolean;
            switch (true)
            {
                case (msg is AddBehaviorToStackAction):
                    _local_2 = (msg as AddBehaviorToStackAction);
                    for each (b in _local_2.behavior)
                    {
                        switch (b)
                        {
                            case StackActionEnum.MOVE:
                                this.addBehaviorToInputStack(new MoveBehavior());
                                this.addBehaviorToInputStack(new ChangeMapBehavior());
                                break;
                            case StackActionEnum.HARVEST:
                                this.addBehaviorToInputStack(new InteractiveElementBehavior());
                                break;
                        };
                    };
                    return (true);
                case (msg is RemoveBehaviorToStackAction):
                    _local_3 = (msg as RemoveBehaviorToStackAction);
                    switch (_local_3.behavior)
                    {
                        case StackActionEnum.REMOVE_ALL:
                            this.stopWatchingActions();
                            break;
                    };
                    return (true);
                case (msg is EmptyStackAction):
                    this.emptyStack();
                    return (true);
                default:
                    _local_5 = getQualifiedClassName(msg).split("::")[1];
                    _local_6 = (((_local_5 == "InteractiveUsedMessage")) || ((_local_5 == "InteractiveUseErrorMessage")));
                    if (((this._paused) && (((!((ACTION_MESSAGES.indexOf(_local_5) == -1))) || (_local_6)))))
                    {
                        for each (behavior in this._stackOutputMessage)
                        {
                            switch (true)
                            {
                                case (behavior is MoveBehavior):
                                    _local_11 = (behavior as MoveBehavior);
                                    if ((((msg is CellClickMessage)) && (((msg as CellClickMessage).cellId == _local_11.getMapPoint().cellId))))
                                    {
                                        this._waitingMessage = msg;
                                        return (false);
                                    };
                                    break;
                                case (behavior is ChangeMapBehavior):
                                    _local_12 = (behavior as ChangeMapBehavior);
                                    if ((((msg is AdjacentMapClickMessage)) && (((msg as AdjacentMapClickMessage).cellId == _local_12.getMapPoint().cellId))))
                                    {
                                        this._waitingMessage = msg;
                                        return (false);
                                    };
                                    break;
                                case (behavior is InteractiveElementBehavior):
                                    _local_13 = (behavior as InteractiveElementBehavior);
                                    if ((((msg is InteractiveElementActivationMessage)) && (((msg as InteractiveElementActivationMessage).interactiveElement.elementId == _local_13.interactiveElement.elementId))))
                                    {
                                        this._waitingMessage = msg;
                                        return (false);
                                    };
                                    if (((_local_6) && ((_local_13.interactiveElement.elementId == (msg as Object).elemId))))
                                    {
                                        _local_13.processOutputMessage(msg, this._currentMode);
                                        this.removeCheckPoint(_local_13);
                                        ieBehaviorIndex = this._stackOutputMessage.indexOf(_local_13);
                                        ieam = (this._waitingMessage as InteractiveElementActivationMessage);
                                        if (((ieam) && ((ieam.interactiveElement.elementId == _local_13.interactiveElement.elementId))))
                                        {
                                            this._waitingMessage = null;
                                        };
                                        if (ieBehaviorIndex != -1)
                                        {
                                            this._stackOutputMessage.splice(ieBehaviorIndex, 1);
                                            return (false);
                                        };
                                    };
                                    break;
                            };
                        };
                        return (false);
                    };
                    for each (_local_4 in this._stackInputMessage)
                    {
                        _local_4.checkAvailability(msg);
                    };
                    if (this._stopMessages.indexOf(_local_5) != -1)
                    {
                        stop = true;
                        if ((msg is EmotePlayMessage))
                        {
                            if ((msg as EmotePlayMessage).actorId != PlayedCharacterManager.getInstance().id)
                            {
                                stop = false;
                            };
                        };
                        if (stop)
                        {
                            this.emptyStack();
                            return (false);
                        };
                    };
                    if (this._ignoredMsg.indexOf(msg) != -1)
                    {
                        this._ignoredMsg.splice(this._ignoredMsg.indexOf(msg), 1);
                        return (false);
                    };
                    _local_7 = this.processStackInputMessages(msg);
                    _local_8 = this.processStackOutputMessages(msg);
                    return (_local_7);
            };
        }

        private function processStackInputMessages(pMsg:Message):Boolean
        {
            var elem:AbstractBehavior;
            var copy:AbstractBehavior;
            var elementInStack:AbstractBehavior;
            var ch:CheckPointEntity;
            var tchatMessage:String;
            if (this._stackOutputMessage.length >= LIMIT)
            {
                this._limitReached = true;
            };
            for each (elem in this._stackInputMessage)
            {
                if (elem.processInputMessage(pMsg, this._currentMode))
                {
                    if ((((this._currentMode == AbstractBehavior.ALWAYS)) && (((!(elem.isActive)) || ((((this._stackOutputMessage.length > 0)) && (!(elem.isAvailableToStart))))))))
                    {
                        this.emptyStack(false);
                        if (!(elem.isActive))
                        {
                            return (false);
                        };
                    };
                    if (elem.canBeStacked)
                    {
                        copy = elem.copy();
                        elementInStack = this.getSameInOutputList(copy);
                        if (elementInStack == null)
                        {
                            if (((this._ignoreAllMessages) || (this._limitReached)))
                            {
                                tchatMessage = "";
                                if (this._ignoreAllMessages)
                                {
                                    tchatMessage = I18n.getUiText("ui.stack.stop");
                                }
                                else
                                {
                                    if (this._limitReached)
                                    {
                                        tchatMessage = I18n.getUiText("ui.stack.limit", [LIMIT]);
                                    };
                                };
                                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, tchatMessage, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                                return (true);
                            };
                            if ((((((this._stackOutputMessage.length == 0)) && (elem.needToWait))) && ((this._currentMode == AbstractBehavior.NORMAL))))
                            {
                                this._stackOutputMessage.push(AbstractBehavior.createFake(StackActionEnum.MOVE, [elem.getFakePosition()]));
                            };
                            this._stackOutputMessage.push(copy);
                            if (((!((this._currentMode == AbstractBehavior.ALWAYS))) || ((((this._currentMode == AbstractBehavior.ALWAYS)) && ((this._stackOutputMessage.length > 1))))))
                            {
                                copy.addIcon();
                            };
                            ch = new CheckPointEntity(copy.sprite, elem.getMapPoint());
                            this._checkPointList.push(ch);
                            EntitiesDisplayManager.getInstance().displayEntity(ch, elem.getMapPoint(), PlacementStrataEnums.STRATA_AREA);
                            if (elem.type == AbstractBehavior.STOP)
                            {
                                this._ignoreAllMessages = true;
                            };
                        }
                        else
                        {
                            if (elementInStack.type == AbstractBehavior.STOP)
                            {
                                this._ignoreAllMessages = false;
                            };
                            this.removeCheckPoint(elementInStack);
                            this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(elementInStack), 1);
                            if (((this._limitReached) && ((this._stackOutputMessage.length < LIMIT))))
                            {
                                this._limitReached = false;
                            };
                        };
                        elem.reset();
                        return (true);
                    };
                };
            };
            return (false);
        }

        private function getSameInOutputList(copy:AbstractBehavior):AbstractBehavior
        {
            var be:AbstractBehavior;
            for each (be in this._stackOutputMessage)
            {
                if (((be.getMapPoint()) && ((be.getMapPoint().cellId == copy.getMapPoint().cellId))))
                {
                    return (be);
                };
            };
            return (null);
        }

        private function processStackOutputMessages(pMsg:Message):Boolean
        {
            var currentStackElement:AbstractBehavior;
            var isCatched:Boolean;
            if (this._stackOutputMessage.length > 0)
            {
                currentStackElement = this._stackOutputMessage[0];
                if (currentStackElement.pendingMessage == null)
                {
                    isCatched = currentStackElement.processOutputMessage(pMsg, this._currentMode);
                    if (isCatched)
                    {
                        this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement), 1);
                        if (((this._limitReached) && ((this._stackOutputMessage.length < LIMIT))))
                        {
                            this._limitReached = false;
                        };
                        if (((this._ignoreAllMessages) && ((currentStackElement.type == AbstractBehavior.STOP))))
                        {
                            this._ignoreAllMessages = false;
                        };
                    };
                    if (currentStackElement.actionStarted)
                    {
                        this.removeCheckPoint(currentStackElement);
                    };
                }
                else
                {
                    if (currentStackElement.pendingMessage != null)
                    {
                        while (this._stackOutputMessage.length > 0)
                        {
                            currentStackElement = this._stackOutputMessage[0];
                            if (currentStackElement.isAvailableToProcess(pMsg))
                            {
                                this._ignoredMsg.push(currentStackElement.pendingMessage);
                                currentStackElement.processMessageToWorker();
                                break;
                            };
                            this.removeCheckPoint(currentStackElement);
                            this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement), 1);
                            if (((this._limitReached) && ((this._stackOutputMessage.length < LIMIT))))
                            {
                                this._limitReached = false;
                            };
                        };
                    };
                };
                return (currentStackElement.isMessageCatchable(pMsg));
            };
            return (false);
        }

        private function removeCheckPoint(stackElement:AbstractBehavior):void
        {
            var ch:CheckPointEntity;
            stackElement.removeIcon();
            if (this._checkPointList.length > 0)
            {
                for each (ch in this._checkPointList)
                {
                    if (((stackElement.getMapPoint()) && ((stackElement.getMapPoint().cellId == ch.position.cellId))))
                    {
                        EntitiesDisplayManager.getInstance().removeEntity(ch);
                        this._checkPointList.splice(this._checkPointList.indexOf(ch), 1);
                        return;
                    };
                };
            };
        }

        public function removeAction(pAction:AbstractBehavior):void
        {
            this.removeCheckPoint(pAction);
            pAction.remove();
            this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(pAction), 1);
        }

        private function emptyStack(all:Boolean=true):void
        {
            var outputMessage:AbstractBehavior;
            var checkpoint:CheckPointEntity;
            if ((((this._stackOutputMessage.length == 1)) && ((this._stackOutputMessage[0].actionStarted == false))))
            {
                this._stackOutputMessage[0].removeIcon();
                this._stackOutputMessage[0].remove();
                this._stackOutputMessage = new Vector.<AbstractBehavior>();
            };
            var cpy:Vector.<AbstractBehavior> = this._stackOutputMessage.concat();
            for each (outputMessage in cpy)
            {
                if (((((all) || (!((cpy.indexOf(outputMessage) == 0))))) || ((((cpy.indexOf(outputMessage) == 0)) && (!(outputMessage.actionStarted))))))
                {
                    outputMessage.removeIcon();
                    outputMessage.remove();
                    this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(outputMessage), 1);
                };
            };
            cpy = null;
            for each (checkpoint in this._checkPointList)
            {
                EntitiesDisplayManager.getInstance().removeEntity(checkpoint);
            };
            this.initStackInputMessages(this._currentMode);
            this._checkPointList = new Vector.<CheckPointEntity>();
            this._ignoredMsg = new Vector.<Message>();
            this._ignoreAllMessages = false;
            this._limitReached = false;
        }

        private function stopWatchingActions():void
        {
            this.initStackInputMessages(AbstractBehavior.ALWAYS);
        }

        private function addBehaviorToInputStack(behavior:AbstractBehavior, pIsActive:Boolean=true):void
        {
            var typeOfOtherBehavior:String;
            var b:AbstractBehavior;
            var typeOfNewBehavior:String = getQualifiedClassName(behavior);
            for each (b in this._stackInputMessage)
            {
                typeOfOtherBehavior = getQualifiedClassName(b);
                if (typeOfNewBehavior == typeOfOtherBehavior)
                {
                    b.isActive = pIsActive;
                    return;
                };
            };
            behavior.isActive = pIsActive;
            this._stackInputMessage.push(behavior);
        }

        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function get stackInputMessage():Vector.<AbstractBehavior>
        {
            return (this._stackInputMessage);
        }

        public function get stackOutputMessage():Vector.<AbstractBehavior>
        {
            return (this._stackOutputMessage);
        }

        public function get waitingMessage():Message
        {
            return (this._waitingMessage);
        }

        public function set waitingMessage(pMsg:Message):void
        {
            this._waitingMessage = pMsg;
        }

        public function get paused():Boolean
        {
            return (this._paused);
        }

        public function set paused(pPause:Boolean):void
        {
            this._paused = pPause;
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

