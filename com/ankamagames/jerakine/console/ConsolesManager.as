package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ConsolesManager extends Object
   {
      
      public function ConsolesManager() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ConsolesManager));
      
      private static var _consoles:Dictionary = new Dictionary();
      
      public static function getConsole(param1:String) : ConsoleHandler {
         return _consoles[param1];
      }
      
      public static function registerConsole(param1:String, param2:ConsoleHandler, param3:ConsoleInstructionRegistar) : void {
         if(getConsole(param1))
         {
            getConsole(param1).changeOutputHandler(param2);
            param2.name = param1;
            _consoles[param1] = param2;
            param3.registerInstructions(param2);
            return;
         }
         param2.name = param1;
         _consoles[param1] = param2;
         param3.registerInstructions(param2);
      }
      
      public static function getMessage(param1:String) : ConsoleInstructionMessage {
         var _loc2_:Array = param1.split(" ");
         var _loc3_:String = _loc2_[0];
         _loc2_.splice(0,1);
         if((_loc2_.length) && _loc2_[_loc2_.length-1].length == 0)
         {
            _loc2_.pop();
         }
         return new ConsoleInstructionMessage(_loc3_,_loc2_);
      }
   }
}
