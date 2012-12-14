package flashx.textLayout.conversion
{
    import flash.system.*;
    import flash.utils.*;
    import flashx.textLayout.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    class BaseTextLayoutExporter extends ConverterBase implements ITextExporter
    {
        private var _config:ImportExportConfiguration;
        private var _rootTag:XML;
        private var _ns:Namespace;
        private static const brRegEx:RegExp = / "" /;

        function BaseTextLayoutExporter(param1:Namespace, param2:XML, param3:ImportExportConfiguration)
        {
            this._config = param3;
            this._ns = param1;
            this._rootTag = param2;
            return;
        }// end function

        public function export(param1:TextFlow, param2:String) : Object
        {
            clear();
            var _loc_3:* = this.exportToXML(param1);
            return param2 == ConversionType.STRING_TYPE ? (convertXMLToString(_loc_3)) : (_loc_3);
        }// end function

        protected function exportToXML(param1:TextFlow) : XML
        {
            var _loc_2:* = null;
            if (this._rootTag)
            {
                _loc_2 = new XML(this._rootTag);
                _loc_2.addNamespace(this._ns);
                _loc_2.appendChild(this.exportChild(param1));
            }
            else
            {
                _loc_2 = XML(exportTextFlow(this, param1));
                _loc_2.addNamespace(this._ns);
            }
            return _loc_2;
        }// end function

        protected function exportFlowElement(param1:FlowElement) : XMLList
        {
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = this._config.lookupName(_loc_2);
            var _loc_4:* = new XML("<" + _loc_3 + "/>");
            new XML("<" + _loc_3 + "/>").setNamespace(this._ns);
            return XMLList(_loc_4);
        }// end function

        protected function get spanTextReplacementRegex() : RegExp
        {
            return brRegEx;
        }// end function

        protected function getSpanTextReplacementXML(param1:String) : XML
        {
            var _loc_2:* = <br/>")("<br/>;
            _loc_2.setNamespace(this.flowNS);
            return _loc_2;
        }// end function

        protected function exportParagraphFormattedElement(param1:FlowElement) : XMLList
        {
            var _loc_4:* = null;
            var _loc_2:* = this.exportFlowElement(param1);
            var _loc_3:* = 0;
            while (_loc_3 < ParagraphFormattedElement(param1).numChildren)
            {
                
                _loc_4 = ParagraphFormattedElement(param1).getChildAt(_loc_3);
                _loc_2.appendChild(this.exportChild(_loc_4));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        protected function exportList(param1:FlowElement) : XMLList
        {
            var _loc_4:* = null;
            var _loc_2:* = this.exportFlowElement(param1);
            var _loc_3:* = 0;
            while (_loc_3 < FlowGroupElement(param1).numChildren)
            {
                
                _loc_4 = FlowGroupElement(param1).getChildAt(_loc_3);
                _loc_2.appendChild(this.exportChild(_loc_4));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        protected function exportListItem(param1:FlowElement) : XMLList
        {
            var _loc_4:* = null;
            var _loc_2:* = this.exportFlowElement(param1);
            var _loc_3:* = 0;
            while (_loc_3 < FlowGroupElement(param1).numChildren)
            {
                
                _loc_4 = FlowGroupElement(param1).getChildAt(_loc_3);
                _loc_2.appendChild(this.exportChild(_loc_4));
                _loc_3++;
            }
            return _loc_2;
        }// end function

        protected function exportContainerFormattedElement(param1:FlowElement) : XMLList
        {
            return this.exportParagraphFormattedElement(param1);
        }// end function

        public function exportChild(param1:FlowElement) : XMLList
        {
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = this._config.lookupByClass(_loc_2);
            if (_loc_3 != null)
            {
                return _loc_3.exporter(this, param1);
            }
            return null;
        }// end function

        protected function exportStyles(param1:XMLList, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            param2.sortOn("xmlName");
            for each (_loc_3 in param2)
            {
                
                _loc_4 = _loc_3.xmlVal;
                if (!useClipboardAnnotations && _loc_3.xmlName == ConverterBase.MERGE_TO_NEXT_ON_PASTE)
                {
                    continue;
                }
                if (_loc_4 is String)
                {
                    param1[_loc_3.xmlName] = _loc_4;
                    continue;
                }
                if (_loc_4 is XMLList)
                {
                    param1.appendChild(_loc_4);
                }
            }
            return;
        }// end function

        function get flowNS() : Namespace
        {
            return this._ns;
        }// end function

        protected function get formatDescription() : Object
        {
            return null;
        }// end function

        static function convertXMLToString(param1:XML) : String
        {
            var result:String;
            var originalSettings:Object;
            var xml:* = param1;
            originalSettings = XML.settings();
            try
            {
                XML.ignoreProcessingInstructions = false;
                XML.ignoreWhitespace = false;
                XML.prettyPrinting = false;
                result = xml.toXMLString();
                if (Configuration.playerEnablesArgoFeatures)
                {
                    var _loc_3:* = System;
                    _loc_3.System["disposeXML"](xml);
                }
                XML.setSettings(originalSettings);
            }
            catch (e:Error)
            {
                XML.setSettings(originalSettings);
                throw e;
            }
            return result;
        }// end function

        public static function exportFlowElement(param1:BaseTextLayoutExporter, param2:FlowElement) : XMLList
        {
            return param1.exportFlowElement(param2);
        }// end function

        public static function exportSpanText(param1:XML, param2:SpanElement, param3:RegExp, param4:Function) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_5:* = param2.text;
            var _loc_6:* = param2.text.match(param3);
            if (param2.text.match(param3))
            {
                while (_loc_6 != null)
                {
                    
                    _loc_8 = _loc_6.index;
                    _loc_9 = _loc_5.substr(0, _loc_8);
                    if (_loc_9.length > 0)
                    {
                        _loc_7 = <dummy/>")("<dummy/>;
                        _loc_7.appendChild(_loc_9);
                        param1.appendChild(_loc_7.text()[0]);
                    }
                    _loc_10 = BaseTextLayoutExporter.param4(_loc_5.charAt(_loc_8));
                    param1.appendChild(_loc_10);
                    _loc_5 = _loc_5.slice((_loc_8 + 1), _loc_5.length);
                    _loc_6 = _loc_5.match(param3);
                    if (!_loc_6 && _loc_5.length > 0)
                    {
                        _loc_7 = <dummy/>")("<dummy/>;
                        _loc_7.appendChild(_loc_5);
                        param1.appendChild(_loc_7.text()[0]);
                    }
                }
            }
            else
            {
                param1.appendChild(_loc_5);
            }
            return;
        }// end function

        public static function exportSpan(param1:BaseTextLayoutExporter, param2:SpanElement) : XMLList
        {
            var _loc_3:* = exportFlowElement(param1, param2);
            exportSpanText(_loc_3[0], param2, param1.spanTextReplacementRegex, param1.getSpanTextReplacementXML);
            return _loc_3;
        }// end function

        public static function exportFlowGroupElement(param1:BaseTextLayoutExporter, param2:FlowGroupElement) : XMLList
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = exportFlowElement(param1, param2);
            var _loc_4:* = 0;
            while (_loc_4 < param2.numChildren)
            {
                
                _loc_5 = param2.getChildAt(_loc_4);
                _loc_6 = param1.exportChild(_loc_5);
                if (_loc_6)
                {
                    _loc_3.appendChild(_loc_6);
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function exportParagraphFormattedElement(param1:BaseTextLayoutExporter, param2:ParagraphFormattedElement) : XMLList
        {
            return param1.exportParagraphFormattedElement(param2);
        }// end function

        public static function exportList(param1:BaseTextLayoutExporter, param2:ParagraphFormattedElement) : XMLList
        {
            return param1.exportList(param2);
        }// end function

        public static function exportListItem(param1:BaseTextLayoutExporter, param2:ParagraphFormattedElement) : XMLList
        {
            return param1.exportListItem(param2);
        }// end function

        public static function exportContainerFormattedElement(param1:BaseTextLayoutExporter, param2:ContainerFormattedElement) : XMLList
        {
            return param1.exportContainerFormattedElement(param2);
        }// end function

        public static function exportTextFlow(param1:BaseTextLayoutExporter, param2:TextFlow) : XMLList
        {
            var _loc_3:* = exportContainerFormattedElement(param1, param2);
            _loc_3[TextLayoutFormat.whiteSpaceCollapseProperty.name] = WhiteSpaceCollapse.PRESERVE;
            _loc_3["version"] = TextLayoutVersion.getVersionString(TextLayoutVersion.CURRENT_VERSION);
            return _loc_3;
        }// end function

    }
}
