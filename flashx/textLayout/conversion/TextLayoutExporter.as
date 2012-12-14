package flashx.textLayout.conversion
{
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    class TextLayoutExporter extends BaseTextLayoutExporter
    {
        private static var _formatDescription:Object = TextLayoutFormat.description;
        private static const brTabRegEx:RegExp = new RegExp("[" + " " + "\t" + "]");

        function TextLayoutExporter()
        {
            super(new Namespace("http://ns.adobe.com/textLayout/2008"), null, TextLayoutImporter.defaultConfiguration);
            return;
        }// end function

        override protected function get spanTextReplacementRegex() : RegExp
        {
            return brTabRegEx;
        }// end function

        override protected function getSpanTextReplacementXML(param1:String) : XML
        {
            var _loc_2:* = null;
            if (param1 == " ")
            {
                _loc_2 = <br/>")("<br/>;
            }
            else if (param1 == "\t")
            {
                _loc_2 = <tab/>")("<tab/>;
            }
            else
            {
                return null;
            }
            _loc_2.setNamespace(flowNS);
            return _loc_2;
        }// end function

        function createStylesFromDescription(param1:Object, param2:Object, param3:Boolean, param4:Array) : Array
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_5:* = [];
            for (_loc_6 in param1)
            {
                
                _loc_7 = param1[_loc_6];
                if (param4 && param4.indexOf(_loc_7) != -1)
                {
                    continue;
                }
                _loc_8 = param2[_loc_6];
                if (!_loc_8)
                {
                    if (param3)
                    {
                        if (_loc_7 is String || _loc_7.hasOwnProperty("toString"))
                        {
                            _loc_5.push({xmlName:_loc_6, xmlVal:_loc_7});
                        }
                    }
                    continue;
                }
                if (_loc_7 is TextLayoutFormat)
                {
                    _loc_9 = this.exportObjectAsTextLayoutFormat(_loc_6, (_loc_7 as TextLayoutFormat).getStyles());
                    if (_loc_9)
                    {
                        _loc_5.push({xmlName:_loc_6, xmlVal:_loc_9});
                    }
                    continue;
                }
                _loc_5.push({xmlName:_loc_6, xmlVal:_loc_8.toXMLString(_loc_7)});
            }
            return _loc_5;
        }// end function

        function exportObjectAsTextLayoutFormat(param1:String, param2:Object) : XMLList
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 == LinkElement.LINK_NORMAL_FORMAT_NAME || param1 == LinkElement.LINK_ACTIVE_FORMAT_NAME || param1 == LinkElement.LINK_HOVER_FORMAT_NAME)
            {
                _loc_3 = "TextLayoutFormat";
                _loc_4 = TextLayoutFormat.description;
            }
            else if (param1 == ListElement.LIST_MARKER_FORMAT_NAME)
            {
                _loc_3 = "ListMarkerFormat";
                _loc_4 = ListMarkerFormat.description;
            }
            if (_loc_3 == null)
            {
                return null;
            }
            var _loc_5:* = new XML("<" + _loc_3 + "/>");
            new XML("<" + _loc_3 + "/>").setNamespace(flowNS);
            var _loc_6:* = this.createStylesFromDescription(param2, _loc_4, true, null);
            exportStyles(XMLList(_loc_5), _loc_6);
            var _loc_7:* = XMLList(new XML("<" + param1 + "/>"));
            XMLList(new XML("<" + param1 + "/>")).appendChild(_loc_5);
            return _loc_7;
        }// end function

        override protected function exportFlowElement(param1:FlowElement) : XMLList
        {
            var _loc_4:* = null;
            var _loc_2:* = super.exportFlowElement(param1);
            var _loc_3:* = param1.styles;
            if (_loc_3)
            {
                delete _loc_3[TextLayoutFormat.whiteSpaceCollapseProperty.name];
                _loc_4 = this.createStylesFromDescription(_loc_3, this.formatDescription, true, param1.parent ? (null) : ([FormatValue.INHERIT]));
                exportStyles(_loc_2, _loc_4);
            }
            if (param1.id != null)
            {
                _loc_2["id"] = param1.id;
            }
            if (param1.typeName != param1.defaultTypeName)
            {
                _loc_2["typeName"] = param1.typeName;
            }
            return _loc_2;
        }// end function

        override protected function get formatDescription() : Object
        {
            return _formatDescription;
        }// end function

        public static function exportImage(param1:BaseTextLayoutExporter, param2:InlineGraphicElement) : XMLList
        {
            var _loc_3:* = exportFlowElement(param1, param2);
            if (param2.height !== undefined)
            {
                _loc_3.@height = param2.height;
            }
            if (param2.width !== undefined)
            {
                _loc_3.@width = param2.width;
            }
            if (param2.source != null)
            {
                _loc_3.@source = param2.source;
            }
            if (param2.float != undefined)
            {
                _loc_3.@float = param2.float;
            }
            return _loc_3;
        }// end function

        public static function exportLink(param1:BaseTextLayoutExporter, param2:LinkElement) : XMLList
        {
            var _loc_3:* = exportFlowGroupElement(param1, param2);
            if (param2.href)
            {
                _loc_3.@href = param2.href;
            }
            if (param2.target)
            {
                _loc_3.@target = param2.target;
            }
            return _loc_3;
        }// end function

        public static function exportDiv(param1:BaseTextLayoutExporter, param2:DivElement) : XMLList
        {
            return exportContainerFormattedElement(param1, param2);
        }// end function

        public static function exportSPGE(param1:BaseTextLayoutExporter, param2:SubParagraphGroupElement) : XMLList
        {
            return exportFlowGroupElement(param1, param2);
        }// end function

        public static function exportTCY(param1:BaseTextLayoutExporter, param2:TCYElement) : XMLList
        {
            return exportFlowGroupElement(param1, param2);
        }// end function

    }
}
