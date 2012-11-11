package gs
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TweenLite extends Object
    {
        public var duration:Number;
        public var vars:Object;
        public var delay:Number;
        public var startTime:Number;
        public var initTime:Number;
        public var tweens:Array;
        public var target:Object;
        public var active:Boolean;
        public var ease:Function;
        public var initted:Boolean;
        public var combinedTimeScale:Number;
        public var gc:Boolean;
        public var started:Boolean;
        protected var _subTweens:Array;
        protected var _hst:Boolean;
        protected var _hasUpdate:Boolean;
        protected var _isDisplayObject:Boolean;
        protected var _specialVars:Object;
        public static var version:Number = 9.29;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var defaultEase:Function = TweenLite.easeOut;
        public static var overwriteManager:Object;
        public static var currentTime:uint;
        public static var masterList:Dictionary = new Dictionary(false);
        public static var timingSprite:Sprite = new Sprite();
        private static var _classInitted:Boolean;
        private static var _timer:Timer = new Timer(2000);

        public function TweenLite(param1:Object, param2:Number, param3:Object)
        {
            if (param1 == null)
            {
                return;
            }
            if (!_classInitted)
            {
                currentTime = getTimer();
                timingSprite.addEventListener(Event.ENTER_FRAME, updateAll, false, 0, true);
                if (overwriteManager == null)
                {
                    overwriteManager = {mode:1, enabled:false};
                }
                _timer.addEventListener("timer", killGarbage, false, 0, true);
                _timer.start();
                _classInitted = true;
            }
            this.vars = param3;
            this.duration = param2 || 0.001;
            this.delay = param3.delay || 0;
            this.combinedTimeScale = param3.timeScale || 1;
            this.active = Boolean(param2 == 0 && this.delay == 0);
            this.target = param1;
            this._isDisplayObject = Boolean(param1 is DisplayObject);
            if (!(this.vars.ease is Function))
            {
                this.vars.ease = defaultEase;
            }
            if (this.vars.easeParams != null)
            {
                this.vars.proxiedEase = this.vars.ease;
                this.vars.ease = this.easeProxy;
            }
            this.ease = this.vars.ease;
            if (!isNaN(Number(this.vars.autoAlpha)))
            {
                this.vars.alpha = Number(this.vars.autoAlpha);
                this.vars.visible = Boolean(this.vars.alpha > 0);
            }
            this._specialVars = this.vars.isTV == true ? (this.vars.exposedProps) : (this.vars);
            this.tweens = [];
            this._subTweens = [];
            var _loc_5:* = false;
            this.initted = false;
            this._hst = _loc_5;
            this.initTime = currentTime;
            this.startTime = this.initTime + this.delay * 1000;
            var _loc_4:* = param3.overwrite == undefined || !overwriteManager.enabled && param3.overwrite > 1 ? (overwriteManager.mode) : (int(param3.overwrite));
            if (masterList[param1] == undefined || param1 != null && _loc_4 == 1)
            {
                masterList[param1] = [];
            }
            masterList[param1].push(this);
            if (this.vars.runBackwards == true && this.vars.renderOnStart != true || this.active)
            {
                this.initTweenVals();
                if (this.active)
                {
                    this.render((this.startTime + 1));
                }
                else
                {
                    this.render(this.startTime);
                }
                if (this._specialVars.visible != null && this.vars.runBackwards == true && this._isDisplayObject)
                {
                    this.target.visible = this._specialVars.visible;
                }
            }
            return;
        }// end function

        public function initTweenVals(param1:Boolean = false, param2:String = "") : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!param1 && overwriteManager.enabled)
            {
                overwriteManager.manageOverwrites(this, masterList[this.target]);
            }
            if (this.target is Array)
            {
                _loc_5 = this.vars.endArray || [];
                _loc_4 = 0;
                while (_loc_4 < _loc_5.length)
                {
                    
                    if (this.target[_loc_4] != _loc_5[_loc_4] && this.target[_loc_4] != undefined)
                    {
                        this.tweens[this.tweens.length] = [this.target, _loc_4.toString(), this.target[_loc_4], _loc_5[_loc_4] - this.target[_loc_4], _loc_4.toString()];
                    }
                    _loc_4++;
                }
            }
            else
            {
                if ((typeof(this._specialVars.tint) != "undefined" || this.vars.removeTint == true) && this._isDisplayObject)
                {
                    _loc_6 = this.target.transform.colorTransform;
                    _loc_7 = new ColorTransform();
                    if (this._specialVars.alpha != undefined)
                    {
                        _loc_7.alphaMultiplier = this._specialVars.alpha;
                        delete this._specialVars.alpha;
                    }
                    else
                    {
                        _loc_7.alphaMultiplier = this.target.alpha;
                    }
                    if (this.vars.removeTint != true && (this._specialVars.tint != null && this._specialVars.tint != "" || this._specialVars.tint == 0))
                    {
                        _loc_7.color = this._specialVars.tint;
                    }
                    this.addSubTween("tint", tintProxy, {progress:0}, {progress:1}, {target:this.target, color:_loc_6, endColor:_loc_7});
                }
                if (this._specialVars.frame != null && this._isDisplayObject)
                {
                    this.addSubTween("frame", frameProxy, {frame:this.target.currentFrame}, {frame:this._specialVars.frame}, {target:this.target});
                }
                if (!isNaN(this.vars.volume) && this.target.hasOwnProperty("soundTransform"))
                {
                    this.addSubTween("volume", volumeProxy, this.target.soundTransform, {volume:this.vars.volume}, {target:this.target});
                }
                if (this._specialVars.visible != null && this._isDisplayObject)
                {
                    this.addSubTween("visible", visibleProxy, {}, {}, {tween:this});
                }
                for (_loc_3 in this._specialVars)
                {
                    
                    if (_loc_3 == "ease" || _loc_3 == "delay" || _loc_3 == "overwrite" || _loc_3 == "onComplete" || _loc_3 == "onCompleteParams" || _loc_3 == "runBackwards" || _loc_3 == "visible" || _loc_3 == "autoOverwrite" || _loc_3 == "persist" || _loc_3 == "onUpdate" || _loc_3 == "onUpdateParams" || _loc_3 == "autoAlpha" || _loc_3 == "timeScale" && !(this.target is TweenLite) || _loc_3 == "onStart" || _loc_3 == "onStartParams" || _loc_3 == "renderOnStart" || _loc_3 == "proxiedEase" || _loc_3 == "easeParams" || param1 && param2.indexOf(" " + _loc_3 + " ") != -1)
                    {
                        continue;
                    }
                    if (!(this._isDisplayObject && (_loc_3 == "tint" || _loc_3 == "removeTint" || _loc_3 == "frame")) && !(_loc_3 == "volume" && this.target.hasOwnProperty("soundTransform")))
                    {
                        if (typeof(this._specialVars[_loc_3]) == "number")
                        {
                            this.tweens[this.tweens.length] = [this.target, _loc_3, this.target[_loc_3], this._specialVars[_loc_3] - this.target[_loc_3], _loc_3];
                            continue;
                        }
                        this.tweens[this.tweens.length] = [this.target, _loc_3, this.target[_loc_3], Number(this._specialVars[_loc_3]), _loc_3];
                    }
                }
            }
            if (this.vars.runBackwards == true)
            {
                _loc_4 = this.tweens.length - 1;
                while (_loc_4 > -1)
                {
                    
                    _loc_8 = this.tweens[_loc_4];
                    _loc_8[2] = _loc_8[2] + _loc_8[3];
                    _loc_8[3] = _loc_8[3] * -1;
                    _loc_4 = _loc_4 - 1;
                }
            }
            if (this.vars.onUpdate != null)
            {
                this._hasUpdate = true;
            }
            this.initted = true;
            return;
        }// end function

        protected function addSubTween(param1:String, param2:Function, param3:Object, param4:Object, param5:Object = null) : void
        {
            var _loc_6:* = null;
            this._subTweens[this._subTweens.length] = {name:param1, proxy:param2, target:param3, info:param5};
            for (_loc_6 in param4)
            {
                
                if (typeof(param4[_loc_6]) == "number")
                {
                    this.tweens[this.tweens.length] = [param3, _loc_6, param3[_loc_6], param4[_loc_6] - param3[_loc_6], param1];
                    continue;
                }
                this.tweens[this.tweens.length] = [param3, _loc_6, param3[_loc_6], Number(param4[_loc_6]), param1];
            }
            this._hst = true;
            return;
        }// end function

        public function render(param1:uint) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = (param1 - this.startTime) * 0.001;
            if (_loc_2 >= this.duration)
            {
                _loc_2 = this.duration;
                _loc_3 = this.ease == this.vars.ease || this.duration == 0.001 ? (1) : (0);
            }
            else
            {
                _loc_3 = this.ease(_loc_2, 0, 1, this.duration);
            }
            _loc_5 = this.tweens.length - 1;
            while (_loc_5 > -1)
            {
                
                _loc_4 = this.tweens[_loc_5];
                _loc_4[0][_loc_4[1]] = _loc_4[2] + _loc_3 * _loc_4[3];
                _loc_5 = _loc_5 - 1;
            }
            if (this._hst)
            {
                _loc_5 = this._subTweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    this._subTweens[_loc_5].proxy(this._subTweens[_loc_5], _loc_2);
                    _loc_5 = _loc_5 - 1;
                }
            }
            if (this._hasUpdate)
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (_loc_2 == this.duration)
            {
                this.complete(true);
            }
            return;
        }// end function

        public function activate() : void
        {
            var _loc_1:* = true;
            this.active = true;
            this.started = _loc_1;
            if (!this.initted)
            {
                this.initTweenVals();
            }
            if (this.vars.onStart != null)
            {
                this.vars.onStart.apply(null, this.vars.onStartParams);
            }
            if (this.duration == 0.001)
            {
                (this.startTime - 1);
            }
            return;
        }// end function

        public function complete(param1:Boolean = false) : void
        {
            if (!param1)
            {
                if (!this.initted)
                {
                    this.initTweenVals();
                }
                this.startTime = currentTime - this.duration * 1000 / this.combinedTimeScale;
                this.render(currentTime);
                return;
            }
            if (this.vars.persist != true)
            {
                this.enabled = false;
            }
            if (this.vars.onComplete != null)
            {
                this.vars.onComplete.apply(null, this.vars.onCompleteParams);
            }
            return;
        }// end function

        public function clear() : void
        {
            this.tweens = [];
            this._subTweens = [];
            this.vars = {};
            var _loc_1:* = false;
            this._hasUpdate = false;
            this._hst = _loc_1;
            return;
        }// end function

        public function killVars(param1:Object) : void
        {
            if (overwriteManager.enabled)
            {
                overwriteManager.killVars(param1, this.vars, this.tweens, this._subTweens, []);
            }
            return;
        }// end function

        protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams));
        }// end function

        public function get enabled() : Boolean
        {
            return this.gc ? (false) : (true);
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            if (param1)
            {
                if (masterList[this.target] == undefined)
                {
                    masterList[this.target] = [this];
                }
                else
                {
                    _loc_2 = masterList[this.target];
                    _loc_4 = _loc_2.length - 1;
                    while (_loc_4 > -1)
                    {
                        
                        if (_loc_2[_loc_4] == this)
                        {
                            _loc_3 = true;
                            break;
                        }
                        _loc_4 = _loc_4 - 1;
                    }
                    if (!_loc_3)
                    {
                        masterList[this.target].push(this);
                    }
                }
            }
            this.gc = param1 ? (false) : (true);
            if (this.gc)
            {
                this.active = false;
            }
            else
            {
                this.active = this.started;
            }
            return;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            return new TweenLite(param1, param2, param3);
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            param3.runBackwards = true;
            return new TweenLite(param1, param2, param3);
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null) : TweenLite
        {
            return new TweenLite(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, overwrite:0});
        }// end function

        public static function updateAll(event:Event = null) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = getTimer();
            currentTime = getTimer();
            var _loc_2:* = _loc_7;
            var _loc_3:* = masterList;
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_4.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _loc_6 = _loc_4[_loc_5];
                    if (_loc_6 == null)
                    {
                    }
                    else if (_loc_6.active)
                    {
                        _loc_6.render(_loc_2);
                    }
                    else if (_loc_6.gc)
                    {
                        _loc_4.splice(_loc_5, 1);
                    }
                    else if (_loc_2 >= _loc_6.startTime)
                    {
                        _loc_6.activate();
                        _loc_6.render(_loc_2);
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            return;
        }// end function

        public static function removeTween(param1:TweenLite, param2:Boolean = true) : void
        {
            if (param1 != null)
            {
                if (param2)
                {
                    param1.clear();
                }
                param1.enabled = false;
            }
            return;
        }// end function

        public static function killTweensOf(param1:Object = null, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 != null && masterList[param1] != undefined)
            {
                _loc_3 = masterList[param1];
                _loc_4 = _loc_3.length - 1;
                while (_loc_4 > -1)
                {
                    
                    _loc_5 = _loc_3[_loc_4];
                    if (param2 && !_loc_5.gc)
                    {
                        _loc_5.complete(false);
                    }
                    _loc_5.clear();
                    _loc_4 = _loc_4 - 1;
                }
                delete masterList[param1];
            }
            return;
        }// end function

        static function killGarbage(event:TimerEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = masterList;
            for (_loc_3 in _loc_2)
            {
                
                if (_loc_2[_loc_3].length == 0)
                {
                    delete _loc_2[_loc_3];
                }
            }
            return;
        }// end function

        public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_5 * (param1 - 2) + param2;
        }// end function

        public static function tintProxy(param1:Object, param2:Number = 0) : void
        {
            var _loc_3:* = param1.target.progress;
            var _loc_4:* = 1 - _loc_3;
            var _loc_5:* = param1.info.color;
            var _loc_6:* = param1.info.endColor;
            param1.info.target.transform.colorTransform = new ColorTransform(_loc_5.redMultiplier * _loc_4 + _loc_6.redMultiplier * _loc_3, _loc_5.greenMultiplier * _loc_4 + _loc_6.greenMultiplier * _loc_3, _loc_5.blueMultiplier * _loc_4 + _loc_6.blueMultiplier * _loc_3, _loc_5.alphaMultiplier * _loc_4 + _loc_6.alphaMultiplier * _loc_3, _loc_5.redOffset * _loc_4 + _loc_6.redOffset * _loc_3, _loc_5.greenOffset * _loc_4 + _loc_6.greenOffset * _loc_3, _loc_5.blueOffset * _loc_4 + _loc_6.blueOffset * _loc_3, _loc_5.alphaOffset * _loc_4 + _loc_6.alphaOffset * _loc_3);
            return;
        }// end function

        public static function frameProxy(param1:Object, param2:Number = 0) : void
        {
            param1.info.target.gotoAndStop(Math.round(param1.target.frame));
            return;
        }// end function

        public static function volumeProxy(param1:Object, param2:Number = 0) : void
        {
            param1.info.target.soundTransform = param1.target;
            return;
        }// end function

        public static function visibleProxy(param1:Object, param2:Number) : void
        {
            var _loc_3:* = param1.info.tween;
            if (_loc_3.duration == param2)
            {
                if (_loc_3.vars.runBackwards != true && _loc_3.ease == _loc_3.vars.ease)
                {
                    _loc_3.target.visible = _loc_3.vars.visible;
                }
            }
            else if (_loc_3.target.visible != true)
            {
                _loc_3.target.visible = true;
            }
            return;
        }// end function

    }
}
