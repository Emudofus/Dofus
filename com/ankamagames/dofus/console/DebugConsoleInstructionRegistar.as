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
      
      public function registerInstructions(console:ConsoleHandler) : void {
         console.addHandler("version",new VersionInstructionHandler());
         console.addHandler(["crc32","md5"],new CryptoInstructionHandler());
         console.addHandler(["displaymap","displaymapdebug","getmapcoord","getmapid","testatouin","mapid","showcellid","playerjump","showtransitions","groundcache"],new DisplayMapInstructionHandler());
         console.addHandler(["clearscene","clearentities"],new ClearSceneInstructionHandler());
         console.addHandler(["inspector","uiinspector","inspectuielement","inspectuielementsos","modulelist","loadui","unloadui","clearuicache","setuiscale","useuicache","uilist","reloadui","fps","getmoduleinfo","chatoutput"],new UiHandlerInstructionHandler());
         console.addHandler(["dtd","componentdtd","shortcutsdtd","kerneleventdtd"],new DtdInstructionHandler());
         console.addHandler("cleartexturecache",new ClearTextureCacheInstructionHandler());
         console.addHandler(["connectionstatus","inspecttraffic"],new ConnectionInstructionHandler());
         console.addHandler(["panic","throw"],new PanicInstructionHandler());
         console.addHandler("fullscreen",new FullScreenInstructionHandler());
         console.addHandler("reset",new ResetInstructionHandler());
         console.addHandler("enterframecount",new EnterFrameInstructionHandler());
         console.addHandler(["savereplaylog","parallelsequenceteststart","log","i18nsize","newdofus","clear","config","clearwebcache","geteventmodeparams","setquality","lowdefskin","copylog","synchrosequence","throw","debugmouseover","idletime","setmonsterspeed"],new MiscInstructionHandler());
         console.addHandler(["additem","looklike"],new TiphonInstructionHandler());
         console.addHandler(["listinventory","searchitem","makeinventory"],new InventoryInstructionHandler());
         console.addHandler(["enablelogs","info","search","searchmonster","searchspell","enablereport","savereport","loadpacket","reccordpacket"],new UtilInstructionHandler());
         console.addHandler("jptest",new FontInstructionHandler());
         console.addHandler(["aping","ping"],new LatencyInstructionHandler());
         console.addHandler(["framelist","framepriority"],new FrameInstructionHandler());
         console.addHandler(["addmovingcharacter","setanimation","setdirection","memorylog","bot-spectator","bot-fight","tiphon-error","fpsmanager","fastanimfun","tacticmode"],new BenchmarkInstructionHandler());
         console.addHandler(["sendaction","listactions","sendhook"],new ActionsInstructionHandler());
         console.addHandler(["debuglos","tracepath","debugcellsinline"],new IAInstructionHandler());
         console.addHandler(["setspellscriptparam","setspellscript"],new FightInstructionHandler());
         console.addHandler(["playmusic","stopmusic","playambiance","stopambiance","addsoundinplaylist","stopplaylist","playplaylist","activesounds","adduisoundelement"],new SoundInstructionHandler());
         console.addHandler(["floodlivingobject"],new LivingObjectInstructionHandler());
         console.addHandler(["partdebug","partlist","partinfo","updaterspeed","downloadpart"],new UpdaterInstructionHandler());
         console.addHandler(["getuid"],new SystemInstructionHandler());
         console.addHandler(["lua","luarecorder"],new LuaInstructionHandler());
      }
   }
}
