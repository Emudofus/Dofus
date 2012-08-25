package gs
{
    import com.ankamagames.tubul.interfaces.*;
    import flash.events.*;
    import flash.utils.*;
    import gs.events.*;

    public class TweenMax extends TweenFilterLite implements IEventDispatcher
    {
        protected var _dispatcher:EventDispatcher;
        protected var _callbacks:Object;
        protected var _repeatCount:Number;
        public var pauseTime:Number;
        public static var version:Number = 3.51;
        static const _RAD2DEG:Number = 57.2958;
        private static var _overwriteMode:int = OverwriteManager.enabled ? (OverwriteManager.mode) : (OverwriteManager.init());
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var removeTween:Function = TweenLite.removeTween;
        public static var setGlobalTimeScale:Function = TweenFilterLite.setGlobalTimeScale;
        static var _pausedTweens:Dictionary = new Dictionary(false);

        public function TweenMax(param1:Object, param2:Number, param3:Object)
        {
            super(param1, param2, param3);
            if (this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null)
            {
                this.initDispatcher();
                if (param2 == 0 && this.delay == 0)
                {
                    this.onUpdateDispatcher();
                    this.onCompleteDispatcher();
                }
            }
            this._repeatCount = 0;
            if (!isNaN(this.vars.yoyo) || !isNaN(this.vars.loop))
            {
                this.vars.persist = true;
            }
            if (TweenFilterLite.version < 9.29)
            {
                trace("TweenMax error! Please update your TweenFilterLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
            }
            return;
        }// end function

        override public function initTweenVals(param1:Boolean = false, param2:String = "") : void
        {
            var _loc_3:String = null;
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_7:Array = null;
            var _loc_9:Number = NaN;
            param2 = param2 + " hexColors bezier bezierThrough shortRotation orientToBezier quaternions onCompleteAll onCompleteAllParams yoyo loop onCompleteListener onUpdateListener onStartListener ";
            if (!param1 && TweenLite.overwriteManager.enabled)
            {
                TweenLite.overwriteManager.manageOverwrites(this, masterList[this.target]);
            }
            var _loc_8:* = bezierProxy;
            if (this.vars.orientToBezier == true)
            {
                this.vars.orientToBezier = [["x", "y", "rotation", 0]];
                _loc_8 = bezierProxy2;
            }
            else if (this.vars.orientToBezier is Array)
            {
                _loc_8 = bezierProxy2;
            }
            if (this.vars.bezier != undefined && this.vars.bezier is Array)
            {
                _loc_6 = {};
                _loc_7 = this.vars.bezier;
                _loc_4 = 0;
                while (_loc_4 < _loc_7.length)
                {
                    
                    for (_loc_3 in _loc_7[_loc_4])
                    {
                        
                        if (_loc_6[_loc_3] == undefined)
                        {
                            _loc_6[_loc_3] = [this.target[_loc_3]];
                        }
                        if (typeof(_loc_7[_loc_4][_loc_3]) == "number")
                        {
                            _loc_6[_loc_3].push(_loc_7[_loc_4][_loc_3]);
                            continue;
                        }
                        _loc_6[_loc_3].push(this.target[_loc_3] + Number(_loc_7[_loc_4][_loc_3]));
                    }
                    _loc_4++;
                }
                for (_loc_3 in _loc_6)
                {
                    
                    if (typeof(this.vars[_loc_3]) == "number")
                    {
                        _loc_6[_loc_3].push(this.vars[_loc_3]);
                    }
                    else
                    {
                        _loc_6[_loc_3].push(this.target[_loc_3] + Number(this.vars[_loc_3]));
                    }
                    delete this.vars[_loc_3];
                }
                addSubTween("bezier", _loc_8, {t:0}, {t:1}, {props:parseBeziers(_loc_6, false), target:this.target, orientToBezier:this.vars.orientToBezier});
            }
            if (this.vars.bezierThrough != undefined && this.vars.bezierThrough is Array)
            {
                _loc_6 = {};
                _loc_7 = this.vars.bezierThrough;
                _loc_4 = 0;
                while (_loc_4 < _loc_7.length)
                {
                    
                    for (_loc_3 in _loc_7[_loc_4])
                    {
                        
                        if (_loc_6[_loc_3] == undefined)
                        {
                            _loc_6[_loc_3] = [this.target[_loc_3]];
                        }
                        if (typeof(_loc_7[_loc_4][_loc_3]) == "number")
                        {
                            _loc_6[_loc_3].push(_loc_7[_loc_4][_loc_3]);
                            continue;
                        }
                        _loc_6[_loc_3].push(this.target[_loc_3] + Number(_loc_7[_loc_4][_loc_3]));
                    }
                    _loc_4++;
                }
                for (_loc_3 in _loc_6)
                {
                    
                    if (typeof(this.vars[_loc_3]) == "number")
                    {
                        _loc_6[_loc_3].push(this.vars[_loc_3]);
                    }
                    else
                    {
                        _loc_6[_loc_3].push(this.target[_loc_3] + Number(this.vars[_loc_3]));
                    }
                    delete this.vars[_loc_3];
                }
                addSubTween("bezierThrough", _loc_8, {t:0}, {t:1}, {props:parseBeziers(_loc_6, true), target:this.target, orientToBezier:this.vars.orientToBezier});
            }
            if (!isNaN(this.vars.shortRotation))
            {
                _loc_9 = (this.vars.shortRotation - this.target.rotation) % 360;
                if ((this.vars.shortRotation - this.target.rotation) % 360 != _loc_9 % 180)
                {
                    _loc_9 = _loc_9 < 0 ? (_loc_9 + 360) : (_loc_9 - 360);
                }
                this.tweens[this.tweens.length] = [this.target, "rotation", this.target.rotation, _loc_9, "rotation"];
            }
            if (this.vars.hexColors != undefined && typeof(this.vars.hexColors) == "object")
            {
                for (_loc_3 in this.vars.hexColors)
                {
                    
                    addSubTween("hexColors", hexColorsProxy, {r:this.target[_loc_3] >> 16, g:this.target[_loc_3] >> 8 & 255, b:this.target[_loc_3] & 255}, {r:this.vars.hexColors[_loc_3] >> 16, g:this.vars.hexColors[_loc_3] >> 8 & 255, b:this.vars.hexColors[_loc_3] & 255}, {prop:_loc_3, target:this.target});
                }
            }
            super.initTweenVals(true, param2);
            return;
        }// end function

        public function pause() : void
        {
            if (isNaN(this.pauseTime))
            {
                this.pauseTime = currentTime;
                this.startTime = 999999999999999;
                this.enabled = false;
                _pausedTweens[this] = this;
            }
            return;
        }// end function

        public function resume() : void
        {
            this.enabled = true;
            if (!isNaN(this.pauseTime))
            {
                this.initTime = this.initTime + (currentTime - this.pauseTime);
                this.startTime = this.initTime + this.delay * (1000 / this.combinedTimeScale);
                this.pauseTime = NaN;
                if (!this.started && currentTime >= this.startTime)
                {
                    activate();
                }
                else
                {
                    this.active = this.started;
                }
                _pausedTweens[this] = null;
                delete _pausedTweens[this];
            }
            return;
        }// end function

        public function restart(param1:Boolean = false) : void
        {
            if (param1)
            {
                this.initTime = currentTime;
                this.startTime = currentTime + this.delay * (1000 / this.combinedTimeScale);
            }
            else
            {
                this.startTime = currentTime;
                this.initTime = currentTime - this.delay * (1000 / this.combinedTimeScale);
            }
            this._repeatCount = 0;
            if (this.target != this.vars.onComplete)
            {
                render(this.startTime);
            }
            this.pauseTime = NaN;
            _pausedTweens[this] = null;
            delete _pausedTweens[this];
            this.enabled = true;
            return;
        }// end function

        public function reverse(param1:Boolean = true, param2:Boolean = true) : void
        {
            this.ease = this.vars.ease == this.ease ? (this.reverseEase) : (this.vars.ease);
            var _loc_3:* = this.progress;
            if (param1 && _loc_3 > 0)
            {
                this.startTime = currentTime - (1 - _loc_3) * this.duration * 1000 / this.combinedTimeScale;
                this.initTime = this.startTime - this.delay * (1000 / this.combinedTimeScale);
            }
            if (param2 != false)
            {
                if (_loc_3 < 1)
                {
                    this.resume();
                }
                else
                {
                    this.restart();
                }
            }
            return;
        }// end function

        public function reverseEase(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return this.vars.ease(param4 - param1, param2, param3, param4);
        }// end function

        public function invalidate(param1:Boolean = true) : void
        {
            var _loc_2:Number = NaN;
            if (this.initted)
            {
                _loc_2 = this.progress;
                if (!param1 && _loc_2 != 0)
                {
                    this.progress = 0;
                }
                this.tweens = [];
                _subTweens = [];
                _specialVars = this.vars.isTV == true ? (this.vars.exposedProps) : (this.vars);
                this.initTweenVals();
                _timeScale = this.vars.timeScale || 1;
                this.combinedTimeScale = _timeScale * _globalTimeScale;
                this.delay = this.vars.delay || 0;
                if (isNaN(this.pauseTime))
                {
                    this.startTime = this.initTime + this.delay * 1000 / this.combinedTimeScale;
                }
                if (this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null)
                {
                    if (this._dispatcher != null)
                    {
                        this.vars.onStart = this._callbacks.onStart;
                        this.vars.onUpdate = this._callbacks.onUpdate;
                        this.vars.onComplete = this._callbacks.onComplete;
                        this._dispatcher = null;
                    }
                    this.initDispatcher();
                }
                if (_loc_2 != 0)
                {
                    if (param1)
                    {
                        this.adjustStartValues();
                    }
                    else
                    {
                        this.progress = _loc_2;
                    }
                }
            }
            return;
        }// end function

        public function setDestination(param1:String, param2, param3:Boolean = true) : void
        {
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_9:Array = null;
            var _loc_4:* = this.progress;
            if (this.vars[param1] != undefined && this.initted)
            {
                if (!param3 && _loc_4 != 0)
                {
                    _loc_6 = this.tweens.length - 1;
                    while (_loc_6 > -1)
                    {
                        
                        if (this.tweens[_loc_6][4] == param1)
                        {
                            this.tweens[_loc_6][0][this.tweens[_loc_6][1]] = this.tweens[_loc_6][2];
                        }
                        _loc_6 = _loc_6 - 1;
                    }
                }
                _loc_5 = {};
                _loc_5[param1] = 1;
                killVars(_loc_5);
            }
            this.vars[param1] = param2;
            if (this.initted)
            {
                _loc_7 = this.vars;
                _loc_8 = this.tweens;
                _loc_9 = _subTweens;
                this.vars = {};
                this.tweens = [];
                _subTweens = [];
                this.vars[param1] = param2;
                this.initTweenVals();
                if (this.ease != this.reverseEase && _loc_7.ease is Function)
                {
                    this.ease = _loc_7.ease;
                }
                if (param3 && _loc_4 != 0)
                {
                    this.adjustStartValues();
                }
                this.vars = _loc_7;
                this.tweens = _loc_8.concat(this.tweens);
                _subTweens = _loc_9.concat(_subTweens);
            }
            return;
        }// end function

        protected function adjustStartValues() : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:Object = null;
            var _loc_5:int = 0;
            var _loc_1:* = this.progress;
            if (_loc_1 != 0)
            {
                _loc_2 = 1 / (1 - this.ease(_loc_1 * this.duration, 0, 1, this.duration));
                _loc_5 = this.tweens.length - 1;
                while (_loc_5 > -1)
                {
                    
                    _loc_4 = this.tweens[_loc_5];
                    _loc_3 = _loc_4[2] + _loc_4[3];
                    _loc_4[3] = (_loc_3 - _loc_4[0][_loc_4[1]]) * _loc_2;
                    _loc_4[2] = _loc_3 - _loc_4[3];
                    _loc_5 = _loc_5 - 1;
                }
            }
            return;
        }// end function

        public function killProperties(param1:Array) : void
        {
            var _loc_3:int = 0;
            var _loc_2:Object = {};
            _loc_3 = param1.length - 1;
            while (_loc_3 > -1)
            {
                
                if (this.vars[param1[_loc_3]] != null)
                {
                    _loc_2[param1[_loc_3]] = 1;
                }
                _loc_3 = _loc_3 - 1;
            }
            killVars(_loc_2);
            return;
        }// end function

        override public function complete(param1:Boolean = false) : void
        {
            if (!isNaN(this.vars.yoyo) && (this._repeatCount < this.vars.yoyo || this.vars.yoyo == 0) || !isNaN(this.vars.loop) && (this._repeatCount < this.vars.loop || this.vars.loop == 0))
            {
                var _loc_2:String = this;
                var _loc_3:* = this._repeatCount + 1;
                _loc_2._repeatCount = _loc_3;
                if (!isNaN(this.vars.yoyo))
                {
                    this.ease = this.vars.ease == this.ease ? (this.reverseEase) : (this.vars.ease);
                }
                this.startTime = param1 ? (this.startTime + this.duration * (1000 / this.combinedTimeScale)) : (currentTime);
                this.initTime = this.startTime - this.delay * (1000 / this.combinedTimeScale);
            }
            else if (this.vars.persist == true)
            {
                super.complete(param1);
                this.pause();
                return;
            }
            super.complete(param1);
            return;
        }// end function

        protected function initDispatcher() : void
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            if (this._dispatcher == null)
            {
                this._dispatcher = new EventDispatcher(this);
                this._callbacks = {onStart:this.vars.onStart, onUpdate:this.vars.onUpdate, onComplete:this.vars.onComplete};
                _loc_1 = {};
                for (_loc_2 in this.vars)
                {
                    
                    _loc_1[_loc_2] = this.vars[_loc_2];
                }
                this.vars = _loc_1;
                this.vars.onStart = this.onStartDispatcher;
                this.vars.onComplete = this.onCompleteDispatcher;
                if (this.vars.onStartListener is Function)
                {
                    this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
                }
                if (this.vars.onUpdateListener is Function)
                {
                    this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                    this.vars.onUpdate = this.onUpdateDispatcher;
                    _hasUpdate = true;
                }
                if (this.vars.onCompleteListener is Function)
                {
                    this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
                }
            }
            return;
        }// end function

        protected function onStartDispatcher(... args) : void
        {
            if (this._callbacks.onStart != null)
            {
                this._callbacks.onStart.apply(null, this.vars.onStartParams);
            }
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
            return;
        }// end function

        protected function onUpdateDispatcher(... args) : void
        {
            if (this._callbacks.onUpdate != null)
            {
                this._callbacks.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            return;
        }// end function

        protected function onCompleteDispatcher(... args) : void
        {
            if (this._callbacks.onComplete != null)
            {
                this._callbacks.onComplete.apply(null, this.vars.onCompleteParams);
            }
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (this._dispatcher == null)
            {
                this.initDispatcher();
            }
            if (param1 == TweenEvent.UPDATE && this.vars.onUpdate != this.onUpdateDispatcher)
            {
                this.vars.onUpdate = this.onUpdateDispatcher;
                _hasUpdate = true;
            }
            this._dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            if (this._dispatcher != null)
            {
                this._dispatcher.removeEventListener(param1, param2, param3);
            }
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            if (this._dispatcher == null)
            {
                return false;
            }
            return this._dispatcher.hasEventListener(param1);
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            if (this._dispatcher == null)
            {
                return false;
            }
            return this._dispatcher.willTrigger(param1);
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            if (this._dispatcher == null)
            {
                return false;
            }
            return this._dispatcher.dispatchEvent(event);
        }// end function

        public function get paused() : Boolean
        {
            return isNaN(this.pauseTime);
        }// end function

        public function set paused(param1:Boolean) : void
        {
            if (param1)
            {
                this.pause();
            }
            else
            {
                this.resume();
            }
            return;
        }// end function

        public function get reversed() : Boolean
        {
            return this.ease == this.reverseEase;
        }// end function

        public function set reversed(param1:Boolean) : void
        {
            if (this.reversed != param1)
            {
                this.reverse();
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (!param1)
            {
                _pausedTweens[this] = null;
                delete _pausedTweens[this];
            }
            super.enabled = param1;
            return;
        }// end function

        public function get progress() : Number
        {
            var _loc_1:* = !isNaN(this.pauseTime) ? (this.pauseTime) : (currentTime);
            var _loc_2:* = ((_loc_1 - this.initTime) * 0.001 - this.delay / this.combinedTimeScale) / this.duration * this.combinedTimeScale;
            if (_loc_2 > 1)
            {
                return 1;
            }
            if (_loc_2 < 0)
            {
                return 0;
            }
            return _loc_2;
        }// end function

        public function set progress(param1:Number) : void
        {
            this.startTime = currentTime - this.duration * param1 * 1000;
            this.initTime = this.startTime - this.delay * (1000 / this.combinedTimeScale);
            if (!this.started)
            {
                activate();
            }
            render(currentTime);
            if (!isNaN(this.pauseTime))
            {
                this.pauseTime = currentTime;
                this.startTime = 999999999999999;
                this.active = false;
            }
            return;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenMax
        {
            return new TweenMax(param1, param2, param3);
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenMax
        {
            param3.runBackwards = true;
            return new TweenMax(param1, param2, param3);
        }// end function

        public static function allTo(param1:Array, param2:Number, param3:Object) : Array
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            var _loc_7:Number = NaN;
            var _loc_8:Object = null;
            trace("WARNING: TweenMax.allTo() and TweenMax.allFrom() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include allTo() and allFrom() (to conserve file size).");
            if (param1.length == 0)
            {
                return [];
            }
            var _loc_9:Array = [];
            var _loc_10:* = param3.delayIncrement || 0;
            delete param3.delayIncrement;
            if (param3.onCompleteAll == undefined)
            {
                _loc_8 = param3;
            }
            else
            {
                _loc_8 = {};
                for (_loc_6 in param3)
                {
                    
                    _loc_8[_loc_6] = param3[_loc_6];
                }
                _loc_8.onCompleteParams = [[param3.onComplete, param3.onCompleteAll], [param3.onCompleteParams, param3.onCompleteAllParams]];
                _loc_8.onComplete = callbackProxy;
                delete param3.onCompleteAll;
            }
            delete param3.onCompleteAllParams;
            if (_loc_10 == 0)
            {
                _loc_4 = 0;
                while (_loc_4 < (param1.length - 1))
                {
                    
                    _loc_5 = {};
                    for (_loc_6 in param3)
                    {
                        
                        _loc_5[_loc_6] = param3[_loc_6];
                    }
                    _loc_9[_loc_9.length] = new TweenMax(param1[_loc_4], param2, _loc_5);
                    _loc_4++;
                }
            }
            else
            {
                _loc_7 = param3.delay || 0;
                _loc_4 = 0;
                while (_loc_4 < (param1.length - 1))
                {
                    
                    _loc_5 = {};
                    for (_loc_6 in param3)
                    {
                        
                        _loc_5[_loc_6] = param3[_loc_6];
                    }
                    _loc_5.delay = _loc_7 + _loc_4 * _loc_10;
                    _loc_9[_loc_9.length] = new TweenMax(param1[_loc_4], param2, _loc_5);
                    _loc_4++;
                }
                _loc_8.delay = _loc_7 + (param1.length - 1) * _loc_10;
            }
            _loc_9[_loc_9.length] = new TweenMax(param1[(param1.length - 1)], param2, _loc_8);
            if (param3.onCompleteAllListener is Function)
            {
                _loc_9[(_loc_9.length - 1)].addEventListener(TweenEvent.COMPLETE, param3.onCompleteAllListener);
            }
            return _loc_9;
        }// end function

        public static function allFrom(param1:Array, param2:Number, param3:Object) : Array
        {
            param3.runBackwards = true;
            return allTo(param1, param2, param3);
        }// end function

        public static function callbackProxy(param1:Array, param2:Array = null) : void
        {
            var _loc_3:uint = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3] != undefined)
                {
                    param1[_loc_3].apply(null, param2[_loc_3]);
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function sequence(param1:Object, param2:Array) : Array
        {
            var _loc_3:uint = 0;
            while (_loc_3 < param2.length)
            {
                
                param2[_loc_3].target = param1;
                _loc_3 = _loc_3 + 1;
            }
            return multiSequence(param2);
        }// end function

        public static function multiSequence(param1:Array) : Array
        {
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:Number = NaN;
            var _loc_9:Number = NaN;
            var _loc_10:uint = 0;
            var _loc_11:Object = null;
            var _loc_12:String = null;
            trace("WARNING: TweenMax.multiSequence() and TweenMax.sequence() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include sequence() and multiSequence() (to conserve file size).");
            var _loc_2:* = new Dictionary();
            var _loc_3:Array = [];
            var _loc_4:* = TweenLite.overwriteManager.mode;
            var _loc_5:Number = 0;
            _loc_10 = 0;
            while (_loc_10 < param1.length)
            {
                
                _loc_6 = param1[_loc_10];
                _loc_9 = _loc_6.time || 0;
                _loc_11 = {};
                for (_loc_12 in _loc_6)
                {
                    
                    _loc_11[_loc_12] = _loc_6[_loc_12];
                }
                delete _loc_11.time;
                _loc_8 = _loc_11.delay || 0;
                _loc_11.delay = _loc_5 + _loc_8;
                _loc_7 = _loc_11.target;
                delete _loc_11.target;
                if (_loc_4 == 1)
                {
                    if (_loc_2[_loc_7] == undefined)
                    {
                        _loc_2[_loc_7] = _loc_11;
                    }
                    else
                    {
                        _loc_11.overwrite = 2;
                    }
                }
                _loc_3[_loc_3.length] = new TweenMax(_loc_7, _loc_9, _loc_11);
                _loc_5 = _loc_5 + (_loc_9 + _loc_8);
                _loc_10 = _loc_10 + 1;
            }
            return _loc_3;
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenMax
        {
            return new TweenMax(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, persist:param4, overwrite:0});
        }// end function

        public static function parseBeziers(param1:Object, param2:Boolean = false) : Object
        {
            var _loc_3:int = 0;
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            var _loc_7:Object = {};
            if (param2)
            {
                for (_loc_6 in param1)
                {
                    
                    _loc_4 = param1[_loc_6];
                    var _loc_10:* = [];
                    _loc_5 = [];
                    _loc_7[_loc_6] = _loc_10;
                    if (_loc_4.length > 2)
                    {
                        _loc_5[_loc_5.length] = {s:_loc_4[0], cp:_loc_4[1] - (_loc_4[2] - _loc_4[0]) / 4, e:_loc_4[1]};
                        _loc_3 = 1;
                        while (_loc_3 < (_loc_4.length - 1))
                        {
                            
                            _loc_5[_loc_5.length] = {s:_loc_4[_loc_3], cp:_loc_4[_loc_3] + (_loc_4[_loc_3] - _loc_5[(_loc_3 - 1)].cp), e:_loc_4[(_loc_3 + 1)]};
                            _loc_3++;
                        }
                        continue;
                    }
                    _loc_5[_loc_5.length] = {s:_loc_4[0], cp:(_loc_4[0] + _loc_4[1]) / 2, e:_loc_4[1]};
                }
            }
            else
            {
                for (_loc_6 in param1)
                {
                    
                    _loc_4 = param1[_loc_6];
                    var _loc_10:* = [];
                    _loc_5 = [];
                    _loc_7[_loc_6] = _loc_10;
                    if (_loc_4.length > 3)
                    {
                        _loc_5[_loc_5.length] = {s:_loc_4[0], cp:_loc_4[1], e:(_loc_4[1] + _loc_4[2]) / 2};
                        _loc_3 = 2;
                        while (_loc_3 < _loc_4.length - 2)
                        {
                            
                            _loc_5[_loc_5.length] = {s:_loc_5[_loc_3 - 2].e, cp:_loc_4[_loc_3], e:(_loc_4[_loc_3] + _loc_4[(_loc_3 + 1)]) / 2};
                            _loc_3++;
                        }
                        _loc_5[_loc_5.length] = {s:_loc_5[(_loc_5.length - 1)].e, cp:_loc_4[_loc_4.length - 2], e:_loc_4[(_loc_4.length - 1)]};
                        continue;
                    }
                    if (_loc_4.length == 3)
                    {
                        _loc_5[_loc_5.length] = {s:_loc_4[0], cp:_loc_4[1], e:_loc_4[2]};
                        continue;
                    }
                    if (_loc_4.length == 2)
                    {
                        _loc_5[_loc_5.length] = {s:_loc_4[0], cp:(_loc_4[0] + _loc_4[1]) / 2, e:_loc_4[1]};
                    }
                }
            }
            return _loc_7;
        }// end function

        public static function getTweensOf(param1:Object) : Array
        {
            var _loc_4:TweenLite = null;
            var _loc_5:int = 0;
            var _loc_2:* = masterList[param1];
            var _loc_3:Array = [];
            if (_loc_2 != null)
            {
                _loc_5 = _loc_2.length - 1;
                while (_loc_5 > -1)
                {
                    
                    if (!_loc_2[_loc_5].gc)
                    {
                        _loc_3[_loc_3.length] = _loc_2[_loc_5];
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            for each (_loc_4 in _pausedTweens)
            {
                
                if (_loc_4.target == param1)
                {
                    _loc_3[_loc_3.length] = _loc_4;
                }
            }
            return _loc_3;
        }// end function

        public static function isTweening(param1:Object) : Boolean
        {
            var _loc_2:* = getTweensOf(param1);
            var _loc_3:* = _loc_2.length - 1;
            while (_loc_3 > -1)
            {
                
                if (_loc_2[_loc_3].active && !_loc_2[_loc_3].gc)
                {
                    return true;
                }
                _loc_3 = _loc_3 - 1;
            }
            return false;
        }// end function

        public static function getAllTweens() : Array
        {
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:TweenLite = null;
            var _loc_1:* = masterList;
            var _loc_2:Array = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = _loc_3.length - 1;
                while (_loc_4 > -1)
                {
                    
                    if (!_loc_3[_loc_4].gc)
                    {
                        _loc_2[_loc_2.length] = _loc_3[_loc_4];
                    }
                    _loc_4 = _loc_4 - 1;
                }
            }
            for each (_loc_5 in _pausedTweens)
            {
                
                _loc_2[_loc_2.length] = _loc_5;
            }
            return _loc_2;
        }// end function

        public static function killAllTweens(param1:Boolean = false) : void
        {
            killAll(param1, true, false);
            return;
        }// end function

        public static function killAllDelayedCalls(param1:Boolean = false) : void
        {
            killAll(param1, false, true);
            return;
        }// end function

        public static function killAll(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true) : void
        {
            var _loc_5:Boolean = false;
            var _loc_6:int = 0;
            var _loc_4:* = getAllTweens();
            _loc_6 = getAllTweens().length - 1;
            while (_loc_6 > -1)
            {
                
                _loc_5 = _loc_4[_loc_6].target == _loc_4[_loc_6].vars.onComplete;
                if (_loc_5 == param3 || _loc_5 != param2)
                {
                    if (param1)
                    {
                        _loc_4[_loc_6].complete(false);
                        _loc_4[_loc_6].clear();
                    }
                    else
                    {
                        TweenLite.removeTween(_loc_4[_loc_6], true);
                    }
                }
                _loc_6 = _loc_6 - 1;
            }
            return;
        }// end function

        public static function pauseAll(param1:Boolean = true, param2:Boolean = false) : void
        {
            changePause(true, param1, param2);
            return;
        }// end function

        public static function resumeAll(param1:Boolean = true, param2:Boolean = false) : void
        {
            changePause(false, param1, param2);
            return;
        }// end function

        public static function changePause(param1:Boolean, param2:Boolean = true, param3:Boolean = false) : void
        {
            var _loc_5:Boolean = false;
            var _loc_4:* = getAllTweens();
            var _loc_6:* = getAllTweens().length - 1;
            while (_loc_6 > -1)
            {
                
                _loc_5 = _loc_4[_loc_6].target == _loc_4[_loc_6].vars.onComplete;
                if (_loc_4[_loc_6] is  && (_loc_5 == param3 || _loc_5 != param2))
                {
                    _loc_4[_loc_6].paused = param1;
                }
                _loc_6 = _loc_6 - 1;
            }
            return;
        }// end function

        public static function hexColorsProxy(param1:Object, param2:Number = 0) : void
        {
            param1.info.target[param1.info.prop] = uint(param1.target.r << 16 | param1.target.g << 8 | param1.target.b);
            return;
        }// end function

        public static function bezierProxy(param1:Object, param2:Number = 0) : void
        {
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_8:Object = null;
            var _loc_9:Number = NaN;
            var _loc_10:uint = 0;
            var _loc_3:* = param1.target.t;
            var _loc_4:* = param1.info.props;
            var _loc_5:* = param1.info.target;
            if (_loc_3 == 1)
            {
                for (_loc_7 in _loc_4)
                {
                    
                    _loc_6 = _loc_4[_loc_7].length - 1;
                    _loc_5[_loc_7] = _loc_4[_loc_7][_loc_6].e;
                }
            }
            else
            {
                for (_loc_7 in _loc_4)
                {
                    
                    _loc_10 = _loc_4[_loc_7].length;
                    if (_loc_3 < 0)
                    {
                        _loc_6 = 0;
                    }
                    else if (_loc_3 >= 1)
                    {
                        _loc_6 = _loc_10 - 1;
                    }
                    else
                    {
                        _loc_6 = int(_loc_10 * _loc_3);
                    }
                    _loc_9 = (_loc_3 - _loc_6 * (1 / _loc_10)) * _loc_10;
                    _loc_8 = _loc_4[_loc_7][_loc_6];
                    _loc_5[_loc_7] = _loc_8.s + _loc_9 * (2 * (1 - _loc_9) * (_loc_8.cp - _loc_8.s) + _loc_9 * (_loc_8.e - _loc_8.s));
                }
            }
            return;
        }// end function

        public static function bezierProxy2(param1:Object, param2:Number = 0) : void
        {
            var _loc_6:Number = NaN;
            var _loc_7:Number = NaN;
            var _loc_8:Number = NaN;
            var _loc_9:Array = null;
            var _loc_10:Number = NaN;
            bezierProxy(param1, param2);
            var _loc_3:Object = {};
            var _loc_4:* = param1.info.target;
            param1.info.target = _loc_3;
            param1.target.t = param1.target.t + 0.01;
            bezierProxy(param1);
            var _loc_5:* = param1.info.orientToBezier;
            var _loc_11:uint = 0;
            while (_loc_11 < _loc_5.length)
            {
                
                _loc_9 = _loc_5[_loc_11];
                _loc_10 = _loc_9[3] || 0;
                _loc_7 = _loc_3[_loc_9[0]] - _loc_4[_loc_9[0]];
                _loc_8 = _loc_3[_loc_9[1]] - _loc_4[_loc_9[1]];
                _loc_4[_loc_9[2]] = Math.atan2(_loc_8, _loc_7) * _RAD2DEG + _loc_10;
                _loc_11 = _loc_11 + 1;
            }
            param1.info.target = _loc_4;
            param1.target.t = param1.target.t - 0.01;
            return;
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
