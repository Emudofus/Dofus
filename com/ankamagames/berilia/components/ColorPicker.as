package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.GradientType;
   import flash.events.Event;
   import com.ankamagames.jerakine.utils.display.ColorUtils;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.ColorChangeMessage;
   import flash.display.InteractiveObject;
   import com.ankamagames.jerakine.messages.Message;
   import flash.geom.Rectangle;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   
   public class ColorPicker extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function ColorPicker() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ColorPicker));
      
      private var _nWidth:uint;
      
      private var _nHeight:uint;
      
      private var _nColor:uint = 16711680;
      
      private var _nGradientColor:uint = 16711680;
      
      private var _texCursorSlider:Texture;
      
      private var _texCursorGradient:Texture;
      
      private var _nSliderWidth:uint = 20;
      
      private var _nSeparationWidth:uint = 10;
      
      private var _nGradientWidth:uint;
      
      private var _sprGradient:Sprite;
      
      private var _sprSliderInf:Sprite;
      
      private var _sprSliderSup:Sprite;
      
      private var _nLoadedSum:uint = 0;
      
      private var _bMouseDown:Boolean = false;
      
      private var _bFixedColor:Boolean = false;
      
      private var _nSliderY:int;
      
      private var _nGradientX:int;
      
      private var _nGradientY:int;
      
      private var _mMatrixGradient:Matrix;
      
      private var _mMatrixSaturation:Matrix;
      
      private var _mMatrixSlider:Matrix;
      
      private var _aColorsHue:Array;
      
      private var _aAlphasHue:Array;
      
      private var _aRatiosHue:Array;
      
      private var _aColorsSat:Array;
      
      private var _aAlphasSat:Array;
      
      private var _aRatiosSat:Array;
      
      private var _aColorsBri:Array;
      
      private var _aAlphasBri:Array;
      
      private var _aRatiosBri:Array;
      
      private var _bFinalized:Boolean = false;
      
      override public function set width(param1:Number) : void {
         this._nWidth = param1;
         if(this.finalized)
         {
            this.updatePicker();
         }
      }
      
      override public function set height(param1:Number) : void {
         this._nHeight = param1;
         this._nSliderY = int(this._nHeight / 2);
         if(this.finalized)
         {
            this.updatePicker();
         }
      }
      
      public function set sliderTexture(param1:Uri) : void {
         this._texCursorSlider = new Texture();
         this._texCursorSlider.x = 0;
         this._texCursorSlider.y = 0;
         this._texCursorSlider.width = 20;
         this._texCursorSlider.height = 16;
         this._texCursorSlider.uri = param1;
      }
      
      public function get sliderTexture() : Uri {
         return this._texCursorSlider.uri;
      }
      
      public function set gradientTexture(param1:Uri) : void {
         this._texCursorGradient = new Texture();
         this._texCursorGradient.x = 0;
         this._texCursorGradient.y = 0;
         this._texCursorGradient.width = 16;
         this._texCursorGradient.height = 16;
         this._texCursorGradient.uri = param1;
      }
      
      public function get gradientTexture() : Uri {
         return this._texCursorGradient.uri;
      }
      
      public function get color() : uint {
         return this._nColor;
      }
      
      public function set color(param1:uint) : void {
         this._nColor = param1;
         this._bFixedColor = true;
         this.getCurrentPos();
      }
      
      public function get finalized() : Boolean {
         return this._bFinalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._bFinalized = param1;
      }
      
      public function finalize() : void {
         this._sprGradient = new Sprite();
         this._sprSliderInf = new Sprite();
         this._sprSliderSup = new Sprite();
         this._nGradientWidth = this._nWidth - this._nSeparationWidth - this._nSliderWidth;
         this._mMatrixGradient = new Matrix();
         this._mMatrixGradient.createGradientBox(this._nGradientWidth,this._nHeight,0,0,0);
         this._aColorsHue = new Array(16711680,16776960,65280,65535,255,16711935,16711680);
         this._aAlphasHue = new Array(100,100,100,100,100,100,100);
         this._aRatiosHue = new Array(0,1 * 255 / 6,2 * 255 / 6,3 * 255 / 6,4 * 255 / 6,5 * 255 / 6,255);
         this._mMatrixSaturation = new Matrix();
         this._mMatrixSaturation.createGradientBox(this._nGradientWidth,this._nHeight,90 / 180 * Math.PI,0,0);
         this._aColorsSat = new Array(8421504,8421504);
         this._aAlphasSat = new Array(0,100);
         this._aRatiosSat = new Array(0,255);
         this._sprGradient.graphics.lineStyle();
         this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsHue,this._aAlphasHue,this._aRatiosHue,this._mMatrixGradient);
         this._sprGradient.graphics.drawRect(0,0,this._nGradientWidth,this._nHeight);
         this._sprGradient.graphics.endFill();
         this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsSat,this._aAlphasSat,this._aRatiosSat,this._mMatrixSaturation);
         this._sprGradient.graphics.drawRect(0,0,this._nGradientWidth,this._nHeight);
         this._sprGradient.graphics.endFill();
         addChild(this._sprGradient);
         this._sprSliderInf.x = this._nGradientWidth + this._nSeparationWidth;
         addChild(this._sprSliderInf);
         this._mMatrixSlider = new Matrix();
         this._mMatrixSlider.createGradientBox(this._nSliderWidth,this._nHeight,90 / 180 * Math.PI,0,0);
         this._aAlphasBri = new Array(1,0,0,1);
         this._aRatiosBri = new Array(0,127.5,127.5,255);
         this._aColorsBri = new Array(16777215,16777215,0,0);
         this._sprSliderSup.graphics.beginGradientFill(GradientType.LINEAR,this._aColorsBri,this._aAlphasBri,this._aRatiosBri,this._mMatrixSlider);
         this._sprSliderSup.graphics.drawRect(0,0,this._nSliderWidth,this._nHeight);
         this._sprSliderSup.graphics.endFill();
         this._sprSliderSup.x = this._nGradientWidth + this._nSeparationWidth;
         addChild(this._sprSliderSup);
         this._texCursorGradient.dispatchMessages = true;
         this._texCursorSlider.dispatchMessages = true;
         this._texCursorSlider.addEventListener(Event.COMPLETE,this.onTextureSliderLoaded);
         this._texCursorSlider.finalize();
         this._texCursorGradient.addEventListener(Event.COMPLETE,this.onTextureGradientLoaded);
         this._texCursorGradient.finalize();
         this._bFinalized = true;
         getUi().iAmFinalized(this);
      }
      
      public function updatePicker() : void {
         var _loc1_:Object = ColorUtils.rgb2hsl(this._nColor);
         this._texCursorGradient.x = _loc1_.h * this._nGradientWidth - this._texCursorGradient.width / 2;
         this._texCursorGradient.y = _loc1_.s * this._nHeight - this._texCursorGradient.height / 2;
         this._texCursorSlider.x = this._sprSliderSup.x;
         this._texCursorSlider.y = _loc1_.l * this._nHeight - this._texCursorSlider.height / 2;
         addChild(this._texCursorGradient);
         addChild(this._texCursorSlider);
         this.updateSlider();
         this._texCursorGradient.addEventListener(Event.CHANGE,this.onMoveGradientCursor);
         this._texCursorSlider.addEventListener(Event.CHANGE,this.onMoveSliderCursor);
      }
      
      override public function remove() : void {
         if(!__removed)
         {
            this._texCursorSlider.remove();
            this._texCursorGradient.remove();
            this._texCursorSlider = null;
            this._texCursorGradient = null;
         }
         super.remove();
      }
      
      public function getGradientColor() : uint {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         if(this._nGradientX >= this._nGradientWidth)
         {
            this._nGradientX = this._nGradientWidth-1;
         }
         _loc1_ = this._nGradientX / this._nGradientWidth;
         var _loc14_:Number = Math.floor(_loc1_ * (this._aRatiosHue.length-1));
         _loc1_ = _loc1_ * 255;
         _loc2_ = 255 - (this._aRatiosHue[_loc14_ + 1] - _loc1_) / (this._aRatiosHue[_loc14_ + 1] - this._aRatiosHue[_loc14_]) * 255;
         _loc9_ = this._aColorsHue[_loc14_];
         _loc10_ = this._aColorsHue[_loc14_ + 1];
         _loc3_ = _loc9_ & 16711680;
         _loc4_ = _loc9_ & 65280;
         _loc5_ = _loc9_ & 255;
         _loc6_ = _loc10_ & 16711680;
         _loc7_ = _loc10_ & 65280;
         _loc8_ = _loc10_ & 255;
         if(_loc3_ != _loc6_)
         {
            _loc11_ = Math.round(_loc3_ > _loc6_?255 - _loc2_:_loc2_);
         }
         else
         {
            _loc11_ = _loc3_ >> 16;
         }
         if(_loc4_ != _loc7_)
         {
            _loc12_ = Math.round(_loc4_ > _loc7_?255 - _loc2_:_loc2_);
         }
         else
         {
            _loc12_ = _loc4_ >> 8;
         }
         if(_loc5_ != _loc8_)
         {
            _loc13_ = Math.round(_loc5_ > _loc8_?255 - _loc2_:_loc2_);
         }
         else
         {
            _loc13_ = _loc5_;
         }
         _loc1_ = this._nGradientY / this._nHeight * 255;
         _loc11_ = _loc11_ + (127 - _loc11_) * _loc1_ / 255;
         _loc12_ = _loc12_ + (127 - _loc12_) * _loc1_ / 255;
         _loc13_ = _loc13_ + (127 - _loc13_) * _loc1_ / 255;
         this._nGradientColor = Math.round((_loc11_ << 16) + (_loc12_ << 8) + _loc13_);
         return this._nGradientColor;
      }
      
      public function updateSlider() : void {
         var _loc1_:uint = this.getGradientColor();
         this._sprSliderInf.graphics.beginFill(_loc1_);
         this._sprSliderInf.graphics.drawRect(0,0,this._nSliderWidth,this._nHeight);
         this._sprSliderInf.graphics.endFill();
      }
      
      private function getCurrentPos() : void {
         var _loc1_:Object = ColorUtils.rgb2hsl(this._nColor);
         this._texCursorGradient.x = _loc1_.h * this._nGradientWidth - this._texCursorGradient.width / 2;
         this._texCursorGradient.y = _loc1_.s * this._nHeight - this._texCursorGradient.height / 2;
         this._texCursorSlider.y = _loc1_.l * this._nHeight - this._texCursorSlider.height / 2;
         this._nGradientX = this._texCursorGradient.x + this._texCursorGradient.width / 2;
         this._nGradientY = this._texCursorGradient.y + this._texCursorGradient.height / 2;
         this._nSliderY = this._texCursorSlider.y + this._texCursorSlider.height / 2;
         this.updateSlider();
         this.getCurrentColor();
      }
      
      private function getCurrentColor() : uint {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         if(!this._bFixedColor)
         {
            this.getGradientColor();
            _loc1_ = 255 - this._nSliderY / this._nHeight * 510;
            _loc2_ = (this._nGradientColor & 16711680) >> 16;
            _loc3_ = (this._nGradientColor & 65280) >> 8;
            _loc4_ = this._nGradientColor & 255;
            if(_loc1_ >= 0)
            {
               _loc5_ = _loc1_ * (255 - _loc2_) / 255 + _loc2_;
               _loc6_ = _loc1_ * (255 - _loc3_) / 255 + _loc3_;
               _loc7_ = _loc1_ * (255 - _loc4_) / 255 + _loc4_;
            }
            else
            {
               _loc1_ = _loc1_ * -1;
               _loc5_ = Math.round(_loc2_ - _loc2_ * _loc1_ / 255);
               _loc6_ = Math.round(_loc3_ - _loc3_ * _loc1_ / 255);
               _loc7_ = Math.round(_loc4_ - _loc4_ * _loc1_ / 255);
            }
            this._nColor = Math.round((_loc5_ << 16) + (_loc6_ << 8) + _loc7_);
         }
         Berilia.getInstance().handler.process(new ColorChangeMessage(InteractiveObject(this)));
         return this._nColor;
      }
      
      override public function process(param1:Message) : Boolean {
         switch(true)
         {
            case param1 is MouseDownMessage:
               this._bFixedColor = false;
               switch(MouseDownMessage(param1).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = true;
                     this._texCursorGradient.x = mouseX - this._texCursorGradient.width / 2;
                     this._texCursorGradient.y = mouseY - this._texCursorGradient.height / 2;
                     this._nGradientX = mouseX;
                     this._nGradientY = mouseY;
                     this._texCursorGradient.startDrag(false,new Rectangle(this._sprGradient.x - this._texCursorGradient.width / 2,this._sprGradient.y - this._texCursorGradient.height / 2,this._sprGradient.width,this._sprGradient.height));
                     EnterFrameDispatcher.addEventListener(this.onMoveGradientCursor,"ColorPickerGradient");
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = true;
                     this._texCursorSlider.x = mouseX;
                     this._texCursorSlider.y = mouseY - this._texCursorSlider.height / 2;
                     this._texCursorSlider.startDrag(false,new Rectangle(this._sprSliderSup.x,this._sprSliderSup.y - this._texCursorSlider.height / 2,0,this._sprSliderSup.height));
                     this._nSliderY = mouseY;
                     EnterFrameDispatcher.addEventListener(this.onMoveSliderCursor,"ColorPickerSlider");
                     break;
               }
               return true;
            case param1 is MouseUpMessage:
               switch(MouseUpMessage(param1).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = false;
                     this._texCursorGradient.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                     this.updateSlider();
                     this.getCurrentColor();
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = false;
                     this._texCursorSlider.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                     this.getCurrentColor();
                     break;
               }
               return true;
            case param1 is MouseReleaseOutsideMessage:
               switch(MouseReleaseOutsideMessage(param1).target)
               {
                  case this._sprGradient:
                  case this._texCursorGradient:
                     this._bMouseDown = false;
                     this._texCursorGradient.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                     this.updateSlider();
                     this.getCurrentColor();
                     break;
                  case this._sprSliderSup:
                  case this._texCursorSlider:
                     this._bMouseDown = false;
                     this._texCursorSlider.stopDrag();
                     EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                     this.getCurrentColor();
                     break;
               }
               return true;
            default:
               return false;
         }
      }
      
      private function onMoveGradientCursor(param1:Event) : void {
         if(!(this._nGradientX == mouseX) || !(this._nGradientY == mouseY))
         {
            this._nGradientX = mouseX;
            if(this._nGradientX < 0)
            {
               this._nGradientX = 0;
            }
            if(this._nGradientX > this._nGradientWidth)
            {
               this._nGradientX = this._nGradientWidth;
            }
            this._nGradientY = mouseY;
            if(this._nGradientY < 0)
            {
               this._nGradientY = 0;
            }
            if(this._nGradientY > this._nHeight)
            {
               this._nGradientY = this._nHeight;
            }
            this.updateSlider();
            this.getCurrentColor();
         }
      }
      
      private function onMoveSliderCursor(param1:Event) : void {
         if(this._nSliderY != mouseY)
         {
            this._nSliderY = mouseY;
            if(this._nSliderY < 0)
            {
               this._nSliderY = 0;
            }
            if(this._nSliderY > this._nHeight)
            {
               this._nSliderY = this._nHeight;
            }
            this._nColor = this.getCurrentColor();
         }
      }
      
      private function onTextureSliderLoaded(param1:Event) : void {
         this._nLoadedSum++;
         this._texCursorSlider.removeEventListener(Event.COMPLETE,this.onTextureSliderLoaded);
         if(this._nLoadedSum >= 2)
         {
            this.updatePicker();
         }
      }
      
      private function onTextureGradientLoaded(param1:Event) : void {
         this._nLoadedSum++;
         this._texCursorGradient.removeEventListener(Event.COMPLETE,this.onTextureGradientLoaded);
         if(this._nLoadedSum >= 2)
         {
            this.updatePicker();
         }
      }
   }
}
