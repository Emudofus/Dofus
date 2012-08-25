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
            var _loc_4:Logger = null;
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            var _loc_7:uint = 0;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:File = null;
            var _loc_11:* = undefined;
            var _loc_12:Array = null;
            var _loc_13:String = null;
            var _loc_14:Object = null;
            var _loc_15:* = undefined;
            var _loc_16:FileStream = null;
            var _loc_17:ByteArray = null;
            switch(param2)
            {
                case "log":
                {
                    _loc_4 = Log.getLogger(getQualifiedClassName(MiscInstructionHandler));
                    LogLogger.activeLog(param3[0] == "true" || param3[0] == "on");
                    param1.output("Log set to " + LogLogger.logIsActive());
                    break;
                }
                case "newdofus":
                {
                    NativeApplication.nativeApplication.dispatchEvent(new Event(InvokeEvent.INVOKE));
                    break;
                }
                case "i18nsize":
                {
                    _loc_5 = 0;
                    _loc_6 = 0;
                    _loc_7 = 1;
                    _loc_8 = "";
                    do
                    {
                        
                        _loc_8 = I18n.getText(_loc_7++);
                        if (_loc_8)
                        {
                            _loc_6 = 0;
                            _loc_5 = _loc_5 + _loc_8.length;
                            continue;
                        }
                        _loc_6 = _loc_6 + 1;
                    }while (_loc_6 < 20)
                    param1.output(_loc_5 + " characters in " + (_loc_7 - 1) + " entries.");
                    break;
                }
                case "clear":
                {
                    KernelEventsManager.getInstance().processCallback(HookList.ConsoleClear);
                    break;
                }
                case "config":
                {
                    if (!param3[0])
                    {
                        param1.output("Syntax : /config <manager> [<option>]");
                        break;
                    }
                    _loc_9 = param3[0];
                    if (!OptionManager.getOptionManager(_loc_9))
                    {
                        param1.output("Unknown manager \'" + _loc_9 + "\').");
                        break;
                    }
                    if (param3[1])
                    {
                        if (OptionManager.getOptionManager("atouin")[param3[1]] != null)
                        {
                            _loc_11 = param3[2];
                            if (_loc_11 == "true")
                            {
                                _loc_11 = true;
                            }
                            if (_loc_11 == "false")
                            {
                                _loc_11 = false;
                            }
                            if (parseInt(_loc_11).toString() == _loc_11)
                            {
                                _loc_11 = parseInt(_loc_11);
                            }
                            OptionManager.getOptionManager("atouin")[param3[1]] = _loc_11;
                        }
                        else
                        {
                            param1.output(param3[1] + " not found on AtouinOption");
                        }
                    }
                    else
                    {
                        _loc_12 = new Array();
                        for (_loc_13 in OptionManager.getOptionManager("atouin"))
                        {
                            
                            _loc_12.push({name:_loc_13, value:OptionManager.getOptionManager("atouin")[_loc_13]});
                        }
                        _loc_12.sortOn("name");
                        for each (_loc_14 in _loc_12)
                        {
                            
                            param1.output(" - " + _loc_14.name + " : " + _loc_14.value);
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
                    if (param3.length != 2)
                    {
                        param1.output("Syntax : /getEventModeParams <login> <password>");
                        return;
                    }
                    param1.output(Base64.encode("login:" + param3[0] + ",password:" + param3[1]));
                    break;
                }
                case "setquality":
                {
                    if (param3.length != 1)
                    {
                        param1.output("Current stage.quality : [" + StageShareManager.stage.quality + "]");
                        return;
                    }
                    StageShareManager.stage.quality = param3[0];
                    param1.output("Try set stage.qualitity to [" + param3[0] + "], result : [" + StageShareManager.stage.quality + "]");
                    break;
                }
                case "lowdefskin":
                {
                    for each (_loc_15 in EntitiesManager.getInstance().entities)
                    {
                        
                        if (_loc_15 is TiphonSprite)
                        {
                            TiphonSprite(_loc_15).setAlternativeSkinIndex(TiphonSprite(_loc_15).getAlternativeSkinIndex() == -1 ? (0) : (-1));
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
                    _loc_10 = LogFrame.getInstance(false).duplicateLogFile();
                    if (_loc_10.exists)
                    {
                        _loc_16 = new FileStream();
                        _loc_17 = new ByteArray();
                        _loc_16.open(_loc_10, FileMode.READ);
                        _loc_16.readBytes(_loc_17);
                        File.desktopDirectory.save(_loc_17, "log.d2l");
                    }
                    break;
                }
                case "synchrosequence":
                {
                    if (Kernel.getWorker().contains(SynchronisationFrame))
                    {
                        this._synchronisationFrameInstance = Kernel.getWorker().getFrame(SynchronisationFrame) as SynchronisationFrame;
                        Kernel.getWorker().removeFrame(this._synchronisationFrameInstance);
                        param1.output("Synchro sequence disable");
                    }
                    else if (this._synchronisationFrameInstance)
                    {
                        param1.output("Synchro sequence enable");
                        Kernel.getWorker().addFrame(this._synchronisationFrameInstance);
                    }
                    else
                    {
                        param1.output("Can\'t enable synchro sequence");
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
                default:
                {
                    break;
                }
            }
            return "No help for command \'" + param1 + "\'";
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_4:Array = [];
            switch(param1)
            {
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
