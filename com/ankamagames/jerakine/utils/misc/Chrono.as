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
      
      public static function start(label:String="") : void {
         var label:String = label.length?label:"Chrono " + times.length;
         times.push(getTimer());
         labels.push(label);
         level = level + 1;
         indent = indent + "  ";
         _log.trace(">>" + indent + "START " + label);
      }
      
      public static function stop() : int {
         var elapsed:int = getTimer() - times.pop();
         if((!show_total_time) && (times.length))
         {
            times[times.length - 1] = times[times.length - 1] - elapsed;
         }
         _log.trace("<<" + indent + "DONE " + labels.pop() + " " + elapsed + "ms.");
         level = level - 1;
         indent = indent.slice(0,2 * level + 1);
         return elapsed;
      }
      
      public static function display(str:String) : void {
         _log.trace("!!" + indent + "TRACE " + str);
      }
   }
}
