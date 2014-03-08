package com.ankamagames.dofus.console
{
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.console.debug.VersionInstructionHandler;
   import com.ankamagames.dofus.console.debug.DisplayMapInstructionHandler;
   import com.ankamagames.dofus.console.debug.MiscInstructionHandler;
   import com.ankamagames.dofus.console.debug.UiHandlerInstructionHandler;
   import com.ankamagames.dofus.console.debug.ActionsInstructionHandler;
   import com.ankamagames.dofus.console.debug.SoundInstructionHandler;
   import com.ankamagames.dofus.console.debug.LuaInstructionHandler;
   
   public class BasicConsoleInstructionRegistar extends Object implements ConsoleInstructionRegistar
   {
      
      public function BasicConsoleInstructionRegistar() {
         super();
      }
      
      public function registerInstructions(param1:ConsoleHandler) : void {
         param1.addHandler("version",new VersionInstructionHandler());
         param1.addHandler("mapid",new DisplayMapInstructionHandler());
         param1.addHandler(["savereplaylog"],new MiscInstructionHandler());
         param1.addHandler(["uiinspector","inspectuielement","loadui","unloadui","clearuicache","useuicache","uilist","reloadui","modulelist"],new UiHandlerInstructionHandler());
         param1.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         param1.addHandler(["adduisoundelement"],new SoundInstructionHandler());
         param1.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}
