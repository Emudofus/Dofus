package flashx.textLayout.elements
{

    public class GlobalSettings extends Object
    {
        private static var _fontMapperFunction:Function;
        private static var _enableSearch:Boolean = true;
        private static var _resolveFontLookupFunction:Function;
        private static var _resourceStringFunction:Function = defaultResourceStringFunction;
        private static const resourceDict:Object = {missingStringResource:"No string for resource {0}", invalidFlowElementConstruct:"Attempted construct of invalid FlowElement subclass", invalidSplitAtPosition:"Invalid parameter to splitAtPosition", badMXMLChildrenArgument:"Bad element of type {0} passed to mxmlChildren", badReplaceChildrenIndex:"Out of range index to FlowGroupElement.replaceChildren", invalidChildType:"NewElement not of a type that this can be parent of", badRemoveChild:"Child to remove not found", invalidSplitAtIndex:"Invalid parameter to splitAtIndex", badShallowCopyRange:"Bad range in shallowCopy", badSurrogatePairCopy:"Copying only half of a surrogate pair in SpanElement.shallowCopy", invalidReplaceTextPositions:"Invalid positions passed to SpanElement.replaceText", invalidSurrogatePairSplit:"Invalid splitting of a surrogate pair", badPropertyValue:"Property {0} value {1} is out of range", illegalOperation:"Illegal attempt to execute {0} operation", unexpectedXMLElementInSpan:"Unexpected element {0} within a span", unexpectedNamespace:"Unexpected namespace {0}", unknownElement:"Unknown element {0}", unknownAttribute:"Attribute {0} not permitted in element {1}", malformedTag:"Malformed tag {0}", malformedMarkup:"Malformed markup {0}", missingTextFlow:"No TextFlow to parse", expectedExactlyOneTextLayoutFormat:"Expected one and only one TextLayoutFormat in {0}", expectedExactlyOneListMarkerFormat:"Expected one and only one ListMarkerFormat in {0}", unsupportedVersion:"Version {0} is unsupported", unsupportedProperty:"Property {0} is unsupported"};
        private static var _enableDefaultTabStops:Boolean = false;
        private static var _alwaysCalculateWhitespaceBounds:Boolean = false;

        public function GlobalSettings()
        {
            return;
        }// end function

        public static function get fontMapperFunction() : Function
        {
            return _fontMapperFunction;
        }// end function

        public static function set fontMapperFunction(param1:Function) : void
        {
            _fontMapperFunction = param1;
            return;
        }// end function

        public static function get enableSearch() : Boolean
        {
            return _enableSearch;
        }// end function

        public static function set enableSearch(param1:Boolean) : void
        {
            _enableSearch = param1;
            return;
        }// end function

        public static function get resolveFontLookupFunction() : Function
        {
            return _resolveFontLookupFunction;
        }// end function

        public static function set resolveFontLookupFunction(param1:Function) : void
        {
            _resolveFontLookupFunction = param1;
            return;
        }// end function

        public static function get resourceStringFunction() : Function
        {
            return _resourceStringFunction;
        }// end function

        public static function set resourceStringFunction(param1:Function) : void
        {
            _resourceStringFunction = param1;
            return;
        }// end function

        static function defaultResourceStringFunction(param1:String, param2:Array = null) : String
        {
            var _loc_3:* = String(resourceDict[param1]);
            if (_loc_3 == null)
            {
                _loc_3 = String(resourceDict["missingStringResource"]);
                param2 = [param1];
            }
            if (param2)
            {
                _loc_3 = substitute(_loc_3, param2);
            }
            return _loc_3;
        }// end function

        static function substitute(param1:String, ... args) : String
        {
            var _loc_4:* = null;
            if (param1 == null)
            {
                return "";
            }
            args = args.length;
            if (args == 1 && args[0] is Array)
            {
                _loc_4 = args[0] as Array;
                args = _loc_4.length;
            }
            else
            {
                _loc_4 = args;
            }
            var _loc_5:* = 0;
            while (_loc_5 < args)
            {
                
                param1 = param1.replace(new RegExp("\\{" + _loc_5 + "\\}", "g"), _loc_4[_loc_5]);
                _loc_5++;
            }
            return param1;
        }// end function

        static function get enableDefaultTabStops() : Boolean
        {
            return _enableDefaultTabStops;
        }// end function

        static function set enableDefaultTabStops(param1:Boolean) : void
        {
            _enableDefaultTabStops = param1;
            return;
        }// end function

        static function get alwaysCalculateWhitespaceBounds() : Boolean
        {
            return _alwaysCalculateWhitespaceBounds;
        }// end function

        static function set alwaysCalculateWhitespaceBounds(param1:Boolean) : void
        {
            _alwaysCalculateWhitespaceBounds = param1;
            return;
        }// end function

    }
}
