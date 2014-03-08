package com.ankamagames.jerakine.utils.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Chrono extends Object
   {
      
      public function Chrono() {
         super();
      }
      
      private static var times:Array = [];
      
      private static var labels:Array = [];
      
      private static var level:int = 0;
      
      private static var indent:String = "";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Chrono));
      
      public static var show_total_time:Boolean = true;
      
      public static function start(param1:String="") : void {
         var param1:String = param1.length?param1:"Chrono " + times.length;
         times.push(getTimer());
         labels.push(param1);
         level = level + 1;
         indent = indent + "  ";
         _log.trace(">>" + indent + "START " + param1);
      }
      
      public static function stop() : int {
         var _loc1_:int = getTimer() - times.pop();
         if(!show_total_time && (times.length))
         {
            times[times.length-1] = times[times.length-1] - _loc1_;
         }
         _log.trace("<<" + indent + "DONE " + labels.pop() + " " + _loc1_ + "ms.");
         level = level-1;
         indent = indent.slice(0,2 * level + 1);
         return _loc1_;
      }
      
      public static function display(param1:String) : void {
         _log.trace("!!" + indent + "TRACE " + param1);
      }
   }
}
