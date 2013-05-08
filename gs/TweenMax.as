package gs
{
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import gs.events.TweenEvent;
   import flash.events.EventDispatcher;
   import flash.events.Event;


   public class TweenMax extends TweenFilterLite implements IEventDispatcher
   {
         

      public function TweenMax($target:Object, $duration:Number, $vars:Object) {
         super($target,$duration,$vars);
         if((!(this.vars.onCompleteListener==null))||(!(this.vars.onUpdateListener==null))||(!(this.vars.onStartListener==null)))
         {
            this.initDispatcher();
            if(($duration==0)&&(this.delay==0))
            {
               this.onUpdateDispatcher();
               this.onCompleteDispatcher();
            }
         }
         this._repeatCount=0;
         if((!isNaN(this.vars.yoyo))||(!isNaN(this.vars.loop)))
         {
            this.vars.persist=true;
         }
         if(TweenFilterLite.version<9.29)
         {
            trace("TweenMax error! Please update your TweenFilterLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
         }
      }

      public static var version:Number = 3.51;

      protected static const _RAD2DEG:Number = 180/Math.PI;

      private static var _overwriteMode:int = OverwriteManager.enabled?OverwriteManager.mode:OverwriteManager.init();

      public static var killTweensOf:Function = TweenLite.killTweensOf;

      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;

      public static var removeTween:Function = TweenLite.removeTween;

      public static var setGlobalTimeScale:Function = TweenFilterLite.setGlobalTimeScale;

      protected static var _pausedTweens:Dictionary = new Dictionary(false);

      public static function to($target:Object, $duration:Number, $vars:Object) : TweenMax {
         return new TweenMax($target,$duration,$vars);
      }

      public static function from($target:Object, $duration:Number, $vars:Object) : TweenMax {
         $vars.runBackwards=true;
         return new TweenMax($target,$duration,$vars);
      }

      public static function allTo($targets:Array, $duration:Number, $vars:Object) : Array {
         var i:* = 0;
         var v:Object = null;
         var p:String = null;
         var dl:* = NaN;
         var lastVars:Object = null;
         trace("WARNING: TweenMax.allTo() and TweenMax.allFrom() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include allTo() and allFrom() (to conserve file size).");
         if($targets.length==0)
         {
            return [];
         }
         var a:Array = [];
         var dli:Number = ($vars.delayIncrement)||(0);
         delete $vars[delayIncrement];
         if($vars.onCompleteAll==undefined)
         {
            lastVars=$vars;
         }
         else
         {
            lastVars={};
            for (p in $vars)
            {
               lastVars[p]=$vars[p];
            }
            lastVars.onCompleteParams=[[$vars.onComplete,$vars.onCompleteAll],[$vars.onCompleteParams,$vars.onCompleteAllParams]];
            lastVars.onComplete=TweenMax.callbackProxy;
            delete $vars[onCompleteAll];
         }
         delete $vars[onCompleteAllParams];
         if(dli==0)
         {
            i=0;
            while(i<$targets.length-1)
            {
               v={};
               for (p in $vars)
               {
                  v[p]=$vars[p];
               }
               a[a.length]=new TweenMax($targets[i],$duration,v);
               i++;
            }
         }
         else
         {
            dl=($vars.delay)||(0);
            i=0;
            while(i<$targets.length-1)
            {
               v={};
               for (p in $vars)
               {
                  v[p]=$vars[p];
               }
               v.delay=dl+i*dli;
               a[a.length]=new TweenMax($targets[i],$duration,v);
               i++;
            }
            lastVars.delay=dl+($targets.length-1)*dli;
         }
         a[a.length]=new TweenMax($targets[$targets.length-1],$duration,lastVars);
         if($vars.onCompleteAllListener is Function)
         {
            a[a.length-1].addEventListener(TweenEvent.COMPLETE,$vars.onCompleteAllListener);
         }
         return a;
      }

      public static function allFrom($targets:Array, $duration:Number, $vars:Object) : Array {
         $vars.runBackwards=true;
         return allTo($targets,$duration,$vars);
      }

      public static function callbackProxy($functions:Array, $params:Array=null) : void {
         var i:uint = 0;
         while(i<$functions.length)
         {
            if($functions[i]!=undefined)
            {
               $functions[i].apply(null,$params[i]);
            }
            i++;
         }
      }

      public static function sequence($target:Object, $tweens:Array) : Array {
         var i:uint = 0;
         while(i<$tweens.length)
         {
            $tweens[i].target=$target;
            i++;
         }
         return multiSequence($tweens);
      }

      public static function multiSequence($tweens:Array) : Array {
         var tw:Object = null;
         var tgt:Object = null;
         var dl:* = NaN;
         var t:* = NaN;
         var i:uint = 0;
         var o:Object = null;
         var p:String = null;
         trace("WARNING: TweenMax.multiSequence() and TweenMax.sequence() have been deprecated in favor of the much more powerful and flexible TweenGroup class. See http://blog.greensock.com/tweengroup/ for more details. Future versions of TweenMax may not include sequence() and multiSequence() (to conserve file size).");
         var dict:Dictionary = new Dictionary();
         var a:Array = [];
         var overwriteMode:int = TweenLite.overwriteManager.mode;
         var totalDelay:Number = 0;
         i=0;
         while(i<$tweens.length)
         {
            tw=$tweens[i];
            t=(tw.time)||(0);
            o={};
            for (p in tw)
            {
               o[p]=tw[p];
            }
            delete o[time];
            dl=(o.delay)||(0);
            o.delay=totalDelay+dl;
            tgt=o.target;
            delete o[target];
            if(overwriteMode==1)
            {
               if(dict[tgt]==undefined)
               {
                  dict[tgt]=o;
               }
               else
               {
                  o.overwrite=2;
               }
            }
            a[a.length]=new TweenMax(tgt,t,o);
            totalDelay=totalDelay+(t+dl);
            i++;
         }
         return a;
      }

      public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array=null, $persist:Boolean=false) : TweenMax {
         return new TweenMax($onComplete,0,
            {
               delay:$delay,
               onComplete:$onComplete,
               onCompleteParams:$onCompleteParams,
               persist:$persist,
               overwrite:0
            }
         );
      }

      public static function parseBeziers($props:Object, $through:Boolean=false) : Object {
         var i:* = 0;
         var a:Array = null;
         var b:Object = null;
         var p:String = null;
         var all:Object = {};
         if($through)
         {
            for (p in $props)
            {
               a=$props[p];
               all[p]=b=[];
               if(a.length>2)
               {
                  b[b.length]=
                     {
                        s:a[0],
                        cp:a[1]-(a[2]-a[0])/4,
                        e:a[1]
                     }
                  ;
                  i=1;
                  while(i<a.length-1)
                  {
                     b[b.length]=
                        {
                           s:a[i],
                           cp:a[i]+(a[i]-b[i-1].cp),
                           e:a[i+1]
                        }
                     ;
                     i++;
                  }
               }
               else
               {
                  b[b.length]=
                     {
                        s:a[0],
                        cp:(a[0]+a[1])/2,
                        e:a[1]
                     }
                  ;
               }
            }
         }
         else
         {
            for (p in $props)
            {
               a=$props[p];
               all[p]=b=[];
               if(a.length>3)
               {
                  b[b.length]=
                     {
                        s:a[0],
                        cp:a[1],
                        e:(a[1]+a[2])/2
                     }
                  ;
                  i=2;
                  while(i<a.length-2)
                  {
                     b[b.length]=
                        {
                           s:b[i-2].e,
                           cp:a[i],
                           e:(a[i]+a[i+1])/2
                        }
                     ;
                     i++;
                  }
                  b[b.length]=
                     {
                        s:b[b.length-1].e,
                        cp:a[a.length-2],
                        e:a[a.length-1]
                     }
                  ;
               }
               else
               {
                  if(a.length==3)
                  {
                     b[b.length]=
                        {
                           s:a[0],
                           cp:a[1],
                           e:a[2]
                        }
                     ;
                  }
                  else
                  {
                     if(a.length==2)
                     {
                        b[b.length]=
                           {
                              s:a[0],
                              cp:(a[0]+a[1])/2,
                              e:a[1]
                           }
                        ;
                     }
                  }
               }
            }
         }
         return all;
      }

      public static function getTweensOf($target:Object) : Array {
         var tween:TweenLite = null;
         var i:* = 0;
         var a:Array = masterList[$target];
         var toReturn:Array = [];
         if(a!=null)
         {
            i=a.length-1;
            while(i>-1)
            {
               if(!a[i].gc)
               {
                  toReturn[toReturn.length]=a[i];
               }
               i--;
            }
         }
         for each (tween in _pausedTweens)
         {
            if(tween.target==$target)
            {
               toReturn[toReturn.length]=tween;
            }
         }
         return toReturn;
      }

      public static function isTweening($target:Object) : Boolean {
         var a:Array = getTweensOf($target);
         var i:int = a.length-1;
         while(i>-1)
         {
            if((a[i].active)&&(!a[i].gc))
            {
               return true;
            }
            i--;
         }
         return false;
      }

      public static function getAllTweens() : Array {
         var a:Array = null;
         var i:* = 0;
         var tween:TweenLite = null;
         var ml:Dictionary = masterList;
         var toReturn:Array = [];
         for each (a in ml)
         {
            i=a.length-1;
            while(i>-1)
            {
               if(!a[i].gc)
               {
                  toReturn[toReturn.length]=a[i];
               }
               i--;
            }
         }
         for each (toReturn[toReturn.length] in _pausedTweens)
         {
         }
         return toReturn;
      }

      public static function killAllTweens($complete:Boolean=false) : void {
         killAll($complete,true,false);
      }

      public static function killAllDelayedCalls($complete:Boolean=false) : void {
         killAll($complete,false,true);
      }

      public static function killAll($complete:Boolean=false, $tweens:Boolean=true, $delayedCalls:Boolean=true) : void {
         var isDC:* = false;
         var i:* = 0;
         var a:Array = getAllTweens();
         i=a.length-1;
         while(i>-1)
         {
            isDC=a[i].target==a[i].vars.onComplete;
            if((isDC==$delayedCalls)||(!(isDC==$tweens)))
            {
               if($complete)
               {
                  a[i].complete(false);
                  a[i].clear();
               }
               else
               {
                  TweenLite.removeTween(a[i],true);
               }
            }
            i--;
         }
      }

      public static function pauseAll($tweens:Boolean=true, $delayedCalls:Boolean=false) : void {
         changePause(true,$tweens,$delayedCalls);
      }

      public static function resumeAll($tweens:Boolean=true, $delayedCalls:Boolean=false) : void {
         changePause(false,$tweens,$delayedCalls);
      }

      public static function changePause($pause:Boolean, $tweens:Boolean=true, $delayedCalls:Boolean=false) : void {
         var isDC:* = false;
         var a:Array = getAllTweens();
         var i:int = a.length-1;
         while(i>-1)
         {
            isDC=a[i].target==a[i].vars.onComplete;
            if((a[i] is TweenMax)&&((isDC==$delayedCalls)||(!(isDC==$tweens))))
            {
               a[i].paused=$pause;
            }
            i--;
         }
      }

      public static function hexColorsProxy($o:Object, $time:Number=0) : void {
         $o.info.target[$o.info.prop]=uint($o.target.r<<16|$o.target.g<<8|$o.target.b);
      }

      public static function bezierProxy($o:Object, $time:Number=0) : void {
         var i:* = 0;
         var p:String = null;
         var b:Object = null;
         var t:* = NaN;
         var segments:uint = 0;
         var factor:Number = $o.target.t;
         var props:Object = $o.info.props;
         var tg:Object = $o.info.target;
         if(factor==1)
         {
            for (p in props)
            {
               i=props[p].length-1;
               tg[p]=props[p][i].e;
            }
         }
         else
         {
            for (p in props)
            {
               segments=props[p].length;
               if(factor<0)
               {
                  i=0;
               }
               else
               {
                  if(factor>=1)
                  {
                     i=segments-1;
                  }
                  else
                  {
                     i=int(segments*factor);
                  }
               }
               t=(factor-i*1/segments)*segments;
               b=props[p][i];
               tg[p]=b.s+t*(2*(1-t)*(b.cp-b.s)+t*(b.e-b.s));
            }
         }
      }

      public static function bezierProxy2($o:Object, $time:Number=0) : void {
         var a:* = NaN;
         var dx:* = NaN;
         var dy:* = NaN;
         var cotb:Array = null;
         var toAdd:* = NaN;
         bezierProxy($o,$time);
         var future:Object = {};
         var tg:Object = $o.info.target;
         $o.info.target=future;
         $o.target.t=$o.target.t+0.01;
         bezierProxy($o);
         var otb:Array = $o.info.orientToBezier;
         var i:uint = 0;
         while(i<otb.length)
         {
            cotb=otb[i];
            toAdd=(cotb[3])||(0);
            dx=future[cotb[0]]-tg[cotb[0]];
            dy=future[cotb[1]]-tg[cotb[1]];
            tg[cotb[2]]=Math.atan2(dy,dx)*_RAD2DEG+toAdd;
            i++;
         }
         $o.info.target=tg;
         $o.target.t=$o.target.t-0.01;
      }

      public static function set globalTimeScale($n:Number) : void {
         setGlobalTimeScale($n);
      }

      public static function get globalTimeScale() : Number {
         return _globalTimeScale;
      }

      protected var _dispatcher:EventDispatcher;

      protected var _callbacks:Object;

      protected var _repeatCount:Number;

      public var pauseTime:Number;

      override public function initTweenVals($hrp:Boolean=false, $reservedProps:String="") : void {
         var p:String = null;
         var i:* = 0;
         var curProp:Object = null;
         var props:Object = null;
         var b:Array = null;
         var dif:* = NaN;
         var $reservedProps:String = $reservedProps+" hexColors bezier bezierThrough shortRotation orientToBezier quaternions onCompleteAll onCompleteAllParams yoyo loop onCompleteListener onUpdateListener onStartListener ";
         if((!$hrp)&&(TweenLite.overwriteManager.enabled))
         {
            TweenLite.overwriteManager.manageOverwrites(this,masterList[this.target]);
         }
         var bProxy:Function = bezierProxy;
         if(this.vars.orientToBezier==true)
         {
            this.vars.orientToBezier=[["x","y","rotation",0]];
            bProxy=bezierProxy2;
         }
         else
         {
            if(this.vars.orientToBezier is Array)
            {
               bProxy=bezierProxy2;
            }
         }
         if((!(this.vars.bezier==undefined))&&(this.vars.bezier is Array))
         {
            props={};
            b=this.vars.bezier;
            i=0;
            while(i<b.length)
            {
               for (p in b[i])
               {
                  if(props[p]==undefined)
                  {
                     props[p]=[this.target[p]];
                  }
                  if(typeof b[i][p]=="number")
                  {
                     props[p].push(b[i][p]);
                  }
                  else
                  {
                     props[p].push(this.target[p]+Number(b[i][p]));
                  }
               }
               i++;
            }
            for (p in props)
            {
               if(typeof this.vars[p]=="number")
               {
                  props[p].push(this.vars[p]);
               }
               else
               {
                  props[p].push(this.target[p]+Number(this.vars[p]));
               }
               delete this.vars[[p]];
            }
            addSubTween("bezier",bProxy,{t:0},{t:1},
               {
                  props:parseBeziers(props,false),
                  target:this.target,
                  orientToBezier:this.vars.orientToBezier
               }
            );
         }
         if((!(this.vars.bezierThrough==undefined))&&(this.vars.bezierThrough is Array))
         {
            props={};
            b=this.vars.bezierThrough;
            i=0;
            while(i<b.length)
            {
               for (p in b[i])
               {
                  if(props[p]==undefined)
                  {
                     props[p]=[this.target[p]];
                  }
                  if(typeof b[i][p]=="number")
                  {
                     props[p].push(b[i][p]);
                  }
                  else
                  {
                     props[p].push(this.target[p]+Number(b[i][p]));
                  }
               }
               i++;
            }
            for (p in props)
            {
               if(typeof this.vars[p]=="number")
               {
                  props[p].push(this.vars[p]);
               }
               else
               {
                  props[p].push(this.target[p]+Number(this.vars[p]));
               }
               delete this.vars[[p]];
            }
            addSubTween("bezierThrough",bProxy,{t:0},{t:1},
               {
                  props:parseBeziers(props,true),
                  target:this.target,
                  orientToBezier:this.vars.orientToBezier
               }
            );
         }
         if(!isNaN(this.vars.shortRotation))
         {
            dif=(this.vars.shortRotation-this.target.rotation)%360;
            if(dif!=dif%180)
            {
               dif=dif<0?dif+360:dif-360;
            }
            this.tweens[this.tweens.length]=[this.target,"rotation",this.target.rotation,dif,"rotation"];
         }
         if((!(this.vars.hexColors==undefined))&&(typeof this.vars.hexColors=="object"))
         {
            for (p in this.vars.hexColors)
            {
               addSubTween("hexColors",hexColorsProxy,
                  {
                     r:this.target[p]>>16,
                     g:this.target[p]>>8&255,
                     b:this.target[p]&255
                  }
               ,
                  {
                     r:this.vars.hexColors[p]>>16,
                     g:this.vars.hexColors[p]>>8&255,
                     b:this.vars.hexColors[p]&255
                  }
               ,
                  {
                     prop:p,
                     target:this.target
                  }
               );
            }
         }
         super.initTweenVals(true,$reservedProps);
      }

      public function pause() : void {
         if(isNaN(this.pauseTime))
         {
            this.pauseTime=currentTime;
            this.startTime=9.99999999999999E14;
            this.enabled=false;
            _pausedTweens[this]=this;
         }
      }

      public function resume() : void {
         this.enabled=true;
         if(!isNaN(this.pauseTime))
         {
            this.initTime=this.initTime+(currentTime-this.pauseTime);
            this.startTime=this.initTime+this.delay*1000/this.combinedTimeScale;
            this.pauseTime=NaN;
            if((!this.started)&&(currentTime>=this.startTime))
            {
               activate();
            }
            else
            {
               this.active=this.started;
            }
            _pausedTweens[this]=null;
            delete _pausedTweens[[this]];
         }
      }

      public function restart($includeDelay:Boolean=false) : void {
         if($includeDelay)
         {
            this.initTime=currentTime;
            this.startTime=currentTime+this.delay*1000/this.combinedTimeScale;
         }
         else
         {
            this.startTime=currentTime;
            this.initTime=currentTime-this.delay*1000/this.combinedTimeScale;
         }
         this._repeatCount=0;
         if(this.target!=this.vars.onComplete)
         {
            render(this.startTime);
         }
         this.pauseTime=NaN;
         _pausedTweens[this]=null;
         delete _pausedTweens[[this]];
         this.enabled=true;
      }

      public function reverse($adjustDuration:Boolean=true, $forcePlay:Boolean=true) : void {
         this.ease=this.vars.ease==this.ease?this.reverseEase:this.vars.ease;
         var p:Number = this.progress;
         if(($adjustDuration)&&(p<0))
         {
            this.startTime=currentTime-(1-p)*this.duration*1000/this.combinedTimeScale;
            this.initTime=this.startTime-this.delay*1000/this.combinedTimeScale;
         }
         if($forcePlay!=false)
         {
            if(p<1)
            {
               this.resume();
            }
            else
            {
               this.restart();
            }
         }
      }

      public function reverseEase($t:Number, $b:Number, $c:Number, $d:Number) : Number {
         return this.vars.ease($d-$t,$b,$c,$d);
      }

      public function invalidate($adjustStartValues:Boolean=true) : void {
         var p:* = NaN;
         if(this.initted)
         {
            p=this.progress;
            if((!$adjustStartValues)&&(!(p==0)))
            {
               this.progress=0;
            }
            this.tweens=[];
            _subTweens=[];
            _specialVars=this.vars.isTV==true?this.vars.exposedProps:this.vars;
            this.initTweenVals();
            _timeScale=(this.vars.timeScale)||(1);
            this.combinedTimeScale=_timeScale*_globalTimeScale;
            this.delay=(this.vars.delay)||(0);
            if(isNaN(this.pauseTime))
            {
               this.startTime=this.initTime+this.delay*1000/this.combinedTimeScale;
            }
            if((!(this.vars.onCompleteListener==null))||(!(this.vars.onUpdateListener==null))||(!(this.vars.onStartListener==null)))
            {
               if(this._dispatcher!=null)
               {
                  this.vars.onStart=this._callbacks.onStart;
                  this.vars.onUpdate=this._callbacks.onUpdate;
                  this.vars.onComplete=this._callbacks.onComplete;
                  this._dispatcher=null;
               }
               this.initDispatcher();
            }
            if(p!=0)
            {
               if($adjustStartValues)
               {
                  this.adjustStartValues();
               }
               else
               {
                  this.progress=p;
               }
            }
         }
      }

      public function setDestination($property:String, $value:*, $adjustStartValues:Boolean=true) : void {
         var v:Object = null;
         var i:* = 0;
         var varsOld:Object = null;
         var tweensOld:Array = null;
         var subTweensOld:Array = null;
         var p:Number = this.progress;
         if((!(this.vars[$property]==undefined))&&(this.initted))
         {
            if((!$adjustStartValues)&&(!(p==0)))
            {
               i=this.tweens.length-1;
               while(i>-1)
               {
                  if(this.tweens[i][4]==$property)
                  {
                     this.tweens[i][0][this.tweens[i][1]]=this.tweens[i][2];
                  }
                  i--;
               }
            }
            v={};
            v[$property]=1;
            killVars(v);
         }
         this.vars[$property]=$value;
         if(this.initted)
         {
            varsOld=this.vars;
            tweensOld=this.tweens;
            subTweensOld=_subTweens;
            this.vars={};
            this.tweens=[];
            _subTweens=[];
            this.vars[$property]=$value;
            this.initTweenVals();
            if((!(this.ease==this.reverseEase))&&(varsOld.ease is Function))
            {
               this.ease=varsOld.ease;
            }
            if(($adjustStartValues)&&(!(p==0)))
            {
               this.adjustStartValues();
            }
            this.vars=varsOld;
            this.tweens=tweensOld.concat(this.tweens);
            _subTweens=subTweensOld.concat(_subTweens);
         }
      }

      protected function adjustStartValues() : void {
         var factor:* = NaN;
         var endValue:* = NaN;
         var tp:Object = null;
         var i:* = 0;
         var p:Number = this.progress;
         if(p!=0)
         {
            factor=1/(1-this.ease(p*this.duration,0,1,this.duration));
            i=this.tweens.length-1;
            while(i>-1)
            {
               tp=this.tweens[i];
               endValue=tp[2]+tp[3];
               tp[3]=(endValue-tp[0][tp[1]])*factor;
               tp[2]=endValue-tp[3];
               i--;
            }
         }
      }

      public function killProperties($names:Array) : void {
         var i:* = 0;
         var v:Object = {};
         i=$names.length-1;
         while(i>-1)
         {
            if(this.vars[$names[i]]!=null)
            {
               v[$names[i]]=1;
            }
            i--;
         }
         killVars(v);
      }

      override public function complete($skipRender:Boolean=false) : void {
         if((!isNaN(this.vars.yoyo))&&((this._repeatCount>this.vars.yoyo)||(this.vars.yoyo==0))||(!isNaN(this.vars.loop))&&((this._repeatCount>this.vars.loop)||(this.vars.loop==0)))
         {
            this._repeatCount++;
            if(!isNaN(this.vars.yoyo))
            {
               this.ease=this.vars.ease==this.ease?this.reverseEase:this.vars.ease;
            }
            this.startTime=$skipRender?this.startTime+this.duration*1000/this.combinedTimeScale:currentTime;
            this.initTime=this.startTime-this.delay*1000/this.combinedTimeScale;
         }
         else
         {
            if(this.vars.persist==true)
            {
               super.complete($skipRender);
               this.pause();
               return;
            }
         }
         super.complete($skipRender);
      }

      protected function initDispatcher() : void {
         var v:Object = null;
         var p:String = null;
         if(this._dispatcher==null)
         {
            this._dispatcher=new EventDispatcher(this);
            this._callbacks=
               {
                  onStart:this.vars.onStart,
                  onUpdate:this.vars.onUpdate,
                  onComplete:this.vars.onComplete
               }
            ;
            v={};
            for (p in this.vars)
            {
               v[p]=this.vars[p];
            }
            this.vars=v;
            this.vars.onStart=this.onStartDispatcher;
            this.vars.onComplete=this.onCompleteDispatcher;
            if(this.vars.onStartListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.START,this.vars.onStartListener,false,0,true);
            }
            if(this.vars.onUpdateListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.UPDATE,this.vars.onUpdateListener,false,0,true);
               this.vars.onUpdate=this.onUpdateDispatcher;
               _hasUpdate=true;
            }
            if(this.vars.onCompleteListener is Function)
            {
               this._dispatcher.addEventListener(TweenEvent.COMPLETE,this.vars.onCompleteListener,false,0,true);
            }
         }
      }

      protected function onStartDispatcher(... $args) : void {
         if(this._callbacks.onStart!=null)
         {
            this._callbacks.onStart.apply(null,this.vars.onStartParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
      }

      protected function onUpdateDispatcher(... $args) : void {
         if(this._callbacks.onUpdate!=null)
         {
            this._callbacks.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
      }

      protected function onCompleteDispatcher(... $args) : void {
         if(this._callbacks.onComplete!=null)
         {
            this._callbacks.onComplete.apply(null,this.vars.onCompleteParams);
         }
         this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
      }

      public function addEventListener($type:String, $listener:Function, $useCapture:Boolean=false, $priority:int=0, $useWeakReference:Boolean=false) : void {
         if(this._dispatcher==null)
         {
            this.initDispatcher();
         }
         if(($type==TweenEvent.UPDATE)&&(!(this.vars.onUpdate==this.onUpdateDispatcher)))
         {
            this.vars.onUpdate=this.onUpdateDispatcher;
            _hasUpdate=true;
         }
         this._dispatcher.addEventListener($type,$listener,$useCapture,$priority,$useWeakReference);
      }

      public function removeEventListener($type:String, $listener:Function, $useCapture:Boolean=false) : void {
         if(this._dispatcher!=null)
         {
            this._dispatcher.removeEventListener($type,$listener,$useCapture);
         }
      }

      public function hasEventListener($type:String) : Boolean {
         if(this._dispatcher==null)
         {
            return false;
         }
         return this._dispatcher.hasEventListener($type);
      }

      public function willTrigger($type:String) : Boolean {
         if(this._dispatcher==null)
         {
            return false;
         }
         return this._dispatcher.willTrigger($type);
      }

      public function dispatchEvent($e:Event) : Boolean {
         if(this._dispatcher==null)
         {
            return false;
         }
         return this._dispatcher.dispatchEvent($e);
      }

      public function get paused() : Boolean {
         return isNaN(this.pauseTime);
      }

      public function set paused($b:Boolean) : void {
         if($b)
         {
            this.pause();
         }
         else
         {
            this.resume();
         }
      }

      public function get reversed() : Boolean {
         return this.ease==this.reverseEase;
      }

      public function set reversed($b:Boolean) : void {
         if(this.reversed!=$b)
         {
            this.reverse();
         }
      }

      override public function set enabled($b:Boolean) : void {
         if(!$b)
         {
            _pausedTweens[this]=null;
            delete _pausedTweens[[this]];
         }
         super.enabled=$b;
      }

      public function get progress() : Number {
         var t:Number = !isNaN(this.pauseTime)?this.pauseTime:currentTime;
         var p:Number = ((t-this.initTime)*0.001-this.delay/this.combinedTimeScale)/this.duration*this.combinedTimeScale;
         if(p>1)
         {
            return 1;
         }
         if(p<0)
         {
            return 0;
         }
         return p;
      }

      public function set progress($n:Number) : void {
         this.startTime=currentTime-this.duration*$n*1000;
         this.initTime=this.startTime-this.delay*1000/this.combinedTimeScale;
         if(!this.started)
         {
            activate();
         }
         render(currentTime);
         if(!isNaN(this.pauseTime))
         {
            this.pauseTime=currentTime;
            this.startTime=9.99999999999999E14;
            this.active=false;
         }
      }
   }

}