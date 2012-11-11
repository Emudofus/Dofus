package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class ColorPicker extends GraphicContainer implements FinalizableUIComponent
    {
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ColorPicker));

        public function ColorPicker()
        {
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._nWidth = param1;
            if (this.finalized)
            {
                this.updatePicker();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._nHeight = param1;
            this._nSliderY = int(this._nHeight / 2);
            if (this.finalized)
            {
                this.updatePicker();
            }
            return;
        }// end function

        public function set sliderTexture(param1:Uri) : void
        {
            this._texCursorSlider = new Texture();
            this._texCursorSlider.x = 0;
            this._texCursorSlider.y = 0;
            this._texCursorSlider.width = 20;
            this._texCursorSlider.height = 16;
            this._texCursorSlider.uri = param1;
            return;
        }// end function

        public function get sliderTexture() : Uri
        {
            return this._texCursorSlider.uri;
        }// end function

        public function set gradientTexture(param1:Uri) : void
        {
            this._texCursorGradient = new Texture();
            this._texCursorGradient.x = 0;
            this._texCursorGradient.y = 0;
            this._texCursorGradient.width = 16;
            this._texCursorGradient.height = 16;
            this._texCursorGradient.uri = param1;
            return;
        }// end function

        public function get gradientTexture() : Uri
        {
            return this._texCursorGradient.uri;
        }// end function

        public function get color() : uint
        {
            return this._nColor;
        }// end function

        public function set color(param1:uint) : void
        {
            this._nColor = param1;
            this._bFixedColor = true;
            this.getCurrentPos();
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return this._bFinalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._bFinalized = param1;
            return;
        }// end function

        public function finalize() : void
        {
            this._sprGradient = new Sprite();
            this._sprSliderInf = new Sprite();
            this._sprSliderSup = new Sprite();
            this._nGradientWidth = this._nWidth - this._nSeparationWidth - this._nSliderWidth;
            this._mMatrixGradient = new Matrix();
            this._mMatrixGradient.createGradientBox(this._nGradientWidth, this._nHeight, 0, 0, 0);
            this._aColorsHue = new Array(16711680, 16776960, 65280, 65535, 255, 16711935, 16711680);
            this._aAlphasHue = new Array(100, 100, 100, 100, 100, 100, 100);
            this._aRatiosHue = new Array(0, 1 * 255 / 6, 2 * 255 / 6, 3 * 255 / 6, 4 * 255 / 6, 5 * 255 / 6, 255);
            this._mMatrixSaturation = new Matrix();
            this._mMatrixSaturation.createGradientBox(this._nGradientWidth, this._nHeight, 90 / 180 * Math.PI, 0, 0);
            this._aColorsSat = new Array(8421504, 8421504);
            this._aAlphasSat = new Array(0, 100);
            this._aRatiosSat = new Array(0, 255);
            this._sprGradient.graphics.lineStyle();
            this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR, this._aColorsHue, this._aAlphasHue, this._aRatiosHue, this._mMatrixGradient);
            this._sprGradient.graphics.drawRect(0, 0, this._nGradientWidth, this._nHeight);
            this._sprGradient.graphics.endFill();
            this._sprGradient.graphics.beginGradientFill(GradientType.LINEAR, this._aColorsSat, this._aAlphasSat, this._aRatiosSat, this._mMatrixSaturation);
            this._sprGradient.graphics.drawRect(0, 0, this._nGradientWidth, this._nHeight);
            this._sprGradient.graphics.endFill();
            addChild(this._sprGradient);
            this._sprSliderInf.x = this._nGradientWidth + this._nSeparationWidth;
            addChild(this._sprSliderInf);
            this._mMatrixSlider = new Matrix();
            this._mMatrixSlider.createGradientBox(this._nSliderWidth, this._nHeight, 90 / 180 * Math.PI, 0, 0);
            this._aAlphasBri = new Array(1, 0, 0, 1);
            this._aRatiosBri = new Array(0, 127.5, 127.5, 255);
            this._aColorsBri = new Array(16777215, 16777215, 0, 0);
            this._sprSliderSup.graphics.beginGradientFill(GradientType.LINEAR, this._aColorsBri, this._aAlphasBri, this._aRatiosBri, this._mMatrixSlider);
            this._sprSliderSup.graphics.drawRect(0, 0, this._nSliderWidth, this._nHeight);
            this._sprSliderSup.graphics.endFill();
            this._sprSliderSup.x = this._nGradientWidth + this._nSeparationWidth;
            addChild(this._sprSliderSup);
            this._texCursorGradient.dispatchMessages = true;
            this._texCursorSlider.dispatchMessages = true;
            this._texCursorSlider.addEventListener(Event.COMPLETE, this.onTextureSliderLoaded);
            this._texCursorSlider.finalize();
            this._texCursorGradient.addEventListener(Event.COMPLETE, this.onTextureGradientLoaded);
            this._texCursorGradient.finalize();
            this._bFinalized = true;
            getUi().iAmFinalized(this);
            return;
        }// end function

        public function updatePicker() : void
        {
            var _loc_1:* = ColorUtils.rgb2hsl(this._nColor);
            this._texCursorGradient.x = _loc_1.h * this._nGradientWidth - this._texCursorGradient.width / 2;
            this._texCursorGradient.y = _loc_1.s * this._nHeight - this._texCursorGradient.height / 2;
            this._texCursorSlider.x = this._sprSliderSup.x;
            this._texCursorSlider.y = _loc_1.l * this._nHeight - this._texCursorSlider.height / 2;
            addChild(this._texCursorGradient);
            addChild(this._texCursorSlider);
            this.updateSlider();
            this._texCursorGradient.addEventListener(Event.CHANGE, this.onMoveGradientCursor);
            this._texCursorSlider.addEventListener(Event.CHANGE, this.onMoveSliderCursor);
            return;
        }// end function

        override public function remove() : void
        {
            if (!__removed)
            {
                this._texCursorSlider.remove();
                this._texCursorGradient.remove();
                this._texCursorSlider = null;
                this._texCursorGradient = null;
            }
            super.remove();
            return;
        }// end function

        public function getGradientColor() : uint
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            if (this._nGradientX >= this._nGradientWidth)
            {
                this._nGradientX = this._nGradientWidth - 1;
            }
            _loc_1 = this._nGradientX / this._nGradientWidth;
            var _loc_14:* = Math.floor(_loc_1 * (this._aRatiosHue.length - 1));
            _loc_1 = _loc_1 * 255;
            _loc_2 = 255 - (this._aRatiosHue[(_loc_14 + 1)] - _loc_1) / (this._aRatiosHue[(_loc_14 + 1)] - this._aRatiosHue[_loc_14]) * 255;
            _loc_9 = this._aColorsHue[_loc_14];
            _loc_10 = this._aColorsHue[(_loc_14 + 1)];
            _loc_3 = _loc_9 & 16711680;
            _loc_4 = _loc_9 & 65280;
            _loc_5 = _loc_9 & 255;
            _loc_6 = _loc_10 & 16711680;
            _loc_7 = _loc_10 & 65280;
            _loc_8 = _loc_10 & 255;
            if (_loc_3 != _loc_6)
            {
                _loc_11 = Math.round(_loc_3 > _loc_6 ? (255 - _loc_2) : (_loc_2));
            }
            else
            {
                _loc_11 = _loc_3 >> 16;
            }
            if (_loc_4 != _loc_7)
            {
                _loc_12 = Math.round(_loc_4 > _loc_7 ? (255 - _loc_2) : (_loc_2));
            }
            else
            {
                _loc_12 = _loc_4 >> 8;
            }
            if (_loc_5 != _loc_8)
            {
                _loc_13 = Math.round(_loc_5 > _loc_8 ? (255 - _loc_2) : (_loc_2));
            }
            else
            {
                _loc_13 = _loc_5;
            }
            _loc_1 = this._nGradientY / this._nHeight * 255;
            _loc_11 = _loc_11 + (127 - _loc_11) * _loc_1 / 255;
            _loc_12 = _loc_12 + (127 - _loc_12) * _loc_1 / 255;
            _loc_13 = _loc_13 + (127 - _loc_13) * _loc_1 / 255;
            this._nGradientColor = Math.round((_loc_11 << 16) + (_loc_12 << 8) + _loc_13);
            return this._nGradientColor;
        }// end function

        public function updateSlider() : void
        {
            var _loc_1:* = this.getGradientColor();
            this._sprSliderInf.graphics.beginFill(_loc_1);
            this._sprSliderInf.graphics.drawRect(0, 0, this._nSliderWidth, this._nHeight);
            this._sprSliderInf.graphics.endFill();
            return;
        }// end function

        private function getCurrentPos() : void
        {
            var _loc_1:* = ColorUtils.rgb2hsl(this._nColor);
            this._texCursorGradient.x = _loc_1.h * this._nGradientWidth - this._texCursorGradient.width / 2;
            this._texCursorGradient.y = _loc_1.s * this._nHeight - this._texCursorGradient.height / 2;
            this._texCursorSlider.y = _loc_1.l * this._nHeight - this._texCursorSlider.height / 2;
            this._nGradientX = this._texCursorGradient.x + this._texCursorGradient.width / 2;
            this._nGradientY = this._texCursorGradient.y + this._texCursorGradient.height / 2;
            this._nSliderY = this._texCursorSlider.y + this._texCursorSlider.height / 2;
            this.updateSlider();
            this.getCurrentColor();
            return;
        }// end function

        private function getCurrentColor() : uint
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (!this._bFixedColor)
            {
                this.getGradientColor();
                _loc_1 = 255 - this._nSliderY / this._nHeight * 510;
                _loc_2 = (this._nGradientColor & 16711680) >> 16;
                _loc_3 = (this._nGradientColor & 65280) >> 8;
                _loc_4 = this._nGradientColor & 255;
                if (_loc_1 >= 0)
                {
                    _loc_5 = _loc_1 * (255 - _loc_2) / 255 + _loc_2;
                    _loc_6 = _loc_1 * (255 - _loc_3) / 255 + _loc_3;
                    _loc_7 = _loc_1 * (255 - _loc_4) / 255 + _loc_4;
                }
                else
                {
                    _loc_1 = _loc_1 * -1;
                    _loc_5 = Math.round(_loc_2 - _loc_2 * _loc_1 / 255);
                    _loc_6 = Math.round(_loc_3 - _loc_3 * _loc_1 / 255);
                    _loc_7 = Math.round(_loc_4 - _loc_4 * _loc_1 / 255);
                }
                this._nColor = Math.round((_loc_5 << 16) + (_loc_6 << 8) + _loc_7);
            }
            Berilia.getInstance().handler.process(new ColorChangeMessage(InteractiveObject(this)));
            return this._nColor;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            switch(true)
            {
                case param1 is MouseDownMessage:
                {
                    this._bFixedColor = false;
                    switch(MouseDownMessage(param1).target)
                    {
                        case this._sprGradient:
                        case this._texCursorGradient:
                        {
                            this._bMouseDown = true;
                            this._texCursorGradient.x = mouseX - this._texCursorGradient.width / 2;
                            this._texCursorGradient.y = mouseY - this._texCursorGradient.height / 2;
                            this._nGradientX = mouseX;
                            this._nGradientY = mouseY;
                            this._texCursorGradient.startDrag(false, new Rectangle(this._sprGradient.x - this._texCursorGradient.width / 2, this._sprGradient.y - this._texCursorGradient.height / 2, this._sprGradient.width, this._sprGradient.height));
                            EnterFrameDispatcher.addEventListener(this.onMoveGradientCursor, "ColorPickerGradient");
                            break;
                        }
                        case this._sprSliderSup:
                        case this._texCursorSlider:
                        {
                            this._bMouseDown = true;
                            this._texCursorSlider.x = mouseX;
                            this._texCursorSlider.y = mouseY - this._texCursorSlider.height / 2;
                            this._texCursorSlider.startDrag(false, new Rectangle(this._sprSliderSup.x, this._sprSliderSup.y - this._texCursorSlider.height / 2, 0, this._sprSliderSup.height));
                            this._nSliderY = mouseY;
                            EnterFrameDispatcher.addEventListener(this.onMoveSliderCursor, "ColorPickerSlider");
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is MouseUpMessage:
                {
                    switch(MouseUpMessage(param1).target)
                    {
                        case this._sprGradient:
                        case this._texCursorGradient:
                        {
                            this._bMouseDown = false;
                            this._texCursorGradient.stopDrag();
                            EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                            this.updateSlider();
                            this.getCurrentColor();
                            break;
                        }
                        case this._sprSliderSup:
                        case this._texCursorSlider:
                        {
                            this._bMouseDown = false;
                            this._texCursorSlider.stopDrag();
                            EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                            this.getCurrentColor();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                case param1 is MouseReleaseOutsideMessage:
                {
                    switch(MouseReleaseOutsideMessage(param1).target)
                    {
                        case this._sprGradient:
                        case this._texCursorGradient:
                        {
                            this._bMouseDown = false;
                            this._texCursorGradient.stopDrag();
                            EnterFrameDispatcher.removeEventListener(this.onMoveGradientCursor);
                            this.updateSlider();
                            this.getCurrentColor();
                            break;
                        }
                        case this._sprSliderSup:
                        case this._texCursorSlider:
                        {
                            this._bMouseDown = false;
                            this._texCursorSlider.stopDrag();
                            EnterFrameDispatcher.removeEventListener(this.onMoveSliderCursor);
                            this.getCurrentColor();
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function onMoveGradientCursor(event:Event) : void
        {
            if (this._nGradientX != mouseX || this._nGradientY != mouseY)
            {
                this._nGradientX = mouseX;
                if (this._nGradientX < 0)
                {
                    this._nGradientX = 0;
                }
                if (this._nGradientX > this._nGradientWidth)
                {
                    this._nGradientX = this._nGradientWidth;
                }
                this._nGradientY = mouseY;
                if (this._nGradientY < 0)
                {
                    this._nGradientY = 0;
                }
                if (this._nGradientY > this._nHeight)
                {
                    this._nGradientY = this._nHeight;
                }
                this.updateSlider();
                this.getCurrentColor();
            }
            return;
        }// end function

        private function onMoveSliderCursor(event:Event) : void
        {
            if (this._nSliderY != mouseY)
            {
                this._nSliderY = mouseY;
                if (this._nSliderY < 0)
                {
                    this._nSliderY = 0;
                }
                if (this._nSliderY > this._nHeight)
                {
                    this._nSliderY = this._nHeight;
                }
                this._nColor = this.getCurrentColor();
            }
            return;
        }// end function

        private function onTextureSliderLoaded(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._nLoadedSum + 1;
            _loc_2._nLoadedSum = _loc_3;
            this._texCursorSlider.removeEventListener(Event.COMPLETE, this.onTextureSliderLoaded);
            if (this._nLoadedSum >= 2)
            {
                this.updatePicker();
            }
            return;
        }// end function

        private function onTextureGradientLoaded(event:Event) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._nLoadedSum + 1;
            _loc_2._nLoadedSum = _loc_3;
            this._texCursorGradient.removeEventListener(Event.COMPLETE, this.onTextureGradientLoaded);
            if (this._nLoadedSum >= 2)
            {
                this.updatePicker();
            }
            return;
        }// end function

    }
}
