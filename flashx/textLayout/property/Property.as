package flashx.textLayout.property
{
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.tlf_internal;
   import __AS3__.vec.Vector;
   import flashx.textLayout.formats.FormatValue;
   
   use namespace tlf_internal;
   
   public class Property extends Object
   {
      
      public function Property(param1:String, param2:*, param3:Boolean, param4:Vector.<String>) {
         super();
         this._name = param1;
         this._default = param2;
         this._inherited = param3;
         this._categories = param4;
         this._hasCustomExporterHandler = false;
      }
      
      public static var errorHandler:Function = defaultErrorHandler;
      
      public static function defaultErrorHandler(param1:Property, param2:Object) : void {
         throw new RangeError(createErrorString(param1,param2));
      }
      
      public static function createErrorString(param1:Property, param2:Object) : String {
         return GlobalSettings.resourceStringFunction("badPropertyValue",[param1.name,param2.toString()]);
      }
      
      tlf_internal  static const sharedStringHandler:StringPropertyHandler = new StringPropertyHandler();
      
      tlf_internal  static const sharedInheritEnumHandler:EnumPropertyHandler = new EnumPropertyHandler([FormatValue.INHERIT]);
      
      tlf_internal  static const sharedUndefinedHandler:UndefinedPropertyHandler = new UndefinedPropertyHandler();
      
      tlf_internal  static const sharedUintHandler:UintPropertyHandler = new UintPropertyHandler();
      
      tlf_internal  static const sharedBooleanHandler:BooleanPropertyHandler = new BooleanPropertyHandler();
      
      tlf_internal  static const sharedTextLayoutFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
      
      tlf_internal  static const sharedListMarkerFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
      
      public static function NewBooleanProperty(param1:String, param2:Boolean, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(sharedUndefinedHandler,sharedBooleanHandler,sharedInheritEnumHandler);
         return _loc5_;
      }
      
      public static function NewStringProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(sharedUndefinedHandler,sharedStringHandler);
         return _loc5_;
      }
      
      public static function NewUintProperty(param1:String, param2:uint, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(sharedUndefinedHandler,sharedUintHandler,sharedInheritEnumHandler);
         return _loc5_;
      }
      
      public static function NewEnumStringProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>, ... rest) : Property {
         var _loc6_:Property = new Property(param1,param2,param3,param4);
         _loc6_.addHandlers(sharedUndefinedHandler,new EnumPropertyHandler(rest),sharedInheritEnumHandler);
         return _loc6_;
      }
      
      public static function NewIntOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:int, param6:int, ... rest) : Property {
         var _loc8_:Property = new Property(param1,param2,param3,param4);
         _loc8_.addHandlers(sharedUndefinedHandler,new EnumPropertyHandler(rest),new IntPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc8_;
      }
      
      public static function NewUintOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, ... rest) : Property {
         var _loc6_:Property = new Property(param1,param2,param3,param4);
         _loc6_.addHandlers(sharedUndefinedHandler,new EnumPropertyHandler(rest),sharedUintHandler,sharedInheritEnumHandler);
         return _loc6_;
      }
      
      public static function NewNumberProperty(param1:String, param2:Number, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number) : Property {
         var _loc7_:Property = new Property(param1,param2,param3,param4);
         _loc7_.addHandlers(sharedUndefinedHandler,new NumberPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc7_;
      }
      
      public static function NewNumberOrPercentOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, param7:String, param8:String, ... rest) : Property {
         var _loc10_:Property = new Property(param1,param2,param3,param4);
         _loc10_.addHandlers(sharedUndefinedHandler,new EnumPropertyHandler(rest),new PercentPropertyHandler(param7,param8),new NumberPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc10_;
      }
      
      public static function NewNumberOrPercentProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, param7:String, param8:String) : Property {
         var _loc9_:Property = new Property(param1,param2,param3,param4);
         _loc9_.addHandlers(sharedUndefinedHandler,new PercentPropertyHandler(param7,param8),new NumberPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc9_;
      }
      
      public static function NewNumberOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, ... rest) : Property {
         var _loc8_:Property = new Property(param1,param2,param3,param4);
         _loc8_.addHandlers(sharedUndefinedHandler,new EnumPropertyHandler(rest),new NumberPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc8_;
      }
      
      public static function NewTabStopsProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>) : Property {
         return new TabStopsProperty(param1,param2,param3,param4);
      }
      
      public static function NewSpacingLimitProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:String, param6:String) : Property {
         var _loc7_:Property = new Property(param1,param2,param3,param4);
         _loc7_.addHandlers(sharedUndefinedHandler,new SpacingLimitPropertyHandler(param5,param6),sharedInheritEnumHandler);
         return _loc7_;
      }
      
      private static const undefinedValue = undefined;
      
      public static function NewTextLayoutFormatProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,undefinedValue,param3,param4);
         _loc5_.addHandlers(sharedUndefinedHandler,sharedTextLayoutFormatHandler,sharedInheritEnumHandler);
         return _loc5_;
      }
      
      public static function NewListMarkerFormatProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,undefinedValue,param3,param4);
         _loc5_.addHandlers(sharedUndefinedHandler,sharedListMarkerFormatHandler,sharedInheritEnumHandler);
         return _loc5_;
      }
      
      public static const NO_LIMITS:String = "noLimits";
      
      public static const LOWER_LIMIT:String = "lowerLimit";
      
      public static const UPPER_LIMIT:String = "upperLimit";
      
      public static const ALL_LIMITS:String = "allLimits";
      
      public static function defaultConcatHelper(param1:*, param2:*) : * {
         return param1 === undefined || param1 == FormatValue.INHERIT?param2:param1;
      }
      
      public static function defaultsAllHelper(param1:Object, param2:Object) : void {
         var _loc3_:Property = null;
         for each (_loc3_ in param1)
         {
            param2[_loc3_.name] = _loc3_.defaultValue;
         }
      }
      
      public static function equalAllHelper(param1:Object, param2:Object, param3:Object) : Boolean {
         var _loc4_:Property = null;
         var _loc5_:String = null;
         if(param2 == param3)
         {
            return true;
         }
         if(param2 == null || param3 == null)
         {
            return false;
         }
         for each (_loc4_ in param1)
         {
            _loc5_ = _loc4_.name;
            if(!_loc4_.equalHelper(param2[_loc5_],param3[_loc5_]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function extractInCategory(param1:Class, param2:Object, param3:Object, param4:String, param5:Boolean=true) : Object {
         var _loc7_:Property = null;
         var _loc6_:Object = null;
         for each (_loc7_ in param2)
         {
            if(param3[_loc7_.name] != null)
            {
               if(param5)
               {
                  if(_loc7_.category != param4)
                  {
                     continue;
                  }
               }
               else
               {
                  if(_loc7_.categories.indexOf(param4) == -1)
                  {
                     continue;
                  }
               }
               if(_loc6_ == null)
               {
                  _loc6_ = new param1();
               }
               _loc6_[_loc7_.name] = param3[_loc7_.name];
            }
         }
         return _loc6_;
      }
      
      public static function shallowCopy(param1:Object) : Object {
         var _loc3_:Object = null;
         var _loc2_:Object = new Object();
         for (_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function shallowCopyInFilter(param1:Object, param2:Object) : Object {
         var _loc4_:Object = null;
         var _loc3_:Object = new Object();
         for (_loc4_ in param1)
         {
            if(param2.hasOwnProperty(_loc4_))
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public static function shallowCopyNotInFilter(param1:Object, param2:Object) : Object {
         var _loc4_:Object = null;
         var _loc3_:Object = new Object();
         for (_loc4_ in param1)
         {
            if(!param2.hasOwnProperty(_loc4_))
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
         }
         return _loc3_;
      }
      
      private static function compareStylesLoop(param1:Object, param2:Object, param3:Object) : Boolean {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:ArrayProperty = null;
         for (_loc4_ in param1)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = param2[_loc4_];
            if(_loc5_ != _loc6_)
            {
               if(!(_loc5_ is Array) || !(_loc6_ is Array) || !(_loc5_.length == _loc6_.length) || !param3)
               {
                  return false;
               }
               _loc7_ = param3[_loc4_];
               if(!_loc7_ || !equalAllHelper(_loc7_.memberType.description,_loc5_,_loc6_))
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      tlf_internal  static const nullStyleObject:Object = new Object();
      
      public static function equalStyles(param1:Object, param2:Object, param3:Object) : Boolean {
         if(param1 == null)
         {
            param1 = nullStyleObject;
         }
         if(param2 == null)
         {
            param2 = nullStyleObject;
         }
         return (compareStylesLoop(param1,param2,param3)) && (compareStylesLoop(param2,param1,param3));
      }
      
      public static function toNumberIfPercent(param1:Object) : Number {
         if(!(param1 is String))
         {
            return NaN;
         }
         var _loc2_:String = String(param1);
         var _loc3_:int = _loc2_.length;
         return !(_loc3_ == 0) && _loc2_.charAt(_loc3_-1) == "%"?parseFloat(_loc2_):NaN;
      }
      
      private static var prototypeFactory:Function = function():void
      {
      };
      
      public static function createObjectWithPrototype(param1:Object) : Object {
         prototypeFactory.prototype = param1;
         return new prototypeFactory();
      }
      
      private var _name:String;
      
      private var _default;
      
      private var _inherited:Boolean;
      
      private var _categories:Vector.<String>;
      
      private var _hasCustomExporterHandler:Boolean;
      
      private var _numberPropertyHandler:NumberPropertyHandler;
      
      protected var _handlers:Vector.<PropertyHandler>;
      
      public function get name() : String {
         return this._name;
      }
      
      public function get defaultValue() : * {
         return this._default;
      }
      
      public function get inherited() : Object {
         return this._inherited;
      }
      
      public function get category() : String {
         return this._categories[0];
      }
      
      public function get categories() : Vector.<String> {
         return this._categories;
      }
      
      public function addHandlers(... rest) : void {
         var _loc3_:PropertyHandler = null;
         this._handlers = new Vector.<PropertyHandler>(rest.length,true);
         var _loc2_:* = 0;
         while(_loc2_ < rest.length)
         {
            _loc3_ = rest[_loc2_];
            this._handlers[_loc2_] = _loc3_;
            if(_loc3_.customXMLStringHandler)
            {
               this._hasCustomExporterHandler = true;
            }
            if(_loc3_ is NumberPropertyHandler)
            {
               this._numberPropertyHandler = _loc3_ as NumberPropertyHandler;
            }
            _loc2_++;
         }
      }
      
      public function findHandler(param1:Class) : PropertyHandler {
         var _loc2_:PropertyHandler = null;
         for each (_loc2_ in this._handlers)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setHelper(param1:*, param2:*) : * {
         var _loc3_:PropertyHandler = null;
         var _loc4_:* = undefined;
         for each (_loc3_ in this._handlers)
         {
            _loc4_ = _loc3_.owningHandlerCheck(param2);
            if(_loc4_ !== undefined)
            {
               return _loc3_.setHelper(_loc4_);
            }
         }
         Property.errorHandler(this,param2);
         return param1;
      }
      
      public function concatInheritOnlyHelper(param1:*, param2:*) : * {
         return (this._inherited) && param1 === undefined || param1 == FormatValue.INHERIT?param2:param1;
      }
      
      public function concatHelper(param1:*, param2:*) : * {
         if(this._inherited)
         {
            return param1 === undefined || param1 == FormatValue.INHERIT?param2:param1;
         }
         if(param1 === undefined)
         {
            return this.defaultValue;
         }
         return param1 == FormatValue.INHERIT?param2:param1;
      }
      
      public function equalHelper(param1:*, param2:*) : Boolean {
         return param1 == param2;
      }
      
      public function toXMLString(param1:Object) : String {
         var _loc2_:PropertyHandler = null;
         if(this._hasCustomExporterHandler)
         {
            for each (_loc2_ in this._handlers)
            {
               if((_loc2_.customXMLStringHandler) && !(_loc2_.owningHandlerCheck(param1) === undefined))
               {
                  return _loc2_.toXMLString(param1);
               }
            }
         }
         return param1.toString();
      }
      
      public function get maxPercentValue() : Number {
         var _loc1_:PercentPropertyHandler = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
         return _loc1_?_loc1_.maxValue:NaN;
      }
      
      public function get minPercentValue() : Number {
         var _loc1_:PercentPropertyHandler = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
         return _loc1_?_loc1_.minValue:NaN;
      }
      
      public function get minValue() : Number {
         var _loc1_:NumberPropertyHandler = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
         if(_loc1_)
         {
            return _loc1_.minValue;
         }
         var _loc2_:IntPropertyHandler = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
         return _loc2_?_loc2_.minValue:NaN;
      }
      
      public function get maxValue() : Number {
         var _loc1_:NumberPropertyHandler = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
         if(_loc1_)
         {
            return _loc1_.maxValue;
         }
         var _loc2_:IntPropertyHandler = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
         return _loc2_?_loc2_.maxValue:NaN;
      }
      
      public function computeActualPropertyValue(param1:Object, param2:Number) : Number {
         var _loc3_:Number = toNumberIfPercent(param1);
         if(isNaN(_loc3_))
         {
            return Number(param1);
         }
         var _loc4_:Number = param2 * _loc3_ / 100;
         return this._numberPropertyHandler?this._numberPropertyHandler.clampToRange(_loc4_):_loc4_;
      }
   }
}
