package com.ankamagames.dofus.logic.game.common.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.dofus.types.enums.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class StackManagementFrame extends Object implements Frame
    {
        private var _stackInputMessage:Vector.<AbstractBehavior>;
        private var _stackOutputMessage:Vector.<AbstractBehavior>;
        private var _stopMessages:Vector.<String>;
        private var _ignoredMsg:Vector.<Message>;
        private var _checkPointList:Vector.<CheckPointEntity>;
        private var _currentMode:String;
        private var _ignoreAllMessages:Boolean = false;
        private var _limitReached:Boolean = false;
        private var _roleplayContextFrame:RoleplayContextFrame;
        private var _keyDown:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(StackManagementFrame));
        private static const LIMIT:int = 100;
        private static const KEY_CODE:uint = 16;
        private static const BEHAVIOR_LIST:Array = [MoveBehavior, InteractiveElementBehavior, ChangeMapBehavior];

        public function StackManagementFrame()
        {
            this.initStackInputMessages(AbstractBehavior.ALWAYS);
            this._checkPointList = new Vector.<CheckPointEntity>;
            this._ignoredMsg = new Vector.<Message>;
            this._stackOutputMessage = new Vector.<AbstractBehavior>;
            this.initStopMessages();
            return;
        }// end function

        private function onActivate(event:Event) : void
        {
            if (!KeyPoll.getInstance().isDown(KEY_CODE) && this._keyDown)
            {
                this.onKeyUp(null);
            }
            return;
        }// end function

        public function onKeyDown(event:KeyboardEvent) : void
        {
            var _loc_2:* = null;
            if (!this._keyDown && event.keyCode == KEY_CODE)
            {
                this._keyDown = true;
                this.initStackInputMessages(AbstractBehavior.NORMAL);
                _loc_2 = new AddBehaviorToStackAction();
                _loc_2.behavior = [StackActionEnum.MOVE, StackActionEnum.HARVEST];
                Kernel.getWorker().process(_loc_2);
            }
            return;
        }// end function

        public function onKeyUp(event:KeyboardEvent = null) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event == null ? (KEY_CODE) : (event.keyCode);
            if (this._keyDown && _loc_2 == KEY_CODE)
            {
                this._keyDown = false;
                _loc_3 = new RemoveBehaviorToStackAction();
                _loc_3.behavior = StackActionEnum.REMOVE_ALL;
                Kernel.getWorker().process(_loc_3);
            }
            return;
        }// end function

        private function getInputMessageAlreadyWatched(param1:Vector.<AbstractBehavior>, param2:Class) : AbstractBehavior
        {
            var _loc_4:* = null;
            var _loc_3:* = getQualifiedClassName(param2);
            for each (_loc_4 in param1)
            {
                
                if (getQualifiedClassName(_loc_4) == _loc_3)
                {
                    return _loc_4;
                }
            }
            return null;
        }// end function

        private function initStackInputMessages(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Vector.<AbstractBehavior>;
            if (this._stackInputMessage != null)
            {
                _loc_2 = this._stackInputMessage.concat();
            }
            this._stackInputMessage = new Vector.<AbstractBehavior>;
            for each (_loc_3 in BEHAVIOR_LIST)
            {
                
                _loc_4 = new _loc_3;
                if (param1 == AbstractBehavior.NORMAL || param1 == AbstractBehavior.ALWAYS && _loc_4.type == AbstractBehavior.ALWAYS)
                {
                    _loc_5 = this.getInputMessageAlreadyWatched(_loc_2, _loc_3);
                    if (_loc_5 != null)
                    {
                        this._stackInputMessage.push(_loc_5);
                    }
                    else
                    {
                        this.addBehaviorToInputStack(_loc_4, true);
                    }
                    continue;
                }
                this.addBehaviorToInputStack(_loc_4, false);
            }
            this._currentMode = param1;
            return;
        }// end function

        private function initStopMessages() : void
        {
            this._stopMessages = new Vector.<String>;
            this._stopMessages.push("NpcDialogCreationMessage");
            this._stopMessages.push("CurrentMapMessage");
            this._stopMessages.push("GameFightStartingMessage");
            this._stopMessages.push("DocumentReadingBeginMessage");
            this._stopMessages.push("LockableShowCodeDialogMessage");
            this._stopMessages.push("PaddockSellBuyDialogMessage");
            this._stopMessages.push("ExchangeStartedMessage");
            this._stopMessages.push("ExchangeStartOkCraftWithInformationMessage");
            this._stopMessages.push("ExchangeStartOkJobIndexMessage");
            this._stopMessages.push("GameMapNoMovementMessage");
            return;
        }// end function

        public function pushed() : Boolean
        {
            StageShareManager.stage.addEventListener(Event.ACTIVATE, this.onActivate);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return true;
        }// end function

        public function pulled() : Boolean
        {
            StageShareManager.stage.removeEventListener(Event.ACTIVATE, this.onActivate);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._roleplayContextFrame == null)
            {
                this._roleplayContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            }
            switch(true)
            {
                case param1 is AddBehaviorToStackAction:
                {
                    _loc_2 = param1 as AddBehaviorToStackAction;
                    for each (_loc_7 in _loc_2.behavior)
                    {
                        
                        switch(_loc_7)
                        {
                            case StackActionEnum.MOVE:
                            {
                                this.addBehaviorToInputStack(new MoveBehavior());
                                this.addBehaviorToInputStack(new ChangeMapBehavior());
                                break;
                            }
                            case StackActionEnum.HARVEST:
                            {
                                this.addBehaviorToInputStack(new InteractiveElementBehavior());
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    return true;
                }
                case param1 is RemoveBehaviorToStackAction:
                {
                    _loc_3 = param1 as RemoveBehaviorToStackAction;
                    switch(_loc_3.behavior)
                    {
                        case StackActionEnum.REMOVE_ALL:
                        {
                            this.stopWatchingActions();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is EmptyStackAction:
                {
                    this.emptyStack();
                    return true;
                }
                default:
                {
                    for each (_loc_8 in this._stackInputMessage)
                    {
                        
                        _loc_8.checkAvailability(param1);
                    }
                    _loc_4 = getQualifiedClassName(param1).split("::")[1];
                    if (this._stopMessages.indexOf(_loc_4) != -1)
                    {
                        this.emptyStack();
                        return false;
                    }
                    if (this._ignoredMsg.indexOf(param1) != -1)
                    {
                        this._ignoredMsg.splice(this._ignoredMsg.indexOf(param1), 1);
                        return false;
                    }
                    _loc_5 = this.processStackInputMessages(param1);
                    _loc_6 = this.processStackOutputMessages(param1);
                    return _loc_5;
                    break;
                }
            }
        }// end function

        private function processStackInputMessages(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (this._roleplayContextFrame && !this._roleplayContextFrame.hasWorldInteraction)
            {
                this.emptyStack();
                return false;
            }
            if (this._stackOutputMessage.length >= LIMIT)
            {
                this._limitReached = true;
            }
            for each (_loc_2 in this._stackInputMessage)
            {
                
                if (_loc_2.processInputMessage(param1, this._currentMode))
                {
                    if (this._currentMode == AbstractBehavior.ALWAYS && (!_loc_2.isActive || this._stackOutputMessage.length > 0 && !_loc_2.isAvailableToStart))
                    {
                        this.emptyStack(false);
                        if (!_loc_2.isActive)
                        {
                            return false;
                        }
                    }
                    if (_loc_2.canBeStacked)
                    {
                        _loc_3 = _loc_2.copy();
                        _loc_4 = this.getSameInOutputList(_loc_3);
                        if (_loc_4 == null)
                        {
                            if (this._ignoreAllMessages || this._limitReached)
                            {
                                _loc_6 = "";
                                if (this._ignoreAllMessages)
                                {
                                    _loc_6 = I18n.getUiText("ui.stack.stop");
                                }
                                else if (this._limitReached)
                                {
                                    _loc_6 = I18n.getUiText("ui.stack.limit", [LIMIT]);
                                }
                                KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, _loc_6, ChatFrame.RED_CHANNEL_ID, TimeManager.getInstance().getTimestamp());
                                return true;
                            }
                            if (this._stackOutputMessage.length == 0 && _loc_2.needToWait && this._currentMode == AbstractBehavior.NORMAL)
                            {
                                this._stackOutputMessage.push(AbstractBehavior.createFake(StackActionEnum.MOVE, [_loc_2.getFakePosition()]));
                            }
                            this._stackOutputMessage.push(_loc_3);
                            if (this._currentMode != AbstractBehavior.ALWAYS || this._currentMode == AbstractBehavior.ALWAYS && this._stackOutputMessage.length > 1)
                            {
                                _loc_3.addIcon();
                            }
                            _loc_5 = new CheckPointEntity(_loc_3.sprite, _loc_2.getMapPoint());
                            this._checkPointList.push(_loc_5);
                            EntitiesDisplayManager.getInstance().displayEntity(_loc_5, _loc_2.getMapPoint(), PlacementStrataEnums.STRATA_AREA);
                            if (_loc_2.type == AbstractBehavior.STOP)
                            {
                                this._ignoreAllMessages = true;
                            }
                        }
                        else
                        {
                            if (_loc_4.type == AbstractBehavior.STOP)
                            {
                                this._ignoreAllMessages = false;
                            }
                            this.removeCheckPoint(_loc_4);
                            this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc_4), 1);
                            if (this._limitReached && this._stackOutputMessage.length < LIMIT)
                            {
                                this._limitReached = false;
                            }
                        }
                        _loc_2.reset();
                        return true;
                    }
                }
            }
            return false;
        }// end function

        private function getSameInOutputList(param1:AbstractBehavior) : AbstractBehavior
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._stackOutputMessage)
            {
                
                if (_loc_2.getMapPoint() && _loc_2.getMapPoint().cellId == param1.getMapPoint().cellId)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function processStackOutputMessages(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            if (this._stackOutputMessage.length > 0)
            {
                _loc_2 = this._stackOutputMessage[0];
                if (_loc_2.pendingMessage == null)
                {
                    _loc_3 = _loc_2.processOutputMessage(param1, this._currentMode);
                    if (_loc_3)
                    {
                        this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc_2), 1);
                        if (this._limitReached && this._stackOutputMessage.length < LIMIT)
                        {
                            this._limitReached = false;
                        }
                        if (this._ignoreAllMessages && _loc_2.type == AbstractBehavior.STOP)
                        {
                            this._ignoreAllMessages = false;
                        }
                    }
                    if (_loc_2.actionStarted)
                    {
                        this.removeCheckPoint(_loc_2);
                    }
                }
                else if (_loc_2.pendingMessage != null)
                {
                    while (this._stackOutputMessage.length > 0)
                    {
                        
                        _loc_2 = this._stackOutputMessage[0];
                        if (_loc_2.isAvailableToProcess(param1))
                        {
                            this._ignoredMsg.push(_loc_2.pendingMessage);
                            _loc_2.processMessageToWorker();
                            break;
                            continue;
                        }
                        this.removeCheckPoint(_loc_2);
                        this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc_2), 1);
                        if (this._limitReached && this._stackOutputMessage.length < LIMIT)
                        {
                            this._limitReached = false;
                        }
                    }
                }
                return _loc_2.isMessageCatchable(param1);
            }
            return false;
        }// end function

        private function removeCheckPoint(param1:AbstractBehavior) : void
        {
            var _loc_2:* = null;
            param1.removeIcon();
            if (this._checkPointList.length > 0)
            {
                for each (_loc_2 in this._checkPointList)
                {
                    
                    if (param1.getMapPoint() && param1.getMapPoint().cellId == _loc_2.position.cellId)
                    {
                        EntitiesDisplayManager.getInstance().removeEntity(_loc_2);
                        this._checkPointList.splice(this._checkPointList.indexOf(_loc_2), 1);
                        return;
                    }
                }
            }
            return;
        }// end function

        private function emptyStack(param1:Boolean = true) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            if (this._stackOutputMessage.length == 1 && this._stackOutputMessage[0].actionStarted == false)
            {
                this._stackOutputMessage[0].removeIcon();
                this._stackOutputMessage[0].remove();
                this._stackOutputMessage = new Vector.<AbstractBehavior>;
            }
            var _loc_3:* = this._stackOutputMessage.concat();
            for each (_loc_2 in _loc_3)
            {
                
                if (param1 || _loc_3.indexOf(_loc_2) != 0 || _loc_3.indexOf(_loc_2) == 0 && !_loc_2.actionStarted)
                {
                    _loc_2.removeIcon();
                    _loc_2.remove();
                    this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(_loc_2), 1);
                }
            }
            _loc_3 = null;
            for each (_loc_4 in this._checkPointList)
            {
                
                EntitiesDisplayManager.getInstance().removeEntity(_loc_4);
            }
            this.initStackInputMessages(this._currentMode);
            this._checkPointList = new Vector.<CheckPointEntity>;
            this._ignoredMsg = new Vector.<Message>;
            this._ignoreAllMessages = false;
            this._limitReached = false;
            return;
        }// end function

        private function stopWatchingActions() : void
        {
            this.initStackInputMessages(AbstractBehavior.ALWAYS);
            return;
        }// end function

        private function addBehaviorToInputStack(param1:AbstractBehavior, param2:Boolean = true) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = getQualifiedClassName(param1);
            for each (_loc_5 in this._stackInputMessage)
            {
                
                _loc_4 = getQualifiedClassName(_loc_5);
                if (_loc_3 == _loc_4)
                {
                    _loc_5.isActive = param2;
                    return;
                }
            }
            param1.isActive = param2;
            this._stackInputMessage.push(param1);
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function get stackInputMessage() : Vector.<AbstractBehavior>
        {
            return this._stackInputMessage;
        }// end function

        public function get stackOutputMessage() : Vector.<AbstractBehavior>
        {
            return this._stackOutputMessage;
        }// end function

        public function get roleplayContextFrame() : RoleplayContextFrame
        {
            return this._roleplayContextFrame;
        }// end function

        public function set roleplayContextFrame(param1:RoleplayContextFrame) : void
        {
            this._roleplayContextFrame = param1;
            return;
        }// end function

    }
}
