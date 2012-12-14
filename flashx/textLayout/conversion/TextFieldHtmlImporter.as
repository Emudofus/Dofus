package flashx.textLayout.conversion
{
    import flash.system.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class TextFieldHtmlImporter extends BaseTextLayoutImporter implements IHTMLImporter
    {
        var _baseFontSize:Number;
        private var _imageSourceResolveFunction:Function;
        private var _preserveBodyElement:Boolean = false;
        private var _importHtmlElement:Boolean = false;
        static const _fontDescription:Object = {color:TextLayoutFormat.colorProperty, trackingRight:TextLayoutFormat.trackingRightProperty, fontFamily:TextLayoutFormat.fontFamilyProperty};
        static const _fontMiscDescription:Object = {size:Property.NewStringProperty("size", null, false, null), kerning:Property.NewStringProperty("kerning", null, false, null)};
        static const _textFormatDescription:Object = {paragraphStartIndent:TextLayoutFormat.paragraphStartIndentProperty, paragraphEndIndent:TextLayoutFormat.paragraphEndIndentProperty, textIndent:TextLayoutFormat.textIndentProperty, lineHeight:TextLayoutFormat.lineHeightProperty, tabStops:TextLayoutFormat.tabStopsProperty};
        static const _textFormatMiscDescription:Object = {blockIndent:Property.NewStringProperty("blockIndent", null, false, null)};
        static const _paragraphFormatDescription:Object = {textAlign:TextLayoutFormat.textAlignProperty};
        static const _linkHrefDescription:Object = {href:Property.NewStringProperty("href", null, false, null)};
        static const _linkTargetDescription:Object = {target:Property.NewStringProperty("target", null, false, null)};
        static const _imageDescription:Object = {height:InlineGraphicElement.heightPropertyDefinition, width:InlineGraphicElement.widthPropertyDefinition};
        static const _imageMiscDescription:Object = {src:Property.NewStringProperty("src", null, false, null), align:Property.NewStringProperty("align", null, false, null)};
        static const _classAndIdDescription:Object = {id:Property.NewStringProperty("ID", null, false, null)};
        static var _fontImporter:FontImporter;
        static var _fontMiscImporter:CaseInsensitiveTLFFormatImporter;
        static var _textFormatImporter:TextFormatImporter;
        static var _textFormatMiscImporter:CaseInsensitiveTLFFormatImporter;
        static var _paragraphFormatImporter:HtmlCustomParaFormatImporter;
        static var _linkHrefImporter:CaseInsensitiveTLFFormatImporter;
        static var _linkTargetImporter:CaseInsensitiveTLFFormatImporter;
        static var _ilgFormatImporter:CaseInsensitiveTLFFormatImporter;
        static var _ilgMiscFormatImporter:CaseInsensitiveTLFFormatImporter;
        static var _classAndIdImporter:CaseInsensitiveTLFFormatImporter;
        static var _activeFormat:TextLayoutFormat = new TextLayoutFormat();
        static var _activeParaFormat:TextLayoutFormat = new TextLayoutFormat();
        static var _activeImpliedParaFormat:TextLayoutFormat = null;
        static var _htmlImporterConfig:ImportExportConfiguration;
        static const stripRegex:RegExp = /<!--.*?-->|<\?("".*?""|''.*?''|[^>""'']+)*>|<!("".*?""|''.*?''|[^>""'']+)*>""<!--.*?-->|<\?(".*?"|'.*?'|[^>"']+)*>|<!(".*?"|'.*?'|[^>"']+)*>/sg;
        static const tagRegex:RegExp = /<(\/?)(\w+)((?:\s+\w+(?:\s*=\s*(?:"".*?""|''.*?''|[\w\.]+))?)*)\s*(\/?)>""<(\/?)(\w+)((?:\s+\w+(?:\s*=\s*(?:".*?"|'.*?'|[\w\.]+))?)*)\s*(\/?)>/sg;
        static const attrRegex:RegExp = /\s+(\w+)(?:\s*=\s*("".*?""|''.*?''|[\w\.]+))?""\s+(\w+)(?:\s*=\s*(".*?"|'.*?'|[\w\.]+))?/sg;
        static const anyPrintChar:RegExp = /[^	t
nr ]""[^	
 ]/g;

        public function TextFieldHtmlImporter()
        {
            createConfig();
            super(null, _htmlImporterConfig);
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

        public function get preserveBodyElement() : Boolean
        {
            return this._preserveBodyElement;
        }// end function

        public function set preserveBodyElement(param1:Boolean) : void
        {
            this._preserveBodyElement = param1;
            return;
        }// end function

        public function get preserveHTMLElement() : Boolean
        {
            return this._importHtmlElement;
        }// end function

        public function set preserveHTMLElement(param1:Boolean) : void
        {
            this._importHtmlElement = param1;
            return;
        }// end function

        override protected function importFromString(param1:String) : TextFlow
        {
            var _loc_2:* = null;
            var _loc_3:* = this.toXML(param1);
            if (_loc_3)
            {
                _loc_2 = this.importFromXML(_loc_3);
                if (Configuration.playerEnablesArgoFeatures)
                {
                    var _loc_4:* = System;
                    _loc_4.System["disposeXML"](_loc_3);
                }
            }
            return _loc_2;
        }// end function

        override protected function importFromXML(param1:XML) : TextFlow
        {
            var _loc_2:* = new TextFlow(_textFlowConfiguration);
            if (this.preserveHTMLElement)
            {
                _loc_2.typeName = "html";
            }
            this._baseFontSize = _loc_2.fontSize === undefined ? (12) : (_loc_2.fontSize);
            this.parseObject(param1.name().localName, param1, _loc_2);
            resetImpliedPara();
            _loc_2.normalize();
            _loc_2.applyWhiteSpaceCollapse(null);
            return _loc_2;
        }// end function

        override function clear() : void
        {
            _activeParaFormat.clearStyles();
            _activeFormat.clearStyles();
            super.clear();
            return;
        }// end function

        override function createImpliedParagraph() : ParagraphElement
        {
            var rslt:ParagraphElement;
            var savedActiveFormat:* = _activeFormat;
            if (_activeImpliedParaFormat)
            {
                _activeFormat = _activeImpliedParaFormat;
            }
            rslt = super.createImpliedParagraph();
            finally
            {
                var _loc_2:* = new catch0;
                throw null;
            }
            finally
            {
                _activeFormat = savedActiveFormat;
            }
            return rslt;
        }// end function

        override public function createParagraphFromXML(param1:XML) : ParagraphElement
        {
            var _loc_2:* = new ParagraphElement();
            var _loc_3:* = [_paragraphFormatImporter, _classAndIdImporter];
            parseAttributes(param1, _loc_3);
            var _loc_4:* = new TextLayoutFormat(_paragraphFormatImporter.result as ITextLayoutFormat);
            if (_activeParaFormat)
            {
                _loc_4.apply(_activeParaFormat);
            }
            if (_activeFormat)
            {
                _loc_4.apply(_activeFormat);
            }
            var _loc_5:* = getSingleFontChild(param1);
            if (getSingleFontChild(param1))
            {
                _loc_4.apply(this.parseFontAttributes(_loc_5));
            }
            if (_loc_4.lineHeight !== undefined)
            {
                _loc_4.leadingModel = LeadingModel.APPROXIMATE_TEXT_FIELD;
            }
            _loc_2.format = _loc_4;
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        override public function createListFromXML(param1:XML) : ListElement
        {
            parseAttributes(param1, [_classAndIdImporter]);
            var _loc_2:* = new ListElement();
            _loc_2.paddingLeft = 36;
            var _loc_3:* = param1 ? (param1.name().localName) : (null);
            _loc_2.listStyleType = _loc_3 == "OL" ? (ListStyleType.DECIMAL) : (ListStyleType.DISC);
            var _loc_4:* = new ListMarkerFormat();
            new ListMarkerFormat().paragraphEndIndent = 14;
            _loc_2.listMarkerFormat = _loc_4;
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        override public function createListItemFromXML(param1:XML) : ListItemElement
        {
            parseAttributes(param1, [_classAndIdImporter]);
            var _loc_2:* = new ListItemElement();
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        public function createDivFromXML(param1:XML) : DivElement
        {
            parseAttributes(param1, [_classAndIdImporter]);
            var _loc_2:* = new DivElement();
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        public function createSPGEFromXML(param1:XML) : SubParagraphGroupElement
        {
            parseAttributes(param1, [_classAndIdImporter]);
            var _loc_2:* = new SubParagraphGroupElement();
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        override protected function onResetImpliedPara(param1:ParagraphElement) : void
        {
            replaceBreakElementsWithParaSplits(param1);
            return;
        }// end function

        private function createLinkFromXML(param1:XML) : LinkElement
        {
            var _loc_2:* = new LinkElement();
            var _loc_3:* = [_linkHrefImporter, _linkTargetImporter, _classAndIdImporter];
            parseAttributes(param1, _loc_3);
            _loc_2.href = _linkHrefImporter.getFormatValue("HREF");
            _loc_2.target = _linkTargetImporter.getFormatValue("TARGET");
            if (!_loc_2.target)
            {
                _loc_2.target = "_self";
            }
            _loc_2.format = _activeFormat;
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            return _loc_2;
        }// end function

        override public function createImpliedSpan(param1:String) : SpanElement
        {
            var _loc_2:* = super.createImpliedSpan(param1);
            _loc_2.format = _activeFormat;
            return _loc_2;
        }// end function

        protected function createInlineGraphicFromXML(param1:XML) : InlineGraphicElement
        {
            var _loc_2:* = new InlineGraphicElement();
            var _loc_3:* = [_ilgFormatImporter, _ilgMiscFormatImporter, _classAndIdImporter];
            parseAttributes(param1, _loc_3);
            var _loc_4:* = _ilgMiscFormatImporter.getFormatValue("SRC");
            _loc_2.source = this._imageSourceResolveFunction != null ? (this._imageSourceResolveFunction(_loc_4)) : (_loc_4);
            _loc_2.height = InlineGraphicElement.heightPropertyDefinition.setHelper(_loc_2.height, _ilgFormatImporter.getFormatValue("HEIGHT"));
            _loc_2.width = InlineGraphicElement.heightPropertyDefinition.setHelper(_loc_2.width, _ilgFormatImporter.getFormatValue("WIDTH"));
            var _loc_5:* = _ilgMiscFormatImporter.getFormatValue("ALIGN");
            if (_ilgMiscFormatImporter.getFormatValue("ALIGN") == Float.LEFT || _loc_5 == Float.RIGHT)
            {
                _loc_2.float = _loc_5;
            }
            _loc_2.format = _activeFormat;
            _loc_2.id = _classAndIdImporter.getFormatValue("ID");
            _loc_2.styleName = _classAndIdImporter.getFormatValue("CLASS");
            return _loc_2;
        }// end function

        override public function createTabFromXML(param1:XML) : TabElement
        {
            return null;
        }// end function

        protected function parseFontAttributes(param1:XML) : ITextLayoutFormat
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = [_fontImporter, _fontMiscImporter];
            parseAttributes(param1, _loc_2);
            var _loc_3:* = new TextLayoutFormat(_fontImporter.result as ITextLayoutFormat);
            var _loc_4:* = _fontMiscImporter.getFormatValue("KERNING");
            if (_fontMiscImporter.getFormatValue("KERNING"))
            {
                _loc_6 = Number(_loc_4);
                _loc_3.kerning = _loc_6 == 0 ? (Kerning.OFF) : (Kerning.AUTO);
            }
            var _loc_5:* = _fontMiscImporter.getFormatValue("SIZE");
            if (_fontMiscImporter.getFormatValue("SIZE"))
            {
                _loc_7 = TextLayoutFormat.fontSizeProperty.setHelper(NaN, _loc_5);
                if (!isNaN(_loc_7))
                {
                    if (_loc_5.search(/\s*(-|\+)""\s*(-|\+)/) != -1)
                    {
                        _loc_7 = _loc_7 + this._baseFontSize;
                    }
                    _loc_3.fontSize = _loc_7;
                }
            }
            return _loc_3;
        }// end function

        override protected function handleUnknownAttribute(param1:String, param2:String) : void
        {
            return;
        }// end function

        override protected function handleUnknownElement(param1:String, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = null;
            var _loc_8:* = null;
            parseAttributes(param2, [_classAndIdImporter]);
            var _loc_5:* = _classAndIdImporter.getFormatValue("CLASS");
            var _loc_6:* = _classAndIdImporter.getFormatValue("ID");
            if (_loc_5 !== undefined || _loc_6 !== undefined || !TextLayoutFormat.isEqual(_activeFormat, TextLayoutFormat.emptyTextLayoutFormat) || param3 is ListElement)
            {
                _loc_4 = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase ? (new SubParagraphGroupElement()) : (new DivElement());
                addChild(param3, _loc_4);
                _loc_4.format = _activeFormat;
                _loc_4.typeName = param1.toLowerCase();
                _loc_4.styleName = _loc_5;
                _loc_4.id = _loc_6;
                parseChildrenUnderNewActiveFormat(this, param2, _loc_4, _activeFormat, null);
                return;
            }
            var _loc_7:* = param3.numChildren;
            parseFlowGroupElementChildren(param2, param3, null, true);
            if (_loc_7 == param3.numChildren)
            {
                return;
            }
            if ((_loc_7 + 1) == param3.numChildren)
            {
                _loc_8 = param3.getChildAt(_loc_7);
                if (_loc_8.id == null && _loc_8.styleName == null && _loc_8.typeName == _loc_8.defaultTypeName)
                {
                    _loc_8.typeName = param1.toLowerCase();
                    return;
                }
            }
            _loc_4 = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase ? (new SubParagraphGroupElement()) : (new DivElement());
            _loc_4.typeName = param1.toLowerCase();
            _loc_4.replaceChildren(0, 0, param3.mxmlChildren.slice(_loc_7));
            addChild(param3, _loc_4);
            return;
        }// end function

        override function parseObject(param1:String, param2:XML, param3:FlowGroupElement, param4:Object = null) : void
        {
            super.parseObject(param1.toUpperCase(), param2, param3, param4);
            return;
        }// end function

        override protected function checkNamespace(param1:XML) : Boolean
        {
            return true;
        }// end function

        protected function toXML(param1:String) : XML
        {
            var xml:XML;
            var source:* = param1;
            var originalSettings:* = XML.settings();
            XML.ignoreProcessingInstructions = false;
            XML.ignoreWhitespace = false;
            xml = this.toXMLInternal(source);
            finally
            {
                var _loc_3:* = new catch0;
                throw null;
            }
            finally
            {
                XML.setSettings(originalSettings);
            }
            return xml;
        }// end function

        protected function toXMLInternal(param1:String) : XML
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            param1 = param1.replace(stripRegex, "");
            var _loc_2:* = <HTML/>")("<HTML/>;
            var _loc_3:* = _loc_2;
            var _loc_17:* = 0;
            tagRegex.lastIndex = 0;
            var _loc_4:* = _loc_17;
            do
            {
                
                _loc_6 = tagRegex.exec(param1);
                if (!_loc_6)
                {
                    this.appendTextChild(_loc_3, param1.substring(_loc_4));
                    break;
                }
                if (_loc_6.index != _loc_4)
                {
                    this.appendTextChild(_loc_3, param1.substring(_loc_4, _loc_6.index));
                }
                _loc_7 = _loc_6[0];
                _loc_8 = _loc_6[1] == "/";
                _loc_9 = _loc_6[2].toUpperCase();
                _loc_10 = _loc_6[3];
                _loc_11 = _loc_6[4] == "/";
                if (!_loc_8)
                {
                    if (_loc_9 == "P" && _loc_3.name().localName == "P")
                    {
                        _loc_3 = _loc_3.parent();
                    }
                    _loc_7 = "<" + _loc_9;
                    do
                    {
                        
                        _loc_12 = attrRegex.exec(_loc_10);
                        if (!_loc_12)
                        {
                            break;
                        }
                        _loc_13 = _loc_12[1].toUpperCase();
                        _loc_7 = _loc_7 + (" " + _loc_13 + "=");
                        _loc_14 = _loc_12[2] ? (_loc_12[2]) : (_loc_13);
                        _loc_15 = _loc_14.charAt(0);
                        _loc_7 = _loc_7 + (_loc_15 == "\'" || _loc_15 == "\"" ? (_loc_14) : ("\"" + _loc_14 + "\""));
                    }while (true)
                    _loc_7 = _loc_7 + "/>";
                    _loc_3.appendChild(new XML(_loc_7));
                    if (!_loc_11 && !this.doesStartTagCloseElement(_loc_9))
                    {
                        _loc_3 = _loc_3.children()[(_loc_3.children().length() - 1)];
                    }
                }
                else if (_loc_11 || _loc_10.length)
                {
                    reportError(GlobalSettings.resourceStringFunction("malformedTag", [_loc_7]));
                }
                else
                {
                    _loc_16 = _loc_3;
                    do
                    {
                        
                        _loc_5 = _loc_16.name().localName;
                        _loc_16 = _loc_16.parent();
                        if (_loc_5 == _loc_9)
                        {
                            _loc_3 = _loc_16;
                            break;
                        }
                        if (!_loc_16)
                        {
                            break;
                        }
                    }while (true)
                }
                _loc_4 = tagRegex.lastIndex;
                if (_loc_4 == param1.length)
                {
                    break;
                }
            }while (_loc_3)
            return _loc_2;
        }// end function

        protected function doesStartTagCloseElement(param1:String) : Boolean
        {
            switch(param1)
            {
                case "BR":
                case "IMG":
                {
                    return true;
                }
                default:
                {
                    return false;
                    break;
                }
            }
        }// end function

        protected function appendTextChild(param1:XML, param2:String) : void
        {
            var xml:XML;
            var parent:* = param1;
            var text:* = param2;
            var parentIsSpan:* = parent.localName() == "SPAN";
            var elemName:* = parentIsSpan ? ("DUMMY") : ("SPAN");
            var xmlText:* = "<" + elemName + ">" + text + "</" + elemName + ">";
            try
            {
                xml = new XML(xmlText);
                parent.appendChild(parentIsSpan ? (xml.children()[0]) : (xml));
            }
            catch (e)
            {
                reportError(GlobalSettings.resourceStringFunction("malformedMarkup", [text]));
            }
            return;
        }// end function

        static function createConfig() : void
        {
            if (!_htmlImporterConfig)
            {
                _htmlImporterConfig = new ImportExportConfiguration();
                _htmlImporterConfig.addIEInfo("BR", BreakElement, BaseTextLayoutImporter.parseBreak, null);
                _htmlImporterConfig.addIEInfo("P", ParagraphElement, TextFieldHtmlImporter.parsePara, null);
                _htmlImporterConfig.addIEInfo("SPAN", SpanElement, TextFieldHtmlImporter.parseSpan, null);
                _htmlImporterConfig.addIEInfo("A", LinkElement, TextFieldHtmlImporter.parseLink, null);
                _htmlImporterConfig.addIEInfo("IMG", InlineGraphicElement, TextFieldHtmlImporter.parseInlineGraphic, null);
                _htmlImporterConfig.addIEInfo("DIV", DivElement, TextFieldHtmlImporter.parseDiv, null);
                _htmlImporterConfig.addIEInfo("HTML", null, TextFieldHtmlImporter.parseHtmlElement, null);
                _htmlImporterConfig.addIEInfo("BODY", null, TextFieldHtmlImporter.parseBody, null);
                _htmlImporterConfig.addIEInfo("FONT", null, TextFieldHtmlImporter.parseFont, null);
                _htmlImporterConfig.addIEInfo("TEXTFORMAT", null, TextFieldHtmlImporter.parseTextFormat, null);
                _htmlImporterConfig.addIEInfo("U", null, TextFieldHtmlImporter.parseUnderline, null);
                _htmlImporterConfig.addIEInfo("I", null, TextFieldHtmlImporter.parseItalic, null);
                _htmlImporterConfig.addIEInfo("B", null, TextFieldHtmlImporter.parseBold, null);
                _htmlImporterConfig.addIEInfo("S", null, TextFieldHtmlImporter.parseStrikeThrough, null);
                _htmlImporterConfig.addIEInfo("UL", null, BaseTextLayoutImporter.parseList, null);
                _htmlImporterConfig.addIEInfo("OL", null, BaseTextLayoutImporter.parseList, null);
                _htmlImporterConfig.addIEInfo("LI", null, TextFieldHtmlImporter.parseListItem, null);
            }
            if (_classAndIdDescription["CLASS"] === undefined)
            {
                _classAndIdDescription["CLASS"] = Property.NewStringProperty("CLASS", null, false, null);
                _paragraphFormatImporter = new HtmlCustomParaFormatImporter(TextLayoutFormat, _paragraphFormatDescription);
                _textFormatImporter = new TextFormatImporter(TextLayoutFormat, _textFormatDescription);
                _fontImporter = new FontImporter(TextLayoutFormat, _fontDescription);
                _fontMiscImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _fontMiscDescription);
                _textFormatMiscImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _textFormatMiscDescription);
                _linkHrefImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _linkHrefDescription, false);
                _linkTargetImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _linkTargetDescription);
                _ilgFormatImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _imageDescription);
                _ilgMiscFormatImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _imageMiscDescription, false);
                _classAndIdImporter = new CaseInsensitiveTLFFormatImporter(Dictionary, _classAndIdDescription);
            }
            return;
        }// end function

        public static function parseListItem(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_5:* = null;
            if (!(param3 is ListElement))
            {
                _loc_5 = param1.createListFromXML(null);
                param1.addChild(param3, _loc_5);
                param3 = _loc_5;
            }
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

        public static function parsePara(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = param1.createParagraphFromXML(param2);
            if (param1.addChild(param3, _loc_4))
            {
                _loc_5 = getSingleFontChild(param2);
                parseChildrenUnderNewActiveFormat(param1, _loc_5 ? (_loc_5) : (param2), _loc_4, _activeFormat, null);
                if (_loc_4.numChildren == 0)
                {
                    _loc_4.addChild(param1.createImpliedSpan(""));
                }
            }
            replaceBreakElementsWithParaSplits(_loc_4);
            return;
        }// end function

        public static function parseDiv(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = null;
            if (param3.canOwnFlowElement(new DivElement()))
            {
                _loc_4 = param1.createDivFromXML(param2);
            }
            else
            {
                _loc_4 = param1.createSPGEFromXML(param2);
                _loc_4.typeName = "div";
            }
            param1.addChild(param3, _loc_4);
            param1.parseFlowGroupElementChildren(param2, _loc_4);
            return;
        }// end function

        public static function parseHtmlElement(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = null;
            if (param1.preserveHTMLElement)
            {
                if (!(param3 is TextFlow))
                {
                    _loc_4 = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase ? (new SubParagraphGroupElement()) : (new DivElement());
                    param3.addChild(_loc_4);
                    param3 = _loc_4;
                }
                param1.parseAttributes(param2, [_classAndIdImporter]);
                param3.typeName = "html";
                param3.styleName = _classAndIdImporter.getFormatValue("CLASS");
                param3.id = _classAndIdImporter.getFormatValue("ID");
            }
            param1.parseFlowGroupElementChildren(param2, param3, null, true);
            return;
        }// end function

        public static function parseBody(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = null;
            if (param1.preserveBodyElement)
            {
                _loc_4 = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase ? (new SubParagraphGroupElement()) : (new DivElement());
                param3.addChild(_loc_4);
                param3 = _loc_4;
                param1.parseAttributes(param2, [_classAndIdImporter]);
                param3.typeName = "body";
                param3.styleName = _classAndIdImporter.getFormatValue("CLASS");
                param3.id = _classAndIdImporter.getFormatValue("ID");
            }
            param1.parseFlowGroupElementChildren(param2, param3, null, true);
            return;
        }// end function

        private static function getSingleFontChild(param1:XML) : XML
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.children();
            if (_loc_2.length() == 1)
            {
                _loc_3 = _loc_2[0];
                if (_loc_3.name().localName.toUpperCase() == "FONT")
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public static function parseLink(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createLinkFromXML(param2);
            if (param1.addChild(param3, _loc_4))
            {
                parseChildrenUnderNewActiveFormat(param1, param2, _loc_4, _activeFormat, null);
            }
            return;
        }// end function

        static function extractSimpleSpanText(param1:XML) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1[0].children();
            if (_loc_2.length() == 0)
            {
                return "";
            }
            if (_loc_2.length() != 1)
            {
                return null;
            }
            for each (_loc_3 in _loc_2)
            {
                
                break;
            }
            _loc_4 = _loc_3.name() ? (_loc_3.name().localName) : (null);
            if (_loc_4 != null)
            {
                return null;
            }
            var _loc_5:* = _loc_3.toString();
            return _loc_3.toString() ? (_loc_5) : ("");
        }// end function

        public static function parseSpan(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_8:* = null;
            param1.parseAttributes(param2, [_classAndIdImporter]);
            var _loc_4:* = _classAndIdImporter.getFormatValue("CLASS");
            var _loc_5:* = _classAndIdImporter.getFormatValue("ID");
            var _loc_6:* = extractSimpleSpanText(param2);
            if (extractSimpleSpanText(param2) == null)
            {
                if (_loc_4 !== undefined || _loc_5 !== undefined || !TextLayoutFormat.isEqual(_activeFormat, TextLayoutFormat.emptyTextLayoutFormat))
                {
                    _loc_8 = new SubParagraphGroupElement();
                    _loc_8.format = _activeFormat;
                    _loc_8.styleName = _loc_4;
                    _loc_8.id = _loc_5;
                    _loc_8.typeName = "span";
                    param1.addChild(param3, _loc_8);
                    param3 = _loc_8;
                }
                parseChildrenUnderNewActiveFormat(param1, param2, param3, _activeFormat, null);
                return;
            }
            var _loc_7:* = new SpanElement();
            new SpanElement().format = _activeFormat;
            _loc_7.styleName = _loc_4;
            _loc_7.id = _loc_5;
            _loc_7.text = _loc_6;
            param1.addChild(param3, _loc_7);
            return;
        }// end function

        public static function parseInlineGraphic(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.createInlineGraphicFromXML(param2);
            param1.addChild(param3, _loc_4);
            return;
        }// end function

        public static function parseFont(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = param1.parseFontAttributes(param2);
            parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1, param2, param3, _loc_4);
            return;
        }// end function

        public static function parseTextFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_4:* = [_textFormatImporter, _textFormatMiscImporter];
            param1.parseAttributes(param2, _loc_4);
            var _loc_5:* = new TextLayoutFormat(_textFormatImporter.result as ITextLayoutFormat);
            var _loc_6:* = _textFormatMiscImporter.getFormatValue("BLOCKINDENT");
            if (_textFormatMiscImporter.getFormatValue("BLOCKINDENT") !== undefined)
            {
                _loc_6 = TextLayoutFormat.paragraphStartIndentProperty.setHelper(undefined, _loc_6);
                if (_loc_6 !== undefined)
                {
                    _loc_8 = Number(_loc_6);
                    _loc_5.paragraphStartIndent = _loc_5.paragraphStartIndent === undefined ? (_loc_8) : (_loc_5.paragraphStartIndent + _loc_8);
                }
            }
            var _loc_7:* = _activeFormat.lineHeight;
            if (param3 is ParagraphElement)
            {
                if (param3.numChildren == 0)
                {
                    _loc_9 = new TextLayoutFormat(param3.format);
                    _loc_9.apply(_loc_5);
                    if (_loc_9.lineHeight !== undefined)
                    {
                        _loc_9.leadingModel = LeadingModel.APPROXIMATE_TEXT_FIELD;
                    }
                    param3.format = _loc_9;
                    _loc_5.clearStyles();
                }
                else if (_loc_5.lineHeight !== undefined)
                {
                    _activeFormat.lineHeight = _loc_5.lineHeight;
                }
            }
            parseChildrenUnderNewActiveFormat(param1, param2, param3, _activeParaFormat, _loc_5, true);
            _activeFormat.lineHeight = _loc_7;
            return;
        }// end function

        public static function parseBold(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = new TextLayoutFormat();
            new TextLayoutFormat().fontWeight = FontWeight.BOLD;
            parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1, param2, param3, _loc_4);
            return;
        }// end function

        public static function parseItalic(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = new TextLayoutFormat();
            new TextLayoutFormat().fontStyle = FontPosture.ITALIC;
            parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1, param2, param3, _loc_4);
            return;
        }// end function

        public static function parseStrikeThrough(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = new TextLayoutFormat();
            new TextLayoutFormat().lineThrough = true;
            parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1, param2, param3, _loc_4);
            return;
        }// end function

        public static function parseUnderline(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void
        {
            var _loc_4:* = new TextLayoutFormat();
            new TextLayoutFormat().textDecoration = TextDecoration.UNDERLINE;
            parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1, param2, param3, _loc_4);
            return;
        }// end function

        static function parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement, param4:ITextLayoutFormat) : void
        {
            var importer:* = param1;
            var xmlToParse:* = param2;
            var parent:* = param3;
            var newFormat:* = param4;
            var oldActiveImpliedParaFormat:* = _activeImpliedParaFormat;
            if (_activeImpliedParaFormat == null)
            {
                _activeImpliedParaFormat = new TextLayoutFormat(_activeFormat);
            }
            parseChildrenUnderNewActiveFormat(importer, xmlToParse, parent, _activeFormat, newFormat, true);
            finally
            {
                var _loc_6:* = new catch0;
                throw null;
            }
            finally
            {
                _activeImpliedParaFormat = oldActiveImpliedParaFormat;
            }
            return;
        }// end function

        static function parseChildrenUnderNewActiveFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement, param4:TextLayoutFormat, param5:ITextLayoutFormat, param6:Boolean = false) : void
        {
            var beforeCount:int;
            var span:SpanElement;
            var importer:* = param1;
            var xmlToParse:* = param2;
            var parent:* = param3;
            var currFormat:* = param4;
            var newFormat:* = param5;
            var chainedParent:* = param6;
            var restoreBaseFontSize:* = importer._baseFontSize;
            var restoreStyles:* = Property.shallowCopy(currFormat.getStyles());
            if (newFormat)
            {
                if (newFormat.fontSize !== undefined)
                {
                    importer._baseFontSize = newFormat.fontSize;
                }
                currFormat.apply(newFormat);
            }
            else
            {
                currFormat.clearStyles();
            }
            beforeCount = parent.numChildren;
            importer.parseFlowGroupElementChildren(xmlToParse, parent, null, chainedParent);
            if (beforeCount == parent.numChildren)
            {
                span = importer.createImpliedSpan("");
                importer.addChild(parent, span);
            }
            finally
            {
                var _loc_8:* = new catch0;
                throw null;
            }
            finally
            {
                currFormat.setStyles(restoreStyles, false);
                importer._baseFontSize = restoreBaseFontSize;
            }
            return;
        }// end function

        static function replaceBreakElementsWithParaSplits(param1:ParagraphElement) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = param1.getFirstLeaf();
            while (_loc_5)
            {
                
                if (!(_loc_5 is BreakElement))
                {
                    _loc_5 = _loc_5.getNextLeaf(param1);
                    continue;
                }
                if (!_loc_2)
                {
                    _loc_2 = [param1];
                    _loc_4 = param1.parent;
                    _loc_3 = _loc_4.getChildIndex(param1);
                    _loc_4.removeChildAt(_loc_3);
                }
                param1 = param1.splitAtPosition(_loc_5.getAbsoluteStart() + _loc_5.textLength) as ParagraphElement;
                _loc_2.push(param1);
                _loc_5.parent.removeChild(_loc_5);
                _loc_5 = param1.getFirstLeaf();
            }
            if (_loc_2)
            {
                _loc_4.replaceChildren(_loc_3, _loc_3, _loc_2);
            }
            return;
        }// end function

    }
}

import flash.system.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.conversion.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.property.*;

class CaseInsensitiveTLFFormatImporter extends TLFormatImporter
{
    private var _convertValuesToLowerCase:Boolean;

    function CaseInsensitiveTLFFormatImporter(param1:Class, param2:Object, param3:Boolean = true)
    {
        var _loc_5:* = null;
        this._convertValuesToLowerCase = param3;
        var _loc_4:* = new Object();
        for (_loc_5 in param2)
        {
            
            _loc_4[_loc_5.toUpperCase()] = param2[_loc_5];
        }
        super(param1, _loc_4);
        return;
    }// end function

    override public function importOneFormat(param1:String, param2:String) : Boolean
    {
        return super.importOneFormat(param1.toUpperCase(), this._convertValuesToLowerCase ? (param2.toLowerCase()) : (param2));
    }// end function

    public function getFormatValue(param1:String)
    {
        return result ? (result[param1.toUpperCase()]) : (undefined);
    }// end function

}


import flash.system.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.conversion.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.property.*;

class HtmlCustomParaFormatImporter extends TLFormatImporter
{

    function HtmlCustomParaFormatImporter(param1:Class, param2:Object)
    {
        super(param1, param2);
        return;
    }// end function

    override public function importOneFormat(param1:String, param2:String) : Boolean
    {
        param1 = param1.toUpperCase();
        if (param1 == "ALIGN")
        {
            param1 = "textAlign";
        }
        return super.importOneFormat(param1, param2.toLowerCase());
    }// end function

}


import flash.system.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.conversion.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.property.*;

class TextFormatImporter extends TLFormatImporter
{

    function TextFormatImporter(param1:Class, param2:Object)
    {
        super(param1, param2);
        return;
    }// end function

    override public function importOneFormat(param1:String, param2:String) : Boolean
    {
        param1 = param1.toUpperCase();
        if (param1 == "LEFTMARGIN")
        {
            param1 = "paragraphStartIndent";
        }
        else if (param1 == "RIGHTMARGIN")
        {
            param1 = "paragraphEndIndent";
        }
        else if (param1 == "INDENT")
        {
            param1 = "textIndent";
        }
        else if (param1 == "LEADING")
        {
            param1 = "lineHeight";
        }
        else if (param1 == "TABSTOPS")
        {
            param1 = "tabStops";
            param2 = param2.replace(/,"",/g, " ");
        }
        return super.importOneFormat(param1, param2);
    }// end function

}


import flash.system.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.conversion.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.formats.*;

import flashx.textLayout.property.*;

class FontImporter extends TLFormatImporter
{

    function FontImporter(param1:Class, param2:Object)
    {
        super(param1, param2);
        return;
    }// end function

    override public function importOneFormat(param1:String, param2:String) : Boolean
    {
        param1 = param1.toUpperCase();
        if (param1 == "LETTERSPACING")
        {
            param1 = "trackingRight";
        }
        else if (param1 == "FACE")
        {
            param1 = "fontFamily";
        }
        else if (param1 == "COLOR")
        {
            param1 = "color";
        }
        return super.importOneFormat(param1, param2);
    }// end function

}

