package flashx.textLayout.conversion
{
    import flashx.textLayout.elements.*;

    public class TextConverter extends Object
    {
        public static const TEXT_FIELD_HTML_FORMAT:String = "textFieldHTMLFormat";
        public static const PLAIN_TEXT_FORMAT:String = "plainTextFormat";
        public static const TEXT_LAYOUT_FORMAT:String = "textLayoutFormat";
        static var _descriptors:Array = [];

        public function TextConverter()
        {
            return;
        }// end function

        static function setFormatsToDefault() : void
        {
            _descriptors = [];
            addFormat(TEXT_LAYOUT_FORMAT, TextLayoutImporter, TextLayoutExporter, TEXT_LAYOUT_FORMAT);
            addFormat(TEXT_FIELD_HTML_FORMAT, TextFieldHtmlImporter, TextFieldHtmlExporter, null);
            addFormat(PLAIN_TEXT_FORMAT, PlainTextImporter, PlainTextExporter, "air:text");
            return;
        }// end function

        public static function importToFlow(param1:Object, param2:String, param3:IConfiguration = null) : TextFlow
        {
            var _loc_4:* = getImporter(param2, param3);
            if (!getImporter(param2, param3))
            {
                return null;
            }
            _loc_4.throwOnError = false;
            return _loc_4.importToFlow(param1);
        }// end function

        public static function export(param1:TextFlow, param2:String, param3:String) : Object
        {
            var _loc_4:* = getExporter(param2);
            if (!getExporter(param2))
            {
                return null;
            }
            _loc_4.flashx.textLayout.conversion:ITextExporter::throwOnError = false;
            return _loc_4.export(param1, param3);
        }// end function

        public static function getImporter(param1:String, param2:IConfiguration = null) : ITextImporter
        {
            var _loc_5:* = null;
            var _loc_3:* = null;
            var _loc_4:* = findFormatIndex(param1);
            if (findFormatIndex(param1) >= 0)
            {
                _loc_5 = _descriptors[_loc_4];
                if (_loc_5 && _loc_5.importerClass)
                {
                    _loc_3 = new _loc_5.importerClass();
                    _loc_3.configuration = param2;
                }
            }
            return _loc_3;
        }// end function

        public static function getExporter(param1:String) : ITextExporter
        {
            var _loc_4:* = null;
            var _loc_2:* = null;
            var _loc_3:* = findFormatIndex(param1);
            if (_loc_3 >= 0)
            {
                _loc_4 = _descriptors[_loc_3];
                if (_loc_4 && _loc_4.exporterClass)
                {
                    _loc_2 = new _loc_4.exporterClass();
                }
            }
            return _loc_2;
        }// end function

        public static function addFormatAt(param1:int, param2:String, param3:Class, param4:Class = null, param5:String = null) : void
        {
            var _loc_6:* = new FormatDescriptor(param2, param3, param4, param5);
            _descriptors.splice(param1, 0, _loc_6);
            return;
        }// end function

        public static function addFormat(param1:String, param2:Class, param3:Class, param4:String) : void
        {
            addFormatAt(_descriptors.length, param1, param2, param3, param4);
            return;
        }// end function

        public static function removeFormatAt(param1:int) : void
        {
            if (param1 >= 0 && param1 < _descriptors.length)
            {
                _descriptors.splice(param1, 1);
            }
            return;
        }// end function

        private static function findFormatIndex(param1:String) : int
        {
            var _loc_2:* = 0;
            while (_loc_2 < numFormats)
            {
                
                if (_descriptors[_loc_2].format == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        public static function removeFormat(param1:String) : void
        {
            removeFormatAt(findFormatIndex(param1));
            return;
        }// end function

        public static function getFormatAt(param1:int) : String
        {
            return _descriptors[param1].format;
        }// end function

        public static function getFormatDescriptorAt(param1:int) : FormatDescriptor
        {
            return _descriptors[param1];
        }// end function

        public static function get numFormats() : int
        {
            return _descriptors.length;
        }// end function

        setFormatsToDefault();
    }
}
