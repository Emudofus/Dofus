package com.ankamagames.berilia.frames
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.api.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.handlers.messages.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.pools.*;
    import com.ankamagames.jerakine.types.enums.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class UIInteractionFrame extends Object implements Frame
    {
        private var hierarchy:Array;
        private var currentDo:DisplayObject;
        private var _isProcessingDirectInteraction:Boolean;
        private var _lastTs:uint = 0;
        private var _lastW:uint;
        private var _lastH:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UIInteractionFrame));

        public function UIInteractionFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function get isProcessingDirectInteraction() : Boolean
        {
            return this._isProcessingDirectInteraction;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            this._isProcessingDirectInteraction = false;
            this.currentDo = null;
            switch(true)
            {
                case param1 is HumanInputMessage:
                {
                    this._isProcessingDirectInteraction = true;
                    _loc_2 = HumanInputMessage(param1);
                    this.hierarchy = new Array();
                    this.currentDo = _loc_2.target;
                    while (this.currentDo != null)
                    {
                        
                        if (this.currentDo is UIComponent)
                        {
                            this.hierarchy.push(this.currentDo);
                        }
                        this.currentDo = this.currentDo.parent;
                    }
                    if (param1 is MouseClickMessage)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseClick, SecureCenter.secure(MouseClickMessage(param1).target));
                    }
                    if (param1 is MouseMiddleClickMessage)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseMiddleClick, SecureCenter.secure(MouseMiddleClickMessage(param1).target));
                    }
                    if (param1 is KeyboardKeyUpMessage)
                    {
                        _loc_8 = KeyboardKeyUpMessage(param1);
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyUp, SecureCenter.secure(_loc_8.target), _loc_8.keyboardEvent.keyCode);
                    }
                    _loc_3 = false;
                    _loc_6 = false;
                    for each (_loc_9 in this.hierarchy)
                    {
                        
                        _loc_4 = UIComponent(_loc_9) is Grid;
                        if (!_loc_3 || _loc_4)
                        {
                            _loc_10 = UIComponent(_loc_9).process(_loc_2);
                            if (_loc_10)
                            {
                                if (_loc_4)
                                {
                                    _loc_6 = true;
                                    _loc_3 = true;
                                }
                                else
                                {
                                    this.hierarchy = null;
                                    this.currentDo = null;
                                    this._isProcessingDirectInteraction = false;
                                    return true;
                                }
                            }
                        }
                        if (!_loc_5 && _loc_4)
                        {
                            _loc_5 = Grid(_loc_9);
                        }
                    }
                    this.currentDo = _loc_2.target;
                    while (this.currentDo != null)
                    {
                        
                        if (UIEventManager.getInstance().isRegisteredInstance(this.currentDo, param1))
                        {
                            _loc_6 = true;
                            this.processRegisteredUiEvent(param1, _loc_5);
                            break;
                        }
                        if (this.currentDo)
                        {
                            UiSoundManager.getInstance().fromUiElement(this.currentDo as GraphicContainer, EventEnums.convertMsgToFct(getQualifiedClassName(param1)));
                        }
                        this.currentDo = this.currentDo.parent;
                    }
                    if (param1 is MouseClickMessage)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.PostMouseClick, SecureCenter.secure(MouseClickMessage(param1).target));
                    }
                    if (param1 is MouseDoubleClickMessage && !_loc_6)
                    {
                        _loc_11 = GenericPool.get(MouseClickMessage, _loc_2.target as InteractiveObject, new MouseEvent(MouseEvent.CLICK));
                        Berilia.getInstance().handler.process(_loc_11);
                    }
                    this.hierarchy = null;
                    this.currentDo = null;
                    this._isProcessingDirectInteraction = false;
                    break;
                }
                case param1 is ComponentMessage:
                {
                    _loc_7 = ComponentMessage(param1);
                    this.hierarchy = new Array();
                    this.currentDo = _loc_7.target;
                    while (this.currentDo != null)
                    {
                        
                        if (this.currentDo is UIComponent)
                        {
                            this.hierarchy.unshift(this.currentDo);
                        }
                        this.currentDo = this.currentDo.parent;
                    }
                    if (this.hierarchy.length == 0)
                    {
                        this._isProcessingDirectInteraction = false;
                        return false;
                    }
                    for each (_loc_12 in this.hierarchy)
                    {
                        
                        UIComponent(_loc_12).process(_loc_7);
                    }
                    _loc_7.bubbling = true;
                    this.hierarchy.reverse();
                    this.hierarchy.pop();
                    for each (_loc_13 in this.hierarchy)
                    {
                        
                        UIComponent(_loc_13).process(_loc_7);
                    }
                    this.hierarchy = null;
                    if (!_loc_7.canceled)
                    {
                        for each (_loc_14 in _loc_7.actions)
                        {
                            
                            Berilia.getInstance().handler.process(_loc_14);
                        }
                        _loc_15 = EventEnums.convertMsgToFct(getQualifiedClassName(param1));
                        UiSoundManager.getInstance().fromUiElement(_loc_7.target as GraphicContainer, _loc_15);
                        this.currentDo = _loc_7.target;
                        while (this.currentDo != null)
                        {
                            
                            switch(true)
                            {
                                case param1 is MouseMiddleClickMessage:
                                case param1 is ChangeMessage:
                                {
                                    break;
                                }
                                case param1 is BrowserSessionTimeout:
                                {
                                    break;
                                }
                                case param1 is BrowserDomReady:
                                {
                                    break;
                                }
                                case param1 is ColorChangeMessage:
                                {
                                    break;
                                }
                                case param1 is EntityReadyMessage:
                                {
                                    break;
                                }
                                case param1 is SelectItemMessage:
                                {
                                    if (SelectItemMessage(param1).selectMethod != SelectMethodEnum.MANUAL && SelectItemMessage(param1).selectMethod != SelectMethodEnum.AUTO)
                                    {
                                    }
                                    break;
                                }
                                case param1 is SelectEmptyItemMessage:
                                {
                                    if (SelectEmptyItemMessage(param1).selectMethod != SelectMethodEnum.MANUAL && SelectEmptyItemMessage(param1).selectMethod != SelectMethodEnum.AUTO)
                                    {
                                    }
                                    break;
                                }
                                case param1 is ItemRollOverMessage:
                                {
                                    break;
                                }
                                case param1 is ItemRollOutMessage:
                                {
                                    break;
                                }
                                case param1 is ItemRightClickMessage:
                                {
                                    break;
                                }
                                case param1 is TextureReadyMessage:
                                {
                                    break;
                                }
                                case param1 is DropMessage:
                                {
                                    break;
                                }
                                case param1 is CreateTabMessage:
                                {
                                    break;
                                }
                                case param1 is DeleteTabMessage:
                                {
                                    break;
                                }
                                case param1 is RenameTabMessage:
                                {
                                    break;
                                }
                                case param1 is MapElementRollOverMessage:
                                {
                                    break;
                                }
                                case param1 is MapElementRollOutMessage:
                                {
                                    break;
                                }
                                case param1 is MapElementRightClickMessage:
                                {
                                    break;
                                }
                                case param1 is MapMoveMessage:
                                {
                                    break;
                                }
                                case param1 is MapRollOverMessage:
                                {
                                    break;
                                }
                                case param1 is VideoConnectFailedMessage:
                                {
                                    break;
                                }
                                case param1 is VideoConnectSuccessMessage:
                                {
                                    break;
                                }
                                case param1 is VideoBufferChangeMessage:
                                {
                                    break;
                                }
                                case param1 is ComponentReadyMessage:
                                {
                                    break;
                                }
                                case param1 is TextClickMessage:
                                {
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            if (_loc_17)
                            {
                            }
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._isProcessingDirectInteraction = false;
            return false;
        }// end function

        public function pushed() : Boolean
        {
            StageShareManager.stage.addEventListener(Event.RESIZE, this.onStageResize);
            return true;
        }// end function

        public function pulled() : Boolean
        {
            StageShareManager.stage.removeEventListener(Event.RESIZE, this.onStageResize);
            return true;
        }// end function

        private function processRegisteredUiEvent(param1:Message, param2:Grid) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
            var _loc_4:* = EventEnums.convertMsgToFct(getQualifiedClassName(param1));
            ModuleLogger.log(param1, _loc_3.instance);
            if (param2)
            {
                if (param1 is MouseWheelMessage)
                {
                    _loc_5 = [SecureCenter.secure(_loc_3.instance), MouseWheelMessage(param1).mouseEvent.delta];
                }
                else
                {
                    _loc_5 = [SecureCenter.secure(_loc_3.instance)];
                }
                _loc_6 = param2.renderer.eventModificator(param1, _loc_4, _loc_5, _loc_3.instance as UIComponent);
                ErrorManager.tryFunction(CallWithParameters.call, [_loc_3.callbackObject[_loc_4], _loc_5], "Erreur lors du traitement de " + param1);
            }
            else if (param1 is MouseWheelMessage)
            {
                ErrorManager.tryFunction(_loc_3.callbackObject[_loc_4], [SecureCenter.secure(_loc_3.instance), MouseWheelMessage(param1).mouseEvent.delta]);
            }
            else
            {
                ErrorManager.tryFunction(_loc_3.callbackObject[_loc_4], [SecureCenter.secure(_loc_3.instance)]);
            }
            return;
        }// end function

        private function onStageResize(event:Event = null) : void
        {
            if (this._lastW == StageShareManager.stage.stageWidth && this._lastH == StageShareManager.stage.stageHeight)
            {
                return;
            }
            if (getTimer() - this._lastTs > 100)
            {
                this._lastTs = getTimer();
                this._lastW = StageShareManager.stage.stageWidth;
                this._lastH = StageShareManager.stage.stageHeight;
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.WindowResize, this._lastW, this._lastH, StageShareManager.windowScale);
            }
            setTimeout(this.onStageResize, 101);
            return;
        }// end function

    }
}
