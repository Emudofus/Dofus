package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import flash.system.System;
   import flash.utils.setTimeout;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.utils.Dictionary;
   
   public class ClearSceneInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ClearSceneInstructionHandler() {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         var scene:DisplayObjectContainer = null;
         var count:uint = 0;
         var o:* = undefined;
         switch(cmd)
         {
            case "clearscene":
               if(args.length > 0)
               {
                  console.output("No arguments needed.");
               }
               scene = Dofus.getInstance().getWorldContainer();
               while(scene.numChildren > 0)
               {
                  scene.removeChildAt(0);
               }
               console.output("Scene cleared.");
               break;
            case "clearentities":
               count = 0;
               for each(o in EntitiesManager.getInstance().entities)
               {
                  count++;
               }
               console.output("EntitiesManager : " + count + " entities");
               Atouin.getInstance().clearEntities();
               Atouin.getInstance().display(PlayedCharacterManager.getInstance().currentMap);
               System.gc();
               setTimeout(this.asynchInfo,2000,console);
               break;
         }
      }
      
      private function asynchInfo(console:ConsoleHandler) : void {
         var sprite:* = undefined;
         var ts:Dictionary = TiphonSprite.MEMORY_LOG;
         for(sprite in ts)
         {
            console.output(sprite + " : " + TiphonSprite(sprite).look);
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "clearscene":
               return "Clear the World Scene.";
            case "clearentities":
               return "Clear all entities from the scene.";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         return [];
      }
   }
}
