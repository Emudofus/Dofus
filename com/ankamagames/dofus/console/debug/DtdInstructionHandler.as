package com.ankamagames.dofus.console.debug
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class DtdInstructionHandler extends Object implements ConsoleInstructionHandler
    {
        private var _chCurrent:ConsoleHandler;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(DtdInstructionHandler));
        public static const DONT_IGNORE:Array = new Array("alpha", "linkedTo");
        public static const IGNORE:Array = new Array("width", "height", "haveFocus");

        public function DtdInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var constants:XML;
            var sBuffer:String;
            var sClassName:String;
            var aElement:Array;
            var xmlKernelEvents:XML;
            var sLang:String;
            var urlRequest:URLRequest;
            var ulLoader:URLLoader;
            var xmlCpt:XML;
            var aElements:Array;
            var aCommonElements:Array;
            var sClass:String;
            var sSubBuffer:String;
            var i:uint;
            var sIter:String;
            var sSubIter:String;
            var j:uint;
            var className:String;
            var xmlDef:XML;
            var bDontIgnore:Boolean;
            var accessor:XML;
            var console:* = param1;
            var cmd:* = param2;
            var args:* = param3;
            this._chCurrent = console;
            switch(cmd)
            {
                case "kerneleventdtd":
                {
                    xmlKernelEvents = describeType(getDefinitionByName("com.ankamagames.dofus.utils.KernelEventList"));
                    sBuffer;
                    aElement = new Array();
                    var _loc_5:* = 0;
                    var _loc_6:* = xmlKernelEvents..constant;
                    while (_loc_6 in _loc_5)
                    {
                        
                        constants = _loc_6[_loc_5];
                        sClassName = "on" + constants..@type.split("::")[(constants..@type.split("::").length - 1)];
                        sBuffer = sBuffer + ("&lt;!ELEMENT " + sClassName + " EMPTY &gt;\n");
                        aElement.push(sClassName);
                    }
                    sBuffer = sBuffer + ("&lt;!ELEMENT SystemEvents (" + aElement.join(" | ") + ")* &gt;");
                    console.output(sBuffer);
                    break;
                }
                case "shortcutsdtd":
                {
                    if (args[0] != null)
                    {
                        sLang = args[0];
                    }
                    if (!sLang)
                    {
                        urlRequest = new URLRequest(LangManager.getInstance().getEntry("config.binds.file"));
                    }
                    else
                    {
                        urlRequest = new URLRequest(LangManager.getInstance().getEntry("config.binds.path.root") + "bind_" + sLang + ".xml");
                    }
                    _log.error(urlRequest.url);
                    ulLoader = new URLLoader();
                    ulLoader.addEventListener(Event.COMPLETE, this.onXmlLoadComplete);
                    ulLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onXmlLoadError);
                    ulLoader.load(urlRequest);
                    break;
                }
                case "componentdtd":
                {
                    xmlCpt = describeType(getDefinitionByName("com.ankamagames.berilia.utils.ComponentList"));
                    args = new Array();
                    var _loc_5:* = 0;
                    var _loc_6:* = xmlCpt..constant;
                    while (_loc_6 in _loc_5)
                    {
                        
                        constants = _loc_6[_loc_5];
                        args.push(constants..@type.split("::").join("."));
                    }
                }
                case "dtd":
                {
                    aElements = new Array();
                    aCommonElements = new Array();
                    sBuffer;
                    sSubBuffer;
                    j;
                    while (j < args.length)
                    {
                        
                        if (args[j].indexOf(".") == -1)
                        {
                            sClass = "com.ankamagames.berilia.components." + args[j];
                        }
                        else
                        {
                            sClass = args[j];
                        }
                        if (ApplicationDomain.currentDomain.hasDefinition(sClass))
                        {
                            className = sClass.split(".")[(sClass.split(".").length - 1)];
                            xmlDef = describeType(getDefinitionByName(sClass));
                            aElement = new Array();
                            var _loc_5:* = 0;
                            var _loc_6:* = xmlDef..accessor;
                            do
                            {
                                
                                accessor = _loc_6[_loc_5];
                                bDontIgnore = accessor..@declaredBy.indexOf("ankamagames") != -1;
                                i;
                                while (i < DONT_IGNORE.length)
                                {
                                    
                                    if (DONT_IGNORE[i] == accessor..@name)
                                    {
                                        bDontIgnore;
                                        break;
                                    }
                                    i = (i + 1);
                                }
                                i;
                                while (i < IGNORE.length)
                                {
                                    
                                    if (IGNORE[i] == accessor..@name)
                                    {
                                        bDontIgnore;
                                        break;
                                    }
                                    i = (i + 1);
                                }
                                if (bDontIgnore && (accessor..@type == "String" || accessor..@type == "Boolean" || accessor..@type == "Number" || accessor..@type == "uint" || accessor..@type == "int"))
                                {
                                    try
                                    {
                                        if (aCommonElements[accessor..@name] == null)
                                        {
                                            aCommonElements[accessor..@name] = {type:accessor..@type, ref:[className]};
                                        }
                                        else
                                        {
                                            aCommonElements[accessor..@name].ref.push(className);
                                        }
                                        aElement[accessor..@name] = accessor..@type;
                                    }
                                    catch (e:Error)
                                    {
                                    }
                                }
                            }while (_loc_6 in _loc_5)
                            aElements[className] = aElement;
                        }
                        else
                        {
                            console.output(sClass + " cannot be found.");
                        }
                        j = (j + 1);
                    }
                    sSubBuffer;
                    var _loc_5:* = 0;
                    var _loc_6:* = aCommonElements;
                    while (_loc_6 in _loc_5)
                    {
                        
                        sIter = _loc_6[_loc_5];
                        if (aCommonElements[sIter].ref.length > 1)
                        {
                            sSubBuffer = sSubBuffer + ("&lt;!ELEMENT " + sIter + " (#PCDATA) &gt;&lt;!-- " + aCommonElements[sIter].type + ", used by " + aCommonElements[sIter].ref.join(", ") + " --&gt;\n");
                        }
                    }
                    if (sSubBuffer.length)
                    {
                        sBuffer = sBuffer + ("\n\n&lt;!--======================= Common Elements =======================--&gt;\n\n" + sSubBuffer);
                    }
                    var _loc_5:* = 0;
                    var _loc_6:* = aElements;
                    while (_loc_6 in _loc_5)
                    {
                        
                        sIter = _loc_6[_loc_5];
                        sBuffer = sBuffer + ("\n\n&lt;!--======================= " + sIter + " Elements =======================--&gt;\n\n");
                        aElement = new Array();
                        var _loc_7:* = 0;
                        var _loc_8:* = aElements[sIter];
                        while (_loc_8 in _loc_7)
                        {
                            
                            sSubIter = _loc_8[_loc_7];
                            if (isNaN(Number(sSubIter)))
                            {
                                aElement.push(sSubIter + "?");
                            }
                            if (aCommonElements[sSubIter] != null && aCommonElements[sSubIter].ref.length == 1)
                            {
                                sBuffer = sBuffer + ("&lt;!ELEMENT " + sSubIter + " (#PCDATA) &gt;&lt;!-- " + aElements[sIter][sSubIter] + " --&gt;\n");
                            }
                        }
                        aElement.push("Size?");
                        aElement.push("Anchors?");
                        aElement.push("Events?");
                        sBuffer = sBuffer + ("&lt;!ELEMENT " + sIter + " (" + aElement.join(" | ") + ")* &gt;\n");
                        sBuffer = sBuffer + ("&lt;!ATTLIST " + sIter + "\n" + "\t\tname CDATA #IMPLIED\n" + "\t\tstrata (LOW | MEDIUM | HIGH | TOP | TOOLTIP) #IMPLIED &gt;");
                    }
                    console.output(sBuffer);
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
                case "kernelEventdtd":
                {
                    return "Generate the Kernel Events DTD.";
                }
                case "componentdtd":
                {
                    return "Generate the Components DTD.";
                }
                case "shortcutsdtd":
                {
                    return "Generate the Shortcuts DTD.";
                }
                case "dtd":
                {
                    return "Generate a DTD for a given class or component.";
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
            return [];
        }// end function

        private function parseShortcutXml(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = XML(param1);
            var _loc_3:* = "";
            var _loc_4:* = new Array();
            for each (_loc_5 in _loc_2..bind)
            {
                
                _loc_3 = _loc_3 + ("&lt;!ELEMENT " + _loc_5..@name + " EMPTY &gt;\n");
                _loc_4.push(_loc_5..@name);
            }
            _loc_3 = _loc_3 + ("&lt;!ELEMENT Shortcuts (" + _loc_4.join(" | ") + ")* &gt;");
            if (this._chCurrent != null)
            {
                this._chCurrent.output(_loc_3);
            }
            return;
        }// end function

        public function onXmlLoadComplete(event:Event) : void
        {
            var _loc_2:* = URLLoader(event.target);
            this.parseShortcutXml(_loc_2.data);
            return;
        }// end function

        public function onXmlLoadError(event:Event) : void
        {
            if (this._chCurrent != null)
            {
                this._chCurrent.output("IO Error : KeyboardBind file cannot be found");
            }
            return;
        }// end function

    }
}
