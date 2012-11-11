package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.managers.*;

    public class UiHandlerInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function UiHandlerInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            switch(param2)
            {
                case "loadui":
                {
                    break;
                }
                case "unloadui":
                {
                    if (param3.length == 0)
                    {
                        _loc_10 = 0;
                        _loc_11 = [];
                        for (_loc_12 in Berilia.getInstance().uiList)
                        {
                            
                            if (Berilia.getInstance().uiList[_loc_12].name != "Console")
                            {
                                _loc_11.push(Berilia.getInstance().uiList[_loc_12].name);
                            }
                        }
                        for each (_loc_12 in _loc_11)
                        {
                            
                            Berilia.getInstance().unloadUi(_loc_12);
                        }
                        param1.output(_loc_11.length + " UI were unload");
                        break;
                    }
                    if (Berilia.getInstance().unloadUi(param3[0]))
                    {
                        param1.output("RIP " + param3[0]);
                    }
                    else
                    {
                        param1.output(param3[0] + " does not exist or an error occured while unloading UI");
                    }
                    break;
                }
                case "clearuicache":
                {
                    UiRenderManager.getInstance().clearCache();
                    break;
                }
                case "setuiscale":
                {
                    Berilia.getInstance().scale = Number(param3[0]);
                    break;
                }
                case "useuicache":
                {
                    StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, "useCache", param3[0] == "true");
                    BeriliaConstants.USE_UI_CACHE = param3[0] == "true";
                    break;
                }
                case "uilist":
                {
                    for (_loc_13 in Berilia.getInstance().uiList)
                    {
                        
                        param1.output(" - " + _loc_13);
                    }
                    break;
                }
                case "reloadui":
                {
                    UiModuleManager.getInstance().loadModule(param3[0]);
                    break;
                }
                case "fps":
                {
                    Dofus.getInstance().toggleFPS();
                    break;
                }
                case "modulelist":
                {
                    _loc_5 = "Enable module :";
                    _loc_6 = UiModuleManager.getInstance().getModules();
                    for each (_loc_4 in _loc_6)
                    {
                        
                        _loc_5 = _loc_5 + ("\n - " + _loc_4.id);
                    }
                    _loc_6 = UiModuleManager.getInstance().disabledModule;
                    if (_loc_6.length)
                    {
                        _loc_5 = _loc_5 + "\n\nDisable module :";
                        for each (_loc_4 in _loc_6)
                        {
                            
                            _loc_5 = _loc_5 + ("\n - " + _loc_4.id);
                        }
                    }
                    param1.output(_loc_5);
                    break;
                }
                case "getmoduleinfo":
                {
                    _loc_7 = UiModuleManager.getInstance().getModule(param3[0]);
                    if (_loc_7)
                    {
                        _loc_14 = new ModuleScriptAnalyzer(_loc_7);
                    }
                    else
                    {
                        param1.output("Module " + param3[0] + " does not exists");
                    }
                    break;
                }
                case "chatoutput":
                {
                    _loc_8 = !param3.length || String(param3[0]).toLowerCase() == "true" || String(param3[0]).toLowerCase() == "on";
                    Console.getInstance().display();
                    Console.getInstance().disableLogEvent();
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ToggleChatLog, _loc_8);
                    _loc_9 = OptionManager.getOptionManager("chat")["chatoutput"];
                    OptionManager.getOptionManager("chat")["chatoutput"] = _loc_8;
                    if (_loc_8)
                    {
                        param1.output("Chatoutput is on.");
                    }
                    else
                    {
                        param1.output("Chatoutput is off.");
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
                case "loadui":
                {
                    return "Load an UI. Usage: loadUi <uiId> <uiInstanceName>(optional)";
                }
                case "unloadui":
                {
                    return "Unload UI with the given UI instance name.";
                }
                case "clearuicache":
                {
                    return "Clear all UI in cache (will force xml parsing).";
                }
                case "setuiscale":
                {
                    return "Set scale for all scalable UI. Usage: setUiScale <Number> (100% = 1.0)";
                }
                case "useuicache":
                {
                    return "Enable UI caching";
                }
                case "uilist":
                {
                    return "Get current UI list";
                }
                case "reloadui":
                {
                    return "Unload and reload an Ui";
                }
                case "fps":
                {
                    return "Toggle FPS";
                }
                case "chatoutput":
                {
                    return "Display the chat content in a separated window.";
                }
                case "modulelist":
                {
                    return "Display activated modules.";
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
            var _loc_4:* = [];
            switch(param1)
            {
                case "unloadui":
                {
                    if (param2 == 0)
                    {
                        for (_loc_5 in Berilia.getInstance().uiList)
                        {
                            
                            _loc_4.push(Berilia.getInstance().uiList[_loc_5].name);
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
