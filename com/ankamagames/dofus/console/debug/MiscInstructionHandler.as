package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.replay.*;
    import com.ankamagames.jerakine.utils.crypto.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;

    public class MiscInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        private var _synchronisationFrameInstance:SynchronisationFrame;

        public function MiscInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var log:Logger;
            var size:uint;
            var emptySince:uint;
            var i:uint;
            var s:String;
            var managerName:String;
            var logFile:File;
            var val:*;
            var prop:Array;
            var name:String;
            var p:Object;
            var o:*;
            var fsLog:FileStream;
            var logContent:ByteArray;
            var console:* = param1;
            var cmd:* = param2;
            var args:* = param3;
            switch(cmd)
            {
                case "log":
                {
                    log = Log.getLogger(getQualifiedClassName(MiscInstructionHandler));
                    LogLogger.activeLog(args[0] == "true" || args[0] == "on");
                    console.output("Log set to " + LogLogger.logIsActive());
                    break;
                }
                case "newdofus":
                {
                    NativeApplication.nativeApplication.dispatchEvent(new Event(InvokeEvent.INVOKE));
                    break;
                }
                case "i18nsize":
                {
                    size;
                    emptySince;
                    i;
                    s;
                    do
                    {
                        
                        i = (i + 1);
                        s = I18n.getText(i);
                        if (s)
                        {
                            emptySince;
                            size = size + s.length;
                            continue;
                        }
                        emptySince = (emptySince + 1);
                    }while (emptySince < 20)
                    console.output(size + " characters in " + (i - 1) + " entries.");
                    break;
                }
                case "clear":
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ConsoleClear);
                    break;
                }
                case "config":
                {
                    if (!args[0])
                    {
                        console.output("Syntax : /config <manager> [<option>]");
                        break;
                    }
                    managerName = args[0];
                    if (!OptionManager.getOptionManager(managerName))
                    {
                        console.output("Unknown manager \'" + managerName + "\').");
                        break;
                    }
                    if (args[1])
                    {
                        if (OptionManager.getOptionManager("atouin")[args[1]] != null)
                        {
                            val = args[2];
                            if (val == "true")
                            {
                                val;
                            }
                            if (val == "false")
                            {
                                val;
                            }
                            if (parseInt(val).toString() == val)
                            {
                                val = parseInt(val);
                            }
                            OptionManager.getOptionManager("atouin")[args[1]] = val;
                        }
                        else
                        {
                            console.output(args[1] + " not found on AtouinOption");
                        }
                    }
                    else
                    {
                        prop = new Array();
                        var _loc_5:* = 0;
                        var _loc_6:* = OptionManager.getOptionManager("atouin");
                        while (_loc_6 in _loc_5)
                        {
                            
                            name = _loc_6[_loc_5];
                            prop.push({name:name, value:OptionManager.getOptionManager("atouin")[name]});
                        }
                        prop.sortOn("name");
                        var _loc_5:* = 0;
                        var _loc_6:* = prop;
                        while (_loc_6 in _loc_5)
                        {
                            
                            p = _loc_6[_loc_5];
                            console.output(" - " + p.name + " : " + p.value);
                        }
                    }
                    break;
                }
                case "clearwebcache":
                {
                    TimeoutHTMLLoader.resetCache();
                    break;
                }
                case "geteventmodeparams":
                {
                    if (args.length != 2)
                    {
                        console.output("Syntax : /getEventModeParams <login> <password>");
                        return;
                    }
                    console.output(Base64.encode("login:" + args[0] + ",password:" + args[1]));
                    break;
                }
                case "setquality":
                {
                    if (args.length != 1)
                    {
                        console.output("Current stage.quality : [" + StageShareManager.stage.quality + "]");
                        return;
                    }
                    StageShareManager.stage.quality = args[0];
                    console.output("Try set stage.qualitity to [" + args[0] + "], result : [" + StageShareManager.stage.quality + "]");
                    break;
                }
                case "lowdefskin":
                {
                    var _loc_5:* = 0;
                    var _loc_6:* = EntitiesManager.getInstance().entities;
                    while (_loc_6 in _loc_5)
                    {
                        
                        o = _loc_6[_loc_5];
                        if (o is TiphonSprite)
                        {
                            TiphonSprite(o).setAlternativeSkinIndex(TiphonSprite(o).getAlternativeSkinIndex() == -1 ? (0) : (-1));
                        }
                    }
                    break;
                }
                case "copylog":
                {
                    LogFrame.getInstance(false).duplicateLogFile();
                    break;
                }
                case "savereplaylog":
                {
                    logFile = LogFrame.getInstance(false).duplicateLogFile();
                    if (logFile.exists)
                    {
                        fsLog = new FileStream();
                        logContent = new ByteArray();
                        fsLog.open(logFile, FileMode.READ);
                        fsLog.readBytes(logContent);
                        File.desktopDirectory.save(logContent, "log.d2l");
                    }
                    break;
                }
                case "synchrosequence":
                {
                    if (Kernel.getWorker().contains(SynchronisationFrame))
                    {
                        this._synchronisationFrameInstance = Kernel.getWorker().getFrame(SynchronisationFrame) as SynchronisationFrame;
                        Kernel.getWorker().removeFrame(this._synchronisationFrameInstance);
                        console.output("Synchro sequence disable");
                    }
                    else if (this._synchronisationFrameInstance)
                    {
                        console.output("Synchro sequence enable");
                        Kernel.getWorker().addFrame(this._synchronisationFrameInstance);
                    }
                    else
                    {
                        console.output("Can\'t enable synchro sequence");
                    }
                    break;
                }
                case "throw":
                {
                    if (args[0] == "async")
                    {
                        setTimeout(function () : void
            {
                throw new Error("Test error");
            }// end function
            , 100);
                    }
                    else
                    {
                        throw new Error("Test error");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "log":
                {
                    return "Switch on/off client log process.";
                }
                case "i18nsize":
                {
                    return "Get the total size in characters of I18N datas.";
                }
                case "newdofus":
                {
                    return "Try to launch a new dofus client.";
                }
                case "clear":
                {
                    return "clear the console output";
                }
                case "clearwebcache":
                {
                    return "clear cached web browser";
                }
                case "geteventmodeparams":
                {
                    return "Get event mode config file param. param 1 : login, param 2 : password";
                }
                case "setquality":
                {
                    return "Set stage quality (no param to get actual value)";
                }
                case "config":
                {
                    return "list options in different managers if no param else set an option /config [managerName] [paramName] [paramValue]";
                }
                case "copylog":
                {
                    return "Copy current log file to xxx.copy";
                }
                case "savereplaylog":
                {
                    return I18n.getUiText("ui.chat.console.help.savereplaylog");
                }
                case "synchrosequence":
                {
                    return "Enable/disable synchro sequence";
                }
                case "throw":
                {
                    return "Throw an exception (test only) option:[async|sync]";
                }
                default:
                {
                    break;
                }
            }
            return "No help for command \'" + param1 + "\'";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_4:* = [];
            switch(param1)
            {
                case "throw":
                {
                    _loc_4 = ["async", "sync"];
                    break;
                }
                case "setquality":
                {
                    _loc_4 = [StageQuality.LOW, StageQuality.MEDIUM, StageQuality.HIGH, StageQuality.BEST];
                    break;
                }
                case "config":
                {
                    if (param2 == 0)
                    {
                        _loc_4 = OptionManager.getOptionManagers();
                    }
                    else if (param2 == 1)
                    {
                        _loc_5 = param3[0];
                        for (_loc_6 in OptionManager.getOptionManager(_loc_5))
                        {
                            
                            _loc_4.push(_loc_6);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

    }
}
