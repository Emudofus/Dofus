package com.ankamagames.berilia.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.jerakine.handlers.messages.FocusChangeMessage;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.components.Input;
    import com.ankamagames.jerakine.handlers.messages.HumanInputMessage;
    import com.ankamagames.berilia.components.Grid;
    import com.ankamagames.berilia.components.messages.ComponentMessage;
    import flash.geom.Point;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
    import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
    import com.ankamagames.berilia.UIComponent;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import com.ankamagames.jerakine.handlers.messages.Action;
    import com.ankamagames.berilia.types.event.InstanceEvent;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseMiddleClickMessage;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.managers.UiSoundManager;
    import com.ankamagames.berilia.enums.EventEnums;
    import com.ankamagames.berilia.managers.UIEventManager;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
    import com.ankamagames.jerakine.pools.GenericPool;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;
    import com.ankamagames.berilia.components.messages.ChangeMessage;
    import com.ankamagames.berilia.components.messages.BrowserSessionTimeout;
    import com.ankamagames.berilia.components.messages.BrowserDomReady;
    import com.ankamagames.berilia.components.messages.ColorChangeMessage;
    import com.ankamagames.berilia.components.messages.EntityReadyMessage;
    import com.ankamagames.berilia.components.messages.SelectItemMessage;
    import com.ankamagames.berilia.enums.SelectMethodEnum;
    import com.ankamagames.berilia.components.messages.SelectEmptyItemMessage;
    import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
    import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
    import com.ankamagames.berilia.components.messages.ItemRightClickMessage;
    import com.ankamagames.berilia.components.messages.TextureReadyMessage;
    import com.ankamagames.berilia.components.messages.TextureLoadFailMessage;
    import com.ankamagames.berilia.components.messages.DropMessage;
    import com.ankamagames.berilia.components.messages.CreateTabMessage;
    import com.ankamagames.berilia.components.messages.DeleteTabMessage;
    import com.ankamagames.berilia.components.messages.RenameTabMessage;
    import com.ankamagames.berilia.api.ReadOnlyObject;
    import com.ankamagames.berilia.components.messages.MapElementRollOverMessage;
    import com.ankamagames.berilia.components.messages.MapElementRollOutMessage;
    import com.ankamagames.berilia.components.messages.MapElementRightClickMessage;
    import com.ankamagames.berilia.components.messages.MapMoveMessage;
    import com.ankamagames.berilia.components.messages.MapRollOverMessage;
    import com.ankamagames.berilia.components.messages.VideoConnectFailedMessage;
    import com.ankamagames.berilia.components.messages.VideoConnectSuccessMessage;
    import com.ankamagames.berilia.components.messages.VideoBufferChangeMessage;
    import com.ankamagames.berilia.components.messages.ComponentReadyMessage;
    import com.ankamagames.berilia.components.messages.TextClickMessage;
    import com.ankamagames.jerakine.logger.ModuleLogger;
    import com.ankamagames.jerakine.managers.ErrorManager;
    import com.ankamagames.jerakine.messages.Message;
    import flash.events.Event;
    import com.ankamagames.jerakine.utils.system.AirScanner;
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
    import com.ankamagames.jerakine.utils.misc.CallWithParameters;
    import flash.utils.getTimer;
    import flash.utils.setTimeout;
    import com.ankamagames.jerakine.handlers.FocusHandler;

    public class UIInteractionFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UIInteractionFrame));

        private var hierarchy:Array;
        private var currentDo:DisplayObject;
        private var _isProcessingDirectInteraction:Boolean;
        private var _warning:InputWarning;
        private var _lastTs:uint = 0;
        private var _lastW:uint;
        private var _lastH:uint;


        public function get priority():int
        {
            return (Priority.HIGHEST);
        }

        public function get isProcessingDirectInteraction():Boolean
        {
            return (this._isProcessingDirectInteraction);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:FocusChangeMessage;
            var _local_3:UiRootContainer;
            var _local_4:Input;
            var _local_5:HumanInputMessage;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:Grid;
            var _local_9:Boolean;
            var _local_10:ComponentMessage;
            var inputPos:Point;
            var kkdmsg:KeyboardKeyDownMessage;
            var kkumsg:KeyboardKeyUpMessage;
            var uic:UIComponent;
            var res:Boolean;
            var newMsg:MouseClickMessage;
            var _local_17:UIComponent;
            var uic4:UIComponent;
            var act2:Action;
            var targetFct:String;
            var ie2:InstanceEvent;
            var args:Array;
            this._isProcessingDirectInteraction = false;
            this.currentDo = null;
            switch (true)
            {
                case (msg is FocusChangeMessage):
                    _local_2 = FocusChangeMessage(msg);
                    this.hierarchy = new Array();
                    this.currentDo = _local_2.target;
                    while (this.currentDo != null)
                    {
                        if ((this.currentDo is UIComponent))
                        {
                            this.hierarchy.unshift(this.currentDo);
                        };
                        this.currentDo = this.currentDo.parent;
                    };
                    _local_3 = (this.hierarchy[0] as UiRootContainer);
                    _local_4 = (this.hierarchy[(this.hierarchy.length - 1)] as Input);
                    if ((((((((this.hierarchy.length > 0)) && (_local_3))) && (_local_4))) && (!(_local_3.uiData.module.trusted))))
                    {
                        if (!(this._warning))
                        {
                            this._warning = new InputWarning();
                        };
                        Berilia.getInstance().docMain.addChild(this._warning);
                        this._warning.width = _local_4.width;
                        inputPos = _local_4.localToGlobal(new Point(_local_4.x, _local_4.y));
                        this._warning.x = inputPos.x;
                        this._warning.y = ((inputPos.y - this._warning.height) - 4);
                        if (this._warning.y < 0)
                        {
                            this._warning.y = ((inputPos.y + _local_4.height) + 4);
                        };
                        if ((this._warning.y + this._warning.height) > StageShareManager.startHeight)
                        {
                            this._warning.y = ((StageShareManager.startHeight - this._warning.height) / 2);
                        };
                    }
                    else
                    {
                        if (((this._warning) && (this._warning.parent)))
                        {
                            this._warning.parent.removeChild(this._warning);
                        };
                    };
                    if (this.hierarchy.length > 0)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange, SecureCenter.secure(this.hierarchy[(this.hierarchy.length - 1)]));
                    }
                    else
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange, null);
                    };
                    return (true);
                case (msg is HumanInputMessage):
                    this._isProcessingDirectInteraction = true;
                    _local_5 = HumanInputMessage(msg);
                    this.hierarchy = new Array();
                    this.currentDo = _local_5.target;
                    while (this.currentDo != null)
                    {
                        if ((this.currentDo is UIComponent))
                        {
                            this.hierarchy.push(this.currentDo);
                        };
                        this.currentDo = this.currentDo.parent;
                    };
                    if ((msg is MouseClickMessage))
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseClick, SecureCenter.secure(MouseClickMessage(msg).target));
                        if (!(this.hierarchy[(this.hierarchy.length - 1)]))
                        {
                            KernelEventsManager.getInstance().processCallback(BeriliaHookList.FocusChange, SecureCenter.secure(MouseClickMessage(msg).target));
                        };
                    };
                    if ((msg is MouseMiddleClickMessage))
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseMiddleClick, SecureCenter.secure(MouseMiddleClickMessage(msg).target));
                    };
                    if ((msg is KeyboardKeyDownMessage))
                    {
                        kkdmsg = KeyboardKeyDownMessage(msg);
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyDown, SecureCenter.secure(kkdmsg.target), kkdmsg.keyboardEvent.keyCode);
                    };
                    if ((msg is KeyboardKeyUpMessage))
                    {
                        kkumsg = KeyboardKeyUpMessage(msg);
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.KeyUp, SecureCenter.secure(kkumsg.target), kkumsg.keyboardEvent.keyCode);
                    };
                    _local_6 = false;
                    _local_9 = false;
                    for each (uic in this.hierarchy)
                    {
                        _local_7 = (UIComponent(uic) is Grid);
                        if (((!(_local_6)) || (_local_7)))
                        {
                            res = UIComponent(uic).process(_local_5);
                            if (res)
                            {
                                if (((_local_7) && (!(_local_5.canceled))))
                                {
                                    _local_9 = true;
                                    _local_6 = true;
                                }
                                else
                                {
                                    this.hierarchy = null;
                                    this.currentDo = null;
                                    this._isProcessingDirectInteraction = false;
                                    return (true);
                                };
                            };
                        };
                        if (((!(_local_8)) && (_local_7)))
                        {
                            _local_8 = Grid(uic);
                        };
                    };
                    this.currentDo = _local_5.target;
                    while (this.currentDo != null)
                    {
                        if ((this.currentDo is GraphicContainer))
                        {
                            UiSoundManager.getInstance().fromUiElement((this.currentDo as GraphicContainer), EventEnums.convertMsgToFct(getQualifiedClassName(msg)));
                        };
                        if (UIEventManager.getInstance().isRegisteredInstance(this.currentDo, msg))
                        {
                            _local_9 = true;
                            this.processRegisteredUiEvent(msg, _local_8);
                            break;
                        };
                        this.currentDo = this.currentDo.parent;
                    };
                    if ((msg is MouseClickMessage))
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.PostMouseClick, SecureCenter.secure(MouseClickMessage(msg).target));
                    };
                    if ((((msg is MouseDoubleClickMessage)) && (!(_local_9))))
                    {
                        newMsg = GenericPool.get(MouseClickMessage, (_local_5.target as InteractiveObject), new MouseEvent(MouseEvent.CLICK));
                        Berilia.getInstance().handler.process(newMsg);
                    };
                    this.hierarchy = null;
                    this.currentDo = null;
                    this._isProcessingDirectInteraction = false;
                    break;
                case (msg is ComponentMessage):
                    _local_10 = ComponentMessage(msg);
                    this.hierarchy = new Array();
                    this.currentDo = _local_10.target;
                    while (this.currentDo != null)
                    {
                        if ((this.currentDo is UIComponent))
                        {
                            this.hierarchy.unshift(this.currentDo);
                        };
                        this.currentDo = this.currentDo.parent;
                    };
                    if (this.hierarchy.length == 0)
                    {
                        this._isProcessingDirectInteraction = false;
                        return (false);
                    };
                    for each (_local_17 in this.hierarchy)
                    {
                        UIComponent(_local_17).process(_local_10);
                    };
                    _local_10.bubbling = true;
                    this.hierarchy.reverse();
                    this.hierarchy.pop();
                    for each (uic4 in this.hierarchy)
                    {
                        UIComponent(uic4).process(_local_10);
                    };
                    this.hierarchy = null;
                    if (!(_local_10.canceled))
                    {
                        for each (act2 in _local_10.actions)
                        {
                            Berilia.getInstance().handler.process(act2);
                        };
                        targetFct = EventEnums.convertMsgToFct(getQualifiedClassName(msg));
                        UiSoundManager.getInstance().fromUiElement((_local_10.target as GraphicContainer), targetFct);
                        this.currentDo = _local_10.target;
                        while (this.currentDo != null)
                        {
                            if (((UIEventManager.getInstance().instances[this.currentDo]) && (UIEventManager.getInstance().instances[this.currentDo].events[getQualifiedClassName(msg)])))
                            {
                                ie2 = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
                                switch (true)
                                {
                                    case (msg is MouseMiddleClickMessage):
                                    case (msg is ChangeMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is BrowserSessionTimeout):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is BrowserDomReady):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is ColorChangeMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is EntityReadyMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is SelectItemMessage):
                                        if (((!((SelectItemMessage(msg).selectMethod == SelectMethodEnum.MANUAL))) && (!((SelectItemMessage(msg).selectMethod == SelectMethodEnum.AUTO)))))
                                        {
                                            this._isProcessingDirectInteraction = true;
                                        };
                                        args = [SecureCenter.secure(ie2.instance), SelectItemMessage(msg).selectMethod, SelectItemMessage(msg).isNewSelection];
                                        break;
                                    case (msg is SelectEmptyItemMessage):
                                        if (((!((SelectEmptyItemMessage(msg).selectMethod == SelectMethodEnum.MANUAL))) && (!((SelectEmptyItemMessage(msg).selectMethod == SelectMethodEnum.AUTO)))))
                                        {
                                            this._isProcessingDirectInteraction = true;
                                        };
                                        args = [SecureCenter.secure(ie2.instance), SelectEmptyItemMessage(msg).selectMethod];
                                        break;
                                    case (msg is ItemRollOverMessage):
                                        args = [SecureCenter.secure(ie2.instance), ItemRollOverMessage(msg).item];
                                        break;
                                    case (msg is ItemRollOutMessage):
                                        args = [SecureCenter.secure(ie2.instance), ItemRollOutMessage(msg).item];
                                        break;
                                    case (msg is ItemRightClickMessage):
                                        this._isProcessingDirectInteraction = true;
                                        args = [SecureCenter.secure(ie2.instance), ItemRightClickMessage(msg).item];
                                        break;
                                    case (msg is TextureReadyMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is TextureLoadFailMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is DropMessage):
                                        this._isProcessingDirectInteraction = true;
                                        args = [DropMessage(msg).target, DropMessage(msg).source];
                                        break;
                                    case (msg is CreateTabMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is DeleteTabMessage):
                                        args = [SecureCenter.secure(ie2.instance), DeleteTabMessage(msg).deletedIndex];
                                        break;
                                    case (msg is RenameTabMessage):
                                        args = [SecureCenter.secure(ie2.instance), RenameTabMessage(msg).index, RenameTabMessage(msg).name];
                                        break;
                                    case (msg is MapElementRollOverMessage):
                                        args = [SecureCenter.secure(ie2.instance), ReadOnlyObject.create(MapElementRollOverMessage(msg).targetedElement)];
                                        break;
                                    case (msg is MapElementRollOutMessage):
                                        args = [SecureCenter.secure(ie2.instance), ReadOnlyObject.create(MapElementRollOutMessage(msg).targetedElement)];
                                        break;
                                    case (msg is MapElementRightClickMessage):
                                        args = [SecureCenter.secure(ie2.instance), ReadOnlyObject.create(MapElementRightClickMessage(msg).targetedElement)];
                                        break;
                                    case (msg is MapMoveMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is MapRollOverMessage):
                                        args = [SecureCenter.secure(ie2.instance), MapRollOverMessage(msg).x, MapRollOverMessage(msg).y];
                                        break;
                                    case (msg is VideoConnectFailedMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is VideoConnectSuccessMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is VideoBufferChangeMessage):
                                        args = [SecureCenter.secure(ie2.instance), VideoBufferChangeMessage(msg).state];
                                        break;
                                    case (msg is ComponentReadyMessage):
                                        args = [SecureCenter.secure(ie2.instance)];
                                        break;
                                    case (msg is TextClickMessage):
                                        this._isProcessingDirectInteraction = true;
                                        args = [SecureCenter.secure(ie2.instance), (msg as TextClickMessage).textEvent];
                                        break;
                                };
                                if (args)
                                {
                                    ModuleLogger.log(msg, ie2.instance);
                                    args = SecureCenter.secureContent(args);
                                    ErrorManager.tryFunction(GraphicContainer(ie2.instance).getUi().call, [ie2.callbackObject[targetFct], args, SecureCenter.ACCESS_KEY], ("Erreur lors du traitement de " + msg));
                                    this._isProcessingDirectInteraction = false;
                                    return (true);
                                };
                                break;
                            };
                            this.currentDo = this.currentDo.parent;
                        };
                    };
                    break;
            };
            this._isProcessingDirectInteraction = false;
            return (false);
        }

        public function pushed():Boolean
        {
            StageShareManager.stage.addEventListener(Event.RESIZE, this.onStageResize);
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.addEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
            return (true);
        }

        public function pulled():Boolean
        {
            StageShareManager.stage.removeEventListener(Event.RESIZE, this.onStageResize);
            if (AirScanner.hasAir())
            {
                StageShareManager.stage.nativeWindow.removeEventListener(Event.DEACTIVATE, this.onWindowDeactivate);
            };
            if (((this._warning) && (this._warning.parent)))
            {
                this._warning.parent.removeChild(this._warning);
            };
            this._warning = null;
            return (true);
        }

        private function processRegisteredUiEvent(msg:Message, gridInstance:Grid):void
        {
            var args:Array;
            var fct:String;
            var ie:InstanceEvent = InstanceEvent(UIEventManager.getInstance().instances[this.currentDo]);
            var fctName:String = EventEnums.convertMsgToFct(getQualifiedClassName(msg));
            ModuleLogger.log(msg, ie.instance);
            if (gridInstance)
            {
                if ((msg is MouseWheelMessage))
                {
                    args = [SecureCenter.secure(ie.instance), MouseWheelMessage(msg).mouseEvent.delta];
                }
                else
                {
                    args = [SecureCenter.secure(ie.instance)];
                };
                fct = gridInstance.renderer.eventModificator(msg, fctName, args, (ie.instance as UIComponent));
                ErrorManager.tryFunction(CallWithParameters.call, [ie.callbackObject[fctName], args], ("Erreur lors du traitement de " + msg));
            }
            else
            {
                if ((msg is MouseWheelMessage))
                {
                    ErrorManager.tryFunction(ie.callbackObject[fctName], [SecureCenter.secure(ie.instance), MouseWheelMessage(msg).mouseEvent.delta]);
                }
                else
                {
                    ErrorManager.tryFunction(ie.callbackObject[fctName], [SecureCenter.secure(ie.instance)]);
                };
            };
        }

        private function onStageResize(e:Event=null):void
        {
            if ((((this._lastW == StageShareManager.stage.stageWidth)) && ((this._lastH == StageShareManager.stage.stageHeight))))
            {
                return;
            };
            if ((getTimer() - this._lastTs) > 100)
            {
                this._lastTs = getTimer();
                this._lastW = StageShareManager.stage.stageWidth;
                this._lastH = StageShareManager.stage.stageHeight;
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.WindowResize, this._lastW, this._lastH, StageShareManager.windowScale);
            };
            setTimeout(this.onStageResize, 101);
        }

        private function onWindowDeactivate(pEvent:Event):void
        {
            Berilia.getInstance().docMain.stage.focus = null;
            FocusHandler.getInstance().setFocus(null);
        }


    }
}//package com.ankamagames.berilia.frames

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import com.ankamagames.jerakine.data.I18n;

class InputWarning extends TextField 
{

    public function InputWarning()
    {
        background = true;
        backgroundColor = 7348259;
        autoSize = TextFieldAutoSize.LEFT;
        wordWrap = true;
        defaultTextFormat = new TextFormat("Verdana", 12, 0xFFFFFF, true);
        text = I18n.getUiText("ui.module.input.warning");
    }

}

