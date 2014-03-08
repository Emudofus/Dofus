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
      
      public function set finalized(b:Boolean) : void {
         this._finalized = b;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      override public function set width(n:Number) : void {
         super.width = n;
         this._mask.width = n;
      }
      
      override public function set height(n:Number) : void {
         super.height = n;
         this._mask.height = n;
      }
      
      public function set scrollbarCss(sValue:Uri) : void {
         this._scrollBarCss = sValue;
      }
      
      public function get verticalScrollSpeed() : Number {
         if(this._vScrollbar)
         {
            return this._vScrollbar.scrollSpeed;
         }
         return this._vScrollbarSpeed;
      }
      
      public function set verticalScrollSpeed(speed:Number) : void {
         if(this._vScrollbar)
         {
            this._vScrollbar.scrollSpeed = speed;
         }
         this._vScrollbarSpeed = speed;
      }
      
      public function set verticalScrollbarValue(value:int) : void {
         if(this._vScrollbar)
         {
            this._vScrollbar.value = value;
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
      
      public function set useHorizontalScroll(yes:Boolean) : void {
         this._useHorizontalScroll = yes;
      }
      
      public function get horizontalScrollSpeed() : Number {
         if(this._hScrollbar)
         {
            return this._hScrollbar.scrollSpeed;
         }
         return this._hScrollbarSpeed;
      }
      
      public function set horizontalScrollSpeed(speed:Number) : void {
         if(this._hScrollbar)
         {
            this._hScrollbar.scrollSpeed = speed;
         }
         this._hScrollbarSpeed = speed;
      }
      
      public function set horizontalScrollbarValue(value:int) : void {
         if(this._hScrollbar)
         {
            this._hScrollbar.value = value;
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
      
      override public function addChild(child:DisplayObject) : DisplayObject {
         child.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(child);
         this.finalize();
         child.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return child;
      }
      
      override public function addContent(child:GraphicContainer, index:int=-1) : GraphicContainer {
         child.addEventListener(Event.REMOVED,this.onChildRemoved);
         this.getStrata(0).addChild(child);
         this.finalize();
         child.addEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         return child;
      }
      
      public function finalize() : void {
         var hScroll:Boolean = (width < Math.floor(this._content.width)) && (this._useHorizontalScroll);
         var vScroll:Boolean = height < Math.floor(this._content.height);
         this._mask.height = height;
         this._mask.width = width;
         this._content.x = 0;
         this._content.y = 0;
         if(hScroll)
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
            this._hScrollbar.width = width - (vScroll?this._scrollBarSize:0);
            this._hScrollbar.max = this._content.width - width + (vScroll?this._scrollBarSize:0);
         }
         else
         {
            if((this._hScrollbar) && (contains(this._hScrollbar)))
            {
               removeChild(this._hScrollbar);
            }
         }
         if(vScroll)
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
            this._vScrollbar.height = height - (hScroll?this._scrollBarSize:0);
            this._vScrollbar.max = this._content.height - height + (vScroll?this._scrollBarSize:0);
         }
         else
         {
            if((this._vScrollbar) && (contains(this._vScrollbar)))
            {
               removeChild(this._vScrollbar);
            }
         }
         this._finalized = true;
         var mouseEventCatcher:Shape = new Shape();
         mouseEventCatcher.graphics.beginFill(0,0);
         mouseEventCatcher.graphics.drawRect(0,0,__width,__height);
         super.addChild(mouseEventCatcher);
         getUi().iAmFinalized(this);
      }
      
      override public function process(msg:Message) : Boolean {
         switch(true)
         {
            case msg is MouseWheelMessage:
               if((this._vScrollbar) && (!(this._vScrollbar.parent == null)))
               {
                  this._vScrollbar.onWheel(MouseWheelMessage(msg).mouseEvent);
               }
               else
               {
                  if((this._hScrollbar) && (!(this._hScrollbar.parent == null)))
                  {
                     this._hScrollbar.onWheel(MouseWheelMessage(msg).mouseEvent);
                  }
               }
               return true;
         }
      }
      
      override public function getStrata(nStrata:uint) : Sprite {
         var nIndex:uint = 0;
         var i:uint = 0;
         if(_aStrata[nStrata] != null)
         {
            return _aStrata[nStrata];
         }
         _aStrata[nStrata] = new Sprite();
         _aStrata[nStrata].name = "strata_" + nStrata;
         _aStrata[nStrata].mouseEnabled = mouseEnabled;
         nIndex = 0;
         i = 0;
         while(i < _aStrata.length)
         {
            if(_aStrata[i] != null)
            {
               this._content.addChildAt(_aStrata[i],nIndex++);
            }
            i++;
         }
         return _aStrata[nStrata];
      }
      
      private function onVerticalScroll(e:Event) : void {
         this._content.y = -this._vScrollbar.value;
      }
      
      private function onHorizontalScroll(e:Event) : void {
         this._content.x = -this._hScrollbar.value;
      }
      
      private function onChildFinalized(e:Event) : void {
         e.target.removeEventListener(UiRenderEvent.UIRenderComplete,this.onChildFinalized);
         this.finalize();
      }
      
      private function onChildRemoved(e:Event) : void {
      }
   }
}
