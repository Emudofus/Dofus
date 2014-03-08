package com.ankamagames.dofus.console
{
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.console.debug.VersionInstructionHandler;
   import com.ankamagames.dofus.console.debug.CryptoInstructionHandler;
   import com.ankamagames.dofus.console.debug.DisplayMapInstructionHandler;
   import com.ankamagames.dofus.console.debug.ClearSceneInstructionHandler;
   import com.ankamagames.dofus.console.debug.UiHandlerInstructionHandler;
   import com.ankamagames.dofus.console.debug.DtdInstructionHandler;
   import com.ankamagames.dofus.console.debug.ClearTextureCacheInstructionHandler;
   import com.ankamagames.dofus.console.debug.ConnectionInstructionHandler;
   import com.ankamagames.dofus.console.debug.PanicInstructionHandler;
   import com.ankamagames.dofus.console.debug.FullScreenInstructionHandler;
   import com.ankamagames.dofus.console.debug.ResetInstructionHandler;
   import com.ankamagames.dofus.console.debug.EnterFrameInstructionHandler;
   import com.ankamagames.dofus.console.debug.MiscInstructionHandler;
   import com.ankamagames.dofus.console.debug.TiphonInstructionHandler;
   import com.ankamagames.dofus.console.debug.InventoryInstructionHandler;
   import com.ankamagames.dofus.console.debug.UtilInstructionHandler;
   import com.ankamagames.dofus.console.debug.FontInstructionHandler;
   import com.ankamagames.dofus.console.common.LatencyInstructionHandler;
   import com.ankamagames.dofus.console.debug.FrameInstructionHandler;
   import com.ankamagames.dofus.console.debug.BenchmarkInstructionHandler;
   import com.ankamagames.dofus.console.debug.ActionsInstructionHandler;
   import com.ankamagames.dofus.console.debug.IAInstructionHandler;
   import com.ankamagames.dofus.console.debug.FightInstructionHandler;
   import com.ankamagames.dofus.console.debug.SoundInstructionHandler;
   import com.ankamagames.dofus.console.debug.LivingObjectInstructionHandler;
   import com.ankamagames.dofus.console.debug.UpdaterInstructionHandler;
   import com.ankamagames.dofus.console.debug.SystemInstructionHandler;
   import com.ankamagames.dofus.console.debug.LuaInstructionHandler;
   
   public class DebugConsoleInstructionRegistar extends Object implements ConsoleInstructionRegistar
   {
      
      public function DebugConsoleInstructionRegistar() {
         super();
      }
      
      public function registerInstructions(param1:ConsoleHandler) : void {
         param1.addHandler("version",new VersionInstructionHandler());
         param1.addHandler(["crc32","md5"],new CryptoInstructionHandler());
         param1.addHandler(["displaymap","displaymapdebug","getmapcoord","getmapid","testatouin","mapid","showcellid","playerjump","showtransitions","groundcache"],new DisplayMapInstructionHandler());
         param1.addHandler(["clearscene","clearentities"],new ClearSceneInstructionHandler());
         param1.addHandler(["inspector","uiinspector","inspectuielement","inspectuielementsos","modulelist","loadui","unloadui","clearuicache","setuiscale","useuicache","uilist","reloadui","fps","getmoduleinfo","chatoutput"],new UiHandlerInstructionHandler());
         param1.addHandler(["dtd","componentdtd","shortcutsdtd","kerneleventdtd"],new DtdInstructionHandler());
         param1.addHandler("cleartexturecache",new ClearTextureCacheInstructionHandler());
         param1.addHandler(["connectionstatus","inspecttraffic"],new ConnectionInstructionHandler());
         param1.addHandler(["panic","throw"],new PanicInstructionHandler());
         param1.addHandler("fullscreen",new FullScreenInstructionHandler());
         param1.addHandler("reset",new ResetInstructionHandler());
         param1.addHandler("enterframecount",new EnterFrameInstructionHandler());
         param1.addHandler(["savereplaylog","parallelsequenceteststart","log","i18nsize","newdofus","clear","config","clearwebcache","geteventmodeparams","setquality","lowdefskin","copylog","synchrosequence","throw","debugmouseover","idletime","setmonsterspeed"],new MiscInstructionHandler());
         param1.addHandler(["additem","looklike"],new TiphonInstructionHandler());
         param1.addHandler(["listinventory","searchitem","makeinventory"],new InventoryInstructionHandler());
         param1.addHandler(["enablelogs","info","search","searchmonster","searchspell","enablereport","savereport","loadpacket","reccordpacket"],new UtilInstructionHandler());
         param1.addHandler("jptest",new FontInstructionHandler());
         param1.addHandler(["aping","ping"],new LatencyInstructionHandler());
         param1.addHandler(["framelist","framepriority"],new FrameInstructionHandler());
         param1.addHandler(["addmovingcharacter","setanimation","setdirection","memorylog","bot-spectator","bot-fight","tiphon-error","fpsmanager","fastanimfun","tacticmode"],new BenchmarkInstructionHandler());
         param1.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         param1.addHandler(["debuglos","tracepath","debugcellsinline"],new IAInstructionHandler());
         param1.addHandler(["setspellscriptparam","setspellscript"],new FightInstructionHandler());
         param1.addHandler(["playmusic","stopmusic","playambiance","stopambiance","addsoundinplaylist","stopplaylist","playplaylist","activesounds","adduisoundelement"],new SoundInstructionHandler());
         param1.addHandler(["floodlivingobject"],new LivingObjectInstructionHandler());
         param1.addHandler(["partdebug","partlist","partinfo","updaterspeed","downloadpart"],new UpdaterInstructionHandler());
         param1.addHandler(["getuid"],new SystemInstructionHandler());
         param1.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}
