package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import flash.system.System;
   import flash.utils.setTimeout;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.dofus.kernel.Kernel;
   import flash.utils.Dictionary;
   
   public class ClearSceneInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function ClearSceneInstructionHandler()
      {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Array = null;
         var _loc10_:RoleplayEntitiesFrame = null;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         switch(param2)
         {
            case "clearscene":
               if(param3.length > 0)
               {
                  param1.output("No arguments needed.");
               }
               _loc4_ = Dofus.getInstance().getWorldContainer();
               while(_loc4_.numChildren > 0)
               {
                  _loc4_.removeChildAt(0);
               }
               param1.output("Scene cleared.");
               break;
            case "clearentities":
               _loc5_ = 0;
               for each(_loc11_ in EntitiesManager.getInstance().entities)
               {
                  _loc5_++;
               }
               param1.output("EntitiesManager : " + _loc5_ + " entities");
               Atouin.getInstance().clearEntities();
               Atouin.getInstance().display(PlayedCharacterManager.getInstance().currentMap);
               System.gc();
               setTimeout(this.asynchInfo,2000,param1);
               break;
            case "countentities":
               _loc6_ = 0;
               _loc7_ = 0;
               _loc8_ = 0;
               _loc9_ = EntitiesManager.getInstance().entities;
               for each(_loc12_ in _loc9_)
               {
                  _loc6_++;
                  if(_loc12_ is TiphonSprite)
                  {
                     if(_loc12_.id >= 0)
                     {
                        _loc7_++;
                     }
                     else
                     {
                        _loc8_++;
                     }
                  }
               }
               param1.output(_loc6_ + " entities : " + _loc7_ + " characters, " + _loc8_ + " monsters & npc.");
               _loc10_ = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(_loc10_)
               {
                  param1.output("Switch to creature mode : " + _loc10_.entitiesNumber + " of " + _loc10_.creaturesLimit + " -> " + _loc10_.creaturesMode);
               }
               break;
         }
      }
      
      private function asynchInfo(param1:ConsoleHandler) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Dictionary = TiphonSprite.MEMORY_LOG;
         for(_loc3_ in _loc2_)
         {
            param1.output(_loc3_ + " : " + TiphonSprite(_loc3_).look);
         }
      }
      
      public function getHelp(param1:String) : String
      {
         switch(param1)
         {
            case "clearscene":
               return "Clear the World Scene.";
            case "clearentities":
               return "Clear all entities from the scene.";
            case "countentities":
               return "Count all entities from the scene.";
            default:
               return "No help for command \'" + param1 + "\'";
         }
      }
      
      public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
      {
         return [];
      }
   }
}
