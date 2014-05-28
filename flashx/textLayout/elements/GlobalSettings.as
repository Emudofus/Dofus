package flashx.textLayout.elements
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class GlobalSettings extends Object
   {
      
      public function GlobalSettings() {
         super();
      }
      
      public static function get fontMapperFunction() : Function {
         return _fontMapperFunction;
      }
      
      public static function set fontMapperFunction(param1:Function) : void {
         _fontMapperFunction = param1;
      }
      
      private static var _fontMapperFunction:Function;
      
      public static function get enableSearch() : Boolean {
         return _enableSearch;
      }
      
      public static function set enableSearch(param1:Boolean) : void {
         _enableSearch = param1;
      }
      
      private static var _enableSearch:Boolean = true;
      
      public static function get resolveFontLookupFunction() : Function {
         return _resolveFontLookupFunction;
      }
      
      public static function set resolveFontLookupFunction(param1:Function) : void {
         _resolveFontLookupFunction = param1;
      }
      
      private static var _resolveFontLookupFunction:Function;
      
      public static function get resourceStringFunction() : Function {
         return _resourceStringFunction;
      }
      
      public static function set resourceStringFunction(param1:Function) : void {
         _resourceStringFunction = param1;
      }
      
      private static var _resourceStringFunction:Function = defaultResourceStringFunction;
      
      private static const resourceDict:Object = 
         {
            "missingStringResource":"No string for resource {0}",
            "invalidFlowElementConstruct":"Attempted construct of invalid FlowElement subclass",
            "invalidSplitAtPosition":"Invalid parameter to splitAtPosition",
            "badMXMLChildrenArgument":"Bad element of type {0} passed to mxmlChildren",
            "badReplaceChildrenIndex":"Out of range index to FlowGroupElement.replaceChildren",
            "invalidChildType":"NewElement not of a type that this can be parent of",
            "badRemoveChild":"Child to remove not found",
            "invalidSplitAtIndex":"Invalid parameter to splitAtIndex",
            "badShallowCopyRange":"Bad range in shallowCopy",
            "badSurrogatePairCopy":"Copying only half of a surrogate pair in SpanElement.shallowCopy",
            "invalidReplaceTextPositions":"Invalid positions passed to SpanElement.replaceText",
            "invalidSurrogatePairSplit":"Invalid splitting of a surrogate pair",
            "badPropertyValue":"Property {0} value {1} is out of range",
            "illegalOperation":"Illegal attempt to execute {0} operation",
            "unexpectedXMLElementInSpan":"Unexpected element {0} within a span",
            "unexpectedNamespace":"Unexpected namespace {0}",
            "unknownElement":"Unknown element {0}",
            "unknownAttribute":"Attribute {0} not permitted in element {1}",
            "malformedTag":"Malformed tag {0}",
            "malformedMarkup":"Malformed markup {0}",
            "missingTextFlow":"No TextFlow to parse",
            "expectedExactlyOneTextLayoutFormat":"Expected one and only one TextLayoutFormat in {0}",
            "expectedExactlyOneListMarkerFormat":"Expected one and only one ListMarkerFormat in {0}",
            "unsupportedVersion":"Version {0} is unsupported",
            "unsupportedProperty":"Property {0} is unsupported"
         };
      
      tlf_internal  static function defaultResourceStringFunction(param1:String, param2:Array=null) : String {
         var _loc3_:String = String(resourceDict[param1]);
         if(_loc3_ == null)
         {
            _loc3_ = String(resourceDict["missingStringResource"]);
            param2 = [param1];
         }
         if(param2)
         {
            _loc3_ = substitute(_loc3_,param2);
         }
         return _loc3_;
      }
      
      tlf_internal  static function substitute(param1:String, ... rest) : String {
         var _loc4_:Array = null;
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:uint = rest.length;
         if(_loc3_ == 1 && rest[0] is Array)
         {
            _loc4_ = rest[0] as Array;
            _loc3_ = _loc4_.length;
         }
         else
         {
            _loc4_ = rest;
         }
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc4_[_loc5_]);
            _loc5_++;
         }
         return param1;
      }
      
      private static var _enableDefaultTabStops:Boolean = false;
      
      tlf_internal  static function get enableDefaultTabStops() : Boolean {
         return _enableDefaultTabStops;
      }
      
      tlf_internal  static function set enableDefaultTabStops(param1:Boolean) : void {
         _enableDefaultTabStops = param1;
      }
   }
}
