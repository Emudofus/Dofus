package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.logic.game.common.managers.SpeakingItemManager;
   
   public class LivingObjectInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function LivingObjectInstructionHandler() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryInstructionHandler));
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         switch(cmd)
         {
            case "floodlivingobject":
               if(SpeakingItemManager.getInstance().speakTimerMinuteDelay != SpeakingItemManager.MINUTE_DELAY)
               {
                  SpeakingItemManager.getInstance().speakTimerMinuteDelay = SpeakingItemManager.MINUTE_DELAY;
               }
               else
               {
                  SpeakingItemManager.getInstance().speakTimerMinuteDelay = 100;
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "floodlivingobject":
               return "Make a flood of talk from living objects.";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }
}
