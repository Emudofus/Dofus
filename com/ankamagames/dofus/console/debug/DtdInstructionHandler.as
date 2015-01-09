package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import com.ankamagames.jerakine.managers.LangManager;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.system.ApplicationDomain;

    public class DtdInstructionHandler implements ConsoleInstructionHandler 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DtdInstructionHandler));
        public static const DONT_IGNORE:Array = new Array("alpha", "linkedTo");
        public static const IGNORE:Array = new Array("width", "height", "haveFocus");

        private var _chCurrent:ConsoleHandler;


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var constants:XML;
            var sBuffer:String;
            var sClassName:String;
            var aElement:Array;
            var _local_8:XML;
            var _local_9:String;
            var _local_10:URLRequest;
            var _local_11:URLLoader;
            var _local_12:XML;
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:String;
            var _local_16:String;
            var _local_17:uint;
            var _local_18:String;
            var _local_19:String;
            var j:uint;
            var className:String;
            var xmlDef:XML;
            var bDontIgnore:Boolean;
            var accessor:XML;
            this._chCurrent = console;
            switch (cmd)
            {
                case "kerneleventdtd":
                    _local_8 = describeType(getDefinitionByName("com.ankamagames.dofus.utils.KernelEventList"));
                    sBuffer = "";
                    aElement = new Array();
                    for each (constants in _local_8..constant)
                    {
                        sClassName = ("on" + constants..@type.split("::")[(constants..@type.split("::").length - 1)]);
                        sBuffer = (sBuffer + (("&lt;!ELEMENT " + sClassName) + " EMPTY &gt;\n"));
                        aElement.push(sClassName);
                    };
                    sBuffer = (sBuffer + (("&lt;!ELEMENT SystemEvents (" + aElement.join(" | ")) + ")* &gt;"));
                    console.output(sBuffer);
                    return;
                case "shortcutsdtd":
                    if (args[0] != null)
                    {
                        _local_9 = args[0];
                    };
                    if (!(_local_9))
                    {
                        _local_10 = new URLRequest(LangManager.getInstance().getEntry("config.binds.file"));
                    }
                    else
                    {
                        _local_10 = new URLRequest((((LangManager.getInstance().getEntry("config.binds.path.root") + "bind_") + _local_9) + ".xml"));
                    };
                    _log.error(_local_10.url);
                    _local_11 = new URLLoader();
                    _local_11.addEventListener(Event.COMPLETE, this.onXmlLoadComplete);
                    _local_11.addEventListener(IOErrorEvent.IO_ERROR, this.onXmlLoadError);
                    _local_11.load(_local_10);
                    return;
                case "componentdtd":
                    _local_12 = describeType(getDefinitionByName("com.ankamagames.berilia.utils.ComponentList"));
                    args = new Array();
                    for each (constants in _local_12..constant)
                    {
                        args.push(constants..@type.split("::").join("."));
                    };
                case "dtd":
                    _local_13 = new Array();
                    _local_14 = new Array();
                    sBuffer = "";
                    _local_16 = "";
                    j = 0;
                    while (j < args.length)
                    {
                        if (args[j].indexOf(".") == -1)
                        {
                            _local_15 = ("com.ankamagames.berilia.components." + args[j]);
                        }
                        else
                        {
                            _local_15 = args[j];
                        };
                        if (ApplicationDomain.currentDomain.hasDefinition(_local_15))
                        {
                            className = _local_15.split(".")[(_local_15.split(".").length - 1)];
                            xmlDef = describeType(getDefinitionByName(_local_15));
                            aElement = new Array();
                            for each (accessor in xmlDef..accessor)
                            {
                                bDontIgnore = !((accessor..@declaredBy.indexOf("ankamagames") == -1));
                                _local_17 = 0;
                                while (_local_17 < DONT_IGNORE.length)
                                {
                                    if (DONT_IGNORE[_local_17] == accessor..@name)
                                    {
                                        bDontIgnore = true;
                                        break;
                                    };
                                    _local_17++;
                                };
                                _local_17 = 0;
                                while (_local_17 < IGNORE.length)
                                {
                                    if (IGNORE[_local_17] == accessor..@name)
                                    {
                                        bDontIgnore = false;
                                        break;
                                    };
                                    _local_17++;
                                };
                                if (((bDontIgnore) && ((((((((((accessor..@type == "String")) || ((accessor..@type == "Boolean")))) || ((accessor..@type == "Number")))) || ((accessor..@type == "uint")))) || ((accessor..@type == "int"))))))
                                {
                                    try
                                    {
                                        if (_local_14[accessor..@name] == null)
                                        {
                                            _local_14[accessor..@name] = {
                                                "type":accessor..@type,
                                                "ref":[className]
                                            };
                                        }
                                        else
                                        {
                                            _local_14[accessor..@name].ref.push(className);
                                        };
                                        aElement[accessor..@name] = accessor..@type;
                                    }
                                    catch(e:Error)
                                    {
                                    };
                                };
                            };
                            _local_13[className] = aElement;
                        }
                        else
                        {
                            console.output((_local_15 + " cannot be found."));
                        };
                        j++;
                    };
                    _local_16 = "";
                    for (_local_18 in _local_14)
                    {
                        if (_local_14[_local_18].ref.length > 1)
                        {
                            _local_16 = (_local_16 + (((((("&lt;!ELEMENT " + _local_18) + " (#PCDATA) &gt;&lt;!-- ") + _local_14[_local_18].type) + ", used by ") + _local_14[_local_18].ref.join(", ")) + " --&gt;\n"));
                        };
                    };
                    if (_local_16.length)
                    {
                        sBuffer = (sBuffer + ("\n\n&lt;!--======================= Common Elements =======================--&gt;\n\n" + _local_16));
                    };
                    for (_local_18 in _local_13)
                    {
                        sBuffer = (sBuffer + (("\n\n&lt;!--======================= " + _local_18) + " Elements =======================--&gt;\n\n"));
                        aElement = new Array();
                        for (_local_19 in _local_13[_local_18])
                        {
                            if (isNaN(Number(_local_19)))
                            {
                                aElement.push((_local_19 + "?"));
                            };
                            if (((!((_local_14[_local_19] == null))) && ((_local_14[_local_19].ref.length == 1))))
                            {
                                sBuffer = (sBuffer + (((("&lt;!ELEMENT " + _local_19) + " (#PCDATA) &gt;&lt;!-- ") + _local_13[_local_18][_local_19]) + " --&gt;\n"));
                            };
                        };
                        aElement.push("Size?");
                        aElement.push("Anchors?");
                        aElement.push("Events?");
                        sBuffer = (sBuffer + (((("&lt;!ELEMENT " + _local_18) + " (") + aElement.join(" | ")) + ")* &gt;\n"));
                        sBuffer = (sBuffer + (((("&lt;!ATTLIST " + _local_18) + "\n") + "\t\tname CDATA #IMPLIED\n") + "\t\tstrata (LOW | MEDIUM | HIGH | TOP | TOOLTIP) #IMPLIED &gt;"));
                    };
                    console.output(sBuffer);
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "kernelEventdtd":
                    return ("Generate the Kernel Events DTD.");
                case "componentdtd":
                    return ("Generate the Components DTD.");
                case "shortcutsdtd":
                    return ("Generate the Shortcuts DTD.");
                case "dtd":
                    return ("Generate a DTD for a given class or component.");
            };
            return ((("No help for command '" + cmd) + "'"));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }

        private function parseShortcutXml(sXml:String):void
        {
            var shortcut:XML;
            var xmlShortcuts:XML = XML(sXml);
            var sBuffer:String = "";
            var aElement:Array = new Array();
            for each (shortcut in xmlShortcuts..bind)
            {
                sBuffer = (sBuffer + (("&lt;!ELEMENT " + shortcut..@name) + " EMPTY &gt;\n"));
                aElement.push(shortcut..@name);
            };
            sBuffer = (sBuffer + (("&lt;!ELEMENT Shortcuts (" + aElement.join(" | ")) + ")* &gt;"));
            if (this._chCurrent != null)
            {
                this._chCurrent.output(sBuffer);
            };
        }

        public function onXmlLoadComplete(event:Event):void
        {
            var loader:URLLoader = URLLoader(event.target);
            this.parseShortcutXml(loader.data);
        }

        public function onXmlLoadError(event:Event):void
        {
            if (this._chCurrent != null)
            {
                this._chCurrent.output("IO Error : KeyboardBind file cannot be found");
            };
        }


    }
}//package com.ankamagames.dofus.console.debug

