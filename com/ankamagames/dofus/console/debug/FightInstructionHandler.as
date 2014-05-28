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
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var spell:Spell = null;
         var spell2:Spell = null;
         switch(cmd)
         {
            case "setspellscript":
               if((args.length == 2) || (args.length == 3))
               {
                  spell = Spell.getSpellById(parseInt(args[0]));
                  if(!spell)
                  {
                     console.output("Spell " + args[0] + " doesn\'t exist");
                  }
                  else
                  {
                     spell.scriptId = parseInt(args[1]);
                     if(args.length == 3)
                     {
                        spell.scriptIdCritical = parseInt(args[2]);
                     }
                  }
               }
               else
               {
                  console.output("Param count error : #1 Spell id, #2 script id, #3 script id (critical hit)");
               }
               break;
            case "setspellscriptparam":
               if((args.length == 2) || (args.length == 3))
               {
                  spell2 = Spell.getSpellById(parseInt(args[0]));
                  if(!spell2)
                  {
                     console.output("Spell " + args[0] + " doesn\'t exist");
                  }
                  else
                  {
                     spell2.scriptParams = args[1];
                     if(args.length == 3)
                     {
                        spell2.scriptParamsCritical = args[2];
                     }
                     spell2.useParamCache = false;
                  }
               }
               else
               {
                  console.output("Param count error : #1 Spell id, #2 script string parametters, #3 script string parameters (critical hit)");
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "setspellscriptparam":
               return "Change script parametters for given spell";
            case "setspellscript":
               return "Change script id used for given spell";
            default:
               return "Unknown command";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
