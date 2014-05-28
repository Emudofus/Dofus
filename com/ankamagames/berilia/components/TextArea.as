package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   
   public class TextArea extends Label implements FinalizableUIComponent
   {
      
      public function TextArea() {
         super();
         this._sbScrollBar = new ScrollBar();
         this._sbScrollBar.min = 1;
         this._sbScrollBar.max = 1;
         this._sbScrollBar.step = 1;
         this._sbScrollBar.scrollSpeed = 1 / 6;
         this._sbScrollBar.addEventListener(Event.CHANGE,this.onScroll);
         _tText.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTextWheel);
         addChild(this._sbScrollBar);
         _tText.wordWrap = true;
         _tText.multiline = true;
         _tText.mouseEnabled = true;
         _tText.mouseWheelEnabled = false;
      }
      
      protected static const _log:Logger;
      
      private var _sbScrollBar:ScrollBar;
      
      private var _bFinalized:Boolean;
      
      private var _nScrollPos:int = 5;
      
      private var _bHideScroll:Boolean = false;
      
      private var _scrollTopMargin:int = 0;
      
      private var _scrollBottomMargin:int = 0;
      
      protected var ___width:uint;
      
      public function get scrollBottomMargin() : int {
         return this._scrollBottomMargin;
      }
      
      public function set scrollBottomMargin(value:int) : void {
         this._scrollBottomMargin = value;
         this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function get scrollTopMargin() : int {
         return this._scrollTopMargin;
      }
      
      public function set scrollTopMargin(value:int) : void {
         this._scrollTopMargin = value;
         this._sbScrollBar.y = this._scrollTopMargin;
         this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function set scrollCss(sUrl:Uri) : void {
         this._sbScrollBar.css = sUrl;
      }
      
      public function get scrollCss() : Uri {
         return this._sbScrollBar.css;
      }
      
      override public function set width(nW:Number) : void {
         this.___width = nW;
         super.width = nW;
         this.updateScrollBarPos();
      }
      
      override public function get width() : Number {
         return this.___width;
      }
      
      override public function set height(nH:Number) : void {
         if((!(nH == super.height)) || (!(nH == this._sbScrollBar.height - this._scrollTopMargin - this._scrollBottomMargin)))
         {
            super.height = nH;
            this._sbScrollBar.height = nH - this._scrollTopMargin - this._scrollBottomMargin;
            if(this._bFinalized)
            {
               this.updateScrollBar();
            }
         }
      }
      
      override public function set text(sValue:String) : void {
         super.text = sValue;
         if(this._bFinalized)
         {
            this.updateScrollBar(true);
         }
      }
      
      public function set scrollPos(nValue:int) : void {
         this._nScrollPos = nValue;
      }
      
      override public function set css(sValue:Uri) : void {
         super.css = sValue;
      }
      
      override public function set scrollV(nVal:int) : void {
         super.scrollV = nVal;
         if(this._bFinalized)
         {
            this.updateScrollBar();
         }
      }
      
      override public function get scrollV() : int {
         return super.scrollV;
      }
      
      override public function get finalized() : Boolean {
         return (this._bFinalized) && (super.finalized);
      }
      
      override public function set finalized(b:Boolean) : void {
         this._bFinalized = b;
      }
      
      public function get hideScroll() : Boolean {
         return this._bHideScroll;
      }
      
      public function set hideScroll(hideScroll:Boolean) : void {
         this._bHideScroll = hideScroll;
      }
      
      override public function appendText(sTxt:String, style:String = null) : void {
         super.appendText(sTxt,style);
         if(this._bFinalized)
         {
            this.updateScrollBar();
         }
      }
      
      override public function finalize() : void {
         this._sbScrollBar.finalize();
         this.updateScrollBarPos();
         this.updateScrollBar();
         this._bFinalized = true;
         super.finalize();
      }
      
      override public function free() : void {
         super.free();
         this._bFinalized = false;
         this._nScrollPos = 5;
         this.___width = 0;
         this._sbScrollBar.min = 1;
         this._sbScrollBar.max = 1;
         this._sbScrollBar.step = 1;
         _tText.wordWrap = true;
         _tText.multiline = true;
      }
      
      override public function remove() : void {
         if(this._sbScrollBar)
         {
            this._sbScrollBar.removeEventListener(Event.CHANGE,this.onScroll);
            this._sbScrollBar.remove();
         }
         this._sbScrollBar = null;
         _tText.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onTextWheel);
         super.remove();
      }
      
      override public function process(msg:Message) : Boolean {
         if((msg is MouseWheelMessage) && (this._sbScrollBar) && (this._sbScrollBar.visible))
         {
            return true;
         }
         return super.process(msg);
      }
      
      private function updateScrollBar(reset:Boolean = false) : void {
         if(_tText.numLines * _tText.getLineMetrics(0).height < height)
         {
            _tText.scrollV = 0;
            this._sbScrollBar.disabled = true;
            if(this._bHideScroll)
            {
               this._sbScrollBar.visible = false;
            }
         }
         else
         {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            this._sbScrollBar.total = _tText.numLines;
            this._sbScrollBar.max = _tText.maxScrollV;
            if(reset)
            {
               _tText.scrollV = 0;
               this._sbScrollBar.value = 0;
            }
            else
            {
               this._sbScrollBar.value = _tText.scrollV;
            }
         }
      }
      
      private function updateScrollBarPos() : void {
         if(this._nScrollPos >= 0)
         {
            this._sbScrollBar.x = this.width - this._sbScrollBar.width;
            _tText.width = this.width - this._sbScrollBar.width - this._nScrollPos;
            _tText.x = 0;
         }
         else
         {
            this._sbScrollBar.x = 0;
            _tText.width = this.width - this._sbScrollBar.width + this._nScrollPos;
            _tText.x = this._sbScrollBar.width - this._nScrollPos;
         }
      }
      
      override protected function updateAlign() : void {
         if(this._sbScrollBar.disabled)
         {
            super.updateAlign();
         }
      }
      
      private function onTextWheel(e:MouseEvent) : void {
         e.delta = e.delta * 3;
         this._sbScrollBar.onWheel(e);
      }
      
      private function onScroll(e:Event) : void {
         _tText.scrollV = this._sbScrollBar.value / this._sbScrollBar.max * _tText.maxScrollV;
      }
   }
}
