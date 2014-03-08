package com.ankamagames.berilia.types.graphic
{
   import flash.display.Sprite;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.interfaces.IDragAndDropHandler;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.filters.DropShadowFilter;
   import flash.display.Shape;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.berilia.Berilia;
   import flash.filters.BitmapFilterQuality;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.pools.GenericPool;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import gs.TweenLite;
   import gs.easing.Strong;
   import flash.geom.Point;
   import flash.display.MovieClip;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.events.Event;
   import com.ankamagames.berilia.components.messages.ItemRollOutMessage;
   import com.ankamagames.berilia.components.messages.ItemRollOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   
   public class GraphicContainer extends Sprite implements UIComponent, IRectangle, Poolable, IDragAndDropHandler, ICustomUnicNameGetter
   {
      
      public function GraphicContainer() {
         this._dropValidatorFunction = this.defaultDropValidatorFunction;
         this._processDropFunction = this.defaultProcessDropFunction;
         this._removeDropSourceFunction = this.defaultRemoveDropSourceFunction;
         super();
         this._aStrata = new Array();
         focusRect = false;
         this.mouseEnabled = false;
         FpsManager.getInstance().watchObject(this);
         doubleClickEnabled = true;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicContainer));
      
      protected var __width:uint;
      
      protected var __widthReal:uint;
      
      protected var __height:uint;
      
      protected var __heightReal:uint;
      
      protected var __removed:Boolean;
      
      protected var _bgColor:int = -1;
      
      protected var _bgAlpha:Number = 1;
      
      protected var _borderColor:int = -1;
      
      protected var _bgCornerRadius:uint = 0;
      
      protected var _aStrata:Array;
      
      private var _scale:Number = 1.0;
      
      private var _sLinkedTo:String;
      
      private var _bDynamicPosition:Boolean;
      
      private var _bDisabled:Boolean;
      
      private var _bSoftDisabled:Boolean;
      
      private var _bGreyedOut:Boolean;
      
      private var _shadow:DropShadowFilter;
      
      private var _luminosity:Number = 1.0;
      
      private var _nMouseX:int;
      
      private var _nMouseY:int;
      
      private var _nStartWidth:int;
      
      private var _nStartHeight:int;
      
      private var _nLastWidth:int;
      
      private var _nLastHeight:int;
      
      private var _shResizeBorder:Shape;
      
      private var _bUseSimpleResize:Boolean = true;
      
      var _uiRootContainer:UiRootContainer;
      
      private var _dropValidatorFunction:Function;
      
      private var _processDropFunction:Function;
      
      private var _removeDropSourceFunction:Function;
      
      private var _startSlideTime:int;
      
      private var _timeSlide:int;
      
      private var _slideBaseX:int;
      
      private var _slideBaseY:int;
      
      private var _slideWidth:int;
      
      private var _slideHeight:int;
      
      public var minSize:GraphicSize;
      
      public var maxSize:GraphicSize;
      
      private var _customName:String;
      
      public function get customUnicName() : String {
         if(!this._customName)
         {
            if(this.getUi())
            {
               if(name.indexOf(this.getUi().name + "::") == 0)
               {
                  this._customName = name;
               }
               else
               {
                  this._customName = this.getUi().name + "::" + name;
               }
            }
         }
         return this._customName;
      }
      
      public function set dropValidator(param1:Function) : void {
         this._dropValidatorFunction = param1;
      }
      
      public function get dropValidator() : Function {
         return this._dropValidatorFunction;
      }
      
      public function set removeDropSource(param1:Function) : void {
         this._removeDropSourceFunction = param1;
      }
      
      public function get removeDropSource() : Function {
         return this._removeDropSourceFunction;
      }
      
      public function set processDrop(param1:Function) : void {
         this._processDropFunction = param1;
      }
      
      public function get processDrop() : Function {
         return this._processDropFunction;
      }
      
      public function focus() : void {
         FocusHandler.getInstance().setFocus(this);
      }
      
      public function get hasFocus() : Boolean {
         return FocusHandler.getInstance().hasFocus(this);
      }
      
      public function get scale() : Number {
         return this._scale;
      }
      
      public function set scale(param1:Number) : void {
         this.__width = this.__widthReal * (1 - param1);
         this.__height = this.__heightReal * (1 - param1);
         scaleX = param1;
         scaleY = param1;
         this._scale = param1;
      }
      
      override public function set width(param1:Number) : void {
         var _loc3_:GraphicElement = null;
         if(param1 < 1)
         {
            this.__width = 1;
         }
         else
         {
            this.__width = param1;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__widthReal = this.__width;
         var _loc2_:UiRootContainer = this.getUi();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getElementById(name);
            if((_loc3_) && (_loc2_.ready))
            {
               _loc3_.size.setX(param1,_loc3_.size.xUnit);
            }
            _loc2_.updateLinkedUi();
         }
      }
      
      override public function set height(param1:Number) : void {
         var _loc3_:GraphicElement = null;
         if(param1 < 1)
         {
            this.__height = 1;
         }
         else
         {
            this.__height = param1;
         }
         if(this._bgColor != -1)
         {
            this.bgColor = this._bgColor;
         }
         this.__heightReal = this.__height;
         var _loc2_:UiRootContainer = this.getUi();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getElementById(name);
            if((_loc3_) && (_loc2_.ready))
            {
               _loc3_.size.setY(param1,_loc3_.size.yUnit);
            }
            _loc2_.updateLinkedUi();
         }
      }
      
      override public function get width() : Number {
         if((isNaN(this.__width)) || !this.__width)
         {
            return this.getBounds(this).width * scaleX;
         }
         return this.__width * scaleX;
      }
      
      override public function get height() : Number {
         if((isNaN(this.__height)) || !this.__height)
         {
            return this.getBounds(this).height * scaleY;
         }
         return this.__height * scaleY;
      }
      
      public function get contentWidth() : Number {
         return super.width;
      }
      
      public function get contentHeight() : Number {
         return super.height;
      }
      
      override public function set x(param1:Number) : void {
         var _loc3_:GraphicElement = null;
         super.x = param1;
         var _loc2_:UiRootContainer = this.getUi();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getElementById(name);
            if((_loc3_) && (_loc2_.ready))
            {
               _loc3_.location.setOffsetX(param1);
            }
            _loc2_.updateLinkedUi();
         }
      }
      
      override public function set y(param1:Number) : void {
         var _loc3_:GraphicElement = null;
         super.y = param1;
         var _loc2_:UiRootContainer = this.getUi();
         if(_loc2_)
         {
            _loc3_ = _loc2_.getElementById(name);
            if((_loc3_) && (_loc2_.ready))
            {
               _loc3_.location.setOffsetY(param1);
            }
            _loc2_.updateLinkedUi();
         }
      }
      
      public function get anchorY() : Number {
         var _loc2_:GraphicElement = null;
         var _loc1_:UiRootContainer = this.getUi();
         if(_loc1_)
         {
            _loc2_ = _loc1_.getElementById(name);
            if((_loc2_) && (_loc1_.ready))
            {
               return _loc2_.location.getOffsetY();
            }
         }
         return NaN;
      }
      
      public function get anchorX() : Number {
         var _loc2_:GraphicElement = null;
         var _loc1_:UiRootContainer = this.getUi();
         if(_loc1_)
         {
            _loc2_ = _loc1_.getElementById(name);
            if((_loc2_) && (_loc1_.ready))
            {
               return _loc2_.location.getOffsetX();
            }
         }
         return NaN;
      }
      
      public function set bgColor(param1:int) : void {
         this._bgColor = param1;
         graphics.clear();
         if(this.bgColor == -1 || !this.width || !this.height)
         {
            return;
         }
         if(this._borderColor != -1)
         {
            graphics.lineStyle(1,this._borderColor);
         }
         graphics.beginFill(param1,this._bgAlpha);
         if(!this._bgCornerRadius)
         {
            graphics.drawRect(0,0,this.width,this.height);
         }
         else
         {
            graphics.drawRoundRect(0,0,this.width,this.height,this._bgCornerRadius,this._bgCornerRadius);
         }
         graphics.endFill();
      }
      
      public function get bgColor() : int {
         return this._bgColor;
      }
      
      public function set bgAlpha(param1:Number) : void {
         this._bgAlpha = param1;
         this.bgColor = this.bgColor;
      }
      
      public function get bgAlpha() : Number {
         return this._bgAlpha;
      }
      
      public function set borderColor(param1:int) : void {
         this._borderColor = param1;
         this.bgColor = this.bgColor;
      }
      
      public function get borderColor() : int {
         return this._borderColor;
      }
      
      public function set bgCornerRadius(param1:uint) : void {
         this._bgCornerRadius = param1;
         this.bgColor = this.bgColor;
      }
      
      public function get bgCornerRadius() : uint {
         return this._bgCornerRadius;
      }
      
      public function set luminosity(param1:Number) : void {
         this._luminosity = param1;
      }
      
      public function get luminosity() : Number {
         return this._luminosity;
      }
      
      public function set linkedTo(param1:String) : void {
         this._sLinkedTo = param1;
      }
      
      public function get linkedTo() : String {
         return this._sLinkedTo;
      }
      
      public function set shadowColor(param1:int) : void {
         if(Berilia.getInstance().options.uiShadows)
         {
            if(param1 >= 0)
            {
               this._shadow = new DropShadowFilter(3,90,param1,1,10,10,0.61,BitmapFilterQuality.HIGH);
               filters = [this._shadow];
            }
            else
            {
               if(param1 == -1 && (this._shadow))
               {
                  this._shadow = null;
                  filters = [];
               }
            }
         }
      }
      
      public function get shadowColor() : int {
         return this._shadow?this._shadow.color:-1;
      }
      
      public function get topParent() : DisplayObject {
         return this.getTopParent(this);
      }
      
      public function setAdvancedGlow(param1:uint, param2:Number=1, param3:Number=6.0, param4:Number=6.0, param5:Number=2) : void {
      }
      
      public function clearFilters() : void {
         filters = [];
      }
      
      public function getStrata(param1:uint) : Sprite {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._aStrata[param1] != null)
         {
            return this._aStrata[param1];
         }
         this._aStrata[param1] = new Sprite();
         this._aStrata[param1].name = "strata_" + param1;
         this._aStrata[param1].mouseEnabled = false;
         this._aStrata[param1].doubleClickEnabled = true;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this._aStrata.length)
         {
            if(this._aStrata[_loc3_] != null)
            {
               addChildAt(this._aStrata[_loc3_],_loc2_++);
            }
            _loc3_++;
         }
         return this._aStrata[param1];
      }
      
      public function set dynamicPosition(param1:Boolean) : void {
         this._bDynamicPosition = param1;
      }
      
      public function get dynamicPosition() : Boolean {
         return this._bDynamicPosition;
      }
      
      public function set disabled(param1:Boolean) : void {
         if(param1)
         {
            transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
            this.handCursor = false;
            this.mouseEnabled = false;
            mouseChildren = false;
         }
         else
         {
            if(!this.greyedOut)
            {
               transform.colorTransform = new ColorTransform(1,1,1,1);
            }
            this.handCursor = true;
            this.mouseEnabled = true;
            mouseChildren = true;
         }
         this._bDisabled = param1;
      }
      
      public function get disabled() : Boolean {
         return this._bDisabled;
      }
      
      public function set softDisabled(param1:Boolean) : void {
         if(this._bSoftDisabled != param1)
         {
            if(param1)
            {
               transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
            }
            else
            {
               transform.colorTransform = new ColorTransform(1,1,1,1);
            }
         }
         this._bSoftDisabled = param1;
      }
      
      public function get softDisabled() : Boolean {
         return this._bSoftDisabled;
      }
      
      public function set greyedOut(param1:Boolean) : void {
         if(this._bGreyedOut != param1)
         {
            if(param1)
            {
               transform.colorTransform = new ColorTransform(0.6,0.6,0.6,1);
            }
            else
            {
               if(!this.disabled)
               {
                  transform.colorTransform = new ColorTransform(1,1,1,1);
               }
            }
         }
         this._bGreyedOut = param1;
      }
      
      public function get greyedOut() : Boolean {
         return this._bGreyedOut;
      }
      
      public function get depths() : Array {
         var _loc1_:Array = new Array();
         var _loc2_:GraphicContainer = this;
         while(_loc2_.getParent() != null)
         {
            _loc1_.unshift(_loc2_.getParent());
            _loc2_ = _loc2_.getParent();
         }
         return _loc1_;
      }
      
      public function set handCursor(param1:Boolean) : void {
         this.buttonMode = param1;
         this.mouseChildren = !param1;
      }
      
      override public function set mouseEnabled(param1:Boolean) : void {
         var _loc2_:DisplayObjectContainer = null;
         super.mouseEnabled = param1;
         for each (_loc2_ in this._aStrata)
         {
            _loc2_.mouseEnabled = param1;
         }
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:UiRootContainer = null;
         var _loc3_:MouseClickMessage = null;
         if(!this.canProcessMessage(param1))
         {
            return true;
         }
         if(param1 is MouseClickMessage && (this._sLinkedTo))
         {
            _loc2_ = this.getUi();
            if(_loc2_ != null)
            {
               _loc3_ = GenericPool.get(MouseClickMessage,_loc2_.getElement(this._sLinkedTo),MouseClickMessage(param1).mouseEvent);
               _loc2_.getElement(this._sLinkedTo).process(_loc3_);
            }
         }
         return false;
      }
      
      override public function stopDrag() : void {
         super.stopDrag();
         this.x = x;
         this.y = y;
      }
      
      public function getStageRect() : Rectangle {
         return this.getRect(stage);
      }
      
      public function remove() : void {
         var _loc1_:UiRootContainer = this.getUi();
         if(_loc1_)
         {
            _loc1_.deleteId(name);
         }
         this.destroy(this);
         SecureCenter.destroy(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         this.__removed = true;
      }
      
      public function addContent(param1:GraphicContainer, param2:int=-1) : GraphicContainer {
         if(param2 == -1)
         {
            this.getStrata(0).addChild(param1);
         }
         else
         {
            this.getStrata(0).addChildAt(param1,param2);
         }
         return param1;
      }
      
      public function removeFromParent() : void {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function getParent() : GraphicContainer {
         if(this.parent == null || this is UiRootContainer)
         {
            return null;
         }
         var _loc1_:DisplayObjectContainer = DisplayObjectContainer(this.parent);
         while(!(_loc1_ is GraphicContainer))
         {
            _loc1_ = DisplayObjectContainer(_loc1_.parent);
         }
         return GraphicContainer(_loc1_);
      }
      
      public function getUi() : UiRootContainer {
         if(this._uiRootContainer)
         {
            return this._uiRootContainer;
         }
         if(this.parent == null)
         {
            return null;
         }
         var _loc1_:Sprite = Sprite(this.parent);
         while(!(_loc1_ is UiRootContainer) && !(_loc1_ == null))
         {
            if(_loc1_ is GraphicContainer && (GraphicContainer(_loc1_)._uiRootContainer))
            {
               _loc1_ = GraphicContainer(_loc1_)._uiRootContainer;
            }
            else
            {
               if(_loc1_.parent is Sprite)
               {
                  _loc1_ = Sprite(_loc1_.parent);
               }
               else
               {
                  _loc1_ = null;
               }
            }
         }
         if(_loc1_ == null)
         {
            return null;
         }
         this._uiRootContainer = UiRootContainer(_loc1_);
         return UiRootContainer(_loc1_);
      }
      
      public function setUi(param1:UiRootContainer, param2:Object) : void {
         if(param2 != SecureCenter.ACCESS_KEY)
         {
            throw new SecurityError();
         }
         else
         {
            this._uiRootContainer = param1;
            return;
         }
      }
      
      public function getTopParent(param1:DisplayObject) : DisplayObject {
         if(param1.parent != null)
         {
            return this.getTopParent(param1.parent);
         }
         return param1;
      }
      
      public function startResize() : void {
         this._nMouseX = StageShareManager.mouseX;
         this._nMouseY = StageShareManager.mouseY;
         this._nStartWidth = this.width;
         this._nStartHeight = this.height;
         if(this._bUseSimpleResize)
         {
            this._shResizeBorder = new Shape();
            addChild(this._shResizeBorder);
         }
         this.getUi().removeFromRenderList(name);
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,"GraphicContainer");
      }
      
      public function endResize() : void {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         if(this._bUseSimpleResize)
         {
            this.getUi().render();
            if(super.contains(this._shResizeBorder))
            {
               removeChild(this._shResizeBorder);
            }
         }
      }
      
      public function slide(param1:int, param2:int, param3:int) : void {
         TweenLite.to(this,param3 / 1000,
            {
               "x":param1,
               "y":param2,
               "ease":Strong.easeOut
            });
      }
      
      private function defaultDropValidatorFunction(param1:*, param2:*, param3:*) : Boolean {
         var _loc4_:DisplayObject = this;
         do
         {
               _loc4_ = _loc4_.parent;
            }while(!(_loc4_ is IDragAndDropHandler) && (_loc4_.parent));
            
            if(_loc4_ is IDragAndDropHandler)
            {
               return (_loc4_ as IDragAndDropHandler).dropValidator(param1,param2,param3);
            }
            return false;
         }
         
         private function defaultProcessDropFunction(param1:*, param2:*, param3:*) : void {
            var _loc4_:DisplayObject = this;
            do
            {
                  _loc4_ = _loc4_.parent;
               }while(!(_loc4_ is IDragAndDropHandler) && (_loc4_.parent));
               
               if(_loc4_ is IDragAndDropHandler)
               {
                  (_loc4_ as IDragAndDropHandler).processDrop(param1,param2,param3);
               }
            }
            
            private function defaultRemoveDropSourceFunction(param1:*) : void {
               var _loc2_:DisplayObject = this;
               do
               {
                     _loc2_ = _loc2_.parent;
                  }while(!(_loc2_ is IDragAndDropHandler) && (_loc2_.parent));
                  
                  if(_loc2_ is IDragAndDropHandler)
                  {
                     (_loc2_ as IDragAndDropHandler).removeDropSource(param1);
                  }
               }
               
               override public function localToGlobal(param1:Point) : Point {
                  var _loc2_:DisplayObject = this;
                  var _loc3_:Point = param1;
                  while((_loc2_) && (_loc2_.parent))
                  {
                     _loc3_.x = _loc3_.x + _loc2_.parent.x;
                     _loc3_.y = _loc3_.y + _loc2_.parent.y;
                     _loc2_ = _loc2_.parent;
                  }
                  return _loc3_;
               }
               
               protected function destroy(param1:DisplayObjectContainer) : void {
                  var _loc2_:DisplayObject = null;
                  if(!param1 || param1 is MovieClip && MovieClip(param1).totalFrames > 1)
                  {
                     return;
                  }
                  var _loc3_:uint = 0;
                  var _loc4_:int = param1.numChildren;
                  while(param1.numChildren)
                  {
                     _loc2_ = param1.removeChildAt(0);
                     if(_loc2_ is TiphonSprite)
                     {
                        (_loc2_ as TiphonSprite).destroy();
                     }
                     else
                     {
                        if(_loc2_ is GraphicContainer)
                        {
                           (_loc2_ as GraphicContainer).remove();
                        }
                        if(_loc2_ is DisplayObjectContainer)
                        {
                           this.destroy(_loc2_ as DisplayObjectContainer);
                        }
                     }
                  }
               }
               
               public function free() : void {
                  this.__width = 0;
                  this.__widthReal = 0;
                  this.__height = 0;
                  this.__heightReal = 0;
                  this.__removed = false;
                  this._bgColor = -1;
                  this._bgAlpha = 1;
                  this.minSize = null;
                  this.maxSize = null;
                  this._scale = 1;
                  this._sLinkedTo = null;
                  this._bDisabled = false;
                  this._shadow = null;
                  this._luminosity = 1;
                  this._bgCornerRadius = 0;
                  this._nMouseX = 0;
                  this._nMouseY = 0;
                  this._nStartWidth = 0;
                  this._nStartHeight = 0;
                  this._nLastWidth = 0;
                  this._nLastHeight = 0;
                  this._shResizeBorder = null;
                  this._bUseSimpleResize = false;
                  this._uiRootContainer = null;
               }
               
               override public function contains(param1:DisplayObject) : Boolean {
                  return super.contains(param1);
               }
               
               private function onEnterFrame(param1:Event) : void {
                  var _loc2_:int = this._nStartWidth + StageShareManager.mouseX - this._nMouseX;
                  var _loc3_:int = this._nStartHeight + StageShareManager.mouseY - this._nMouseY;
                  if(this.minSize != null)
                  {
                     if(!isNaN(this.minSize.x) && _loc2_ < this.minSize.x)
                     {
                        _loc2_ = this.minSize.x;
                     }
                     if(!isNaN(this.minSize.y) && _loc3_ < this.minSize.y)
                     {
                        _loc3_ = this.minSize.y;
                     }
                  }
                  if(this.maxSize != null)
                  {
                     if(!isNaN(this.maxSize.x) && _loc2_ > this.maxSize.x)
                     {
                        _loc2_ = this.maxSize.x;
                     }
                     if(!isNaN(this.maxSize.y) && _loc3_ > this.maxSize.y)
                     {
                        _loc3_ = this.maxSize.y;
                     }
                  }
                  this.width = _loc2_;
                  this.height = _loc3_;
                  if(!(this._nLastWidth == this.width) || !(this._nLastHeight == this.height))
                  {
                     if(this._bUseSimpleResize)
                     {
                        this._shResizeBorder.graphics.clear();
                        this._shResizeBorder.graphics.beginFill(16777215,0.05);
                        this._shResizeBorder.graphics.lineStyle(1,0,0.2);
                        this._shResizeBorder.graphics.drawRect(0,0,this.width,this.height);
                        this._shResizeBorder.graphics.endFill();
                     }
                     else
                     {
                        try
                        {
                           this.getUi().render();
                        }
                        catch(err:Error)
                        {
                        }
                     }
                     this._nLastWidth = this.width;
                     this._nLastHeight = this.height;
                  }
               }
               
               protected function canProcessMessage(param1:Message) : Boolean {
                  if(this._bSoftDisabled)
                  {
                     if(!(param1 is ItemRollOutMessage || param1 is ItemRollOverMessage || param1 is MouseOverMessage || param1 is MouseOutMessage))
                     {
                        return false;
                     }
                  }
                  return true;
               }
            }
         }
