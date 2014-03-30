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
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function asynchInfo(console:ConsoleHandler) : void {
         var sprite:* = undefined;
         var ts:Dictionary = TiphonSprite.MEMORY_LOG;
         for (sprite in ts)
         {
            console.output(sprite + " : " + TiphonSprite(sprite).look);
         }
      }
      
      public function getHelp(cmd:String) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null) : Array {
         return [];
      }
   }
}
