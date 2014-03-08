package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   
   public class FightInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function FightInstructionHandler() {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void {
         var _loc4_:Spell = null;
         var _loc5_:Spell = null;
         switch(param2)
         {
            case "setspellscript":
               if(param3.length == 2 || param3.length == 3)
               {
                  _loc4_ = Spell.getSpellById(parseInt(param3[0]));
                  if(!_loc4_)
                  {
                     param1.output("Spell " + param3[0] + " doesn\'t exist");
                  }
                  else
                  {
                     _loc4_.scriptId = parseInt(param3[1]);
                     if(param3.length == 3)
                     {
                        _loc4_.scriptIdCritical = parseInt(param3[2]);
                     }
                  }
               }
               else
               {
                  param1.output("Param count error : #1 Spell id, #2 script id, #3 script id (critical hit)");
               }
               break;
            case "setspellscriptparam":
               if(param3.length == 2 || param3.length == 3)
               {
                  _loc5_ = Spell.getSpellById(parseInt(param3[0]));
                  if(!_loc5_)
                  {
                     param1.output("Spell " + param3[0] + " doesn\'t exist");
                  }
                  else
                  {
                     _loc5_.scriptParams = param3[1];
                     if(param3.length == 3)
                     {
                        _loc5_.scriptParamsCritical = param3[2];
                     }
                     _loc5_.useParamCache = false;
                  }
               }
               else
               {
                  param1.output("Param count error : #1 Spell id, #2 script string parametters, #3 script string parameters (critical hit)");
               }
               break;
         }
      }
      
      public function getHelp(param1:String) : String {
         switch(param1)
         {
            case "setspellscriptparam":
               return "Change script parametters for given spell";
            case "setspellscript":
               return "Change script id used for given spell";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint=0, param3:Array=null) : Array {
         return [];
      }
   }
}
