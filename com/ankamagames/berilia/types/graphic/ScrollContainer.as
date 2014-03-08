package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import flash.display.Shape;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.components.ScrollBar;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import flash.display.Sprite;
   
   public class ScrollContainer extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function ScrollContainer() {
         this.d = new Shape();
         super();
         mouseEnabled = true;
         this._mask = new Shape();
         this._mask.graphics.beginFill(16776960);
         this._mask.graphics.drawRect(0,0,1,1);
         this._content = new Sprite();
         this._content.mask = this._mask;
         super.addChild(this._content);
         super.addChild(this._mask);
      }
      
      private var _finalized:Boolean = false;
      
      private var _mask:Shape;
      
      private var _content:DisplayObjectContainer;
      
      private var d:Shape;
      
      private var _hScrollbar:ScrollBar;
      
      private var _vScrollbar:ScrollBar;
      
      private var _hScrollbarSpeed:Number = 1;
      
      private var _vScrollbarSpeed:Number = 1;
      
      private var _useHorizontalScroll:Boolean = true;
      
      private var _scrollBarCss:Uri;
      
      private var _scrollBarSize:uint = 16;
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      override public function set width(param1:Number) : void {
         super.width = param1;
         this._mask.width = param1;
      }
      
      override public function set height(param1:Number) : void {
         super.height = param1;
         this._mask.height = param1;
      }
      
      public function set scrollbarCss(param1:Uri) : void {
         this._scrollBarCss = param1;
      }
      
      public function get verticalScrollSpeed() : Number {
         if(this._vScrollbar)
         {
            return this._vScrollbar.scrollSpeed;
         }
         return this._vScrollbarSpeed;
      }
      
      public function set verticalScrollSpeed(param1:Number) : void {
         if(this._vScrollbar)
         {
            this._vScrollbar.scrollSpeed = param1;
         }
         this._vScrollbarSpeed = param1;
      }
      
      public function set verticalScrollbarValue(param1:int) : void {
         if(this._vScrollbar)
         {
            this._vScrollbar.value = param1;
            this.onVerticalScroll(null);
         }
      }
      
      public function get verticalScrollbarValue() : int {
         if(this._vScrollbar)
         {
            return this._vScrollbar.value;
         }
         return -1;
      }
      
      public function get useHorizontalScroll() : Boolean {
         return this._useHorizontalScroll;
      }
      
      public function set useHorizontalScroll(param1:Boolean) : void {
         this._useHorizontalScroll = param1;
      }
      
      public function get horizontalScrollSpeed() : Number {
         if(this._hScrollbar)
         {
            return this._hScrollbar.scrollSpeed;
         }
         return this._hScrollbarSpeed;
      }
      
      public function set horizontalScrollSpeed(param1:Number) : void {
         if(this._hScrollbar)
         {
            this._hScrollbar.scrollSpeed = param1;
         }
         this._hScrollbarSpeed = param1;
      }
      
      public function set horizontalScrollbarValue(param1:int) : void {
         if(this._hScrollbar)
         {
            this._hScrollbar.value = param1;
            this.onHorizontalScroll(null);
         }
      }
      
      public function get horizontalScrollbarValue() : int {
         if(this._hScrollbar)
         {
            return this._hScrollbar.value;
         }
         return -1;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject {
         param1.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(param1);
         this.finalize();
         param1.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return param1;
      }
      
      override public function addContent(param1:GraphicContainer, param2:int=-1) : GraphicContainer {
         param1.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(param1);
         this.finalize();
         param1.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return param1;
      }
      
      public function finalize() : void {
         var _loc1_:Boolean = width < Math.floor(this._content.width) && (this._useHorizontalScroll);
         var _loc2_:* = height < Math.floor(this._content.height);
         this._mask.height = height;
         this._mask.width = width;
         this._content.x = 0;
         this._content.y = 0;
         if(_loc1_)
         {
            if(!this._hScrollbar)
            {
               this._hScrollbar = new ScrollBar();
               this._hScrollbar.vertical = false;
               this._hScrollbar.addEventListener(Event.CHANGE,this.onHorizontalScroll);
               this._hScrollbar.css = this._scrollBarCss;
               this._hScrollbar.min = 0;
               this._hScrollbar.height = this._scrollBarSize;
               this._hScrollbar.y = height - this._hScrollbar.height;
               this._hScrollbar.step = 1;
               this._hScrollbar.scrollSpeed = this._hScrollbarSpeed;
               super.addChild(this._hScrollbar);
               this._hScrollbar.finalize();
            }
            else
            {
               super.addChild(this._hScrollbar);
            }
            this._mask.height = height - this._scrollBarSize;
            this._hScrollbar.width = width - (_loc2_?this._scrollBarSize:0);
            this._hScrollbar.max = this._content.width - width + (_loc2_?this._scrollBarSize:0);
         }
         else
         {
            if((this._hScrollbar) && (contains(this._hScrollbar)))
            {
               removeChild(this._hScrollbar);
            }
         }
         if(_loc2_)
         {
            if(!this._vScrollbar)
            {
               this._vScrollbar = new ScrollBar();
               this._vScrollbar.addEventListener(Event.CHANGE,this.onVerticalScroll);
               this._vScrollbar.css = this._scrollBarCss;
               this._vScrollbar.min = 0;
               this._vScrollbar.width = this._scrollBarSize;
               this._vScrollbar.x = width - this._vScrollbar.width;
               this._vScrollbar.vertical = false;
               this._vScrollbar.step = 1;
               this._vScrollbar.scrollSpeed = this._vScrollbarSpeed;
               super.addChild(this._vScrollbar);
               this._vScrollbar.finalize();
            }
            else
            {
               super.addChild(this._vScrollbar);
            }
            this._mask.width = width - this._scrollBarSize;
            this._vScrollbar.height = height - (_loc1_?this._scrollBarSize:0);
            this._vScrollbar.max = this._content.height - height + (_loc2_?this._scrollBarSize:0);
         }
         else
         {
            if((this._vScrollbar) && (contains(this._vScrollbar)))
            {
               removeChild(this._vScrollbar);
            }
         }
         this._finalized = true;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0,0);
         _loc3_.graphics.drawRect(0,0,__width,__height);
         super.addChild(_loc3_);
         getUi().iAmFinalized(this);
      }
      
      override public function process(param1:Message) : Boolean {
         switch(true)
         {
            case param1 is MouseWheelMessage:
               if((this._vScrollbar) && !(this._vScrollbar.parent == null))
               {
                  this._vScrollbar.onWheel(MouseWheelMessage(param1).mouseEvent);
               }
               else
               {
                  if((this._hScrollbar) && !(this._hScrollbar.parent == null))
                  {
                     this._hScrollbar.onWheel(MouseWheelMessage(param1).mouseEvent);
                  }
               }
               return true;
            default:
               return false;
         }
      }
      
      override public function getStrata(param1:uint) : Sprite {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_aStrata[param1] != null)
         {
            return _aStrata[param1];
         }
         _aStrata[param1] = new Sprite();
         _aStrata[param1].name = "strata_" + param1;
         _aStrata[param1].mouseEnabled = mouseEnabled;
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ < _aStrata.length)
         {
            if(_aStrata[_loc3_] != null)
            {
               this._content.addChildAt(_aStrata[_loc3_],_loc2_++);
            }
            _loc3_++;
         }
         return _aStrata[param1];
      }
      
      private function onVerticalScroll(param1:Event) : void {
         this._content.y = -this._vScrollbar.value;
      }
      
      private function onHorizontalScroll(param1:Event) : void {
         this._content.x = -this._hScrollbar.value;
      }
      
      private function onChildFinalized(param1:Event) : void {
         param1.target.removeEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         this.finalize();
      }
      
      private function onChildRemoved(param1:Event) : void {
      }
   }
}
