package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import flash.geom.Point;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import com.ankamagames.berilia.utils.EmbedIcons;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.enums.StatesEnum;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.berilia.types.data.SlotDragAndDropData;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import com.ankamagames.berilia.components.messages.DropMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import gs.events.TweenEvent;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   
   public class Slot extends ButtonContainer implements ISlotDataHolder, FinalizableUIComponent, IDragAndDropHandler
   {
      
      public function Slot() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Slot));
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static const DRAG_AND_DROP_CURSOR_NAME:String = "DragAndDrop";
      
      public static const NEED_CACHE_AS_BITMAP:String = "needCacheAsBitmap";
      
      private static var _unicID:uint = 0;
      
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
      
      public var _customTexture:Uri;
      
      public var _forcedBackGroundIconUri:Uri;
      
      private var _widthHeightMax:uint = 52;
      
      private var _targetUri:Uri;
      
      public var highlightTexture:Uri;
      
      public var selectedTexture:Uri;
      
      public var timerTexture:Uri;
      
      public var acceptDragTexture:Uri;
      
      public var refuseDragTexture:Uri;
      
      public function set data(param1:*) : void {
         var _loc2_:* = SecureCenter.unsecure(param1);
         if(!_loc2_ is ISlotData)
         {
            throw new TypeError("data must implement ISlotData interface.");
         }
         else
         {
            this._data = _loc2_ as ISlotData;
            if(this.data)
            {
               this._data.addHolder(this);
            }
            if(this._isButton)
            {
               addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            }
            this.refresh();
            return;
         }
      }
      
      public function get data() : * {
         return SecureCenter.unsecure(this._data);
      }
      
      override public function get finalized() : Boolean {
         return _finalized;
      }
      
      override public function set finalized(param1:Boolean) : void {
         _finalized = param1;
      }
      
      override public function set selected(param1:Boolean) : void {
         this._selected = param1;
         if(!this._isButton)
         {
            if(this._effect)
            {
               if(param1)
               {
                  this._effect.uri = this.selectedTexture;
               }
               else
               {
                  if(this._customTexture)
                  {
                     this._effect.uri = this._customTexture;
                  }
                  else
                  {
                     this._effect.uri = null;
                  }
               }
            }
         }
         else
         {
            super.selected = param1;
         }
      }
      
      public function get allowDrag() : Boolean {
         return this._allowDrag;
      }
      
      public function set allowDrag(param1:Boolean) : void {
         if(this._allowDrag != param1)
         {
            if(!param1 && (StageShareManager.stage.hasEventListener(MouseEvent.MOUSE_MOVE)))
            {
               StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
            }
            this._allowDrag = param1;
         }
      }
      
      public function set css(param1:Uri) : void {
         this._css = param1;
         if(this._topLabel)
         {
            this._topLabel.css = this._css;
         }
         if(this._middleLabel)
         {
            this._middleLabel.css = this._css;
         }
         if(this._bottomLabel)
         {
            this._bottomLabel.css = this._css;
         }
      }
      
      public function set cssClass(param1:String) : void {
         this._cssClass = param1;
         if(this._topLabel)
         {
            this._topLabel.cssClass = this._cssClass;
         }
         if(this._middleLabel)
         {
            this._middleLabel.cssClass = this._cssClass;
         }
         if(this._bottomLabel)
         {
            this._bottomLabel.cssClass = this._cssClass;
         }
      }
      
      override public function set dropValidator(param1:Function) : void {
         this._dropValidator = param1;
         this._unboxedDropValidator = null;
      }
      
      override public function get dropValidator() : Function {
         if(this._dropValidator == null)
         {
            return super.dropValidator;
         }
         if(this._unboxedDropValidator == null)
         {
            this._unboxedDropValidator = SecureCenter.unsecure(this._dropValidator);
         }
         return this._unboxedDropValidator;
      }
      
      override public function set removeDropSource(param1:Function) : void {
         this._removeDropSource = param1;
         this._unboxedRemoveDropSource = null;
      }
      
      override public function get removeDropSource() : Function {
         if(this._removeDropSource == null)
         {
            return super.removeDropSource;
         }
         if(this._unboxedRemoveDropSource == null)
         {
            this._unboxedRemoveDropSource = SecureCenter.unsecure(this._removeDropSource);
         }
         return this._unboxedRemoveDropSource;
      }
      
      override public function set processDrop(param1:Function) : void {
         this._processDrop = param1;
         this._unboxedProcessDrop = null;
      }
      
      override public function get processDrop() : Function {
         if(this._processDrop == null)
         {
            return super.processDrop;
         }
         if(this._unboxedProcessDrop == null)
         {
            this._unboxedProcessDrop = SecureCenter.unsecure(this._processDrop);
         }
         return this._unboxedProcessDrop;
      }
      
      public function get emptyTexture() : Uri {
         return this._emptyTexture;
      }
      
      public function set emptyTexture(param1:Uri) : void {
         this._emptyTexture = param1;
         if(this._icon != null)
         {
            this._icon.uri = this._emptyTexture;
         }
      }
      
      public function get customTexture() : Uri {
         return this._customTexture;
      }
      
      public function set customTexture(param1:Uri) : void {
         this._customTexture = param1;
         if(this._effect)
         {
            this._effect.uri = this._customTexture;
         }
      }
      
      public function get forcedBackGroundIconUri() : Uri {
         return this._forcedBackGroundIconUri;
      }
      
      public function set forcedBackGroundIconUri(param1:Uri) : void {
         this._forcedBackGroundIconUri = param1;
         if(this._backgroundIcon)
         {
            this._backgroundIcon.uri = this._forcedBackGroundIconUri;
         }
      }
      
      public function get hideTopLabel() : Boolean {
         return this._hideTopLabel;
      }
      
      public function set hideTopLabel(param1:Boolean) : void {
         this._hideTopLabel = param1;
         if(this._topLabel != null)
         {
            this._topLabel.visible = !param1;
         }
      }
      
      public function get displayBackgroundIcon() : Boolean {
         return this._displayBackgroundIcon;
      }
      
      public function set displayBackgroundIcon(param1:Boolean) : void {
         this._displayBackgroundIcon = param1;
         if(this._backgroundIcon)
         {
            this._backgroundIcon.visible = param1;
         }
      }
      
      public function set isButton(param1:Boolean) : void {
         this._isButton = param1;
         if(!param1)
         {
            buttonMode = false;
            useHandCursor = false;
         }
         else
         {
            buttonMode = true;
            useHandCursor = true;
         }
      }
      
      public function refresh() : void {
         this.finalize();
         if((this._data) && (this._data.info1) && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         else
         {
            this.updateQuantity(0);
         }
         if(this._isTimerRunning)
         {
            if(!this._data || this._data.timer == 0)
            {
               this.updateTimer(0);
            }
         }
         else
         {
            if((this._data) && (this._data.timer))
            {
               this.updateTimer(this._data.timer);
            }
         }
         if(width <= this._widthHeightMax && height <= this._widthHeightMax)
         {
            this._targetUri = this._data?this._data.iconUri:this._emptyTexture;
         }
         else
         {
            this._targetUri = this._data?this._data.fullSizeIconUri:this._emptyTexture;
         }
         this._icon.finalized = true;
         StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.loadTargetUri);
         this._icon.greyedOut = this._data?!this._data.active:false;
         this._icon.cacheAsBitmap = (this._icon.uri) && this._icon.uri.tag == NEED_CACHE_AS_BITMAP;
         if(this._backgroundIcon)
         {
            if(this._forcedBackGroundIconUri)
            {
               this._backgroundIcon.uri = this._forcedBackGroundIconUri;
            }
            else
            {
               if((this._data) && (Object(this._data).hasOwnProperty("backGroundIconUri")) && (Object(this._data).backGroundIconUri))
               {
                  this._backgroundIcon.uri = Object(this._data).backGroundIconUri;
               }
               else
               {
                  this._backgroundIcon.uri = null;
               }
            }
         }
      }
      
      override public function finalize() : void {
         var stateChangingProperties:Array = null;
         if(!this._icon)
         {
            _unicID++;
            this._icon = new Texture();
            if(EmbedIcons.SLOT_DEFAULT_ICON != null)
            {
               this._icon.defaultBitmapData = EmbedIcons.SLOT_DEFAULT_ICON;
            }
            this._icon.name = "tx_slotUnicIcon" + _unicID;
            this._icon.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
            this._icon.forceReload = true;
            this._icon.mouseEnabled = false;
            this._icon.width = width;
            this._icon.height = height;
            if(width <= this._widthHeightMax && height <= this._widthHeightMax)
            {
               this._targetUri = this._data?this._data.iconUri:this._emptyTexture;
            }
            else
            {
               this._targetUri = this._data?this._data.fullSizeIconUri:this._emptyTexture;
            }
            this._icon.cacheAsBitmap = (this._icon.uri) && this._icon.uri.tag == NEED_CACHE_AS_BITMAP;
            this._icon.finalized = this._targetUri == null;
            this._icon.finalize();
            addChild(this._icon);
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.loadTargetUri);
         }
         if(!this._tx_timerForeground)
         {
            this._tx_timerForeground = new Texture();
            this._tx_timerForeground.addEventListener(TextureLoadFailedEvent.EVENT_TEXTURE_LOAD_FAILED,this.onSlotTextureFailed);
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
            if(!this._backgroundIcon && ((this._forcedBackGroundIconUri) || ((this._data) && (Object(this._data).hasOwnProperty("backGroundIconUri")) && Object(this._data).backGroundIconUri)))
            {
               this._backgroundIcon = new Texture();
               this._backgroundIcon.mouseEnabled = false;
               this._backgroundIcon.width = width;
               this._backgroundIcon.height = height;
               this._backgroundIcon.uri = this._forcedBackGroundIconUri?this._forcedBackGroundIconUri:Object(this._data).backGroundIconUri;
               this._backgroundIcon.finalized = true;
               this._backgroundIcon.finalize();
               this._backgroundIcon.visible = this._displayBackgroundIcon;
               addChildAt(this._backgroundIcon,0);
            }
         }
         catch(e:Error)
         {
            _log.warn("C\'est mal de pas implémenter les fonction de base sur " + getQualifiedClassName(_data));
         }
         if((this._data) && (this._data.info1) && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         if((this._data) && (this._data.info1) && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         if(this._isTimerRunning)
         {
            if(!this._data || this._data.timer == 0)
            {
               this.updateTimer(0);
            }
         }
         else
         {
            if((this._data) && (this._data.timer))
            {
               this.updateTimer(this._data.timer);
            }
         }
         if(!this._effect)
         {
            this._effect = new Texture();
            this._effect.mouseEnabled = false;
            this._effect.width = width;
            this._effect.height = height;
            if(this._selected)
            {
               this._effect.uri = this.selectedTexture;
            }
            else
            {
               if(this._customTexture)
               {
                  this._effect.uri = this._customTexture;
               }
            }
            this._effect.finalize();
            this._effect.finalized = true;
            addChild(this._effect);
         }
         if((this._isButton) && (!changingStateData || changingStateData.length == 0))
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
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
         return;
         if(!this._backgroundIcon && ((this._forcedBackGroundIconUri) || ((this._data) && (Object(this._data).hasOwnProperty("backGroundIconUri")) && Object(this._data).backGroundIconUri)))
         {
            this._backgroundIcon = new Texture();
            this._backgroundIcon.mouseEnabled = false;
            this._backgroundIcon.width = width;
            this._backgroundIcon.height = height;
            this._backgroundIcon.uri = this._forcedBackGroundIconUri?this._forcedBackGroundIconUri:Object(this._data).backGroundIconUri;
            this._backgroundIcon.finalized = true;
            this._backgroundIcon.finalize();
            this._backgroundIcon.visible = this._displayBackgroundIcon;
            addChildAt(this._backgroundIcon,0);
         }
         if((this._data) && (this._data.info1) && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         if((this._data) && (this._data.info1) && !this._hideTopLabel)
         {
            this.updateQuantity(int(this._data.info1));
         }
         if(this._isTimerRunning)
         {
            if(!this._data || this._data.timer == 0)
            {
               this.updateTimer(0);
            }
         }
         else
         {
            if((this._data) && (this._data.timer))
            {
               this.updateTimer(this._data.timer);
            }
         }
         if(!this._effect)
         {
            this._effect = new Texture();
            this._effect.mouseEnabled = false;
            this._effect.width = width;
            this._effect.height = height;
            if(this._selected)
            {
               this._effect.uri = this.selectedTexture;
            }
            else
            {
               if(this._customTexture)
               {
                  this._effect.uri = this._customTexture;
               }
            }
            this._effect.finalize();
            this._effect.finalized = true;
            addChild(this._effect);
         }
         if((this._isButton) && (!changingStateData || changingStateData.length == 0))
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
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      private var _quantitySprite:Sprite;
      
      private var _quantityText:TextField;
      
      private const _quantityTextFormat:TextFormat = new TextFormat("Tahoma",15,16777215);
      
      public function updateQuantity(param1:int) : void {
         if(param1 == 0)
         {
            if((this._quantitySprite) && (this._quantitySprite.parent))
            {
               removeChild(this._quantitySprite);
            }
            return;
         }
         if(!this._quantitySprite)
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
         this._quantitySprite.graphics.beginFill(3355443,0.6);
         this._quantitySprite.graphics.drawRoundRectComplex(0,0,this._quantityText.width,18,10,0,0,0);
         this._quantitySprite.graphics.endFill();
      }
      
      private function updateTimer(param1:int) : void {
         var _loc3_:* = 0;
         this._timerMaxDuration = param1;
         if(this._timerMaxDuration == 0)
         {
            this._tx_timerForeground.visible = false;
            this._isTimerRunning = false;
            return;
         }
         var _loc2_:int = getTimer();
         if(!this._data.endTime)
         {
            this._data.endTime = _loc2_ + this._timerMaxDuration;
            this._timerStartTime = this._data.startTime;
            this._tx_timerForeground.gotoAndStop = 100;
         }
         else
         {
            this._timerMaxDuration = this._data.endTime - this._data.startTime;
            this._timerStartTime = this._data.startTime;
            _loc3_ = Math.round((_loc2_ - this._timerStartTime) / this._timerMaxDuration * 100);
            _loc3_ = 100 - _loc3_;
            this._tx_timerForeground.gotoAndStop = _loc3_;
         }
         this._tx_timerForeground.visible = true;
         this._isTimerRunning = true;
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,"timerEvent");
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:LinkedCursorData = null;
         var _loc3_:uint = 0;
         var _loc4_:IInterfaceListener = null;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:uint = 0;
         var _loc9_:IDragAndDropHandler = null;
         var _loc10_:SlotDragAndDropData = null;
         var _loc11_:ISlotDataHolder = null;
         var _loc12_:IInterfaceListener = null;
         var _loc13_:IInterfaceListener = null;
         if(this._isButton)
         {
            _loc3_ = 9999;
            if(!super.canProcessMessage(param1))
            {
               return true;
            }
            if(!_disabled)
            {
               switch(true)
               {
                  case param1 is MouseDownMessage:
                     _mousePressed = true;
                     break;
                  case param1 is MouseDoubleClickMessage:
                  case param1 is MouseClickMessage:
                     _mousePressed = false;
                     if(!isMute)
                     {
                        for each (_loc4_ in Berilia.getInstance().UISoundListeners)
                        {
                           _loc5_ = super.selectSound();
                           if(int(_loc5_) != -1)
                           {
                              _loc4_.playUISound(_loc5_);
                           }
                        }
                     }
                     break;
                  default:
                     super.process(param1);
               }
            }
         }
         switch(true)
         {
            case param1 is MouseDownMessage:
               if(ShortcutsFrame.shiftKey)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick,SecureCenter.secure(this));
               }
               else
               {
                  if(this._allowDrag)
                  {
                     if(!this._data)
                     {
                        return false;
                     }
                     this._dragging = true;
                     StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
                     this._dragStartPoint = new Point(-MouseDownMessage(param1).mouseEvent.localX,-MouseDownMessage(param1).mouseEvent.localY);
                  }
               }
               break;
            case param1 is MouseOverMessage:
               if(this._allowDrag)
               {
                  _loc2_ = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
                  if((_loc2_) && (_loc2_.data is SlotDragAndDropData) && !(SlotDragAndDropData(_loc2_.data).slotData == this._data))
                  {
                     _loc7_ = SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder);
                     _loc8_ = getTimer();
                     if(!(this.dropValidator == null) && (this.dropValidator(this,SlotDragAndDropData(_loc2_.data).slotData,_loc7_)))
                     {
                        this._effect.uri = this.acceptDragTexture;
                     }
                     else
                     {
                        this._effect.uri = this.refuseDragTexture;
                     }
                  }
                  else
                  {
                     if(this._effect != null)
                     {
                        this._effect.uri = this.highlightTexture;
                     }
                  }
               }
               else
               {
                  if(this._effect != null)
                  {
                     this._effect.uri = this.highlightTexture;
                  }
               }
               break;
            case param1 is MouseOutMessage:
               if(this._effect)
               {
                  if(this._selected)
                  {
                     this._effect.uri = this.selectedTexture;
                  }
                  else
                  {
                     if(this._customTexture)
                     {
                        this._effect.uri = this._customTexture;
                     }
                     else
                     {
                        this._effect.uri = null;
                     }
                  }
               }
               break;
            case param1 is MouseReleaseOutsideMessage:
               _loc6_ = MouseReleaseOutsideMessage(param1).mouseEvent.target;
               _loc2_ = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if((_loc2_) && (this._dragging) && !(_loc6_ is ISlotDataHolder))
               {
                  _loc7_ = SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder);
                  switch(true)
                  {
                     case _loc6_ is IDragAndDropHandler:
                        if((_loc6_ as IDragAndDropHandler).dropValidator != null)
                        {
                           _loc9_ = _loc6_ as IDragAndDropHandler;
                           _loc10_ = _loc2_.data;
                           _loc11_ = null;
                           if(_loc10_)
                           {
                              _loc11_ = _loc10_.currentHolder;
                           }
                           if(_loc9_.dropValidator(this,this.data,_loc11_))
                           {
                              _loc9_.processDrop(this,this.data,_loc11_);
                           }
                           for each (_loc12_ in Berilia.getInstance().UISoundListeners)
                           {
                              _loc12_.playUISound("16053");
                           }
                        }
                        break;
                     case _loc6_ is MovieClip:
                     case _loc6_ is TextField:
                     case _loc6_ is Stage:
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedNorBeriliaNorWorld,_loc7_);
                        break;
                     case getQualifiedClassName(_loc6_.parent).indexOf("com.ankamagames.berilia") >= 0:
                        KernelEventsManager.getInstance().processCallback(BeriliaHookList.SlotDropedOnBerilia,_loc7_,_loc6_);
                        break;
                  }
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME,true);
                  if(_loc2_ != null)
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder));
                  }
               }
               else
               {
                  if(_loc6_ is Slot)
                  {
                     if((_loc6_ as Slot).allowDrag == false)
                     {
                        LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                        if(_loc2_ != null)
                        {
                           KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder));
                        }
                     }
                  }
               }
               this.removeDrag();
               break;
            case param1 is MouseClickMessage:
            case param1 is MouseDoubleClickMessage:
               _loc2_ = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if((_loc2_) && _loc2_.data is SlotDragAndDropData)
               {
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder));
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
               if((ShortcutsFrame.ctrlKey) && param1 is MouseDoubleClickMessage)
               {
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseCtrlDoubleClick,SecureCenter.secure(this));
               }
               else
               {
                  if((ShortcutsFrame.altKey) && param1 is MouseDoubleClickMessage)
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseAltDoubleClick,SecureCenter.secure(this));
                  }
               }
               break;
            case param1 is MouseUpMessage:
               _loc2_ = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if((_loc2_) && _loc2_.data is SlotDragAndDropData)
               {
                  _loc10_ = _loc2_.data;
                  if(!(_loc10_.slotData == this._data) && (this.dropValidator(this,SlotDragAndDropData(_loc2_.data).slotData,_loc10_.currentHolder)))
                  {
                     if(_loc10_.currentHolder)
                     {
                        _loc10_.currentHolder.removeDropSource(_loc10_.currentHolder);
                     }
                     this.processDrop(this,_loc10_.slotData,_loc10_.currentHolder);
                     for each (_loc13_ in Berilia.getInstance().UISoundListeners)
                     {
                        _loc13_.playUISound("16053");
                     }
                     LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  }
                  else
                  {
                     LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  }
                  Berilia.getInstance().handler.process(new DropMessage(this,_loc10_.currentHolder));
                  if(this._allowDrag)
                  {
                     KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(_loc10_.currentHolder));
                  }
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
               break;
            case param1 is MouseRightClickOutsideMessage:
               _loc2_ = LinkedCursorSpriteManager.getInstance().getItem(DRAG_AND_DROP_CURSOR_NAME);
               if((_loc2_) && _loc2_.data is SlotDragAndDropData)
               {
                  LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SecureCenter.secure(SlotDragAndDropData(_loc2_.data).currentHolder));
               }
               if(this._dragging)
               {
                  this.removeDrag();
               }
         }
         return false;
      }
      
      override public function remove() : void {
         if(!__removed)
         {
            this._dropValidator = null;
            this._unboxedDropValidator = null;
            this._removeDropSource = null;
            this._unboxedRemoveDropSource = null;
            this._processDrop = null;
            this._unboxedProcessDrop = null;
            removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
            if(this._topLabel)
            {
               this._topLabel.remove();
            }
            if(this._middleLabel)
            {
               this._middleLabel.remove();
            }
            if(this._bottomLabel)
            {
               this._bottomLabel.remove();
            }
            if(this._icon)
            {
               this._icon.remove();
            }
            if(this._effect)
            {
               this._effect.remove();
            }
            if(this._backgroundIcon)
            {
               this._backgroundIcon.remove();
            }
            if(this._tx_timerForeground)
            {
               this._tx_timerForeground.remove();
            }
            if(this._data)
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
            if(parent)
            {
               parent.removeChild(this);
            }
            if(this._quantitySprite)
            {
               if(this._quantitySprite.parent)
               {
                  removeChild(this._quantitySprite);
               }
               this._quantitySprite = null;
            }
         }
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         super.remove();
      }
      
      private function removeDrag() : void {
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
         if(this._icon)
         {
            this._icon.filters = [];
         }
         this._dragStartPoint = null;
         this._dragging = false;
      }
      
      private function emptyFunction(... rest) : * {
         return null;
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc3_:* = 0;
         var _loc2_:int = getTimer();
         if(_loc2_ > this._timerStartTime + this._timerMaxDuration)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this._timerMaxDuration = 0;
            this._timerStartTime = 0;
            this._tx_timerForeground.visible = false;
            this._isTimerRunning = false;
            if(this._data)
            {
               this._data.endTime = 0;
            }
         }
         else
         {
            _loc3_ = Math.round((_loc2_ - this._timerStartTime) / this._timerMaxDuration * 100);
            _loc3_ = 100 - _loc3_;
            this._tx_timerForeground.gotoAndStop = _loc3_;
         }
      }
      
      private function loadTargetUri(param1:Event) : void {
         StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.loadTargetUri);
         if(this._icon)
         {
            this._icon.uri = this._targetUri;
            this._icon.finalized = true;
         }
         else
         {
            _log.error("Impossible de donner au slot l\'icone : " + this._targetUri);
         }
      }
      
      private function onTweenEnd(param1:TweenEvent) : void {
         LinkedCursorSpriteManager.getInstance().removeItem(DRAG_AND_DROP_CURSOR_NAME);
      }
      
      private function onSlotTextureFailed(param1:TextureLoadFailedEvent) : void {
         if((this._data) && (this._data.errorIconUri))
         {
            param1.behavior.cancel = true;
            this._icon.uri = this._data.errorIconUri;
         }
      }
      
      private function onDragAndDropStart(param1:Event) : void {
         var _loc2_:IInterfaceListener = null;
         var _loc3_:LinkedCursorData = null;
         var _loc4_:BitmapData = null;
         var _loc5_:SlotDragAndDropData = null;
         var _loc6_:Array = null;
         if(!stage)
         {
            return;
         }
         for each (_loc2_ in Berilia.getInstance().UISoundListeners)
         {
            _loc2_.playUISound("16059");
         }
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragAndDropStart);
         _loc3_ = new LinkedCursorData();
         _loc4_ = new BitmapData(width,height,true,0);
         this._effect.visible = false;
         _loc4_.draw(this);
         this._effect.visible = true;
         _loc3_.sprite = new DragSprite(_loc4_);
         _loc3_.offset = new Point(0,0);
         _loc5_ = new SlotDragAndDropData(this,this._data);
         _loc3_.data = _loc5_;
         LinkedCursorSpriteManager.getInstance().addItem(DRAG_AND_DROP_CURSOR_NAME,_loc3_);
         _loc6_ = new Array();
         _loc6_ = _loc6_.concat([1 / 2,0,0,0,0]);
         _loc6_ = _loc6_.concat([0,1 / 2,0,0,0]);
         _loc6_ = _loc6_.concat([0,0,1 / 2,0,0]);
         _loc6_ = _loc6_.concat([0,0,0,1,0]);
         this._icon.filters = [new ColorMatrixFilter(_loc6_)];
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropStart,SecureCenter.secure(this));
      }
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         var _loc2_:Object = getUi();
         if((_loc2_) && (this._icon))
         {
            _loc2_.registerId(this._icon.name,new GraphicElement(this._icon,new Array(),this._icon.name));
         }
      }
   }
}
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;

class DragSprite extends Sprite
{
   
   function DragSprite(param1:BitmapData) {
      super();
      alpha = 0.8;
      addChild(new Bitmap(param1));
   }
}
