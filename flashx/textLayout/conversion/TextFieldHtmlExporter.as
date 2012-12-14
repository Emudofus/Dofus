package flashx.textLayout.conversion
{
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.conversion.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class TextFieldHtmlExporter extends ConverterBase implements ITextExporter
    {
        static var _config:ImportExportConfiguration;
        static const brRegEx:RegExp = / "" /;

        public function TextFieldHtmlExporter()
        {
            if (!_config)
            {
                _config = new ImportExportConfiguration();
                _config.addIEInfo(null, DivElement, null, this.exportDiv);
                _config.addIEInfo(null, ParagraphElement, null, this.exportParagraph);
                _config.addIEInfo(null, LinkElement, null, this.exportLink);
                _config.addIEInfo(null, TCYElement, null, this.exportTCY);
                _config.addIEInfo(null, SubParagraphGroupElement, null, this.exportSPGE);
                _config.addIEInfo(null, SpanElement, null, this.exportSpan);
                _config.addIEInfo(null, InlineGraphicElement, null, this.exportImage);
                _config.addIEInfo(null, TabElement, null, this.exportTab);
                _config.addIEInfo(null, BreakElement, null, this.exportBreak);
                _config.addIEInfo(null, ListElement, null, this.exportList);
                _config.addIEInfo(null, ListItemElement, null, this.exportListItem);
            }
            return;
        }// end function

        public function export(param1:TextFlow, param2:String) : Object
        {
            var _loc_3:* = this.exportToXML(param1);
            return param2 == ConversionType.STRING_TYPE ? (BaseTextLayoutExporter.convertXMLToString(_loc_3)) : (_loc_3);
        }// end function

        function exportToXML(param1:TextFlow) : XML
        {
            var _loc_3:* = null;
            var _loc_2:* = <HTML/>")("<HTML/>;
            if (param1.numChildren != 0)
            {
                if (param1.getChildAt(0).typeName != "BODY")
                {
                    _loc_3 = <BODY/>")("<BODY/>;
                    _loc_2.appendChild(_loc_3);
                    this.exportChildren(param1, _loc_3);
                }
                else
                {
                    this.exportChildren(param1, _loc_2);
                }
            }
            return _loc_2;
        }// end function

        function exportChildren(param1:FlowGroupElement, param2:XML) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param1.numChildren)
            {
                
                _loc_4 = param1.getChildAt(_loc_3);
                this.exportElement(_loc_4, param2);
                _loc_3++;
            }
            return;
        }// end function

        function exportList(param1:ListElement, param2:XML) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1.isNumberedList())
            {
                _loc_3 = <OL/>")("<OL/>;
            }
            else
            {
                _loc_3 = <UL/>")("<UL/>;
            }
            exportStyling(param1, _loc_3);
            this.exportChildren(param1, _loc_3);
            if (param1.typeName != param1.defaultTypeName)
            {
                _loc_4 = new XML("<" + param1.typeName + "/>");
                _loc_4.appendChild(_loc_3);
                param2.appendChild(_loc_4);
            }
            else
            {
                param2.appendChild(_loc_3);
            }
            return;
        }// end function

        function exportListItem(param1:ListItemElement, param2:XML) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = <LI/>")("<LI/>;
            exportStyling(param1, _loc_3);
            this.exportChildren(param1, _loc_3);
            var _loc_4:* = _loc_3.children();
            if (_loc_3.children().length() == 1)
            {
                _loc_5 = _loc_4[0];
                if (_loc_5.name().localName == "P")
                {
                    _loc_6 = _loc_5.children();
                    if (_loc_6.length() == 1)
                    {
                        _loc_3 = <LI/>")("<LI/>;
                        _loc_3.appendChild(_loc_6[0]);
                    }
                }
            }
            param2.appendChild(_loc_3);
            return;
        }// end function

        function exportDiv(param1:DivElement, param2:XML) : void
        {
            var _loc_3:* = makeTaggedTypeName(param1, "DIV");
            exportStyling(param1, _loc_3);
            this.exportChildren(param1, _loc_3);
            param2.appendChild(_loc_3);
            return;
        }// end function

        function exportParagraph(param1:ParagraphElement, param2:XML) : void
        {
            var _loc_3:* = makeTaggedTypeName(param1, "P");
            exportStyling(param1, _loc_3);
            var _loc_4:* = this.exportFont(param1.computedFormat);
            this.exportSubParagraphChildren(param1, _loc_4);
            nest(_loc_3, _loc_4);
            param2.appendChild(this.exportParagraphFormat(_loc_3, param1));
            return;
        }// end function

        function exportLink(param1:LinkElement, param2:XML) : void
        {
            var _loc_3:* = <A/>")("<A/>;
            if (param1.href)
            {
                _loc_3.@HREF = param1.href;
            }
            if (param1.target)
            {
                _loc_3.@TARGET = param1.target;
            }
            else
            {
                _loc_3.@TARGET = "_blank";
            }
            this.exportSubParagraphElement(param1, _loc_3, param2);
            return;
        }// end function

        function exportTCY(param1:TCYElement, param2:XML) : void
        {
            var _loc_3:* = <TCY/>")("<TCY/>;
            this.exportSubParagraphElement(param1, _loc_3, param2);
            return;
        }// end function

        function exportSPGE(param1:SubParagraphGroupElement, param2:XML) : void
        {
            var _loc_3:* = param1.typeName != param1.defaultTypeName ? (new XML("<" + param1.typeName + "/>")) : (<SPAN/>")("<SPAN/>);
            this.exportSubParagraphElement(param1, _loc_3, param2, false);
            return;
        }// end function

        function exportSubParagraphElement(param1:SubParagraphGroupElementBase, param2:XML, param3:XML, param4:Boolean = true) : void
        {
            var _loc_9:* = null;
            exportStyling(param1, param2);
            this.exportSubParagraphChildren(param1, param2);
            var _loc_5:* = param1.computedFormat;
            var _loc_6:* = param1.parent.computedFormat;
            var _loc_7:* = this.exportFont(_loc_5, _loc_6);
            var _loc_8:* = this.exportFont(_loc_5, _loc_6) ? (nest(_loc_7, param2)) : (param2);
            if (param4 && param1.typeName != param1.defaultTypeName)
            {
                _loc_9 = new XML("<" + param1.typeName + "/>");
                _loc_9.appendChild(_loc_8);
                param3.appendChild(_loc_9);
            }
            else
            {
                param3.appendChild(_loc_8);
            }
            return;
        }// end function

        function exportSpan(param1:SpanElement, param2:XML) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = makeTaggedTypeName(param1, "SPAN");
            exportStyling(param1, _loc_3);
            BaseTextLayoutExporter.exportSpanText(_loc_3, param1, brRegEx, getSpanTextReplacementXML);
            if (param1.id == null && param1.styleName == null && param1.typeName == param1.defaultTypeName)
            {
                _loc_4 = _loc_3.children();
                if (_loc_4.length() == 1 && _loc_4[0].nodeKind() == "text")
                {
                    _loc_4 = _loc_3.text()[0];
                }
                param2.appendChild(this.exportSpanFormat(_loc_4, param1));
            }
            else
            {
                param2.appendChild(this.exportSpanFormat(_loc_3, param1));
            }
            return;
        }// end function

        function exportImage(param1:InlineGraphicElement, param2:XML) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = <IMG/>")("<IMG/>;
            exportStyling(param1, _loc_3);
            if (param1.source)
            {
                _loc_3.@SRC = param1.source;
            }
            if (param1.width !== undefined && param1.width != FormatValue.AUTO)
            {
                _loc_3.@WIDTH = param1.width;
            }
            if (param1.height !== undefined && param1.height != FormatValue.AUTO)
            {
                _loc_3.@HEIGHT = param1.height;
            }
            if (param1.computedFloat != Float.NONE)
            {
                _loc_3.@ALIGN = param1.float;
            }
            if (param1.typeName != param1.defaultTypeName)
            {
                _loc_4 = new XML("<" + param1.typeName + "/>");
                _loc_4.appendChild(_loc_3);
                param2.appendChild(_loc_4);
            }
            else
            {
                param2.appendChild(_loc_3);
            }
            return;
        }// end function

        function exportBreak(param1:BreakElement, param2:XML) : void
        {
            param2.appendChild(<BR/>")("<BR/>);
            return;
        }// end function

        function exportTab(param1:TabElement, param2:XML) : void
        {
            this.exportSpan(param1, param2);
            return;
        }// end function

        function exportTextFormatAttribute(param1:XML, param2:String, param3) : XML
        {
            if (!param1)
            {
                param1 = <TEXTFORMAT/>")("<TEXTFORMAT/>;
            }
            param1[param2] = param3;
            return param1;
        }// end function

        function exportParagraphFormat(param1:XML, param2:ParagraphElement) : XML
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_3:* = param2.computedFormat;
            switch(_loc_3.textAlign)
            {
                case TextAlign.START:
                {
                    _loc_4 = _loc_3.direction == Direction.LTR ? (TextAlign.LEFT) : (TextAlign.RIGHT);
                    break;
                }
                case TextAlign.END:
                {
                    _loc_4 = _loc_3.direction == Direction.LTR ? (TextAlign.RIGHT) : (TextAlign.LEFT);
                    break;
                }
                default:
                {
                    _loc_4 = _loc_3.textAlign;
                    break;
                }
            }
            param1.@ALIGN = _loc_4;
            if (_loc_3.paragraphStartIndent != 0)
            {
                _loc_5 = this.exportTextFormatAttribute(_loc_5, _loc_3.direction == Direction.LTR ? ("LEFTMARGIN") : ("RIGHTMARGIN"), _loc_3.paragraphStartIndent);
            }
            if (_loc_3.paragraphEndIndent != 0)
            {
                _loc_5 = this.exportTextFormatAttribute(_loc_5, _loc_3.direction == Direction.LTR ? ("RIGHTMARGIN") : ("LEFTMARGIN"), _loc_3.paragraphEndIndent);
            }
            if (_loc_3.textIndent != 0)
            {
                _loc_5 = this.exportTextFormatAttribute(_loc_5, "INDENT", _loc_3.textIndent);
            }
            if (_loc_3.leadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
            {
                _loc_7 = param2.getFirstLeaf();
                if (_loc_7)
                {
                    _loc_8 = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_loc_7.computedFormat.lineHeight, _loc_7.getEffectiveFontSize());
                    if (_loc_8 != 0)
                    {
                        _loc_5 = this.exportTextFormatAttribute(_loc_5, "LEADING", _loc_8);
                    }
                }
            }
            var _loc_6:* = _loc_3.tabStops;
            if (_loc_3.tabStops)
            {
                _loc_9 = "";
                for each (_loc_10 in _loc_6)
                {
                    
                    if (_loc_10.alignment != TabAlignment.START)
                    {
                        break;
                    }
                    if (_loc_9.length)
                    {
                        _loc_9 = _loc_9 + ", ";
                    }
                    _loc_9 = _loc_9 + _loc_10.position;
                }
                if (_loc_9.length)
                {
                    _loc_5 = this.exportTextFormatAttribute(_loc_5, "TABSTOPS", _loc_9);
                }
            }
            return _loc_5 ? (nest(_loc_5, param1)) : (param1);
        }// end function

        function exportSpanFormat(param1:Object, param2:SpanElement) : Object
        {
            var _loc_3:* = param2.computedFormat;
            var _loc_4:* = param1;
            if (_loc_3.textDecoration.toString() == TextDecoration.UNDERLINE)
            {
                _loc_4 = nest(<U/>")("<U/>, _loc_4);
            }
            if (_loc_3.fontStyle.toString() == FontPosture.ITALIC)
            {
                _loc_4 = nest(<I/>")("<I/>, _loc_4);
            }
            if (_loc_3.fontWeight.toString() == FontWeight.BOLD)
            {
                _loc_4 = nest(<B/>")("<B/>, _loc_4);
            }
            var _loc_5:* = param2.getParentByType(LinkElement);
            if (!param2.getParentByType(LinkElement))
            {
                _loc_5 = param2.getParagraph();
            }
            var _loc_6:* = this.exportFont(_loc_3, _loc_5.computedFormat);
            if (this.exportFont(_loc_3, _loc_5.computedFormat))
            {
                _loc_4 = nest(_loc_6, _loc_4);
            }
            return _loc_4;
        }// end function

        function exportFontAttribute(param1:XML, param2:String, param3) : XML
        {
            if (!param1)
            {
                param1 = <FONT/>")("<FONT/>;
            }
            param1[param2] = param3;
            return param1;
        }// end function

        function exportFont(param1:ITextLayoutFormat, param2:ITextLayoutFormat = null) : XML
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!param2 || param2.fontFamily != param1.fontFamily)
            {
                _loc_3 = this.exportFontAttribute(_loc_3, "FACE", param1.fontFamily);
            }
            if (!param2 || param2.fontSize != param1.fontSize)
            {
                _loc_3 = this.exportFontAttribute(_loc_3, "SIZE", param1.fontSize);
            }
            if (!param2 || param2.color != param1.color)
            {
                _loc_4 = param1.color.toString(16);
                while (_loc_4.length < 6)
                {
                    
                    _loc_4 = "0" + _loc_4;
                }
                _loc_4 = "#" + _loc_4;
                _loc_3 = this.exportFontAttribute(_loc_3, "COLOR", _loc_4);
            }
            if (!param2 || param2.trackingRight != param1.trackingRight)
            {
                _loc_3 = this.exportFontAttribute(_loc_3, "LETTERSPACING", param1.trackingRight);
            }
            if (!param2 || param2.kerning != param1.kerning)
            {
                _loc_3 = this.exportFontAttribute(_loc_3, "KERNING", param1.kerning == Kerning.OFF ? ("0") : ("1"));
            }
            return _loc_3;
        }// end function

        function exportElement(param1:FlowElement, param2:XML) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = getQualifiedClassName(param1);
            var _loc_4:* = _config.lookupByClass(_loc_3);
            if (_config.lookupByClass(_loc_3))
            {
                _loc_4.exporter(param1, param2);
            }
            else
            {
                _loc_5 = new XML("<" + param1.typeName.toUpperCase() + "/>");
                this.exportChildren(param1 as FlowGroupElement, _loc_5);
                param2.appendChild(_loc_5);
            }
            return;
        }// end function

        function exportSubParagraphChildren(param1:FlowGroupElement, param2:XML) : void
        {
            var _loc_3:* = 0;
            while (_loc_3 < param1.numChildren)
            {
                
                this.exportElement(param1.getChildAt(_loc_3), param2);
                _loc_3++;
            }
            return;
        }// end function

        static function makeTaggedTypeName(param1:FlowElement, param2:String) : XML
        {
            if (param1.typeName == param1.defaultTypeName)
            {
                return new XML("<" + param2 + "/>");
            }
            return new XML("<" + param1.typeName.toUpperCase() + "/>");
        }// end function

        static function exportStyling(param1:FlowElement, param2:XML) : void
        {
            if (param1.id != null)
            {
                param2["id"] = param1.id;
            }
            if (param1.styleName != null)
            {
                param2["class"] = param1.styleName;
            }
            return;
        }// end function

        static function getSpanTextReplacementXML(param1:String) : XML
        {
            return <BR/>")("<BR/>;
        }// end function

        static function nest(param1:XML, param2:Object) : XML
        {
            param1.setChildren(param2);
            return param1;
        }// end function

    }
}
