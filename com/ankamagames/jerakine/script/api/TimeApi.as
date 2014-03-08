package com.ankamagames.jerakine.script.api
{
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.utils.setTimeout;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.clearInterval;
   
   public class TimeApi extends Object
   {
      
      public function TimeApi() {
         super();
      }
      
      public static function Timeout(param1:uint, param2:Function, ... rest) : uint {
         if(!rest)
         {
            rest = new Array();
         }
         rest.unshift(param1);
         rest.unshift(param2);
         return CallWithParameters.callR(setTimeout,rest);
      }
      
      public static function CancelTimeout(param1:uint) : void {
         clearTimeout(param1);
      }
      
      public static function Repeat(param1:uint, param2:Function, ... rest) : uint {
         if(!rest)
         {
            rest = new Array();
         }
         rest.unshift(param1);
         rest.unshift(param2);
         return CallWithParameters.callR(setInterval,rest);
      }
      
      public static function CancelRepeat(param1:uint) : void {
         clearInterval(param1);
      }
   }
}
