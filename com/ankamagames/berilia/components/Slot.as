package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.frames.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;
    import gs.events.*;

    public class Slot extends ButtonContainer implements ISlotDataHolder, FinalizableUIComponent, IDragAndDropHandler
    {
        private var _data:ISlotData;
        private var _dropValidator:Function;
        private var _unboxedDropValidator:Function;
        private var _topLabel:Label;
        private var _middleLabel:Label;
        private var _bottomLabel:Label;
        private var _backgroundIcon:Texture;
        private var _icon:Texture;
        private var _effect:Texture;
        private var _tx_timerForeground:Texture;
        private var _allowDrag:Boolean = true;
        private var _dragStartPoint:Point;
        private var _displayBackgroundIcon:Boolean = true;
        private var _dragging:Boolean = false;
        private var _selected:Boolean;
        private var _isButton:Boolean = false;
        private var _isTimerRunning:Boolean = false;
        private var _timerMaxDuration:int;
        private var _timerStartTime:int;
        private var _css:Uri;
        private var _cssClass:String = "quantity";
        private var _removeDropSource:Function;
        private var _unboxedRemoveDropSource:Function;
        private var _processDrop:Function;
        private var _unboxedProcessDrop:Function;
        private var _hideTopLabel:Boolean = false;
        public var _emptyTexture:Uri;
        private var _widthHeightMax:uint = 52;
        private var _targetUri:Uri;
        public var highlightTexture:Uri;
        public var selectedTexture:Uri;
        public var timerTexture:Uri;
        public var acceptDragTexture:Uri;
        public var refuseDragTexture:Uri;
        private var _quantitySprite:Sprite;
        private var _quantityText:TextField;
        private const _quantityTextFormat:TextFormat;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Slot));
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        public static const DRAG_AND_DROP_CURSOR_NAME:String = "DragAndDrop";
        public static const NEED_CACHE_AS_BITMAP:String = "needCacheAsBitmap";
        private static var _unicID:uint = 0;

        public function Slot()
        {
            this._quantityTextFormat = new TextFormat("Tahoma", 15, 16777215);
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function set data(param1) : void
        {
            var _loc_2:* = SecureCenter.unsecure(param1);
            if (!_loc_2 is ISlotData)
            {
                throw new TypeError("data must implement ISlotData interface.");
            }
            this._data = _loc_2 as ISlotData;
            if (this.data)
            {
                this._data.addHolder(this);
            }
            if (this._isButton)
            {
                addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            }
            this.refresh();
            return;
        }// end function

        public function get data()
        {
            return SecureCenter.unsecure(this._data);
        }// end function

        override public function get finalized() : Boolean
        {
            return _finalized;
        }// end function

        override public function set finalized(param1:Boolean) : void
        {
            _finalized = param1;
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            if (!this._isButton)
            {
                if (this._effect)
                {
                    if (param1)
                    {
                        this._effect.uri = this.selectedTexture;
                    }
                    else
                    {
                        this._effect.uri = null;
                    }
                }
            }
            else
            {
                super.selected = param1;
            }
            return;
        }// end function

        public function get allowDrag() : Boolean
        {
            return this._allowDrag;
        }// end function

        public function set allowDrag(param1:Boolean) : void
        {
            if (this._allowDrag != param1)
            {
                if (!param1 && StageShareManager.stage.hasEventListener(MouseEvent.MOUSE_MOVE))
                {
                    StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragAndDropStart);
                }
                this._allowDrag = param1;
            }
            return;
        }// end function

        public function set css(param1:Uri) : void
        {
            this._css = param1;
            if (this._topLabel)
            {
                this._topLabel.css = this._css;
            }
            if (this._middleLabel)
            {
                this._middleLabel.css = this._css;
            }
            if (this._bottomLabel)
            {
                this._bottomLabel.css = this._css;
            }
            return;
        }// end function

        public function set cssClass(param1:String) : void
        {
            this._cssClass = param1;
            if (this._topLabel)
            {
                this._topLabel.cssClass = this._cssClass;
            }
            if (this._middleLabel)
            {
                this._middleLabel.cssClass = this._cssClass;
            }
            if (this._bottomLabel)
            {
                this._bottomLabel.cssClass = this._cssClass;
            }
            return;
        }// end function

        override public function set dropValidator(param1:Function) : void
        {
            this._dropValidator = param1;
            this._unboxedDropValidator = null;
            return;
        }// end function

        override public function get dropValidator() : Function
        {
            if (this._dropValidator == null)
            {
                return super.dropValidator;
            }
            if (this._unboxedDropValidator == null)
            {
                this._unboxedDropValidator = SecureCenter.unsecure(this._dropValidator);
            }
            return this._unboxedDropValidator;
        }// end function

        override public function set removeDropSource(param1:Function) : void
        {
            this._removeDropSource = param1;
            this._unboxedRemoveDropSource = null;
            return;
        }// end function

        override public function get removeDropSource() : Function
        {
            if (this._removeDropSource == null)
            {
                return super.removeDropSource;
            }
            if (this._unboxedRemoveDropSource == null)
            {
                this._unboxedRemoveDropSource = SecureCenter.unsecure(this._removeDropSource);
            }
            return this._unboxedRemoveDropSource;
        }// end function

        override public function set processDrop(param1:Function) : void
        {
            this._processDrop = param1;
            this._unboxedProcessDrop = null;
            return;
        }// end function

        override public function get processDrop() : Function
        {
            if (this._processDrop == null)
            {
                return super.processDrop;
            }
            if (this._unboxedProcessDrop == null)
            {
                this._unboxedProcessDrop = SecureCenter.unsecure(this._processDrop);
            }
            return this._unboxedProcessDrop;
        }// end function

        public function get emptyTexture() : Uri
        {
            return this._emptyTexture;
        }// end function

        public function set emptyTexture(param1:Uri) : void
        {
            this._emptyTexture = param1;
            if (this._icon != null)
            {
                this._icon.uri = this._emptyTexture;
            }
            return;
        }// end function

        public function get hideTopLabel() : Boolean
        {
            return this._hideTopLabel;
        }// end function

        public function set hideTopLabel(param1:Boolean) : void
        {
            this._hideTopLabel = param1;
            if (this._topLabel != null)
            {
                this._topLabel.visible = !param1;
            }
            return;
        }// end function

        public function get displayBackgroundIcon() : Boolean
        {
            return this._displayBackgroundIcon;
        }// end function

        public function set displayBackgroundIcon(param1:Boolean) : void
        {
            this._displayBackgroundIcon = param1;
            if (this._backgroundIcon)
            {
                this._backgroundIcon.visible = param1;
            }
            return;
        }// end function

        public function set isButton(param1:Boolean) : void
        {
            this._isButton = param1;
            if (!param1)
            {
                buttonMode = false;
                useHandCursor = false;
            }
            else
            {
                buttonMode = true;
                useHandCursor = true;
            }
            return;
        }// end function

        public function refresh() : void
        {
            this.finalize();
            if (this._data && this._data.info1 && !this._hideTopLabel)
            {
                this.updateQuantity(int(this._data.info1));
            }
            else
            {
                this.updateQuantity(0);
            }
            if (this._isTimerRunning)
            {
                if (!this._data || this._data.timer == 0)
                {
                    this.updateTimer(0);
                }
            }
            else if (this._data && this._data.timer)
            {
                this.updateTimer(this._data.timer);
            }
            if (width <= this._widthHeightMax && height <= this._widthHeightMax)
            {
                this._targetUri = this._data ? (this._data.iconUri) : (this._emptyTexture);
            }
            else
            {
                this._targetUri = this._data ? (this._data.fullSizeIconUri) : (this._emptyTexture);
            }
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.loadTargetUri);
            this._icon.greyedOut = this._data ? (!this._data.active) : (false);
            this._icon.cacheAsBitmap = this._icon.uri && this._icon.uri.tag == NEED_CACHE_AS_BITMAP;
            if (this._backgroundIcon)
            {
                if (this._data && Object(this._data).hasOwnProperty("backGroundIconUri") && Object(this._data).backGroundIconUri)
                {
                    this._backgroundIcon.uri = Object(this._data).backGroundIconUri;
                }
                else
                {
                    this._backgroundIcon.uri = null;
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            var stateChangingProperties:Array;
            if (!this._icon)
            {
                var _loc_3:* = _unicID + 1;
                _unicID = _loc_3;
                this._icon = new Texture();
                if (EmbedIcons.SLOT_DEFAULT_ICON != null)
                {
                    this._icon.defaultBitmapData = EmbedIcons.SLOT_DEFAULT_ICON;
                }
                this._icon.name = "tx_slotUnicIcon" + _unicID;
                this._icon.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED, this.onSlotTextureFailed);
                this._icon.forceReload = true;
                this._icon.mouseEnabled = false;
                this._icon.width = width;
                this._icon.height = height;
                if (width <= this._widthHeightMax && height <= this._widthHeightMax)
                {
                    this._targetUri = this._data ? (this._data.iconUri) : (this._emptyTexture);
                }
                else
                {
                    this._targetUri = this._data ? (this._data.fullSizeIconUri) : (this._emptyTexture);
                }
                this._icon.cacheAsBitmap = this._icon.uri && this._icon.uri.tag == NEED_CACHE_AS_BITMAP;
                this._icon.finalized = true;
                this._icon.finalize();
                addChild(this._icon);
                StageShareManager.stage.addEventListener(Event.ENTER_FRAME, this.loadTargetUri);
            }
            if (!this._tx_timerForeground)
            {
                this._tx_timerForeground = new Texture();
                this._tx_timerForeground.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED, this.onSlotTextureFailed);
                this._tx_timerForeground.forceReload = true;
                this._tx_timerForeground.uri = this.timerTexture;
                this._tx_timerForeground.mouseEnabled = false;
                this._tx_timerForeground.width = width;
                this._tx_timerForeground.height = height;
                this._tx_timerForeground.finalized = true;
                this._tx_timerForeground.finalize();
                this._tx_timerForeground.visible = false;
                addChild(this._tx_timerForeground);
            }
            try
            {
                if (!this._backgroundIcon && this._data && Object(this._data).hasOwnProperty("backGroundIconUri") && Object(this._data).backGroundIconUri)
                {
                    this._backgroundIcon = new Texture();
                    this._backgroundIcon.mouseEnabled = false;
                    this._backgroundIcon.width = width;
                    this._backgroundIcon.height = height;
                    this._backgroundIcon.uri = Object(this._data).backGroundIconUri;
                    this._backgroundIcon.finalized = true;
                    this._backgroundIcon.finalize();
                    this._backgroundIcon.visible = this._displayBackgroundIcon;
                    addChildAt(this._backgroundIcon, 0);
                }
            }
            catch (e:Error)
            {
                _log.warn("C\'est mal de pas implémenter les fonction de base sur " + getQualifiedClassName(_data));
            }
            if (this._data && this._data.info1 && !this._hideTopLabel)
            {
                this.updateQuantity(int(this._data.info1));
            }
            if (this._data && this._data.info1 && !this._hideTopLabel)
            {
                this.updateQuantity(int(this._data.info1));
            }
            if (this._isTimerRunning)
            {
                if (!this._data || this._data.timer == 0)
                {
                    this.updateTimer(0);
                }
            }
            else if (this._data && this._data.timer)
            {
                this.updateTimer(this._data.timer);
            }
            if (!this._effect)
            {
                this._effect = new Texture();
                this._effect.mouseEnabled = false;
                this._effect.width = width;
                this._effect.height = height;
                if (this._selected)
                {
                    this._effect.uri = this.selectedTexture;
                }
                this._effect.finalize();
                this._effect.finalized = true;
                addChild(this._effect);
            }
            if (this._isButton && (!changingStateData || changingStateData.length == 0))
            {
                stateChangingProperties = new Array();
                stateChangingProperties[StatesEnum.STATE_NORMAL] = new Array();
                stateChangingProperties[StatesEnum.STATE_NORMAL][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_NORMAL][this._icon.name]["gotoAndStop"] = "normal";
                stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
                stateChangingProperties[StatesEnum.STATE_OVER][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_OVER][this._icon.name]["gotoAndStop"] = "over";
                stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
                stateChangingProperties[StatesEnum.STATE_CLICKED][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_CLICKED][this._icon.name]["gotoAndStop"] = "pressed";
                stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED][this._icon.name]["gotoAndStop"] = "selected";
                stateChangingProperties[StatesEnum.STATE_SELECTED_OVER] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][this._icon.name]["gotoAndStop"] = "selected_over";
                stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED][this._icon.name] = new Array();
                stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED][this._icon.name]["gotoAndStop"] = "selected_pressed";
                changingStateData = stateChangingProperties;
            }
            _finalized = true;
            if (getUi())
            {
                getUi().iAmFinalized(this);
            }
            return;
        }// end function

        private function updateQuantity(param1:int) : void
        {
            if (param1 == 0)
            {
                if (this._quantitySprite && this._quantitySprite.parent)
                {
                    removeChild(this._quantitySprite);
                }
                return;
            }
            if (!this._quantitySprite)
            {
                this._quantitySprite = new Sprite();
                this._quantitySprite.mouseChildren = false;
                this._quantitySprite.mouseEnabled = false;
                this._quantityText = new TextField();
                this._quantityText.defaultTextFormat = this._quantityTextFormat;
                this._quantityText.height = 25;
                this._quantityText.x = 1;
                this._quantityText.y = -3;
                this._quantityText.autoSize = TextFieldAutoSize.LEFT;
                this._quantitySprite.addChild(this._quantityText);
            }
            addChild(this._quantitySprite);
            this._quantityText.text = String(param1);
            this._quantitySprite.graphics.clear();
            this._quantitySprite.graphics.beginFill(3355443, 0.6);
            this._quantitySprite.graphics.drawRoundRectComplex(0, 0, this._quantityText.width, 18, 10, 0, 0, 0);
            this._quantitySprite.graphics.endFill();
            return;
        }// end function

        private function updateTimer(param1:int) : void
        {
            this._timerMaxDuration = param1;
            if (this._timerMaxDuration == 0)
            {
                this._tx_timerForeground.visible = false;
                this._isTimerRunning = false;
                return;
            }
            this._timerStartTime = getTimer();
            this._tx_timerForeground.gotoAndStop = 100;
            this._tx_timerForeground.visible = true;
            this._isTimerRunning = true;
            EnterFrameDispatcher.addEventListener(this.onEnterFrame, "timerEvent");
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (this._isButton)
            {
                _loc_3 = 9999;
                if (!super.canProcessMessage(param1))
                {
                    return true;
                }
                if (!_disabled)
                {
                    switch(true)
                    {
                        case param1 is MouseDownMessage:
                        {
                            _mousePressed = true;
                            break;
                        }
                        case param1 is MouseDoubleClickMessage:
                        case param1 is MouseClickMessage:
                        {
                            _mousePressed = false;
                            if (!isMute)
                            {
                                for each (_loc_4 in Berilia.getInstance().UISoundListeners)
                                {
                                    
                                    _loc_5 = super.selectSound();
                                    if (int(_loc_5) != -1)
                                    {
                                        _loc_4.playUISound(_loc_5);
                                    }
                                }
                            }
                            break;
                        }
                        default:
                        {
                            super.process(param1);
                            break;
                            break;
                        }
                    }
                }
            }
            switch(true)
            {
                case param1 is MouseDownMessage:
                {
                    if (ShortcutsFrame.shiftKey)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick, SecureCenter.secure(this));
                    }
                    else if (this._allowDrag)
                    {
                        if (!this._data)
                        {
                            return false;
                        }
                        this._dragging = true;
                        StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onDragAndDropStart);
                        this._dragStartPoint = new Point(-MouseDownMessage(param1).mouseEvent.localX, -MouseDownMessage(param1).mouseEvent.localY);
                    }
                    break;
                }
                case param1 is MouseOverMessage:
                {
                    if (this._allowDrag)
                    {
                        _loc_2 = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                        if (_loc_2 && _loc_2.data is SlotDragAndDropData && SlotDragAndDropData(_loc_2.data).slotData != this._data)
                        {
                            _loc_7 = SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder);
                            _loc_8 = getTimer();
                            if (this.dropValidator != null && this.dropValidator(this, SlotDragAndDropData(_loc_2.data).slotData, _loc_7))
                            {
                                this._effect.uri = this.acceptDragTexture;
                            }
                            else
                            {
                                this._effect.uri = this.refuseDragTexture;
                            }
                        }
                        else if (this._effect != null)
                        {
                            this._effect.uri = this.highlightTexture;
                        }
                    }
                    else if (this._effect != null)
                    {
                        this._effect.uri = this.highlightTexture;
                    }
                    break;
                }
                case param1 is MouseOutMessage:
                {
                    if (this._effect)
                    {
                        if (this._selected)
                        {
                            this._effect.uri = this.selectedTexture;
                        }
                        else
                        {
                            this._effect.uri = null;
                        }
                    }
                    break;
                }
                case param1 is MouseReleaseOutsideMessage:
                {
                    _loc_6 = MouseReleaseOutsideMessage(param1).mouseEvent.target;
                    _loc_2 = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                    if (_loc_2 && this._dragging && !(_loc_6 is ISlotDataHolder))
                    {
                        _loc_7 = SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder);
                        switch(true)
                        {
                            case _loc_6 is IDragAndDropHandler:
                            {
                                if ((_loc_6 as IDragAndDropHandler).dropValidator != null)
                                {
                                    _loc_9 = _loc_6 as IDragAndDropHandler;
                                    _loc_10 = _loc_2.data;
                                    _loc_11 = null;
                                    if (_loc_10)
                                    {
                                        _loc_11 = _loc_10.currentHolder;
                                    }
                                    if (_loc_9.dropValidator(this, this.data, _loc_11))
                                    {
                                        _loc_9.processDrop(this, this.data, _loc_11);
                                    }
                                    for each (_loc_12 in Berilia.getInstance().UISoundListeners)
                                    {
                                        
                                        _loc_12.playUISound("16053");
                                    }
                                }
                                break;
                            }
                            case _loc_6 is MovieClip:
                            case _loc_6 is TextField:
                            case _loc_6 is Stage:
                            {
                                KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedNorBeriliaNorWorld, _loc_7);
                                break;
                            }
                            case getQualifiedClassName(_loc_6.parent).indexOf("com.ankamagames.berilia") >= 0:
                            {
                                KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedOnBerilia, _loc_7, _loc_6);
                                break;
                            }
                            case Boolean(_loc_6.parent && _loc_6.parent.parent is MapViewer):
                            case Boolean(_loc_6.parent && getQualifiedClassName(_loc_6.parent).indexOf("Dofus") >= 0):
                            {
                                KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedNorBeriliaNorWorld, _loc_7, _loc_6);
                                break;
                            }
                            default:
                            {
                                KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedOnWorld, _loc_7, _loc_6);
                                break;
                                break;
                            }
                        }
                        LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME, true);
                        if (_loc_2 != null)
                        {
                            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder));
                        }
                    }
                    else if (_loc_6 is Slot)
                    {
                        if ((_loc_6 as Slot).allowDrag == false)
                        {
                            LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                            if (_loc_2 != null)
                            {
                                KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder));
                            }
                        }
                    }
                    this.removeDrag();
                    break;
                }
                case param1 is MouseClickMessage:
                case param1 is MouseDoubleClickMessage:
                {
                    _loc_2 = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                    if (_loc_2 && _loc_2.data is SlotDragAndDropData)
                    {
                        LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder));
                    }
                    if (this._dragging)
                    {
                        this.removeDrag();
                    }
                    if (ShortcutsFrame.ctrlKey && param1 is MouseDoubleClickMessage)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseCtrlDoubleClick, SecureCenter.secure(this));
                    }
                    else if (ShortcutsFrame.altKey && param1 is MouseDoubleClickMessage)
                    {
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseAltDoubleClick, SecureCenter.secure(this));
                    }
                    break;
                }
                case param1 is MouseUpMessage:
                {
                    _loc_2 = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                    if (_loc_2 && _loc_2.data is SlotDragAndDropData)
                    {
                        _loc_10 = _loc_2.data;
                        if (_loc_10.slotData != this._data && this.dropValidator(this, SlotDragAndDropData(_loc_2.data).slotData, _loc_10.currentHolder))
                        {
                            if (_loc_10.currentHolder)
                            {
                                _loc_10.currentHolder.removeDropSource(_loc_10.currentHolder);
                            }
                            this.processDrop(this, _loc_10.slotData, _loc_10.currentHolder);
                            for each (_loc_13 in Berilia.getInstance().UISoundListeners)
                            {
                                
                                _loc_13.playUISound("16053");
                            }
                            LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                        }
                        else
                        {
                            LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                        }
                        Berilia.getInstance().handler.process(new DropMessage(this, _loc_10.currentHolder));
                        if (this._allowDrag)
                        {
                            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(_loc_10.currentHolder));
                        }
                    }
                    if (this._dragging)
                    {
                        this.removeDrag();
                    }
                    break;
                }
                case param1 is MouseRightClickOutsideMessage:
                {
                    _loc_2 = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                    if (_loc_2 && _loc_2.data is SlotDragAndDropData)
                    {
                        LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd, SecureCenter.secure(SlotDragAndDropData(_loc_2.data).currentHolder));
                    }
                    if (this._dragging)
                    {
                        this.removeDrag();
                    }
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function remove() : void
        {
            if (!__removed)
            {
                this._dropValidator = null;
                this._unboxedDropValidator = null;
                this._removeDropSource = null;
                this._unboxedRemoveDropSource = null;
                this._processDrop = null;
                this._unboxedProcessDrop = null;
                removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
                if (this._topLabel)
                {
                    this._topLabel.remove();
                }
                if (this._middleLabel)
                {
                    this._middleLabel.remove();
                }
                if (this._bottomLabel)
                {
                    this._bottomLabel.remove();
                }
                if (this._icon)
                {
                    this._icon.remove();
                }
                if (this._effect)
                {
                    this._effect.remove();
                }
                if (this._backgroundIcon)
                {
                    this._backgroundIcon.remove();
                }
                if (this._tx_timerForeground)
                {
                    this._tx_timerForeground.remove();
                }
                if (this._data)
                {
                    this._data.removeHolder(this);
                }
                this._data = null;
                this._topLabel = null;
                this._middleLabel = null;
                this._bottomLabel = null;
                this._icon = null;
                this._effect = null;
                this._backgroundIcon = null;
                this._tx_timerForeground = null;
                if (parent)
                {
                    parent.removeChild(this);
                }
                if (this._quantitySprite)
                {
                    if (this._quantitySprite.parent)
                    {
                        removeChild(this._quantitySprite);
                    }
                    this._quantitySprite = null;
                }
            }
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            super.remove();
            return;
        }// end function

        private function removeDrag() : void
        {
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragAndDropStart);
            this._icon.filters = [];
            this._dragStartPoint = null;
            this._dragging = false;
            return;
        }// end function

        private function emptyFunction(... args)
        {
            return null;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = getTimer();
            if (_loc_2 > this._timerStartTime + this._timerMaxDuration)
            {
                EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
                this._timerMaxDuration = 0;
                this._timerStartTime = 0;
                this._tx_timerForeground.visible = false;
                this._isTimerRunning = false;
            }
            else
            {
                _loc_3 = Math.round((_loc_2 - this._timerStartTime) / this._timerMaxDuration * 100);
                _loc_3 = 100 - _loc_3;
                this._tx_timerForeground.gotoAndStop = _loc_3;
            }
            return;
        }// end function

        private function loadTargetUri(event:Event) : void
        {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME, this.loadTargetUri);
            if (this._icon)
            {
                this._icon.uri = this._targetUri;
            }
            else
            {
                _log.error("Impossible de donner au slot l\'icone : " + this._targetUri);
            }
            return;
        }// end function

        private function onTweenEnd(event:TweenEvent) : void
        {
            LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
            return;
        }// end function

        private function onSlotTextureFailed(event:TextureLoadFailedEvent) : void
        {
            if (this._data && this._data.errorIconUri)
            {
                event.behavior.cancel = true;
                this._icon.uri = this._data.errorIconUri;
            }
            return;
        }// end function

        private function onDragAndDropStart(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!stage)
            {
                return;
            }
            for each (_loc_2 in Berilia.getInstance().UISoundListeners)
            {
                
                _loc_2.playUISound("16059");
            }
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragAndDropStart);
            _loc_3 = new LinkedCursorData();
            _loc_4 = new BitmapData(width, height, true, 0);
            this._effect.visible = false;
            _loc_4.draw(this);
            this._effect.visible = true;
            _loc_3.sprite = new DragSprite(_loc_4);
            _loc_3.offset = new Point(0, 0);
            _loc_5 = new SlotDragAndDropData(this, this._data);
            _loc_3.data = _loc_5;
            LinkedCursorSpriteManager.getInstance().addItem(DRAG_AND_DROP_CURSOR_NAME, _loc_3);
            _loc_6 = new Array();
            _loc_6 = _loc_6.concat([1 / 2, 0, 0, 0, 0]);
            _loc_6 = _loc_6.concat([0, 1 / 2, 0, 0, 0]);
            _loc_6 = _loc_6.concat([0, 0, 1 / 2, 0, 0]);
            _loc_6 = _loc_6.concat([0, 0, 0, 1, 0]);
            this._icon.filters = [new ColorMatrixFilter(_loc_6)];
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropStart, SecureCenter.secure(this));
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            var _loc_2:* = getUi();
            if (_loc_2 && this._icon)
            {
                _loc_2.registerId(this._icon.name, new GraphicElement(this._icon, new Array(), this._icon.name));
            }
            return;
        }// end function

    }
}

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.components.messages.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.berilia.frames.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.event.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.berilia.utils.*;

import com.ankamagames.jerakine.handlers.messages.mouse.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.display.*;

import flash.display.*;

import flash.events.*;

import flash.filters.*;

import flash.geom.*;

import flash.text.*;

import flash.utils.*;

import gs.events.*;

class DragSprite extends Sprite
{

    function DragSprite(param1:BitmapData)
    {
        alpha = 0.8;
        addChild(new Bitmap(param1));
        return;
    }// end function

}

