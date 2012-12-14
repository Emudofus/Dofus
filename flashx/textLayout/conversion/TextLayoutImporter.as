package flashx.textLayout.conversion
{
    import flash.utils.*;
    import flashx.textLayout.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class TextLayoutImporter extends BaseTextLayoutImporter implements ITextLayoutImporter
    {
        private var _imageSourceResolveFunction:Function;
        private static var _defaultConfiguration:ImportExportConfiguration;
        private static const _formatImporter:TLFormatImporter = new TLFormatImporter(TextLayoutFormat, TextLayoutFormat.description);
        private static const _idImporter:SingletonAttributeImporter = new SingletonAttributeImporter("id");
        private static const _typeNameImporter:SingletonAttributeImporter = new SingletonAttributeImporter("typeName");
        private static const _customFormatImporter:CustomFormatImporter = new CustomFormatImporter();
        private static const _flowElementFormatImporters:Array = [_formatImporter, _idImporter, _typeNameImporter, _customFormatImporter];
        static const _linkDescription:Object = {href:Property.NewStringProperty("href", null, false, null), target:Property.NewStringProperty("target", null, false, null)};
        private static const _linkFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary, _linkDescription);
        private static const _linkElementFormatImporters:Array = [_linkFormatImporter, _formatImporter, _idImporter, _typeNameImporter, _customFormatImporter];
        private static const _imageDescription:Object = {height:InlineGraphicElement.heightPropertyDefinition, width:InlineGraphicElement.widthPropertyDefinition, source:Property.NewStringProperty("source", null, false, null), float:Property.NewStringProperty("float", null, false, null), rotation:InlineGraphicElement.rotationPropertyDefinition};
        private static const _ilgFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary, _imageDescription);
        private static const _ilgElementFormatImporters:Array = [_ilgFormatImporter, _formatImporter, _idImporter, _typeNameImporter, _customFormatImporter];

        public function TextLayoutImporter()
        {
            super(new Namespace("flow", "http://ns.adobe.com/textLayout/2008"), defaultConfiguration);
            return;
        }// end function

        public function get imageSourceResolveFunction() : Function
        {
            return this._imageSourceResolveFunction;
        }// end function

        public function set imageSourceResolveFunction(param1:Function) : void
        {
            this._imageSourceResolveFunction = param1;
            return;
        }// end function

        override protected function parseContent(param1:XML) : TextFlow
        {
            var _loc_2:* = param1.name().localName;
            var _loc_3:* = _loc_2 == "TextFlow" ? (param1) : (param1..TextFlow[0]);
            if (!_loc_3)
            {
                reportError(GlobalSettings.resourceStringFunction("missingTextFlow"));
                return null;
            }
            if (!checkNamespace(_loc_3))
            {
                return null;
            }
            return parseTextFlow(this, _loc_3);
        }// end function

        private function parseStandardFlowElementAttributes(param1:FlowElement, param2:XML, param3:Array = null) : void
        {
            var _loc_5:* = null;
            if (param3 == null)
            {
                param3 = _flowElementFormatImporters;
            }
            parseAttributes(param2, param3);
            var _loc_4:* = this.extractTextFormatAttributesHelper(param1.format, _formatImporter) as TextLayoutFormat;
            if (this.extractTextFormatAttributesHelper(param1.format, _formatImporter) as TextLayoutFormat)
            {
                param1.format = _loc_4;
            }
            if (_idImporter.result)
            {
                param1.id = _idImporter.result as String;
            }
            if (_typeNameImporter.result)
            {
                param1.typeName = _typeNameImporter.result as String;
            }
            if (_customFormatImporter.result)
            {
                for (_loc_5 in _customFormatImporter.result)
                {
                    
                    param1.setStyle(_loc_5, _customFormatImporter.result[_loc_5]);
                }
            }
            return;
        }// end function

        override public function createTextFlowFromXML(param1:XML, param2:TextFlow = null) : TextFlow
        {
            var _loc_4:* = null;
            var _loc_3:* = null;
            if (!checkNamespace(param1))
            {
                return _loc_3;
            }
            if (param1.hasOwnProperty("@version"))
            {
                _loc_4 = param1["version"];
                if (_loc_4 == "2.0.0")
                {
                    _importVersion = TextLayoutVersion.VERSION_2_0;
                }
                else if (_loc_4 == "1.1.0" || _loc_4 == "1.0.0")
                {
                    _importVersion = TextLayoutVersion.VERSION_1_0;
                }
                else
                {
                    reportError(GlobalSettings.resourceStringFunction("unsupportedVersion", [param1["version"]]));
                    _importVersion = TextLayoutVersion.CURRENT_VERSION;
                }
            }
            else
            {
                _importVersion = TextLayoutVersion.VERSION_1_0;
            }
            if (!_loc_3)
            {
                _loc_3 = new TextFlow(_textFlowConfiguration);
            }
            this.parseStandardFlowElementAttributes(_loc_3, param1);
            parseFlowGroupElementChildren(param1, _loc_3);
            _loc_3.normalize();
            _loc_3.applyWhiteSpaceCollapse(null);
            return _loc_3;
        }// end function

        public function createDivFromXML(param1:XML) : DivElement
        {
            var _loc_2:* = new DivElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        override public function createParagraphFromXML(param1:XML) : ParagraphElement
        {
            var _loc_2:* = new ParagraphElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        public function createSubParagraphGroupFromXML(param1:XML) : SubParagraphGroupElement
        {
            var _loc_2:* = new SubParagraphGroupElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        public function createTCYFromXML(param1:XML) : TCYElement
        {
            var _loc_2:* = new TCYElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        public function createLinkFromXML(param1:XML) : LinkElement
        {
            var _loc_2:* = new LinkElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1, _linkElementFormatImporters);
            if (_linkFormatImporter.result)
            {
                _loc_2.href = _linkFormatImporter.result["href"] as String;
                _loc_2.target = _linkFormatImporter.result["target"] as String;
            }
            return _loc_2;
        }// end function

        override public function createSpanFromXML(param1:XML) : SpanElement
        {
            var _loc_2:* = new SpanElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        public function createInlineGraphicFromXML(param1:XML) : InlineGraphicElement
        {
            var _loc_3:* = null;
            var _loc_2:* = new InlineGraphicElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1, _ilgElementFormatImporters);
            if (_ilgFormatImporter.result)
            {
                _loc_3 = _ilgFormatImporter.result["source"];
                _loc_2.source = this._imageSourceResolveFunction != null ? (this._imageSourceResolveFunction(_loc_3)) : (_loc_3);
                _loc_2.height = _ilgFormatImporter.result["height"];
                _loc_2.width = _ilgFormatImporter.result["width"];
                _loc_2.float = _ilgFormatImporter.result["float"];
            }
            return _loc_2;
        }// end function

        override public function createListFromXML(param1:XML) : ListElement
        {
            var _loc_2:* = new ListElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        override public function createListItemFromXML(param1:XML) : ListItemElement
        {
            var _loc_2:* = new ListItemElement();
            this.parseStandardFlowElementAttributes(_loc_2, param1);
            return _loc_2;
        }// end function

        public function extractTextFormatAttributesHelper(param1:Object, param2:TLFormatImporter) : Object
        {
            return extractAttributesHelper(param1, param2);
        }// end function

        public function createDictionaryFromXML(param1:XML) : Dictionary
        {
            var _loc_2:* = [_customFormatImporter];
            var _loc_3:* = param1..TextLayoutFormat;
            if (_loc_3.length() != 1)
            {
                reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneTextLayoutFormat", [param1.name()]));
            }
            var _loc_4:* = _loc_3.length() > 0 ? (_loc_3[0]) : (param1);
            parseAttributes(_loc_4, _loc_2);
            return _customFormatImporter.result as Dictionary;
        }// end function

        public function createListMarkerFormatDictionaryFromXML(param1:XML) : Dictionary
        {
            var _loc_2:* = [_customFormatImporter];
            var _loc_3:* = param1..ListMarkerFormat;
            if (_loc_3.length() != 1)
            {
                reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneListMarkerFormat", [param1.name()]));
            }
            var _loc_4:* = _loc_3.length() > 0 ? (_loc_3[0]) : (param1);
            parseAttributes(_loc_4, _loc_2);
            return _customFormatImporter.result as Dictionary;
        }// end function

        public static function get defaultConfiguration() : ImportExportConfiguration
        {
            if (!_defaultConfiguration)
            {
                _defaultConfiguration = new ImportExportConfiguration();
                _defaultConfiguration.addIEInfo("TextFlow", TextFlow, BaseTextLayoutImporter.parseTextFlow, BaseTextLayoutExporter.exportTextFlow);
                _defaultConfiguration.addIEInfo("br", BreakElement, BaseTextLayoutImporter.parseBreak, BaseTextLayoutExporter.exportFlowElement);
                _defaultConfiguration.addIEInfo("p", ParagraphElement, BaseTextLayoutImporter.parsePara, BaseTextLayoutExporter.exportParagraphFormattedElement);
                _defaultConfiguration.addIEInfo("span", SpanElement, BaseTextLayoutImporter.parseSpan, BaseTextLayoutExporter.exportSpan);
                _defaultConfiguration.addIEInfo("tab", TabElement, BaseTextLayoutImporter.parseTab, BaseTextLayoutExporter.exportFlowElement);
                _defaultConfiguration.addIEInfo("list", ListElement, BaseTextLayoutImporter.parseList, BaseTextLayoutExporter.exportList);
                _defaultConfiguration.addIEInfo("li", ListItemElement, BaseTextLayoutImporter.parseListItem, BaseTextLayoutExporter.exportListItem);
                _defaultConfiguration.addIEInfo("g", SubParagraphGroupElement, TextLayoutImporter.parseSPGE, TextLayoutExporter.exportSPGE);
                _defaultConfiguration.addIEInfo("tcy", TCYElement, TextLayoutImporter.parseTCY, TextLayoutExporter.exportTCY);
                _defaultConfiguration.addIEInfo("a", LinkElement, TextLayoutImporter.parseLink, TextLayoutExporter.exportLink);
                _defaultConfiguration.addIEInfo("div", DivElement, TextLayoutImporter.parseDivElement, TextLayoutExporter.exportDiv);
                _defaultConfiguration.addIEInfo("img", InlineGraphicElement, TextLayoutImporter.parseInlineGraphic, TextLayoutExporter.exportImage);
                _defaultConfiguration.addIEInfo(LinkElement.LINK_NORMAL_FORMAT_NAME, null, TextLayoutImporter.parseLinkNormalFormat, null);
                _defaultConfiguration.addIEInfo(LinkElement.LINK_ACTIVE_FORMAT_NAME, null, TextLayoutImporter.parseLinkActiveFormat, null);
                _defaultConfiguration.addIEInfo(LinkElement.LINK_HOVER_FORMAT_NAME, null, TextLayoutImporter.parseLinkHoverFormat, null);
                _defaultConfiguration.addIEInfo(ListElement.LIST_MARKER_FORMAT_NAME, null, TextLayoutImporter.parseListMarkerFormat, null);
            }
            return _defaultConfiguration;
        }// end function

        public static function restoreDefaults() : void
        {
            _defaultConfiguration = null;
            return;
        }// end function

        public static function parseSPGE(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = TextLayoutImporter.TextLayoutImporter(param1).createSubParagraphGroupFromXML(param2);
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

        public static function parseTCY(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = TextLayoutImporter.TextLayoutImporter(param1).createTCYFromXML(param2);
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

        public static function parseLink(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = TextLayoutImporter.TextLayoutImporter(param1).createLinkFromXML(param2);
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

        public static function parseLinkNormalFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            param3.linkNormalFormat = TextLayoutImporter.TextLayoutImporter(param1).createDictionaryFromXML(param2);
            return;
        }// end function

        public static function parseLinkActiveFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            param3.linkActiveFormat = TextLayoutImporter.TextLayoutImporter(param1).createDictionaryFromXML(param2);
            return;
        }// end function

        public static function parseLinkHoverFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            param3.linkHoverFormat = TextLayoutImporter.TextLayoutImporter(param1).createDictionaryFromXML(param2);
            return;
        }// end function

        public static function parseListMarkerFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            param3.listMarkerFormat = TextLayoutImporter.TextLayoutImporter(param1).createListMarkerFormatDictionaryFromXML(param2);
            return;
        }// end function

        public static function parseDivElement(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = TextLayoutImporter.TextLayoutImporter(param1).createDivFromXML(param2);
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

        public static function parseInlineGraphic(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = TextLayoutImporter.TextLayoutImporter(param1).createInlineGraphicFromXML(param2);
            param1.addChild(param3, _loc_4);
            return;
        }// end function

    }
}
