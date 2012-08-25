package gs
{
    import flash.filters.*;
    import flash.utils.*;

    public class TweenFilterLite extends TweenLite
    {
        protected var _matrix:Array;
        protected var _endMatrix:Array;
        protected var _cmf:ColorMatrixFilter;
        protected var _clrsa:Array;
        protected var _hf:Boolean = false;
        protected var _filters:Array;
        protected var _timeScale:Number;
        protected var _roundProps:Boolean;
        public static var version:Number = 9.29;
        public static var delayedCall:Function = TweenLite.delayedCall;
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var removeTween:Function = TweenLite.removeTween;
        static var _globalTimeScale:Number = 1;
        private static var _idMatrix:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        private static var _lumR:Number = 0.212671;
        private static var _lumG:Number = 0.71516;
        private static var _lumB:Number = 0.072169;

        public function TweenFilterLite(param1:Object, param2:Number, param3:Object)
        {
            this._filters = [];
            super(param1, param2, param3);
            if (this.combinedTimeScale != 1 && this.target is TweenFilterLite)
            {
                this._timeScale = 1;
                this.combinedTimeScale = _globalTimeScale;
            }
            else
            {
                this._timeScale = this.combinedTimeScale;
                this.combinedTimeScale = this.combinedTimeScale * _globalTimeScale;
            }
            if (this.combinedTimeScale != 1 && this.delay != 0)
            {
                this.startTime = this.initTime + this.delay * (1000 / this.combinedTimeScale);
            }
            if (TweenLite.version < 9.29)
            {
                trace("TweenFilterLite error! Please update your TweenLite class or try deleting your ASO files. TweenFilterLite requires a more recent version. Download updates at http://www.TweenLite.com.");
            }
            return;
        }// end function

        override public function initTweenVals(param1:Boolean = false, param2:String = "") : void
        {
            var _loc_3:int = 0;
            var _loc_4:Object = null;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:int = 0;
            var _loc_8:String = null;
            if (!param1 && TweenLite.overwriteManager.enabled)
            {
                TweenLite.overwriteManager.manageOverwrites(this, masterList[this.target]);
            }
            this._clrsa = [];
            this._filters = [];
            this._matrix = _idMatrix.slice();
            param2 = param2 + " blurFilter glowFilter colorMatrixFilter dropShadowFilter bevelFilter roundProps ";
            this._roundProps = Boolean(this.vars.roundProps is Array);
            if (_isDisplayObject)
            {
                if (this.vars.blurFilter != null)
                {
                    _loc_4 = this.vars.blurFilter;
                    this.addFilter("blurFilter", _loc_4, BlurFilter, ["blurX", "blurY", "quality"], new BlurFilter(0, 0, _loc_4.quality || 2));
                }
                if (this.vars.glowFilter != null)
                {
                    _loc_4 = this.vars.glowFilter;
                    this.addFilter("glowFilter", _loc_4, GlowFilter, ["alpha", "blurX", "blurY", "color", "quality", "strength", "inner", "knockout"], new GlowFilter(16777215, 0, 0, 0, _loc_4.strength || 1, _loc_4.quality || 2, _loc_4.inner, _loc_4.knockout));
                }
                if (this.vars.colorMatrixFilter != null)
                {
                    _loc_4 = this.vars.colorMatrixFilter;
                    _loc_5 = this.addFilter("colorMatrixFilter", _loc_4, ColorMatrixFilter, [], new ColorMatrixFilter(this._matrix));
                    this._cmf = _loc_5.filter;
                    this._matrix = ColorMatrixFilter(this._cmf).matrix;
                    if (_loc_4.matrix != null && _loc_4.matrix is Array)
                    {
                        this._endMatrix = _loc_4.matrix;
                    }
                    else
                    {
                        if (_loc_4.relative == true)
                        {
                            this._endMatrix = this._matrix.slice();
                        }
                        else
                        {
                            this._endMatrix = _idMatrix.slice();
                        }
                        this._endMatrix = setBrightness(this._endMatrix, _loc_4.brightness);
                        this._endMatrix = setContrast(this._endMatrix, _loc_4.contrast);
                        this._endMatrix = setHue(this._endMatrix, _loc_4.hue);
                        this._endMatrix = setSaturation(this._endMatrix, _loc_4.saturation);
                        this._endMatrix = setThreshold(this._endMatrix, _loc_4.threshold);
                        if (!isNaN(_loc_4.colorize))
                        {
                            this._endMatrix = colorize(this._endMatrix, _loc_4.colorize, _loc_4.amount);
                        }
                        else if (!isNaN(_loc_4.color))
                        {
                            this._endMatrix = colorize(this._endMatrix, _loc_4.color, _loc_4.amount);
                        }
                    }
                    _loc_3 = 0;
                    while (_loc_3 < this._endMatrix.length)
                    {
                        
                        if (this._matrix[_loc_3] != this._endMatrix[_loc_3] && this._matrix[_loc_3] != undefined)
                        {
                            this.tweens[this.tweens.length] = [this._matrix, _loc_3.toString(), this._matrix[_loc_3], this._endMatrix[_loc_3] - this._matrix[_loc_3], "colorMatrixFilter"];
                        }
                        _loc_3++;
                    }
                }
                if (this.vars.dropShadowFilter != null)
                {
                    _loc_4 = this.vars.dropShadowFilter;
                    this.addFilter("dropShadowFilter", _loc_4, DropShadowFilter, ["alpha", "angle", "blurX", "blurY", "color", "distance", "quality", "strength", "inner", "knockout", "hideObject"], new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, _loc_4.quality || 2, _loc_4.inner, _loc_4.knockout, _loc_4.hideObject));
                }
                if (this.vars.bevelFilter != null)
                {
                    _loc_4 = this.vars.bevelFilter;
                    this.addFilter("bevelFilter", _loc_4, BevelFilter, ["angle", "blurX", "blurY", "distance", "highlightAlpha", "highlightColor", "quality", "shadowAlpha", "shadowColor", "strength"], new BevelFilter(0, 0, 16777215, 0.5, 0, 0.5, 2, 2, 0, _loc_4.quality || 2));
                }
                if (this.vars.runBackwards == true)
                {
                    _loc_3 = this._clrsa.length - 1;
                    while (_loc_3 > -1)
                    {
                        
                        _loc_6 = this._clrsa[_loc_3];
                        this._clrsa[_loc_3].sr = _loc_6.sr + _loc_6.cr;
                        _loc_6.cr = _loc_6.cr * -1;
                        _loc_6.sg = _loc_6.sg + _loc_6.cg;
                        _loc_6.cg = _loc_6.cg * -1;
                        _loc_6.sb = _loc_6.sb + _loc_6.cb;
                        _loc_6.cb = _loc_6.cb * -1;
                        _loc_6.f[_loc_6.p] = _loc_6.sr << 16 | _loc_6.sg << 8 | _loc_6.sb;
                        _loc_3 = _loc_3 - 1;
                    }
                }
                super.initTweenVals(true, param2);
            }
            else
            {
                super.initTweenVals(param1, param2);
            }
            if (this._roundProps)
            {
                _loc_3 = this.vars.roundProps.length - 1;
                while (_loc_3 > -1)
                {
                    
                    _loc_8 = this.vars.roundProps[_loc_3];
                    _loc_7 = this.tweens.length - 1;
                    while (_loc_7 > -1)
                    {
                        
                        if (this.tweens[_loc_7][1] == _loc_8 && this.tweens[_loc_7][0] == this.target)
                        {
                            this.tweens[_loc_7][5] = true;
                            break;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        private function addFilter(param1:String, param2:Object, param3:Class, param4:Array, param5:BitmapFilter) : Object
        {
            var _loc_8:int = 0;
            var _loc_9:String = null;
            var _loc_10:Number = NaN;
            var _loc_11:Object = null;
            var _loc_12:Object = null;
            var _loc_6:Object = {type:param3, name:param1};
            var _loc_7:* = this.target.filters;
            _loc_8 = 0;
            while (_loc_8 < _loc_7.length)
            {
                
                if (_loc_7[_loc_8] is param3)
                {
                    _loc_6.filter = _loc_7[_loc_8];
                    break;
                }
                _loc_8++;
            }
            if (_loc_6.filter == undefined)
            {
                _loc_6.filter = param5;
                _loc_7[_loc_7.length] = _loc_6.filter;
                this.target.filters = _loc_7;
            }
            _loc_8 = 0;
            while (_loc_8 < param4.length)
            {
                
                _loc_9 = param4[_loc_8];
                if (param2[_loc_9] != undefined)
                {
                    if (_loc_9 == "color" || _loc_9 == "highlightColor" || _loc_9 == "shadowColor")
                    {
                        _loc_11 = HEXtoRGB(_loc_6.filter[_loc_9]);
                        _loc_12 = HEXtoRGB(param2[_loc_9]);
                        this._clrsa[this._clrsa.length] = {f:_loc_6.filter, p:_loc_9, sr:_loc_11.rb, cr:_loc_12.rb - _loc_11.rb, sg:_loc_11.gb, cg:_loc_12.gb - _loc_11.gb, sb:_loc_11.bb, cb:_loc_12.bb - _loc_11.bb};
                    }
                    else if (_loc_9 == "quality" || _loc_9 == "inner" || _loc_9 == "knockout" || _loc_9 == "hideObject")
                    {
                        _loc_6.filter[_loc_9] = param2[_loc_9];
                    }
                    else
                    {
                        if (typeof(param2[_loc_9]) == "number")
                        {
                            _loc_10 = param2[_loc_9] - _loc_6.filter[_loc_9];
                        }
                        else
                        {
                            _loc_10 = Number(param2[_loc_9]);
                        }
                        this.tweens[this.tweens.length] = [_loc_6.filter, _loc_9, _loc_6.filter[_loc_9], _loc_10, param1];
                    }
                }
                _loc_8++;
            }
            this._filters[this._filters.length] = _loc_6;
            this._hf = true;
            return _loc_6;
        }// end function

        override public function render(param1:uint) : void
        {
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_6:Number = NaN;
            var _loc_7:int = 0;
            var _loc_8:Array = null;
            var _loc_9:int = 0;
            var _loc_2:* = (param1 - this.startTime) * 0.001 * this.combinedTimeScale;
            if (_loc_2 >= this.duration)
            {
                _loc_2 = this.duration;
                _loc_3 = this.ease == this.vars.ease || this.duration == 0.001 ? (1) : (0);
            }
            else
            {
                _loc_3 = this.ease(_loc_2, 0, 1, this.duration);
            }
            if (!this._roundProps)
            {
                _loc_5 = this.tweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _loc_4 = this.tweens[_loc_5];
                    _loc_4[0][_loc_4[1]] = _loc_4[2] + _loc_3 * _loc_4[3];
                    _loc_5 = _loc_5 - 1;
                }
            }
            else
            {
                _loc_5 = this.tweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _loc_4 = this.tweens[_loc_5];
                    if (_loc_4[5])
                    {
                        _loc_6 = _loc_4[2] + _loc_3 * _loc_4[3];
                        _loc_7 = _loc_6 < 0 ? (-1) : (1);
                        _loc_4[0][_loc_4[1]] = _loc_6 % 1 * _loc_7 > 0.5 ? (int(_loc_6) + _loc_7) : (int(_loc_6));
                    }
                    else
                    {
                        _loc_4[0][_loc_4[1]] = _loc_4[2] + _loc_3 * _loc_4[3];
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            if (this._hf)
            {
                _loc_5 = this._clrsa.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _loc_4 = this._clrsa[_loc_5];
                    _loc_4.f[_loc_4.p] = _loc_4.sr + _loc_3 * _loc_4.cr << 16 | _loc_4.sg + _loc_3 * _loc_4.cg << 8 | _loc_4.sb + _loc_3 * _loc_4.cb;
                    _loc_5 = _loc_5 - 1;
                }
                if (this._cmf != null)
                {
                    ColorMatrixFilter(this._cmf).matrix = this._matrix;
                }
                _loc_8 = this.target.filters;
                _loc_5 = 0;
                while (_loc_5 < this._filters.length)
                {
                    
                    _loc_9 = _loc_8.length - 1;
                    while (_loc_9 > -1)
                    {
                        
                        if (_loc_8[_loc_9] is this._filters[_loc_5].type)
                        {
                            _loc_8.splice(_loc_9, 1, this._filters[_loc_5].filter);
                            break;
                        }
                        _loc_9 = _loc_9 - 1;
                    }
                    _loc_5++;
                }
                this.target.filters = _loc_8;
            }
            if (_hst)
            {
                _loc_5 = _subTweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _subTweens[_loc_5].proxy(_subTweens[_loc_5], _loc_2);
                    _loc_5 = _loc_5 - 1;
                }
            }
            if (_hasUpdate)
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (_loc_2 == this.duration)
            {
                complete(true);
            }
            return;
        }// end function

        override public function killVars(param1:Object) : void
        {
            if (TweenLite.overwriteManager.enabled)
            {
                TweenLite.overwriteManager.killVars(param1, this.vars, this.tweens, _subTweens, this._filters || []);
            }
            return;
        }// end function

        public function get timeScale() : Number
        {
            return this._timeScale;
        }// end function

        public function set timeScale(param1:Number) : void
        {
            if (param1 < 1e-005)
            {
                var _loc_2:Number = 1e-005;
                this._timeScale = 1e-005;
                param1 = _loc_2;
            }
            else
            {
                this._timeScale = param1;
                param1 = param1 * _globalTimeScale;
            }
            this.initTime = currentTime - (currentTime - this.initTime - this.delay * (1000 / this.combinedTimeScale)) * this.combinedTimeScale * (1 / param1) - this.delay * (1000 / param1);
            if (this.startTime != 999999999999999)
            {
                this.startTime = this.initTime + this.delay * (1000 / param1);
            }
            this.combinedTimeScale = param1;
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if (param1)
            {
                this.combinedTimeScale = this._timeScale * _globalTimeScale;
            }
            return;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenFilterLite
        {
            return new TweenFilterLite(param1, param2, param3);
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenFilterLite
        {
            param3.runBackwards = true;
            return new TweenFilterLite(param1, param2, param3);
        }// end function

        public static function setGlobalTimeScale(param1:Number) : void
        {
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            if (param1 < 1e-005)
            {
                param1 = 1e-005;
            }
            var _loc_2:* = masterList;
            _globalTimeScale = param1;
            for each (_loc_4 in _loc_2)
            {
                
                _loc_3 = _loc_4.length - 1;
                while (_loc_3 > -1)
                {
                    
                    if (_loc_4[_loc_3] is TweenFilterLite)
                    {
                        _loc_4[_loc_3].timeScale = _loc_4[_loc_3].timeScale * 1;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return;
        }// end function

        public static function HEXtoRGB(param1:Number) : Object
        {
            return {rb:param1 >> 16, gb:param1 >> 8 & 255, bb:param1 & 255};
        }// end function

        public static function colorize(param1:Array, param2:Number, param3:Number = 1) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            if (isNaN(param3))
            {
                param3 = 1;
            }
            var _loc_4:* = (param2 >> 16 & 255) / 255;
            var _loc_5:* = (param2 >> 8 & 255) / 255;
            var _loc_6:* = (param2 & 255) / 255;
            var _loc_7:* = 1 - param3;
            var _loc_8:Array = [1 - param3 + param3 * _loc_4 * _lumR, param3 * _loc_4 * _lumG, param3 * _loc_4 * _lumB, 0, 0, param3 * _loc_5 * _lumR, _loc_7 + param3 * _loc_5 * _lumG, param3 * _loc_5 * _lumB, 0, 0, param3 * _loc_6 * _lumR, param3 * _loc_6 * _lumG, _loc_7 + param3 * _loc_6 * _lumB, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(_loc_8, param1);
        }// end function

        public static function setThreshold(param1:Array, param2:Number) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            var _loc_3:Array = [_lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, _lumR * 256, _lumG * 256, _lumB * 256, 0, -256 * param2, 0, 0, 0, 1, 0];
            return applyMatrix(_loc_3, param1);
        }// end function

        public static function setHue(param1:Array, param2:Number) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            param2 = param2 * (Math.PI / 180);
            var _loc_3:* = Math.cos(param2);
            var _loc_4:* = Math.sin(param2);
            var _loc_5:Array = [_lumR + _loc_3 * (1 - _lumR) + _loc_4 * (-_lumR), _lumG + _loc_3 * (-_lumG) + _loc_4 * (-_lumG), _lumB + _loc_3 * (-_lumB) + _loc_4 * (1 - _lumB), 0, 0, _lumR + _loc_3 * (-_lumR) + _loc_4 * 0.143, _lumG + _loc_3 * (1 - _lumG) + _loc_4 * 0.14, _lumB + _loc_3 * (-_lumB) + _loc_4 * -0.283, 0, 0, _lumR + _loc_3 * (-_lumR) + _loc_4 * (-(1 - _lumR)), _lumG + _loc_3 * (-_lumG) + _loc_4 * _lumG, _lumB + _loc_3 * (1 - _lumB) + _loc_4 * _lumB, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return applyMatrix(_loc_5, param1);
        }// end function

        public static function setBrightness(param1:Array, param2:Number) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            param2 = param2 * 100 - 100;
            return applyMatrix([1, 0, 0, 0, param2, 0, 1, 0, 0, param2, 0, 0, 1, 0, param2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], param1);
        }// end function

        public static function setSaturation(param1:Array, param2:Number) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            var _loc_3:* = 1 - param2;
            var _loc_4:* = _loc_3 * _lumR;
            var _loc_5:* = _loc_3 * _lumG;
            var _loc_6:* = _loc_3 * _lumB;
            var _loc_7:Array = [_loc_4 + param2, _loc_5, _loc_6, 0, 0, _loc_4, _loc_5 + param2, _loc_6, 0, 0, _loc_4, _loc_5, _loc_6 + param2, 0, 0, 0, 0, 0, 1, 0];
            return applyMatrix(_loc_7, param1);
        }// end function

        public static function setContrast(param1:Array, param2:Number) : Array
        {
            if (isNaN(param2))
            {
                return param1;
            }
            param2 = param2 + 0.01;
            var _loc_3:Array = [param2, 0, 0, 0, 128 * (1 - param2), 0, param2, 0, 0, 128 * (1 - param2), 0, 0, param2, 0, 128 * (1 - param2), 0, 0, 0, 1, 0];
            return applyMatrix(_loc_3, param1);
        }// end function

        public static function applyMatrix(param1:Array, param2:Array) : Array
        {
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            if (!(param1 is Array) || !(param2 is Array))
            {
                return param2;
            }
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            _loc_6 = 0;
            while (_loc_6 < 4)
            {
                
                _loc_7 = 0;
                while (_loc_7 < 5)
                {
                    
                    if (_loc_7 == 4)
                    {
                        _loc_5 = param1[_loc_4 + 4];
                    }
                    else
                    {
                        _loc_5 = 0;
                    }
                    _loc_3[_loc_4 + _loc_7] = param1[_loc_4] * param2[_loc_7] + param1[(_loc_4 + 1)] * param2[_loc_7 + 5] + param1[_loc_4 + 2] * param2[_loc_7 + 10] + param1[_loc_4 + 3] * param2[_loc_7 + 15] + _loc_5;
                    _loc_7++;
                }
                _loc_4 = _loc_4 + 5;
                _loc_6++;
            }
            return _loc_3;
        }// end function

        public static function set globalTimeScale(param1:Number) : void
        {
            setGlobalTimeScale(param1);
            return;
        }// end function

        public static function get globalTimeScale() : Number
        {
            return _globalTimeScale;
        }// end function

    }
}
