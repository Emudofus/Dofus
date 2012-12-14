package com.ankamagames.dofus.console.debug
{
    import avmplus.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.console.moduleLogger.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.utils.misc.*;

    public class UiHandlerInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        private var _uiInspector:UiInspector;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(UiHandlerInstructionHandler));

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
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
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
                        _loc_12 = 0;
                        _loc_13 = [];
                        for (_loc_14 in Berilia.getInstance().uiList)
                        {
                            
                            if (Berilia.getInstance().uiList[_loc_14].name != "Console")
                            {
                                _loc_13.push(Berilia.getInstance().uiList[_loc_14].name);
                            }
                        }
                        for each (_loc_14 in _loc_13)
                        {
                            
                            Berilia.getInstance().unloadUi(_loc_14);
                        }
                        param1.output(_loc_13.length + " UI were unload");
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
                    for (_loc_15 in Berilia.getInstance().uiList)
                    {
                        
                        param1.output(" - " + _loc_15);
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
                        _loc_16 = new ModuleScriptAnalyzer(_loc_7);
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
                case "uiinspector":
                {
                    if (!this._uiInspector)
                    {
                        this._uiInspector = new UiInspector();
                    }
                    this._uiInspector.enable = !this._uiInspector.enable;
                    if (this._uiInspector.enable)
                    {
                        param1.output("UI Inspector is ON.\n Use Ctrl-C to save the last hovered element informations.");
                    }
                    else
                    {
                        param1.output("UI Inspector is OFF.");
                    }
                    break;
                }
                case "inspectuielementsos":
                case "inspectuielement":
                {
                    if (param3.length == 0)
                    {
                        param1.output(param2 + " need at least one argument (" + param2 + " uiName [uiElementName])");
                        break;
                    }
                    _loc_10 = Berilia.getInstance().getUi(param3[0]);
                    if (!_loc_10)
                    {
                        param1.output("UI " + param3[0] + " not found (use /uilist to grab current displayed UI list)");
                        break;
                    }
                    if (param3.length == 1)
                    {
                        this.inspectUiElement(_loc_10, param2 == "inspectuielementsos" ? (null) : (param1));
                        break;
                    }
                    _loc_11 = _loc_10.getElement(param3[1]);
                    if (!_loc_11)
                    {
                        param1.output("UI Element " + param3[0] + " not found on UI " + param3[0] + "(use /uiinspector to view elements names)");
                        break;
                    }
                    this.inspectUiElement(_loc_11, param2 == "inspectuielementsos" ? (null) : (param1));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function inspectUiElement(param1:GraphicContainer, param2:ConsoleHandler) : void
        {
            var txt:String;
            var property:String;
            var type:String;
            var target:* = param1;
            var console:* = param2;
            var properties:* = DescribeTypeCache.getVariables(target).concat();
            properties.sort();
            var _loc_4:* = 0;
            var _loc_5:* = properties;
            while (_loc_5 in _loc_4)
            {
                
                property = _loc_5[_loc_4];
                try
                {
                    type = target[property] != null ? (getQualifiedClassName(target[property]).split("::").pop()) : ("?");
                    if (type == "Array")
                    {
                        type = type + (", len: " + target[property].length);
                    }
                    txt = property + " (" + type + ") : " + target[property];
                }
                catch (e:Error)
                {
                    txt = property + " (?) : <Exception throw by getter>";
                }
                if (!console)
                {
                    _log.info(txt);
                    continue;
                }
                console.output(txt);
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
                case "uiinspector":
                {
                    return "Display a tooltip over each interactive UI element";
                }
                case "inspectuielement":
                {
                    return "Display the property list of an UI element (UI or Component), usage /inspectuielement uiName (elementName)";
                }
                case "inspectuielementsos":
                {
                    return "Display the property list of an UI element (UI or Component) to SOS, usage /inspectuielement uiName (elementName)";
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
