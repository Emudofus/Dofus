package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.tiphon.types.EventListener;
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.Scene;
   import flash.display.FrameLabel;
   import com.ankamagames.tiphon.types.TiphonEventInfo;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class TiphonEventsManager extends Object
   {
      
      public function TiphonEventsManager(param1:TiphonSprite) {
         super();
         this._weakTiphonSprite = new WeakReference(param1);
         this._events = new Array();
         if(_eventsDic == null)
         {
            _eventsDic = new Array();
         }
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEventsManager));
      
      private static var _listeners:Vector.<EventListener> = new Vector.<EventListener>();
      
      private static var _eventsDic:Array;
      
      private static const EVENT_SHOT:String = "SHOT";
      
      private static const EVENT_END:String = "END";
      
      private static const PLAYER_STOP:String = "STOP";
      
      private static const EVENT_SOUND:String = "SOUND";
      
      private static const EVENT_DATASOUND:String = "DATASOUND";
      
      private static const EVENT_PLAYANIM:String = "PLAYANIM";
      
      public static var BALISE_SOUND:String = "Sound";
      
      public static var BALISE_DATASOUND:String = "DataSound";
      
      public static var BALISE_PLAYANIM:String = "PlayAnim";
      
      public static var BALISE_EVT:String = "Evt";
      
      public static var BALISE_PARAM_BEGIN:String = "(";
      
      public static var BALISE_PARAM_END:String = ")";
      
      public static function get listeners() : Vector.<EventListener> {
         return _listeners;
      }
      
      public static function addListener(param1:IFLAEventHandler, param2:String) : void {
         var _loc5_:EventListener = null;
         var _loc3_:* = -1;
         var _loc4_:int = _listeners.length;
         while(++_loc3_ < _loc4_)
         {
            _loc5_ = _listeners[_loc3_];
            if(_loc5_.listener == param1 && _loc5_.typesEvents == param2)
            {
               return;
            }
         }
         TiphonEventsManager._listeners.push(new EventListener(param1,param2));
      }
      
      public static function removeListener(param1:IFLAEventHandler) : void {
         var _loc2_:int = TiphonEventsManager._listeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            TiphonEventsManager._listeners.splice(_loc2_,1);
         }
      }
      
      private var _weakTiphonSprite:WeakReference;
      
      private var _events:Array;
      
      public function parseLabels(param1:Scene, param2:String) : void {
         var _loc5_:FrameLabel = null;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc3_:int = param1.labels.length;
         var _loc4_:* = -1;
         while(++_loc4_ < _loc3_)
         {
            _loc5_ = param1.labels[_loc4_] as FrameLabel;
            _loc6_ = _loc5_.name;
            _loc7_ = _loc5_.frame;
            this.addEvent(_loc6_,_loc7_,param2);
         }
      }
      
      public function dispatchEvents(param1:*) : void {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:TiphonEventInfo = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:EventListener = null;
         if(!this._weakTiphonSprite)
         {
            return;
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc2_:TiphonSprite = this._weakTiphonSprite.object as TiphonSprite;
         var _loc3_:uint = _loc2_.getDirection();
         if(_loc3_ == 3)
         {
            _loc3_ = 1;
         }
         if(_loc3_ == 7)
         {
            _loc3_ = 5;
         }
         if(_loc3_ == 4)
         {
            _loc3_ = 0;
         }
         var _loc4_:String = _loc2_.getAnimation();
         var _loc5_:Vector.<TiphonEventInfo> = this._events[param1];
         if(_loc5_)
         {
            _loc6_ = _loc5_.length;
            _loc7_ = -1;
            while(++_loc7_ < _loc6_)
            {
               _loc8_ = _loc5_[_loc7_];
               _loc9_ = _listeners.length;
               _loc10_ = -1;
               while(++_loc10_ < _loc9_)
               {
                  _loc11_ = _listeners[_loc10_];
                  if(_loc11_.typesEvents == _loc8_.type && _loc8_.animationType == _loc4_ && _loc8_.direction == _loc3_)
                  {
                     _loc11_.listener.handleFLAEvent(_loc8_.animationName,_loc8_.type,_loc8_.params,_loc2_);
                  }
               }
            }
         }
      }
      
      public function destroy() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Vector.<TiphonEventInfo> = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:TiphonEventInfo = null;
         if(this._events)
         {
            _loc1_ = -1;
            _loc2_ = this._events.length;
            while(++_loc1_ < _loc2_)
            {
               _loc3_ = this._events[_loc1_];
               if(_loc3_)
               {
                  _loc4_ = -1;
                  _loc5_ = _loc3_.length;
                  while(++_loc4_ < _loc5_)
                  {
                     _loc6_ = _loc3_[_loc4_];
                     _loc6_.destroy();
                  }
               }
            }
            this._events = null;
         }
         if(this._weakTiphonSprite)
         {
            this._weakTiphonSprite.destroy();
            this._weakTiphonSprite = null;
         }
      }
      
      public function addEvent(param1:String, param2:int, param3:String) : void {
         var _loc4_:TiphonEventInfo = null;
         var _loc5_:TiphonEventInfo = null;
         var _loc6_:TiphonEventInfo = null;
         var _loc7_:TiphonSprite = null;
         if(this._events[param2] == null)
         {
            this._events[param2] = new Vector.<TiphonEventInfo>();
         }
         for each (_loc4_ in this._events[param2])
         {
            if(_loc4_.animationName == param3 && _loc4_.label == param1)
            {
               return;
            }
         }
         if(_eventsDic[param1])
         {
            _loc5_ = (_eventsDic[param1] as TiphonEventInfo).duplicate();
            _loc5_.label = param1;
            this._events[param2].push(_loc5_);
            _loc5_.animationName = param3;
         }
         else
         {
            _loc6_ = this.parseLabel(param1);
            if(_loc6_)
            {
               _eventsDic[param1] = _loc6_;
               _loc6_.animationName = param3;
               _loc6_.label = param1;
               this._events[param2].push(_loc6_);
            }
            else
            {
               if(param1 != "END")
               {
                  _loc7_ = this._weakTiphonSprite.object as TiphonSprite;
                  _log.error("Found label \'" + param1 + "\' on sprite " + _loc7_.look.getBone() + " (anim " + _loc7_.getAnimation() + ")");
               }
            }
         }
      }
      
      public function removeEvents(param1:String, param2:String) : void {
         var _loc3_:String = null;
         var _loc4_:Vector.<TiphonEventInfo> = null;
         var _loc5_:Vector.<TiphonEventInfo> = null;
         var _loc6_:TiphonEventInfo = null;
         for (_loc3_ in this._events)
         {
            _loc4_ = this._events[_loc3_];
            _loc5_ = new Vector.<TiphonEventInfo>();
            for each (_loc6_ in _loc4_)
            {
               if(!(_loc6_.animationName == param2) || !(_loc6_.type == param1))
               {
                  _loc5_.push(_loc6_);
               }
            }
            if(_loc5_.length != _loc4_.length)
            {
               this._events[_loc3_] = _loc5_;
            }
         }
      }
      
      private function parseLabel(param1:String) : TiphonEventInfo {
         var _loc2_:TiphonEventInfo = null;
         var _loc5_:String = null;
         var _loc3_:String = param1.split(BALISE_PARAM_BEGIN)[0];
         var _loc4_:RegExp = new RegExp("^\\s*(.*?)\\s*$","g");
         _loc3_ = _loc3_.replace(_loc4_,"$1");
         switch(_loc3_.toUpperCase())
         {
            case BALISE_SOUND.toUpperCase():
               _loc5_ = param1.split(BALISE_PARAM_BEGIN)[1];
               _loc5_ = _loc5_.split(BALISE_PARAM_END)[0];
               _loc2_ = new TiphonEventInfo(TiphonEvent.SOUND_EVENT,_loc5_);
               break;
            case BALISE_DATASOUND.toUpperCase():
               _loc5_ = param1.split(BALISE_PARAM_BEGIN)[1];
               _loc5_ = _loc5_.split(BALISE_PARAM_END)[0];
               _loc2_ = new TiphonEventInfo(TiphonEvent.DATASOUND_EVENT,_loc5_);
               break;
            case BALISE_PLAYANIM.toUpperCase():
               _loc5_ = param1.split(BALISE_PARAM_BEGIN)[1];
               _loc5_ = _loc5_.split(BALISE_PARAM_END)[0];
               _loc2_ = new TiphonEventInfo(TiphonEvent.PLAYANIM_EVENT,_loc5_);
               break;
            case BALISE_EVT.toUpperCase():
               trace("BALISE_EVT : " + param1);
               _loc5_ = param1.split(BALISE_PARAM_BEGIN)[1];
               _loc5_ = _loc5_.split(BALISE_PARAM_END)[0];
               _loc2_ = new TiphonEventInfo(TiphonEvent.EVT_EVENT,_loc5_);
               break;
            default:
               _loc2_ = this.convertOldLabel(param1);
         }
         return _loc2_;
      }
      
      private function convertOldLabel(param1:String) : TiphonEventInfo {
         var _loc2_:TiphonEventInfo = null;
         switch(param1)
         {
            case EVENT_END:
               _loc2_ = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_END);
               break;
            case PLAYER_STOP:
               _loc2_ = new TiphonEventInfo(TiphonEvent.EVT_EVENT,PLAYER_STOP);
               break;
            case EVENT_SHOT:
               _loc2_ = new TiphonEventInfo(TiphonEvent.EVT_EVENT,EVENT_SHOT);
               break;
         }
         return _loc2_;
      }
   }
}
