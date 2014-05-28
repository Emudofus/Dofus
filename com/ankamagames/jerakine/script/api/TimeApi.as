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
      
      public static function Timeout(delay:uint, fct:Function, ... parameters) : uint {
         if(!parameters)
         {
            parameters = new Array();
         }
         parameters.unshift(delay);
         parameters.unshift(fct);
         return CallWithParameters.callR(setTimeout,parameters);
      }
      
      public static function CancelTimeout(timeoutID:uint) : void {
         clearTimeout(timeoutID);
      }
      
      public static function Repeat(delay:uint, fct:Function, ... parameters) : uint {
         if(!parameters)
         {
            parameters = new Array();
         }
         parameters.unshift(delay);
         parameters.unshift(fct);
         return CallWithParameters.callR(setInterval,parameters);
      }
      
      public static function CancelRepeat(intervalID:uint) : void {
         clearInterval(intervalID);
      }
   }
}
