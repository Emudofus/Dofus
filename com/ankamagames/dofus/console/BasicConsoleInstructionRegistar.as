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
      
      public function registerInstructions(console:ConsoleHandler) : void {
         console.addHandler("version",new VersionInstructionHandler());
         console.addHandler("mapid",new DisplayMapInstructionHandler());
         console.addHandler(["savereplaylog"],new MiscInstructionHandler());
         console.addHandler(["uiinspector","inspectuielement","loadui","unloadui","clearuicache","useuicache","uilist","reloadui","modulelist"],new UiHandlerInstructionHandler());
         console.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         console.addHandler(["adduisoundelement"],new SoundInstructionHandler());
         console.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}
