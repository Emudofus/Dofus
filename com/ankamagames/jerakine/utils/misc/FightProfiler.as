package com.ankamagames.jerakine.utils.misc
{
   import flash.utils.getTimer;
   
   public class FightProfiler extends Object
   {
      
      public function FightProfiler() {
         super();
      }
      
      private static const _profiler:FightProfiler;
      
      private static var _startTime:int = 0;
      
      public static function getInstance() : FightProfiler {
         return _profiler;
      }
      
      private var _info:String;
      
      public function start() : void {
         _startTime = getTimer();
      }
      
      public function stop() : void {
         this._info = (getTimer() - _startTime).toString();
      }
      
      public function get info() : String {
         return this._info;
      }
   }
}
