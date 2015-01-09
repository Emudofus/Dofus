package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import avmplus.getQualifiedClassName;
    import com.ankamagames.dofus.misc.utils.Inspector;
    import flash.utils.Dictionary;
    import com.ankamagames.berilia.types.data.UiModule;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;
    import com.ankamagames.berilia.types.graphic.GraphicContainer;
    import com.ankamagames.berilia.types.data.UiData;
    import com.ankamagames.berilia.utils.ModuleScriptAnalyzer;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.managers.UiRenderManager;
    import com.ankamagames.jerakine.managers.StoreDataManager;
    import com.ankamagames.berilia.BeriliaConstants;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.console.moduleLogger.Console;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;

    public class UiHandlerInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(UiHandlerInstructionHandler));

        private var _uiInspector:Inspector;


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:Dictionary;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:UiModule;
            var _local_8:Array;
            var _local_9:UiModule;
            var _local_10:Boolean;
            var _local_11:Boolean;
            var _local_12:UiRootContainer;
            var _local_13:GraphicContainer;
            var count:uint;
            var uiList:Array;
            var i:String;
            var uiName:String;
            var ui:UiData;
            var ma:ModuleScriptAnalyzer;
            switch (cmd)
            {
                case "loadui":
                    return;
                case "unloadui":
                    if (args.length == 0)
                    {
                        count = 0;
                        uiList = [];
                        for (i in Berilia.getInstance().uiList)
                        {
                            if (Berilia.getInstance().uiList[i].name != "Console")
                            {
                                uiList.push(Berilia.getInstance().uiList[i].name);
                            };
                        };
                        for each (i in uiList)
                        {
                            Berilia.getInstance().unloadUi(i);
                        };
                        console.output((uiList.length + " UI were unload"));
                        return;
                    };
                    if (Berilia.getInstance().unloadUi(args[0]))
                    {
                        console.output(("RIP " + args[0]));
                    }
                    else
                    {
                        console.output((args[0] + " does not exist or an error occured while unloading UI"));
                    };
                    return;
                case "clearuicache":
                    UiRenderManager.getInstance().clearCache();
                    return;
                case "setuiscale":
                    Berilia.getInstance().scale = Number(args[0]);
                    return;
                case "useuicache":
                    StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_DEFINITION, "useCache", (args[0] == "true"));
                    BeriliaConstants.USE_UI_CACHE = (args[0] == "true");
                    return;
                case "uilist":
                    _local_4 = Berilia.getInstance().uiList;
                    _local_5 = [];
                    for (uiName in _local_4)
                    {
                        ui = UiRootContainer(_local_4[uiName]).uiData;
                        _local_5.push([uiName, ui.name, ui.uiClassName, ui.module.id, ui.module.trusted]);
                    };
                    console.output(StringUtils.formatArray(_local_5, ["Instance ID", "Ui name", "Class", "Module", "Trusted"]));
                    return;
                case "reloadui":
                    UiModuleManager.getInstance().loadModule(args[0]);
                    return;
                case "fps":
                    Dofus.getInstance().toggleFPS();
                    return;
                case "modulelist":
                    _local_6 = [];
                    _local_8 = UiModuleManager.getInstance().getModules();
                    for each (_local_7 in _local_8)
                    {
                        _local_6.push([_local_7.id, _local_7.author, _local_7.trusted, true]);
                    };
                    _local_8 = UiModuleManager.getInstance().disabledModules;
                    if (_local_8.length)
                    {
                        for each (_local_7 in _local_8)
                        {
                            _local_6.push([_local_7.id, _local_7.author, _local_7.trusted, false]);
                        };
                    };
                    console.output(StringUtils.formatArray(_local_6, ["ID", "Author", "Trusted", "Active"]));
                    return;
                case "getmoduleinfo":
                    _local_9 = UiModuleManager.getInstance().getModule(args[0]);
                    if (_local_9)
                    {
                        ma = new ModuleScriptAnalyzer(_local_9, null);
                    }
                    else
                    {
                        console.output((("Module " + args[0]) + " does not exists"));
                    };
                    return;
                case "chatoutput":
                    _local_10 = ((((!(args.length)) || ((String(args[0]).toLowerCase() == "true")))) || ((String(args[0]).toLowerCase() == "on")));
                    Console.getInstance().display();
                    Console.getInstance().disableLogEvent();
                    KernelEventsManager.getInstance().processCallback(ChatHookList.ToggleChatLog, _local_10);
                    _local_11 = OptionManager.getOptionManager("chat")["chatoutput"];
                    OptionManager.getOptionManager("chat")["chatoutput"] = _local_10;
                    if (_local_10)
                    {
                        console.output("Chatoutput is on.");
                    }
                    else
                    {
                        console.output("Chatoutput is off.");
                    };
                    return;
                case "uiinspector":
                case "inspector":
                    if (!(this._uiInspector))
                    {
                        this._uiInspector = new Inspector();
                    };
                    this._uiInspector.enable = !(this._uiInspector.enable);
                    if (this._uiInspector.enable)
                    {
                        console.output("Inspector is ON.\n Use Ctrl-C to save the last hovered element informations.");
                    }
                    else
                    {
                        console.output("Inspector is OFF.");
                    };
                    return;
                case "inspectuielementsos":
                case "inspectuielement":
                    if (args.length == 0)
                    {
                        console.output((((cmd + " need at least one argument (") + cmd) + " uiName [uiElementName])"));
                        return;
                    };
                    _local_12 = Berilia.getInstance().getUi(args[0]);
                    if (!(_local_12))
                    {
                        console.output((("UI " + args[0]) + " not found (use /uilist to grab current displayed UI list)"));
                        return;
                    };
                    if (args.length == 1)
                    {
                        this.inspectUiElement(_local_12, (((cmd == "inspectuielementsos")) ? null : console));
                        return;
                    };
                    _local_13 = _local_12.getElement(args[1]);
                    if (!(_local_13))
                    {
                        console.output((((("UI Element " + args[0]) + " not found on UI ") + args[0]) + "(use /uiinspector to view elements names)"));
                        return;
                    };
                    this.inspectUiElement(_local_13, (((cmd == "inspectuielementsos")) ? null : console));
                    return;
            };
        }

        private function inspectUiElement(target:GraphicContainer, console:ConsoleHandler):void
        {
            var txt:String;
            var property:String;
            var type:String;
            var properties:Array = DescribeTypeCache.getVariables(target).concat();
            properties.sort();
            for each (property in properties)
            {
                try
                {
                    type = ((!((target[property] == null))) ? getQualifiedClassName(target[property]).split("::").pop() : "?");
                    if (type == "Array")
                    {
                        type = (type + (", len: " + target[property].length));
                    };
                    txt = ((((property + " (") + type) + ") : ") + target[property]);
                }
                catch(e:Error)
                {
                    txt = (property + " (?) : <Exception throw by getter>");
                };
                if (!(console))
                {
                    _log.info(txt);
                }
                else
                {
                    console.output(txt);
                };
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "loadui":
                    return ("Load an UI. Usage: loadUi <uiId> <uiInstanceName>(optional)");
                case "unloadui":
                    return ("Unload UI with the given UI instance name.");
                case "clearuicache":
                    return ("Clear all UI in cache (will force xml parsing).");
                case "setuiscale":
                    return ("Set scale for all scalable UI. Usage: setUiScale <Number> (100% = 1.0)");
                case "useuicache":
                    return ("Enable UI caching");
                case "uilist":
                    return ("Get current UI list");
                case "reloadui":
                    return ("Unload and reload an Ui");
                case "fps":
                    return ("Toggle FPS");
                case "chatoutput":
                    return ("Display the chat content in a separated window.");
                case "modulelist":
                    return ("Display activated modules.");
                case "inspector":
                case "uiinspector":
                    return ("Display a tooltip with informations over each interactive element");
                case "inspectuielement":
                    return ("Display the property list of an UI element (UI or Component), usage /inspectuielement uiName (elementName)");
                case "inspectuielementsos":
                    return ("Display the property list of an UI element (UI or Component) to SOS, usage /inspectuielement uiName (elementName)");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            var i:String;
            var possibilities:Array = [];
            switch (cmd)
            {
                case "unloadui":
                    if (paramIndex == 0)
                    {
                        for (i in Berilia.getInstance().uiList)
                        {
                            possibilities.push(Berilia.getInstance().uiList[i].name);
                        };
                    };
                    break;
            };
            return (possibilities);
        }


    }
}//package com.ankamagames.dofus.console.debug

