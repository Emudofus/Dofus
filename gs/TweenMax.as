package gs
{
   import flash.events.IEventDispatcher;
   import flash.utils.*;
   import gs.events.TweenEvent;
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class TweenMax extends TweenFilterLite implements IEventDispatcher
   {
      
      public function TweenMax(param1:Object, param2:Number, param3:Object) {
         super(param1,param2,param3);
         if(!(this.vars.onCompleteListener == null) || !(this.vars.onUpdateListener == null) || !(this.vars.onStartListener == null))
         {
            this.initDispatcher();
            if(param2 == 0 && this.delay == 0)
            {
               this.onUpdateDispatcher();
               this.onCompleteDispatcher();
            }
         }
         this._repeatCount = 0;
         if(!isNaN(this.vars.yoyo) || !isNaN(this.vars.loop))
         {
            this.vars.persist = true;
         }
         if(TweenFilterLite.version < 9.29)
         {
            trace("TweenMax error! Please update your TweenFilterLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
         }
      }
      
      public static var version:Number = 3.51;
      
      protected static const _RAD2DEG:Number = 180 / Math.PI;
      
      private static var _overwriteMode:int = OverwriteManager.enabled?OverwriteManager.mode:OverwriteManager.init();
      
      public static var killTweensOf:Function = TweenLite.killTweensOf;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var removeTween:Function = TweenLite.removeTween;
      
      public static var setGlobalTimeScale:Function = TweenFilterLite.setGlobalTimeScale;
      
      protected static var _pausedTweens:Dictionary = new Dictionary(false);
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenMax {
         return new TweenMax(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenMax {
         param3.runBackwards = true;
         return new TweenMax(param1,param2,param3);
      }
      
      public static function allTo(param1:Array, param2:Number, param3:Object) : Array {
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:Object = null;
         trace("WARNING: TweenMax.allTo() and TweenMax.allFrom() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include allTo() and allFrom() (to conserve file size).");
         if(param1.length == 0)
         {
            return [];
         }
         var _loc9_:Array = [];
         var _loc10_:Number = (param3.delayIncrement) || (0);
         delete param3[delayIncrement];
         if(param3.onCompleteAll == undefined)
         {
            _loc8_ = param3;
         }
         else
         {
            _loc8_ = {};
            for (_loc6_ in param3)
            {
               _loc8_[_loc6_] = param3[_loc6_];
            }
            _loc8_.onCompleteParams = [[param3.onComplete,param3.onCompleteAll],[param3.onCompleteParams,param3.onCompleteAllParams]];
            _loc8_.onComplete = TweenMax.callbackProxy;
            delete param3[onCompleteAll];
         }
         delete param3[onCompleteAllParams];
         if(_loc10_ == 0)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length-1)
            {
               _loc5_ = {};
               for (_loc6_ in param3)
               {
                  _loc5_[_loc6_] = param3[_loc6_];
               }
               _loc9_[_loc9_.length] = new TweenMax(param1[_loc4_],param2,_loc5_);
               _loc4_++;
            }
         }
         else
         {
            _loc7_ = (param3.delay) || (0);
            _loc4_ = 0;
            while(_loc4_ < param1.length-1)
            {
               _loc5_ = {};
               for (_loc6_ in param3)
               {
                  _loc5_[_loc6_] = param3[_loc6_];
               }
               _loc5_.delay = _loc7_ + _loc4_ * _loc10_;
               _loc9_[_loc9_.length] = new TweenMax(param1[_loc4_],param2,_loc5_);
               _loc4_++;
            }
            _loc8_.delay = _loc7_ + (param1.length-1) * _loc10_;
         }
         _loc9_[_loc9_.length] = new TweenMax(param1[param1.length-1],param2,_loc8_);
         if(param3.onCompleteAllListener is Function)
         {
            _loc9_[_loc9_.length-1].addEventListener(TweenEvent.COMPLETE,param3.onCompleteAllListener);
         }
         return _loc9_;
      }
      
      public static function allFrom(param1:Array, param2:Number, param3:Object) : Array {
         param3.runBackwards = true;
         return allTo(param1,param2,param3);
      }
      
      public static function callbackProxy(param1:Array, param2:Array=null) : void {
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != undefined)
            {
               param1[_loc3_].apply(null,param2[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      public static function sequence(param1:Object, param2:Array) : Array {
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            param2[_loc3_].target = param1;
            _loc3_++;
         }
         return multiSequence(param2);
      }
      
      public static function multiSequence(param1:Array) : Array {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:uint = 0;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         trace("WARNING: TweenMax.multiSequence() and TweenMax.sequence() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include sequence() and multiSequence() (to conserve file size).");
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:Array = [];
         var _loc4_:int = TweenLite.overwriteManager.mode;
         var _loc5_:Number = 0;
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc6_ = param1[_loc10_];
            _loc9_ = (_loc6_.time) || (0);
            _loc11_ = {};
            for (_loc12_ in _loc6_)
            {
               _loc11_[_loc12_] = _loc6_[_loc12_];
            }
            delete _loc11_[time];
            _loc8_ = (_loc11_.delay) || (0);
            _loc11_.delay = _loc5_ + _loc8_;
            _loc7_ = _loc11_.target;
            delete _loc11_[target];
            if(_loc4_ == 1)
            {
               if(_loc2_[_loc7_] == undefined)
               {
                  _loc2_[_loc7_] = _loc11_;
               }
               else
               {
                  _loc11_.overwrite = 2;
               }
            }
            _loc3_[_loc3_.length] = new TweenMax(_loc7_,_loc9_,_loc11_);
            _loc5_ = _loc5_ + (_loc9_ + _loc8_);
            _loc10_++;
         }
         return _loc3_;
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array=null, param4:Boolean=false) : TweenMax {
         return new TweenMax(param2,0,
            {
               "delay":param1,
               "onComplete":param2,
               "onCompleteParams":param3,
               "persist":param4,
               "overwrite":0
            });
      }
      
      public static function parseBeziers(param1:Object, param2:Boolean=false) : Object {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:Object = {};
         if(param2)
         {
            for (_loc6_ in param1)
            {
               _loc4_ = param1[_loc6_];
               _loc7_[_loc6_] = _loc5_ = [];
               if(_loc4_.length > 2)
               {
                  _loc5_[_loc5_.length] = 
                     {
                        "s":_loc4_[0],
                        "cp":_loc4_[1] - (_loc4_[2] - _loc4_[0]) / 4,
                        "e":_loc4_[1]
                     };
                  _loc3_ = 1;
                  while(_loc3_ < _loc4_.length-1)
                  {
                     _loc5_[_loc5_.length] = 
                        {
                           "s":_loc4_[_loc3_],
                           "cp":_loc4_[_loc3_] + (_loc4_[_loc3_] - _loc5_[_loc3_-1].cp),
                           "e":_loc4_[_loc3_ + 1]
                        };
                     _loc3_++;
                  }
               }
               else
               {
                  _loc5_[_loc5_.length] = 
                     {
                        "s":_loc4_[0],
                        "cp":(_loc4_[0] + _loc4_[1]) / 2,
                        "e":_loc4_[1]
                     };
               }
            }
         }
         else
         {
            for (_loc6_ in param1)
            {
               _loc4_ = param1[_loc6_];
               _loc7_[_loc6_] = _loc5_ = [];
               if(_loc4_.length > 3)
               {
                  _loc5_[_loc5_.length] = 
                     {
                        "s":_loc4_[0],
                        "cp":_loc4_[1],
                        "e":(_loc4_[1] + _loc4_[2]) / 2
                     };
                  _loc3_ = 2;
                  while(_loc3_ < _loc4_.length - 2)
                  {
                     _loc5_[_loc5_.length] = 
                        {
                           "s":_loc5_[_loc3_ - 2].e,
                           "cp":_loc4_[_loc3_],
                           "e":(_loc4_[_loc3_] + _loc4_[_loc3_ + 1]) / 2
                        };
                     _loc3_++;
                  }
                  _loc5_[_loc5_.length] = 
                     {
                        "s":_loc5_[_loc5_.length-1].e,
                        "cp":_loc4_[_loc4_.length - 2],
                        "e":_loc4_[_loc4_.length-1]
                     };
               }
               else
               {
                  if(_loc4_.length == 3)
                  {
                     _loc5_[_loc5_.length] = 
                        {
                           "s":_loc4_[0],
                           "cp":_loc4_[1],
                           "e":_loc4_[2]
                        };
                  }
                  else
                  {
                     if(_loc4_.length == 2)
                     {
                        _loc5_[_loc5_.length] = 
                           {
                              "s":_loc4_[0],
                              "cp":(_loc4_[0] + _loc4_[1]) / 2,
                              "e":_loc4_[1]
                           };
                     }
                  }
               }
            }
         }
         return _loc7_;
      }
      
      public static function getTweensOf(param1:Object) : Array {
         var _loc4_:TweenLite = null;
         var _loc5_:* = 0;
         var _loc2_:Array = masterList[param1];
         var _loc3_:Array = [];
         if(_loc2_ != null)
         {
            _loc5_ = _loc2_.length-1;
            while(_loc5_ > -1)
            {
               if(!_loc2_[_loc5_].gc)
               {
                  _loc3_[_loc3_.length] = _loc2_[_loc5_];
               }
               _loc5_--;
            }
         }
         for each (_loc4_ in _pausedTweens)
         {
            if(_loc4_.target == param1)
            {
               _loc3_[_loc3_.length] = _loc4_;
            }
         }
         return _loc3_;
      }
      
      public static function isTweening(param1:Object) : Boolean {
         var _loc2_:Array = getTweensOf(param1);
         var _loc3_:int = _loc2_.length-1;
         while(_loc3_ > -1)
         {
            if((_loc2_[_loc3_].active) && !_loc2_[_loc3_].gc)
            {
               return true;
            }
            _loc3_--;
         }
         return false;
      }
      
      public static function getAllTweens() : Array {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:TweenLite = null;
         var _loc1_:Dictionary = masterList;
         var _loc2_:Array = [];
         for each (_loc3_ in _loc1_)
         {
            _loc4_ = _loc3_.length-1;
            while(_loc4_ > -1)
            {
               if(!_loc3_[_loc4_].gc)
               {
                  _loc2_[_loc2_.length] = _loc3_[_loc4_];
               }
               _loc4_--;
            }
         }
         for each (_loc2_[_loc2_.length] in _pausedTweens)
         {
         }
         return _loc2_;
      }
      
      public static function killAllTweens(param1:Boolean=false) : void {
         killAll(param1,true,false);
      }
      
      public static function killAllDelayedCalls(param1:Boolean=false) : void {
         killAll(param1,false,true);
      }
      
      public static function killAll(param1:Boolean=false, param2:Boolean=true, param3:Boolean=true) : void {
         var _loc5_:* = false;
         var _loc6_:* = 0;
         var _loc4_:Array = getAllTweens();
         _loc6_ = _loc4_.length-1;
         while(_loc6_ > -1)
         {
            _loc5_ = _loc4_[_loc6_].target == _loc4_[_loc6_].vars.onComplete;
            if(_loc5_ == param3 || !(_loc5_ == param2))
            {
               if(param1)
               {
                  _loc4_[_loc6_].complete(false);
                  _loc4_[_loc6_].clear();
               }
               else
               {
                  TweenLite.removeTween(_loc4_[_loc6_],true);
               }
            }
            _loc6_--;
         }
      }
      
      public static function pauseAll(param1:Boolean=true, param2:Boolean=false) : void {
         changePause(true,param1,param2);
      }
      
      public static function resumeAll(param1:Boolean=true, param2:Boolean=false) : void {
         changePause(false,param1,param2);
      }
      
      public static function changePause(param1:Boolean, param2:Boolean=true, param3:Boolean=false) : void {
         var _loc5_:* = false;
         var _loc4_:Array = getAllTweens();
         var _loc6_:int = _loc4_.length-1;
         while(_loc6_ > -1)
         {
            _loc5_ = _loc4_[_loc6_].target == _loc4_[_loc6_].vars.onComplete;
            if(_loc4_[_loc6_] is TweenMax && (_loc5_ == param3 || !(_loc5_ == param2)))
            {
               _loc4_[_loc6_].paused = param1;
            }
            _loc6_--;
         }
      }
      
      public static function hexColorsProxy(param1:Object, param2:Number=0) : void {
         param1.info.target[param1.info.prop] = uint(param1.target.r << 16 | param1.target.g << 8 | param1.target.b);
      }
      
      public static function bezierProxy(param1:Object, param2:Number=0) : void {
         var _loc6_:* = 0;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:* = NaN;
         var _loc10_:uint = 0;
         var _loc3_:Number = param1.target.t;
         var _loc4_:Object = param1.info.props;
         var _loc5_:Object = param1.info.target;
         if(_loc3_ == 1)
         {
            for (_loc7_ in _loc4_)
            {
               _loc6_ = _loc4_[_loc7_].length-1;
               _loc5_[_loc7_] = _loc4_[_loc7_][_loc6_].e;
            }
         }
         else
         {
            for (_loc7_ in _loc4_)
            {
               _loc10_ = _loc4_[_loc7_].length;
               if(_loc3_ < 0)
               {
                  _loc6_ = 0;
               }
               else
               {
                  if(_loc3_ >= 1)
                  {
                     _loc6_ = _loc10_-1;
                  }
                  else
                  {
                     _loc6_ = int(_loc10_ * _loc3_);
                  }
               }
               _loc9_ = (_loc3_ - _loc6_ * 1 / _loc10_) * _loc10_;
               _loc8_ = _loc4_[_loc7_][_loc6_];
               _loc5_[_loc7_] = _loc8_.s + _loc9_ * (2 * (1 - _loc9_) * (_loc8_.cp - _loc8_.s) + _loc9_ * (_loc8_.e - _loc8_.s));
            }
         }
      }
      
      public static function bezierProxy2(param1:Object, param2:Number=0) : void {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:Array = null;
         var _loc10_:* = NaN;
         bezierProxy(param1,param2);
         var _loc3_:Object = {};
         var _loc4_:Object = param1.info.target;
         param1.info.target = _loc3_;
         param1.target.t = param1.target.t + 0.01;
         bezierProxy(param1);
         var _loc5_:Array = param1.info.orientToBezier;
         var _loc11_:uint = 0;
         while(_loc11_ < _loc5_.length)
         {
            _loc9_ = _loc5_[_loc11_];
            _loc10_ = (_loc9_[3]) || (0);
            _loc7_ = _loc3_[_loc9_[0]] - _loc4_[_loc9_[0]];
            _loc8_ = _loc3_[_loc9_[1]] - _loc4_[_loc9_[1]];
            _loc4_[_loc9_[2]] = Math.atan2(_loc8_,_loc7_) * _RAD2DEG + _loc10_;
            _loc11_++;
         }
         param1.info.target = _loc4_;
         param1.target.t = param1.target.t - 0.01;
      }
      
      public static function set globalTimeScale(param1:Number) : void {
         setGlobalTimeScale(param1);
      }
      
      public static function get globalTimeScale() : Number {
         return _globalTimeScale;
      }
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _callbacks:Object;
      
      protected var _repeatCount:Number;
      
      public var pauseTime:Number;
      
      override public function initTweenVals(param1:Boolean=false, param2:String="") : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function pause() : void {
         if(isNaN(this.pauseTime))
         {
            this.pauseTime = currentTime;
            this.startTime = 9.99999999999999E14;
            this.enabled = false;
            _pausedTweens[this] = this;
         }
      }
      
      public function resume() : void {
         this.enabled = true;
         if(!isNaN(this.pauseTime))
         {
            this.initTime = this.initTime + (currentTime - this.pauseTime);
            this.startTime = this.initTime + this.delay * 1000 / this.combinedTimeScale;
            this.pauseTime = NaN;
            if(!this.started && currentTime >= this.startTime)
            {
               activate();
            }
            else
            {
               this.active = this.started;
            }
            _pausedTweens[this] = null;
            delete _pausedTweens[[this]];
         }
      }
      
      public function restart(param1:Boolean=false) : void {
         if(param1)
         {
            this.initTime = currentTime;
            this.startTime = currentTime + this.delay * 1000 / this.combinedTimeScale;
         }
         else
         {
            this.startTime = currentTime;
            this.initTime = currentTime - this.delay * 1000 / this.combinedTimeScale;
         }
         this._repeatCount = 0;
         if(this.target != this.vars.onComplete)
         {
            render(this.startTime);
         }
         this.pauseTime = NaN;
         _pausedTweens[this] = null;
         delete _pausedTweens[[this]];
         this.enabled = true;
      }
      
      public function reverse(param1:Boolean=true, param2:Boolean=true) : void {
         this.ease = this.vars.ease == this.ease?this.reverseEase:this.vars.ease;
         var _loc3_:Number = this.progress;
         if((param1) && _loc3_ > 0)
         {
            this.startTime = currentTime - (1 - _loc3_) * this.duration * 1000 / this.combinedTimeScale;
            this.initTime = this.startTime - this.delay * 1000 / this.combinedTimeScale;
         }
         if(param2 != false)
         {
            if(_loc3_ < 1)
            {
               this.resume();
            }
            else
            {
               this.restart();
            }
         }
      }
      
      public function reverseEase(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         return this.vars.ease(param4 - param1,param2,param3,param4);
      }
      
      public function invalidate(param1:Boolean=true) : void {
         var _loc2_:* = NaN;
         if(this.initted)
         {
            _loc2_ = this.progress;
            if(!param1 && !(_loc2_ == 0))
            {
               this.progress = 0;
            }
            this.tweens = [];
            _subTweens = [];
            _specialVars = this.vars.isTV == true?this.vars.exposedProps:this.vars;
            this.initTweenVals();
            _timeScale = (this.vars.timeScale) || (1);
            this.combinedTimeScale = _timeScale * _globalTimeScale;
            this.delay = (this.vars.delay) || (0);
            if(isNaN(this.pauseTime))
            {
               this.startTime = this.initTime + this.delay * 1000 / this.combinedTimeScale;
            }
            if(!(this.vars.onCompleteListener == null) || !(this.vars.onUpdateListener == null) || !(this.vars.onStartListener == null))
            {
               if(this._dispatcher != null)
               {
                  this.vars.onStart = this._callbacks.onStart;
                  this.vars.onUpdate = this._callbacks.onUpdate;
                  this.vars.onComplete = this._callbacks.onComplete;
                  this._dispatcher = null;
               }
               this.initDispatcher();
            }
            if(_loc2_ != 0)
            {
               if(param1)
               {
                  this.adjustStartValues();
               }
               else
               {
                  this.progress = _loc2_;
               }
            }
         }
      }
      
      public function setDestination(param1:String, param2:*, param3:Boolean=true) : void {
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc4_:Number = this.progress;
         if(!(this.vars[param1] == undefined) && (this.initted))
         {
            if(!param3 && !(_loc4_ == 0))
            {
               _loc6_ = this.tweens.length-1;
               while(_loc6_ > -1)
               {
                  if(this.tweens[_loc6_][4] == param1)
                  {
                     this.tweens[_loc6_][0][this.tweens[_loc6_][1]] = this.tweens[_loc6_][2];
                  }
                  _loc6_--;
               }
            }
            _loc5_ = {};
            _loc5_[param1] = 1;
            killVars(_loc5_);
         }
         this.vars[param1] = param2;
         if(this.initted)
         {
            _loc7_ = this.vars;
            _loc8_ = this.tweens;
            _loc9_ = _subTweens;
            this.vars = {};
            this.tweens = [];
            _subTweens = [];
            this.vars[param1] = param2;
            this.initTweenVals();
            if(!(this.ease == this.reverseEase) && _loc7_.ease is Function)
            {
               this.ease = _loc7_.ease;
            }
            if((param3) && !(_loc4_ == 0))
            {
               this.adjustStartValues();
            }
            this.vars = _loc7_;
            this.tweens = _loc8_.concat(this.tweens);
            _subTweens = _loc9_.concat(_subTweens);
         }
      }
      
      protected function adjustStartValues() : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         var _loc1_:Number = this.progress;
         if(_loc1_ != 0)
         {
            _loc2_ = 1 / (1 - this.ease(_loc1_ * this.duration,0,1,this.duration));
            _loc5_ = this.tweens.length-1;
            while(_loc5_ > -1)
            {
               _loc4_ = this.tweens[_loc5_];
               _loc3_ = _loc4_[2] + _loc4_[3];
               _loc4_[3] = (_loc3_ - _loc4_[0][_loc4_[1]]) * _loc2_;
               _loc4_[2] = _loc3_ - _loc4_[3];
               _loc5_--;
            }
         }
      }
      
      public function killProperties(param1:Array) : void {
         var _loc3_:* = 0;
         var _loc2_:Object = {};
         _loc3_ = param1.length-1;
         while(_loc3_ > -1)
         {
            if(this.vars[param1[_loc3_]] != null)
            {
               _loc2_[param1[_loc3_]] = 1;
            }
            _loc3_--;
         }
         killVars(_loc2_);
      }
      
      override public function complete(param1:Boolean=false) : void {
         if(!isNaN(this.vars.yoyo) && (this._repeatCount < this.vars.yoyo || this.vars.yoyo == 0) || !isNaN(this.vars.loop) && (this._repeatCount < this.vars.loop || this.vars.loop == 0))
         {
            this._repeatCount++;
            if(!isNaN(this.vars.yoyo))
            {
               this.ease = this.vars.ease == this.ease?this.reverseEase:this.vars.ease;
            }
            this.startTime = param1?this.startTime + this.duration * 1000 / this.combinedTimeScale:currentTime;
            this.initTime = this.startTime - this.delay * 1000 / this.combinedTimeScale;
         }
         else
         {
            if(this.vars.persist == true)
            {
               super.complete(param1);
               this.pause();
               return;
            }
         }
         super.complete(param1);
      }
      
      protected function initDispatcher() : void {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         if(this._dispatcher == null)
         {
            this._dispatcher = new EventDispatcher(this);
            this._callbacks = 
               {
                  "onStart":this.vars.onStart,
                  "onUpdate":this.vars.onUpdate,
                  "onComplete":this.vars.onComplete
               };
            _loc1_ = {};
            for (_loc2_ in this.vars)
            {
               _loc1_[_loc2_] = this.vars[_loc2_];
            }
            this.vars = _loc1_;
            this.vars.onStart = this.onStartDispatcher;
            this.vars.onComplete = this.onCompleteDispatcher;
            if(this.vars.onStartListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.START,this.vars.onStartListener,false,0,true);
            }
            if(this.vars.onUpdateListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.UPDATE,this.vars.onUpdateListener,false,0,true);
               this.vars.onUpdate = this.onUpdateDispatcher;
               _hasUpdate = true;
            }
            if(this.vars.onCompleteListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.COMPLETE,this.vars.onCompleteListener,false,0,true);
            }
         }
      }
      
      protected function onStartDispatcher(... rest) : void {
         if(this._callbacks.onStart != null)
         {
            this._callbacks.onStart.apply(null,this.vars.onStartParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
      }
      
      protected function onUpdateDispatcher(... rest) : void {
         if(this._callbacks.onUpdate != null)
         {
            this._callbacks.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
      }
      
      protected function onCompleteDispatcher(... rest) : void {
         if(this._callbacks.onComplete != null)
         {
            this._callbacks.onComplete.apply(null,this.vars.onCompleteParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean=false, param4:int=0, param5:Boolean=false) : void {
         if(this._dispatcher == null)
         {
            this.initDispatcher();
         }
         if(param1 == TweenEvent.UPDATE && !(this.vars.onUpdate == this.onUpdateDispatcher))
         {
            this.vars.onUpdate = this.onUpdateDispatcher;
            _hasUpdate = true;
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean=false) : void {
         if(this._dispatcher != null)
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean {
         if(this._dispatcher == null)
         {
            return false;
         }
         return this._dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean {
         if(this._dispatcher == null)
         {
            return false;
         }
         return this._dispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean {
         if(this._dispatcher == null)
         {
            return false;
         }
         return this._dispatcher.dispatchEvent(param1);
      }
      
      public function get paused() : Boolean {
         return isNaN(this.pauseTime);
      }
      
      public function set paused(param1:Boolean) : void {
         if(param1)
         {
            this.pause();
         }
         else
         {
            this.resume();
         }
      }
      
      public function get reversed() : Boolean {
         return this.ease == this.reverseEase;
      }
      
      public function set reversed(param1:Boolean) : void {
         if(this.reversed != param1)
         {
            this.reverse();
         }
      }
      
      override public function set enabled(param1:Boolean) : void {
         if(!param1)
         {
            _pausedTweens[this] = null;
            delete _pausedTweens[[this]];
         }
         super.enabled = param1;
      }
      
      public function get progress() : Number {
         var _loc1_:Number = !isNaN(this.pauseTime)?this.pauseTime:currentTime;
         var _loc2_:Number = ((_loc1_ - this.initTime) * 0.001 - this.delay / this.combinedTimeScale) / this.duration * this.combinedTimeScale;
         if(_loc2_ > 1)
         {
            return 1;
         }
         if(_loc2_ < 0)
         {
            return 0;
         }
         return _loc2_;
      }
      
      public function set progress(param1:Number) : void {
         this.startTime = currentTime - this.duration * param1 * 1000;
         this.initTime = this.startTime - this.delay * 1000 / this.combinedTimeScale;
         if(!this.started)
         {
            activate();
         }
         render(currentTime);
         if(!isNaN(this.pauseTime))
         {
            this.pauseTime = currentTime;
            this.startTime = 9.99999999999999E14;
            this.active = false;
         }
      }
   }
}
