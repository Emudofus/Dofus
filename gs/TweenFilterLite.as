package gs
{
   import flash.filters.*;
   import flash.utils.Dictionary;
   
   public class TweenFilterLite extends TweenLite
   {
      
      public function TweenFilterLite(param1:Object, param2:Number, param3:Object) {
         this._filters = [];
         super(param1,param2,param3);
         if(!(this.combinedTimeScale == 1) && this.target is TweenFilterLite)
         {
            this._timeScale = 1;
            this.combinedTimeScale = _globalTimeScale;
         }
         else
         {
            this._timeScale = this.combinedTimeScale;
            this.combinedTimeScale = this.combinedTimeScale * _globalTimeScale;
         }
         if(!(this.combinedTimeScale == 1) && !(this.delay == 0))
         {
            this.startTime = this.initTime + this.delay * 1000 / this.combinedTimeScale;
         }
         if(TweenLite.version < 9.29)
         {
            trace("TweenFilterLite error! Please update your TweenLite class or try deleting your ASO files. TweenFilterLite requires a more recent version. Download updates at http://www.TweenLite.com.");
         }
      }
      
      public static var version:Number = 9.29;
      
      public static var delayedCall:Function = TweenLite.delayedCall;
      
      public static var killTweensOf:Function = TweenLite.killTweensOf;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var removeTween:Function = TweenLite.removeTween;
      
      protected static var _globalTimeScale:Number = 1;
      
      private static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      private static var _lumR:Number = 0.212671;
      
      private static var _lumG:Number = 0.71516;
      
      private static var _lumB:Number = 0.072169;
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenFilterLite {
         return new TweenFilterLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenFilterLite {
         param3.runBackwards = true;
         return new TweenFilterLite(param1,param2,param3);
      }
      
      public static function setGlobalTimeScale(param1:Number) : void {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         if(param1 < 1.0E-5)
         {
            param1 = 1.0E-5;
         }
         var _loc2_:Dictionary = masterList;
         _globalTimeScale = param1;
         for each (_loc4_ in _loc2_)
         {
            _loc3_ = _loc4_.length-1;
            while(_loc3_ > -1)
            {
               if(_loc4_[_loc3_] is TweenFilterLite)
               {
                  _loc4_[_loc3_].timeScale = _loc4_[_loc3_].timeScale * 1;
               }
               _loc3_--;
            }
         }
      }
      
      public static function HEXtoRGB(param1:Number) : Object {
         return 
            {
               "rb":param1 >> 16,
               "gb":param1 >> 8 & 255,
               "bb":param1 & 255
            };
      }
      
      public static function colorize(param1:Array, param2:Number, param3:Number=1) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         if(isNaN(param3))
         {
            param3 = 1;
         }
         var _loc4_:Number = (param2 >> 16 & 255) / 255;
         var _loc5_:Number = (param2 >> 8 & 255) / 255;
         var _loc6_:Number = (param2 & 255) / 255;
         var _loc7_:Number = 1 - param3;
         var _loc8_:Array = [_loc7_ + param3 * _loc4_ * _lumR,param3 * _loc4_ * _lumG,param3 * _loc4_ * _lumB,0,0,param3 * _loc5_ * _lumR,_loc7_ + param3 * _loc5_ * _lumG,param3 * _loc5_ * _lumB,0,0,param3 * _loc6_ * _lumR,param3 * _loc6_ * _lumG,_loc7_ + param3 * _loc6_ * _lumB,0,0,0,0,0,1,0];
         return applyMatrix(_loc8_,param1);
      }
      
      public static function setThreshold(param1:Array, param2:Number) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         var _loc3_:Array = [_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * param2,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * param2,_lumR * 256,_lumG * 256,_lumB * 256,0,-256 * param2,0,0,0,1,0];
         return applyMatrix(_loc3_,param1);
      }
      
      public static function setHue(param1:Array, param2:Number) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         var param2:Number = param2 * Math.PI / 180;
         var _loc3_:Number = Math.cos(param2);
         var _loc4_:Number = Math.sin(param2);
         var _loc5_:Array = [_lumR + _loc3_ * (1 - _lumR) + _loc4_ * -_lumR,_lumG + _loc3_ * -_lumG + _loc4_ * -_lumG,_lumB + _loc3_ * -_lumB + _loc4_ * (1 - _lumB),0,0,_lumR + _loc3_ * -_lumR + _loc4_ * 0.143,_lumG + _loc3_ * (1 - _lumG) + _loc4_ * 0.14,_lumB + _loc3_ * -_lumB + _loc4_ * -0.283,0,0,_lumR + _loc3_ * -_lumR + _loc4_ * -(1 - _lumR),_lumG + _loc3_ * -_lumG + _loc4_ * _lumG,_lumB + _loc3_ * (1 - _lumB) + _loc4_ * _lumB,0,0,0,0,0,1,0,0,0,0,0,1];
         return applyMatrix(_loc5_,param1);
      }
      
      public static function setBrightness(param1:Array, param2:Number) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         var param2:Number = param2 * 100 - 100;
         return applyMatrix([1,0,0,0,param2,0,1,0,0,param2,0,0,1,0,param2,0,0,0,1,0,0,0,0,0,1],param1);
      }
      
      public static function setSaturation(param1:Array, param2:Number) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         var _loc3_:Number = 1 - param2;
         var _loc4_:Number = _loc3_ * _lumR;
         var _loc5_:Number = _loc3_ * _lumG;
         var _loc6_:Number = _loc3_ * _lumB;
         var _loc7_:Array = [_loc4_ + param2,_loc5_,_loc6_,0,0,_loc4_,_loc5_ + param2,_loc6_,0,0,_loc4_,_loc5_,_loc6_ + param2,0,0,0,0,0,1,0];
         return applyMatrix(_loc7_,param1);
      }
      
      public static function setContrast(param1:Array, param2:Number) : Array {
         if(isNaN(param2))
         {
            return param1;
         }
         var param2:Number = param2 + 0.01;
         var _loc3_:Array = [param2,0,0,0,128 * (1 - param2),0,param2,0,0,128 * (1 - param2),0,0,param2,0,128 * (1 - param2),0,0,0,1,0];
         return applyMatrix(_loc3_,param1);
      }
      
      public static function applyMatrix(param1:Array, param2:Array) : Array {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         if(!(param1 is Array) || !(param2 is Array))
         {
            return param2;
         }
         var _loc3_:Array = [];
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = 0;
            while(_loc7_ < 5)
            {
               if(_loc7_ == 4)
               {
                  _loc5_ = param1[_loc4_ + 4];
               }
               else
               {
                  _loc5_ = 0;
               }
               _loc3_[_loc4_ + _loc7_] = param1[_loc4_] * param2[_loc7_] + param1[_loc4_ + 1] * param2[_loc7_ + 5] + param1[_loc4_ + 2] * param2[_loc7_ + 10] + param1[_loc4_ + 3] * param2[_loc7_ + 15] + _loc5_;
               _loc7_++;
            }
            _loc4_ = _loc4_ + 5;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function set globalTimeScale(param1:Number) : void {
         setGlobalTimeScale(param1);
      }
      
      public static function get globalTimeScale() : Number {
         return _globalTimeScale;
      }
      
      protected var _matrix:Array;
      
      protected var _endMatrix:Array;
      
      protected var _cmf:ColorMatrixFilter;
      
      protected var _clrsa:Array;
      
      protected var _hf:Boolean = false;
      
      protected var _filters:Array;
      
      protected var _timeScale:Number;
      
      protected var _roundProps:Boolean;
      
      override public function initTweenVals(param1:Boolean=false, param2:String="") : void {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:* = 0;
         var _loc8_:String = null;
         if(!param1 && (TweenLite.overwriteManager.enabled))
         {
            TweenLite.overwriteManager.manageOverwrites(this,masterList[this.target]);
         }
         this._clrsa = [];
         this._filters = [];
         this._matrix = _idMatrix.slice();
         var param2:* = param2 + " blurFilter glowFilter colorMatrixFilter dropShadowFilter bevelFilter roundProps ";
         this._roundProps = Boolean(this.vars.roundProps is Array);
         if(_isDisplayObject)
         {
            if(this.vars.blurFilter != null)
            {
               _loc4_ = this.vars.blurFilter;
               this.addFilter("blurFilter",_loc4_,BlurFilter,["blurX","blurY","quality"],new BlurFilter(0,0,(_loc4_.quality) || 2));
            }
            if(this.vars.glowFilter != null)
            {
               _loc4_ = this.vars.glowFilter;
               this.addFilter("glowFilter",_loc4_,GlowFilter,["alpha","blurX","blurY","color","quality","strength","inner","knockout"],new GlowFilter(16777215,0,0,0,(_loc4_.strength) || (1),(_loc4_.quality) || 2,_loc4_.inner,_loc4_.knockout));
            }
            if(this.vars.colorMatrixFilter != null)
            {
               _loc4_ = this.vars.colorMatrixFilter;
               _loc5_ = this.addFilter("colorMatrixFilter",_loc4_,ColorMatrixFilter,[],new ColorMatrixFilter(this._matrix));
               this._cmf = _loc5_.filter;
               this._matrix = ColorMatrixFilter(this._cmf).matrix;
               if(!(_loc4_.matrix == null) && _loc4_.matrix is Array)
               {
                  this._endMatrix = _loc4_.matrix;
               }
               else
               {
                  if(_loc4_.relative == true)
                  {
                     this._endMatrix = this._matrix.slice();
                  }
                  else
                  {
                     this._endMatrix = _idMatrix.slice();
                  }
                  this._endMatrix = setBrightness(this._endMatrix,_loc4_.brightness);
                  this._endMatrix = setContrast(this._endMatrix,_loc4_.contrast);
                  this._endMatrix = setHue(this._endMatrix,_loc4_.hue);
                  this._endMatrix = setSaturation(this._endMatrix,_loc4_.saturation);
                  this._endMatrix = setThreshold(this._endMatrix,_loc4_.threshold);
                  if(!isNaN(_loc4_.colorize))
                  {
                     this._endMatrix = colorize(this._endMatrix,_loc4_.colorize,_loc4_.amount);
                  }
                  else
                  {
                     if(!isNaN(_loc4_.color))
                     {
                        this._endMatrix = colorize(this._endMatrix,_loc4_.color,_loc4_.amount);
                     }
                  }
               }
               _loc3_ = 0;
               while(_loc3_ < this._endMatrix.length)
               {
                  if(!(this._matrix[_loc3_] == this._endMatrix[_loc3_]) && !(this._matrix[_loc3_] == undefined))
                  {
                     this.tweens[this.tweens.length] = [this._matrix,_loc3_.toString(),this._matrix[_loc3_],this._endMatrix[_loc3_] - this._matrix[_loc3_],"colorMatrixFilter"];
                  }
                  _loc3_++;
               }
            }
            if(this.vars.dropShadowFilter != null)
            {
               _loc4_ = this.vars.dropShadowFilter;
               this.addFilter("dropShadowFilter",_loc4_,DropShadowFilter,["alpha","angle","blurX","blurY","color","distance","quality","strength","inner","knockout","hideObject"],new DropShadowFilter(0,45,0,0,0,0,1,(_loc4_.quality) || 2,_loc4_.inner,_loc4_.knockout,_loc4_.hideObject));
            }
            if(this.vars.bevelFilter != null)
            {
               _loc4_ = this.vars.bevelFilter;
               this.addFilter("bevelFilter",_loc4_,BevelFilter,["angle","blurX","blurY","distance","highlightAlpha","highlightColor","quality","shadowAlpha","shadowColor","strength"],new BevelFilter(0,0,16777215,0.5,0,0.5,2,2,0,(_loc4_.quality) || 2));
            }
            if(this.vars.runBackwards == true)
            {
               _loc3_ = this._clrsa.length-1;
               while(_loc3_ > -1)
               {
                  _loc6_ = this._clrsa[_loc3_];
                  _loc6_.sr = _loc6_.sr + _loc6_.cr;
                  _loc6_.cr = _loc6_.cr * -1;
                  _loc6_.sg = _loc6_.sg + _loc6_.cg;
                  _loc6_.cg = _loc6_.cg * -1;
                  _loc6_.sb = _loc6_.sb + _loc6_.cb;
                  _loc6_.cb = _loc6_.cb * -1;
                  _loc6_.f[_loc6_.p] = _loc6_.sr << 16 | _loc6_.sg << 8 | _loc6_.sb;
                  _loc3_--;
               }
            }
            super.initTweenVals(true,param2);
         }
         else
         {
            super.initTweenVals(param1,param2);
         }
         if(this._roundProps)
         {
            _loc3_ = this.vars.roundProps.length-1;
            while(_loc3_ > -1)
            {
               _loc8_ = this.vars.roundProps[_loc3_];
               _loc7_ = this.tweens.length-1;
               while(_loc7_ > -1)
               {
                  if(this.tweens[_loc7_][1] == _loc8_ && this.tweens[_loc7_][0] == this.target)
                  {
                     this.tweens[_loc7_][5] = true;
                     break;
                  }
                  _loc7_--;
               }
               _loc3_--;
            }
         }
      }
      
      private function addFilter(param1:String, param2:Object, param3:Class, param4:Array, param5:BitmapFilter) : Object {
         var _loc8_:* = 0;
         var _loc9_:String = null;
         var _loc10_:* = NaN;
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc6_:Object = 
            {
               "type":param3,
               "name":param1
            };
         var _loc7_:Array = this.target.filters;
         _loc8_ = 0;
         while(_loc8_ < _loc7_.length)
         {
            if(_loc7_[_loc8_] is param3)
            {
               _loc6_.filter = _loc7_[_loc8_];
               break;
            }
            _loc8_++;
         }
         if(_loc6_.filter == undefined)
         {
            _loc6_.filter = param5;
            _loc7_[_loc7_.length] = _loc6_.filter;
            this.target.filters = _loc7_;
         }
         _loc8_ = 0;
         while(_loc8_ < param4.length)
         {
            _loc9_ = param4[_loc8_];
            if(param2[_loc9_] != undefined)
            {
               if(_loc9_ == "color" || _loc9_ == "highlightColor" || _loc9_ == "shadowColor")
               {
                  _loc11_ = HEXtoRGB(_loc6_.filter[_loc9_]);
                  _loc12_ = HEXtoRGB(param2[_loc9_]);
                  this._clrsa[this._clrsa.length] = 
                     {
                        "f":_loc6_.filter,
                        "p":_loc9_,
                        "sr":_loc11_.rb,
                        "cr":_loc12_.rb - _loc11_.rb,
                        "sg":_loc11_.gb,
                        "cg":_loc12_.gb - _loc11_.gb,
                        "sb":_loc11_.bb,
                        "cb":_loc12_.bb - _loc11_.bb
                     };
               }
               else
               {
                  if(_loc9_ == "quality" || _loc9_ == "inner" || _loc9_ == "knockout" || _loc9_ == "hideObject")
                  {
                     _loc6_.filter[_loc9_] = param2[_loc9_];
                  }
                  else
                  {
                     if(typeof param2[_loc9_] == "number")
                     {
                        _loc10_ = param2[_loc9_] - _loc6_.filter[_loc9_];
                     }
                     else
                     {
                        _loc10_ = Number(param2[_loc9_]);
                     }
                     this.tweens[this.tweens.length] = [_loc6_.filter,_loc9_,_loc6_.filter[_loc9_],_loc10_,param1];
                  }
               }
            }
            _loc8_++;
         }
         this._filters[this._filters.length] = _loc6_;
         this._hf = true;
         return _loc6_;
      }
      
      override public function render(param1:uint) : void {
         var _loc3_:* = NaN;
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = 0;
         var _loc8_:Array = null;
         var _loc9_:* = 0;
         var _loc2_:Number = (param1 - this.startTime) * 0.001 * this.combinedTimeScale;
         if(_loc2_ >= this.duration)
         {
            _loc2_ = this.duration;
            _loc3_ = this.ease == this.vars.ease || this.duration == 0.001?1:0;
         }
         else
         {
            _loc3_ = this.ease(_loc2_,0,1,this.duration);
         }
         if(!this._roundProps)
         {
            _loc5_ = this.tweens.length-1;
            while(_loc5_ > -1)
            {
               _loc4_ = this.tweens[_loc5_];
               _loc4_[0][_loc4_[1]] = _loc4_[2] + _loc3_ * _loc4_[3];
               _loc5_--;
            }
         }
         else
         {
            _loc5_ = this.tweens.length-1;
            while(_loc5_ > -1)
            {
               _loc4_ = this.tweens[_loc5_];
               if(_loc4_[5])
               {
                  _loc6_ = _loc4_[2] + _loc3_ * _loc4_[3];
                  _loc7_ = _loc6_ < 0?-1:1;
                  _loc4_[0][_loc4_[1]] = _loc6_ % 1 * _loc7_ > 0.5?int(_loc6_) + _loc7_:int(_loc6_);
               }
               else
               {
                  _loc4_[0][_loc4_[1]] = _loc4_[2] + _loc3_ * _loc4_[3];
               }
               _loc5_--;
            }
         }
         if(this._hf)
         {
            _loc5_ = this._clrsa.length-1;
            while(_loc5_ > -1)
            {
               _loc4_ = this._clrsa[_loc5_];
               _loc4_.f[_loc4_.p] = _loc4_.sr + _loc3_ * _loc4_.cr << 16 | _loc4_.sg + _loc3_ * _loc4_.cg << 8 | _loc4_.sb + _loc3_ * _loc4_.cb;
               _loc5_--;
            }
            if(this._cmf != null)
            {
               ColorMatrixFilter(this._cmf).matrix = this._matrix;
            }
            _loc8_ = this.target.filters;
            _loc5_ = 0;
            while(_loc5_ < this._filters.length)
            {
               _loc9_ = _loc8_.length-1;
               while(_loc9_ > -1)
               {
                  if(_loc8_[_loc9_] is this._filters[_loc5_].type)
                  {
                     _loc8_.splice(_loc9_,1,this._filters[_loc5_].filter);
                     break;
                  }
                  _loc9_--;
               }
               _loc5_++;
            }
            this.target.filters = _loc8_;
         }
         if(_hst)
         {
            _loc5_ = _subTweens.length-1;
            while(_loc5_ > -1)
            {
               _subTweens[_loc5_].proxy(_subTweens[_loc5_],_loc2_);
               _loc5_--;
            }
         }
         if(_hasUpdate)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_loc2_ == this.duration)
         {
            complete(true);
         }
      }
      
      override public function killVars(param1:Object) : void {
         if(TweenLite.overwriteManager.enabled)
         {
            TweenLite.overwriteManager.killVars(param1,this.vars,this.tweens,_subTweens,this._filters || []);
         }
      }
      
      public function get timeScale() : Number {
         return this._timeScale;
      }
      
      public function set timeScale(param1:Number) : void {
         if(param1 < 1.0E-5)
         {
            param1 = this._timeScale = 1.0E-5;
         }
         else
         {
            this._timeScale = param1;
            param1 = param1 * _globalTimeScale;
         }
         this.initTime = currentTime - (currentTime - this.initTime - this.delay * 1000 / this.combinedTimeScale) * this.combinedTimeScale * 1 / param1 - this.delay * 1000 / param1;
         if(this.startTime != 9.99999999999999E14)
         {
            this.startTime = this.initTime + this.delay * 1000 / param1;
         }
         this.combinedTimeScale = param1;
      }
      
      override public function set enabled(param1:Boolean) : void {
         super.enabled = param1;
         if(param1)
         {
            this.combinedTimeScale = this._timeScale * _globalTimeScale;
         }
      }
   }
}
