package com.ankamagames.dofus.console
{
    import com.ankamagames.dofus.console.common.*;
    import com.ankamagames.dofus.console.debug.*;
    import com.ankamagames.jerakine.console.*;

    public class DebugConsoleInstructionRegistar extends Object implements ConsoleInstructionRegistar
    {

        public function DebugConsoleInstructionRegistar()
        {
            return;
        }// end function

        public function registerInstructions(param1:ConsoleHandler) : void
        {
            param1.addHandler("version", new VersionInstructionHandler());
            param1.addHandler(["crc32", "md5"], new CryptoInstructionHandler());
            param1.addHandler(["displaymap", "displaymapdebug", "getmapcoord", "getmapid", "testatouin", "mapid", "showcellid", "playerjump", "showtransitions", "groundcache"], new DisplayMapInstructionHandler());
            param1.addHandler(["clearscene", "clearentities"], new ClearSceneInstructionHandler());
            param1.addHandler(["modulelist", "loadui", "unloadui", "clearuicache", "setuiscale", "useuicache", "uilist", "reloadui", "fps", "getmoduleinfo", "chatoutput"], new UiHandlerInstructionHandler());
            param1.addHandler(["dtd", "componentdtd", "shortcutsdtd", "kerneleventdtd"], new DtdInstructionHandler());
            param1.addHandler("cleartexturecache", new ClearTextureCacheInstructionHandler());
            param1.addHandler("connectionstatus", new ConnectionInstructionHandler());
            param1.addHandler(["panic", "throw"], new PanicInstructionHandler());
            param1.addHandler("fullscreen", new FullScreenInstructionHandler());
            param1.addHandler("reset", new ResetInstructionHandler());
            param1.addHandler("enterframecount", new EnterFrameInstructionHandler());
            param1.addHandler(["savereplaylog", "parallelsequenceteststart", "log", "i18nsize", "newdofus", "clear", "config", "clearwebcache", "geteventmodeparams", "setquality", "lowdefskin", "copylog", "synchrosequence", "throw"], new MiscInstructionHandler());
            param1.addHandler(["additem", "looklike"], new TiphonInstructionHandler());
            param1.addHandler(["listinventory", "searchitem", "makeinventory"], new InventoryInstructionHandler());
            param1.addHandler(["enablelogs", "info", "search", "searchmonster", "searchspell", "enablereport", "savereport"], new UtilInstructionHandler());
            param1.addHandler("jptest", new FontInstructionHandler());
            param1.addHandler(["aping", "ping"], new LatencyInstructionHandler());
            param1.addHandler(["framelist", "framepriority"], new FrameInstructionHandler());
            param1.addHandler(["addmovingcharacter", "setanimation", "setdirection", "memorylog", "bot-spectator", "bot-fight", "tiphon-error", "fpsmanager", "fastanimfun", "tacticmode"], new BenchmarkInstructionHandler());
            param1.addHandler(["sendaction", "listactions", "sendhook"], new ActionsInstructionHandler());
            param1.addHandler(["debuglos", "tracepath", "debugcellsinline"], new IAInstructionHandler());
            param1.addHandler(["setspellscriptparam", "setspellscript"], new FightInstructionHandler());
            param1.addHandler(["playmusic", "stopmusic", "playambiance", "stopambiance", "addsoundinplaylist", "stopplaylist", "playplaylist", "activesounds"], new SoundInstructionHandler());
            param1.addHandler(["floodlivingobject"], new LivingObjectInstructionHandler());
            param1.addHandler(["partdebug", "partlist", "partinfo", "updaterspeed", "downloadpart"], new UpdaterInstructionHandler());
            param1.addHandler(["getuid"], new SystemInstructionHandler());
            return;
        }// end function

    }
}
