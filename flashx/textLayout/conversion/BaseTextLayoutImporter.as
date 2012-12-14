package flashx.textLayout.conversion
{
    import flash.system.*;
    import flashx.textLayout.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.property.*;

    class BaseTextLayoutImporter extends ConverterBase implements ITextImporter
    {
        private var _ns:Namespace;
        private var _textFlowNamespace:Namespace;
        protected var _config:ImportExportConfiguration;
        protected var _textFlowConfiguration:IConfiguration = null;
        protected var _importVersion:uint;
        private var _impliedPara:ParagraphElement = null;
        private static const anyPrintChar:RegExp = /[^	t
nr ]""[^	
 ]/g;
        private static const dblSpacePattern:RegExp = /[ ]{2,}""[ ]{2,}/g;
        private static const tabNewLinePattern:RegExp = /[	t
nr]""[	
]/g;

        function BaseTextLayoutImporter(param1:Namespace, param2:ImportExportConfiguration)
        {
            this._ns = param1;
            this._config = param2;
            return;
        }// end function

        override function clear() : void
        {
            super.clear();
            this._textFlowNamespace = null;
            this._impliedPara = null;
            return;
        }// end function

        public function importToFlow(param1:Object) : TextFlow
        {
            var source:* = param1;
            this.clear();
            if (throwOnError)
            {
                return this.importToFlowCanThrow(source);
            }
            var rslt:TextFlow;
            var savedErrorHandler:* = Property.errorHandler;
            try
            {
                Property.errorHandler = this.importPropertyErrorHandler;
                rslt = this.importToFlowCanThrow(source);
            }
            catch (e:Error)
            {
                reportError(e.toString());
            }
            Property.errorHandler = savedErrorHandler;
            return rslt;
        }// end function

        public function get configuration() : IConfiguration
        {
            return this._textFlowConfiguration;
        }// end function

        public function set configuration(param1:IConfiguration) : void
        {
            this._textFlowConfiguration = param1;
            return;
        }// end function

        protected function importPropertyErrorHandler(param1:Property, param2:Object) : void
        {
            reportError(Property.createErrorString(param1, param2));
            return;
        }// end function

        private function importToFlowCanThrow(param1:Object) : TextFlow
        {
            if (param1 is String)
            {
                return this.importFromString(String(param1));
            }
            if (param1 is XML)
            {
                return this.importFromXML(XML(param1));
            }
            return null;
        }// end function

        protected function importFromString(param1:String) : TextFlow
        {
            var xmlTree:XML;
            var source:* = param1;
            var originalSettings:* = XML.settings();
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            xmlTree = new XML(source);
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                XML.setSettings(originalSettings);
            }
            var textFlow:* = this.importFromXML(xmlTree);
            if (Configuration.playerEnablesArgoFeatures)
            {
                var _loc_3:* = System;
                _loc_3.System["disposeXML"](xmlTree);
            }
            return textFlow;
        }// end function

        protected function importFromXML(param1:XML) : TextFlow
        {
            return this.parseContent(param1[0]);
        }// end function

        protected function parseContent(param1:XML) : TextFlow
        {
            var _loc_2:* = param1..TextFlow[0];
            if (_loc_2)
            {
                return parseTextFlow(this, param1);
            }
            return null;
        }// end function

        public function get ns() : Namespace
        {
            return this._ns;
        }// end function

        protected function checkNamespace(param1:XML) : Boolean
        {
            var _loc_2:* = param1.namespace();
            if (!this._textFlowNamespace)
            {
                if (_loc_2 != this.ns)
                {
                    reportError(GlobalSettings.resourceStringFunction("unexpectedNamespace", [_loc_2.toString()]));
                    return false;
                }
                this._textFlowNamespace = _loc_2;
            }
            else if (_loc_2 != this._textFlowNamespace)
            {
                reportError(GlobalSettings.resourceStringFunction("unexpectedNamespace", [_loc_2.toString()]));
                return false;
            }
            return true;
        }// end function

        public function parseAttributes(param1:XML, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            for each (_loc_3 in param2)
            {
                
                _loc_3.reset();
            }
            if (!param1)
            {
                return;
            }
            for each (_loc_4 in param1.attributes())
            {
                
                _loc_5 = _loc_4.name().localName;
                _loc_6 = _loc_4.toString();
                _loc_7 = false;
                if (param1.localName() == "TextFlow")
                {
                    if (_loc_5 == "version")
                    {
                        continue;
                    }
                }
                else if (this._importVersion < TextLayoutVersion.VERSION_2_0 && (_loc_5 == "paddingLeft" || _loc_5 == "paddingTop" || _loc_5 == "paddingRight" || _loc_5 == "paddingBottom"))
                {
                    continue;
                }
                for each (_loc_3 in param2)
                {
                    
                    if (_loc_3.importOneFormat(_loc_5, _loc_6))
                    {
                        _loc_7 = true;
                        break;
                    }
                }
                if (!_loc_7)
                {
                    this.handleUnknownAttribute(param1.name().localName, _loc_5);
                }
            }
            return;
        }// end function

        public function createTextFlowFromXML(param1:XML, param2:TextFlow = null) : TextFlow
        {
            return null;
        }// end function

        public function createParagraphFromXML(param1:XML) : ParagraphElement
        {
            return null;
        }// end function

        public function createSpanFromXML(param1:XML) : SpanElement
        {
            return null;
        }// end function

        public function createBreakFromXML(param1:XML) : BreakElement
        {
            this.parseAttributes(param1, null);
            return new BreakElement();
        }// end function

        public function createListFromXML(param1:XML) : ListElement
        {
            return null;
        }// end function

        public function createListItemFromXML(param1:XML) : ListItemElement
        {
            return null;
        }// end function

        public function createTabFromXML(param1:XML) : TabElement
        {
            this.parseAttributes(param1, null);
            return new TabElement();
        }// end function

        public function parseFlowChildren(param1:XML, param2:FlowGroupElement) : void
        {
            this.parseFlowGroupElementChildren(param1, param2);
            return;
        }// end function

        public function parseFlowGroupElementChildren(param1:XML, param2:FlowGroupElement, param3:Object = null, param4:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            for each (_loc_5 in param1.children())
            {
                
                if (_loc_5.nodeKind() == "element")
                {
                    this.parseObject(_loc_5.name().localName, _loc_5, param2, param3);
                    continue;
                }
                if (_loc_5.nodeKind() == "text")
                {
                    _loc_6 = _loc_5.toString();
                    _loc_7 = false;
                    if (param2 is ContainerFormattedElement)
                    {
                        _loc_7 = _loc_6.search(anyPrintChar) == -1;
                    }
                    if (!_loc_7)
                    {
                        this.addChild(param2, this.createImpliedSpan(_loc_6));
                    }
                }
            }
            if (!param4 && param2 is ContainerFormattedElement)
            {
                this.resetImpliedPara();
            }
            return;
        }// end function

        public function createImpliedSpan(param1:String) : SpanElement
        {
            var _loc_2:* = new SpanElement();
            _loc_2.text = param1;
            return _loc_2;
        }// end function

        public function createParagraphFlowFromXML(param1:XML, param2:TextFlow = null) : TextFlow
        {
            return null;
        }// end function

        function parseObject(param1:String, param2:XML, param3:FlowGroupElement, param4:Object = null) : void
        {
            if (!this.checkNamespace(param2))
            {
                return;
            }
            var _loc_5:* = this._config.lookup(param1);
            if (!this._config.lookup(param1))
            {
                if (param4 == null || param4[param1] === undefined)
                {
                    this.handleUnknownElement(param1, param2, param3);
                }
            }
            else
            {
                _loc_5.parser(this, param2, param3);
            }
            return;
        }// end function

        protected function handleUnknownElement(param1:String, param2:XML, param3:FlowGroupElement) : void
        {
            reportError(GlobalSettings.resourceStringFunction("unknownElement", [param1]));
            return;
        }// end function

        protected function handleUnknownAttribute(param1:String, param2:String) : void
        {
            reportError(GlobalSettings.resourceStringFunction("unknownAttribute", [param2, param1]));
            return;
        }// end function

        protected function getElementInfo(param1:XML) : FlowElementInfo
        {
            return this._config.lookup(param1.name().localName);
        }// end function

        protected function GetClass(param1:XML) : Class
        {
            var _loc_2:* = this._config.lookup(param1.name().localName);
            return _loc_2 ? (_loc_2.flowClass) : (null);
        }// end function

        function createImpliedParagraph() : ParagraphElement
        {
            return this.createParagraphFromXML(<p/>")("<p/>);
        }// end function

        function addChild(param1:FlowGroupElement, param2:FlowElement) : Boolean
        {
            var parent:* = param1;
            var child:* = param2;
            if (child is ParagraphFormattedElement)
            {
                this.resetImpliedPara();
            }
            else if (parent is ContainerFormattedElement)
            {
                if (!this._impliedPara)
                {
                    this._impliedPara = this.createImpliedParagraph();
                    parent.addChild(this._impliedPara);
                }
                parent = this._impliedPara;
            }
            if (throwOnError)
            {
                parent.addChild(child);
            }
            else
            {
                try
                {
                    parent.addChild(child);
                }
                catch (e)
                {
                    reportError(e);
                    return false;
                }
            }
            return true;
        }// end function

        function resetImpliedPara() : void
        {
            if (this._impliedPara)
            {
                this.onResetImpliedPara(this._impliedPara);
                this._impliedPara = null;
            }
            return;
        }// end function

        protected function onResetImpliedPara(param1:ParagraphElement) : void
        {
            return;
        }// end function

        static function stripWhitespace(param1:String) : String
        {
            return param1.replace(tabNewLinePattern, " ");
        }// end function

        public static function parseTextFlow(param1:BaseTextLayoutImporter, param2:XML, param3:Object = null) : TextFlow
        {
            return param1.createTextFlowFromXML(param2, null);
        }// end function

        public static function parsePara(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createParagraphFromXML(param2);
            if (param1.addChild(param3, _loc_4))
            {
                param1.parseFlowGroupElementChildren(param2, _loc_4);
                if (_loc_4.numChildren == 0)
                {
                    _loc_4.addChild(new SpanElement());
                }
            }
            return;
        }// end function

        static function copyAllStyleProps(param1:FlowLeafElement, param2:FlowLeafElement) : void
        {
            param1.format = param2.format;
            param1.typeName = param2.typeName;
            param1.id = param2.id;
            return;
        }// end function

        public static function parseSpan(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_4:* = param1.createSpanFromXML(param2);
            var _loc_5:* = param2[0].children();
            if (param2[0].children().length() == 0)
            {
                param1.addChild(param3, _loc_4);
                return;
            }
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = _loc_6.name() ? (_loc_6.name().localName) : (null);
                if (_loc_7 == null)
                {
                    if (_loc_4.parent == null)
                    {
                        _loc_4.text = _loc_6.toString();
                        param1.addChild(param3, _loc_4);
                    }
                    else
                    {
                        _loc_8 = new SpanElement();
                        copyAllStyleProps(_loc_8, _loc_4);
                        _loc_8.text = _loc_6.toString();
                        param1.addChild(param3, _loc_8);
                    }
                    continue;
                }
                if (_loc_7 == "br")
                {
                    _loc_9 = param1.createBreakFromXML(_loc_6);
                    if (_loc_9)
                    {
                        copyAllStyleProps(_loc_9, _loc_4);
                        param1.addChild(param3, _loc_9);
                    }
                    else
                    {
                        param1.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan", [_loc_7]));
                    }
                    continue;
                }
                if (_loc_7 == "tab")
                {
                    _loc_10 = param1.createTabFromXML(_loc_6);
                    if (_loc_10)
                    {
                        copyAllStyleProps(_loc_10, _loc_4);
                        param1.addChild(param3, _loc_10);
                    }
                    else
                    {
                        param1.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan", [_loc_7]));
                    }
                    continue;
                }
                param1.reportError(GlobalSettings.resourceStringFunction("unexpectedXMLElementInSpan", [_loc_7]));
            }
            return;
        }// end function

        public static function parseBreak(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createBreakFromXML(param2);
            param1.addChild(param3, _loc_4);
            return;
        }// end function

        public static function parseTab(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createTabFromXML(param2);
            if (param1.createTabFromXML(param2))
            {
                param1.addChild(param3, _loc_4);
            }
            return;
        }// end function

        public static function parseList(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createListFromXML(param2);
            if (param1.addChild(param3, _loc_4))
            {
                param1.parseFlowGroupElementChildren(param2, _loc_4);
            }
            return;
        }// end function

        public static function parseListItem(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createListItemFromXML(param2);
            if (param1.addChild(param3, _loc_4))
            {
                param1.parseFlowGroupElementChildren(param2, _loc_4);
                if (_loc_4.numChildren == 0)
                {
                    _loc_4.addChild(new ParagraphElement());
                }
            }
            return;
        }// end function

        static function extractAttributesHelper(param1:Object, param2:TLFormatImporter) : Object
        {
            if (param1 == null)
            {
                return param2.result;
            }
            if (param2.result == null)
            {
                return param1;
            }
            var _loc_3:* = new param2.classType(param1);
            _loc_3.apply(param2.result);
            return _loc_3;
        }// end function

    }
}
