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
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = false;
            var _loc_24:* = null;
            this._chCurrent = param1;
            switch(param2)
            {
                case "kerneleventdtd":
                {
                    _loc_8 = describeType(getDefinitionByName("com.ankamagames.dofus.utils.KernelEventList"));
                    _loc_5 = "";
                    _loc_7 = new Array();
                    for each (_loc_4 in _loc_8..constant)
                    {
                        
                        _loc_6 = "on" + _loc_4..@type.split("::")[(_loc_4..@type.split("::").length - 1)];
                        _loc_5 = _loc_5 + ("&lt;!ELEMENT " + _loc_6 + " EMPTY &gt;\n");
                        _loc_7.push(_loc_6);
                    }
                    _loc_5 = _loc_5 + ("&lt;!ELEMENT SystemEvents (" + _loc_7.join(" | ") + ")* &gt;");
                    param1.output(_loc_5);
                    break;
                }
                case "shortcutsdtd":
                {
                    if (param3[0] != null)
                    {
                        _loc_9 = param3[0];
                    }
                    if (!_loc_9)
                    {
                        _loc_10 = new URLRequest(LangManager.getInstance().getEntry("config.binds.file"));
                    }
                    else
                    {
                        _loc_10 = new URLRequest(LangManager.getInstance().getEntry("config.binds.path.root") + "bind_" + _loc_9 + ".xml");
                    }
                    _log.error(_loc_10.url);
                    _loc_11 = new URLLoader();
                    _loc_11.addEventListener(Event.COMPLETE, this.onXmlLoadComplete);
                    _loc_11.addEventListener(IOErrorEvent.IO_ERROR, this.onXmlLoadError);
                    _loc_11.load(_loc_10);
                    break;
                }
                case "componentdtd":
                {
                    _loc_12 = describeType(getDefinitionByName("com.ankamagames.berilia.utils.ComponentList"));
                    param3 = new Array();
                    for each (_loc_4 in _loc_12..constant)
                    {
                        
                        param3.push(_loc_4..@type.split("::").join("."));
                    }
                }
                case "dtd":
                {
                    _loc_13 = new Array();
                    _loc_14 = new Array();
                    _loc_5 = "";
                    _loc_16 = "";
                    _loc_20 = 0;
                    while (_loc_20 < param3.length)
                    {
                        
                        if (param3[_loc_20].indexOf(".") == -1)
                        {
                            _loc_15 = "com.ankamagames.berilia.components." + param3[_loc_20];
                        }
                        else
                        {
                            _loc_15 = param3[_loc_20];
                        }
                        if (ApplicationDomain.currentDomain.hasDefinition(_loc_15))
                        {
                            _loc_21 = _loc_15.split(".")[(_loc_15.split(".").length - 1)];
                            _loc_22 = describeType(getDefinitionByName(_loc_15));
                            _loc_7 = new Array();
                            var _loc_25:* = 0;
                            var _loc_26:* = _loc_22..accessor;
                            do
                            {
                                
                                _loc_24 = _loc_26[_loc_25];
                                _loc_23 = _loc_24..@declaredBy.indexOf("ankamagames") != -1;
                                _loc_17 = 0;
                                while (_loc_17 < DONT_IGNORE.length)
                                {
                                    
                                    if (DONT_IGNORE[_loc_17] == _loc_24..@name)
                                    {
                                        _loc_23 = true;
                                        break;
                                    }
                                    _loc_17 = _loc_17 + 1;
                                }
                                _loc_17 = 0;
                                while (_loc_17 < IGNORE.length)
                                {
                                    
                                    if (IGNORE[_loc_17] == _loc_24..@name)
                                    {
                                        _loc_23 = false;
                                        break;
                                    }
                                    _loc_17 = _loc_17 + 1;
                                }
                                if (_loc_23 && (_loc_24..@type == "String" || _loc_24..@type == "Boolean" || _loc_24..@type == "Number" || _loc_24..@type == "uint" || _loc_24..@type == "int"))
                                {
                                    try
                                    {
                                        if (_loc_14[_loc_24..@name] == null)
                                        {
                                            _loc_14[_loc_24..@name] = {type:_loc_24..@type, ref:[_loc_21]};
                                        }
                                        else
                                        {
                                            _loc_14[_loc_24..@name].ref.push(_loc_21);
                                        }
                                        _loc_7[_loc_24..@name] = _loc_24..@type;
                                    }
                                    catch (e:Error)
                                    {
                                    }
                                }
                            }while (_loc_26 in _loc_25)
                            _loc_13[_loc_21] = _loc_7;
                        }
                        else
                        {
                            param1.output(_loc_15 + " cannot be found.");
                        }
                        _loc_20 = _loc_20 + 1;
                    }
                    _loc_16 = "";
                    for (_loc_18 in _loc_14)
                    {
                        
                        if (_loc_14[_loc_18].ref.length > 1)
                        {
                            _loc_16 = _loc_16 + ("&lt;!ELEMENT " + _loc_18 + " (#PCDATA) &gt;&lt;!-- " + _loc_14[_loc_18].type + ", used by " + _loc_14[_loc_18].ref.join(", ") + " --&gt;\n");
                        }
                    }
                    if (_loc_16.length)
                    {
                        _loc_5 = _loc_5 + ("\n\n&lt;!--======================= Common Elements =======================--&gt;\n\n" + _loc_16);
                    }
                    for (_loc_18 in _loc_13)
                    {
                        
                        _loc_5 = _loc_5 + ("\n\n&lt;!--======================= " + _loc_18 + " Elements =======================--&gt;\n\n");
                        _loc_7 = new Array();
                        for (_loc_19 in _loc_13[_loc_18])
                        {
                            
                            if (isNaN(Number(_loc_19)))
                            {
                                _loc_7.push(_loc_19 + "?");
                            }
                            if (_loc_14[_loc_19] != null && _loc_14[_loc_19].ref.length == 1)
                            {
                                _loc_5 = _loc_5 + ("&lt;!ELEMENT " + _loc_19 + " (#PCDATA) &gt;&lt;!-- " + _loc_13[_loc_18][_loc_19] + " --&gt;\n");
                            }
                        }
                        _loc_7.push("Size?");
                        _loc_7.push("Anchors?");
                        _loc_7.push("Events?");
                        _loc_5 = _loc_5 + ("&lt;!ELEMENT " + _loc_18 + " (" + _loc_7.join(" | ") + ")* &gt;\n");
                        _loc_5 = _loc_5 + ("&lt;!ATTLIST " + _loc_18 + "\n" + "\t\tname CDATA #IMPLIED\n" + "\t\tstrata (LOW | MEDIUM | HIGH | TOP | TOOLTIP) #IMPLIED &gt;");
                    }
                    param1.output(_loc_5);
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
