package com.ankamagames.jerakine.utils.display
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class EnterFrameDispatcher extends Object
   {
      
      public function EnterFrameDispatcher() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EnterFrameDispatcher));
      
      private static var _listenerUp:Boolean;
      
      private static var _currentTime:uint;
      
      private static var _controledListeners:Dictionary = new Dictionary(true);
      
      private static var _realTimeListeners:Dictionary = new Dictionary();
      
      private static var _listenersCount:uint;
      
      public static function get enterFrameListenerCount() : uint {
         return _listenersCount;
      }
      
      public static function get controledEnterFrameListeners() : Dictionary {
         return _controledListeners;
      }
      
      public static function get realTimeEnterFrameListeners() : Dictionary {
         return _realTimeListeners;
      }
      
      public static function addEventListener(param1:Function, param2:String, param3:uint=4.294967295E9) : void {
         var _loc4_:Stage = null;
         if(param3 == uint.MAX_VALUE || param3 >= StageShareManager.stage.frameRate)
         {
            _realTimeListeners[param1] = param2;
            StageShareManager.stage.addEventListener(Event.ENTER_FRAME,param1,false,0,true);
         }
         else
         {
            if(!_controledListeners[param1])
            {
               _controledListeners[param1] = new ControledEnterFrameListener(param2,param1,param3 > 0?1000 / param3:0,_listenerUp?_currentTime:getTimer());
               if(!_listenerUp)
               {
                  StageShareManager.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
                  _loc4_ = StageShareManager.stage;
                  _listenerUp = true;
               }
            }
         }
         _listenersCount++;
      }
      
      public static function hasEventListener(param1:Function) : Boolean {
         return !(_controledListeners[param1] == null);
      }
      
      public static function removeEventListener(param1:Function) : void {
         var _loc2_:* = undefined;
         if(_controledListeners[param1])
         {
            delete _controledListeners[[param1]];
            _listenersCount--;
         }
         if(_realTimeListeners[param1])
         {
            delete _realTimeListeners[[param1]];
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,param1,false);
            _listenersCount--;
         }
         for each (_loc2_ in _controledListeners)
         {
         }
         if(StageShareManager.stage)
         {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
         }
         _listenerUp = false;
      }
      
      private static function onEnterFrame(param1:Event) : void {
         var _loc2_:ControledEnterFrameListener = null;
         var _loc3_:uint = 0;
         _currentTime = getTimer();
         for each (_loc2_ in _controledListeners)
         {
            _loc3_ = _currentTime - _loc2_.latestChange;
            if(_loc3_ > _loc2_.wantedGap - _loc2_.overhead)
            {
               _loc2_.listener(param1);
               _loc2_.latestChange = _currentTime;
               _loc2_.overhead = _loc3_ - _loc2_.wantedGap + _loc2_.overhead;
            }
         }
      }
   }
}
class ControledEnterFrameListener extends Object
{
   
   function ControledEnterFrameListener(param1:String, param2:Function, param3:uint, param4:uint) {
      super();
      this.name = param1;
      this.listener = param2;
      this.wantedGap = param3;
      this.latestChange = param4;
   }
   
   public var name:String;
   
   public var listener:Function;
   
   public var wantedGap:uint;
   
   public var overhead:uint;
   
   public var latestChange:uint;
}
