package flashx.textLayout.property
{
    import __AS3__.vec.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class Property extends Object
    {
        private var _name:String;
        private var _default:Object;
        private var _inherited:Boolean;
        private var _categories:Vector.<String>;
        private var _hasCustomExporterHandler:Boolean;
        private var _numberPropertyHandler:NumberPropertyHandler;
        protected var _handlers:Vector.<PropertyHandler>;
        public static var errorHandler:Function = defaultErrorHandler;
        static const sharedStringHandler:StringPropertyHandler = new StringPropertyHandler();
        static const sharedInheritEnumHandler:EnumPropertyHandler = new EnumPropertyHandler([FormatValue.INHERIT]);
        static const sharedUndefinedHandler:UndefinedPropertyHandler = new UndefinedPropertyHandler();
        static const sharedUintHandler:UintPropertyHandler = new UintPropertyHandler();
        static const sharedBooleanHandler:BooleanPropertyHandler = new BooleanPropertyHandler();
        static const sharedTextLayoutFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
        static const sharedListMarkerFormatHandler:FormatPropertyHandler = new FormatPropertyHandler();
        private static const undefinedValue:Object = undefined;
        public static const NO_LIMITS:String = "noLimits";
        public static const LOWER_LIMIT:String = "lowerLimit";
        public static const UPPER_LIMIT:String = "upperLimit";
        public static const ALL_LIMITS:String = "allLimits";
        static const nullStyleObject:Object = new Object();
        private static var prototypeFactory:Function = @%@function ()@%@29387@%@;

        public function Property(param1:String, param2, param3:Boolean, param4:Vector.<String>)
        {
            this._name = param1;
            this._default = param2;
            this._inherited = param3;
            this._categories = param4;
            this._hasCustomExporterHandler = false;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get defaultValue()
        {
            return this._default;
        }// end function

        public function get inherited() : Object
        {
            return this._inherited;
        }// end function

        public function get category() : String
        {
            return this._categories[0];
        }// end function

        public function get categories() : Vector.<String>
        {
            return this._categories;
        }// end function

        public function addHandlers(... args) : void
        {
            var _loc_3:* = null;
            this._handlers = new Vector.<PropertyHandler>(args.length, true);
            args = 0;
            while (args < args.length)
            {
                
                _loc_3 = args[args];
                this._handlers[args] = _loc_3;
                if (_loc_3.customXMLStringHandler)
                {
                    this._hasCustomExporterHandler = true;
                }
                if (_loc_3 is NumberPropertyHandler)
                {
                    this._numberPropertyHandler = _loc_3 as NumberPropertyHandler;
                }
                args++;
            }
            return;
        }// end function

        public function findHandler(param1:Class) : PropertyHandler
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._handlers)
            {
                
                if (_loc_2 is param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function setHelper(param1, param2)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            for each (_loc_3 in this._handlers)
            {
                
                _loc_4 = _loc_3.owningHandlerCheck(param2);
                if (_loc_4 !== undefined)
                {
                    return _loc_3.setHelper(_loc_4);
                }
            }
            Property.errorHandler(this, param2);
            return param1;
        }// end function

        public function concatInheritOnlyHelper(param1, param2)
        {
            return this._inherited && param1 === undefined || param1 == FormatValue.INHERIT ? (param2) : (param1);
        }// end function

        public function concatHelper(param1, param2)
        {
            if (this._inherited)
            {
                return param1 === undefined || param1 == FormatValue.INHERIT ? (param2) : (param1);
            }
            if (param1 === undefined)
            {
                return this.defaultValue;
            }
            return param1 == FormatValue.INHERIT ? (param2) : (param1);
        }// end function

        public function equalHelper(param1, param2) : Boolean
        {
            return param1 == param2;
        }// end function

        public function toXMLString(param1:Object) : String
        {
            var _loc_2:* = null;
            if (this._hasCustomExporterHandler)
            {
                for each (_loc_2 in this._handlers)
                {
                    
                    if (_loc_2.customXMLStringHandler && _loc_2.owningHandlerCheck(param1) !== undefined)
                    {
                        return _loc_2.toXMLString(param1);
                    }
                }
            }
            return param1.toString();
        }// end function

        public function get maxPercentValue() : Number
        {
            var _loc_1:* = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
            return _loc_1 ? (_loc_1.maxValue) : (NaN);
        }// end function

        public function get minPercentValue() : Number
        {
            var _loc_1:* = this.findHandler(PercentPropertyHandler) as PercentPropertyHandler;
            return _loc_1 ? (_loc_1.minValue) : (NaN);
        }// end function

        public function get minValue() : Number
        {
            var _loc_1:* = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
            if (_loc_1)
            {
                return _loc_1.minValue;
            }
            var _loc_2:* = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
            return _loc_2 ? (_loc_2.minValue) : (NaN);
        }// end function

        public function get maxValue() : Number
        {
            var _loc_1:* = this.findHandler(NumberPropertyHandler) as NumberPropertyHandler;
            if (_loc_1)
            {
                return _loc_1.maxValue;
            }
            var _loc_2:* = this.findHandler(IntPropertyHandler) as IntPropertyHandler;
            return _loc_2 ? (_loc_2.maxValue) : (NaN);
        }// end function

        public function computeActualPropertyValue(param1:Object, param2:Number) : Number
        {
            var _loc_3:* = toNumberIfPercent(param1);
            if (isNaN(_loc_3))
            {
                return Number(param1);
            }
            var _loc_4:* = param2 * (_loc_3 / 100);
            return this._numberPropertyHandler ? (this._numberPropertyHandler.clampToRange(_loc_4)) : (_loc_4);
        }// end function

        public static function defaultErrorHandler(param1:Property, param2:Object) : void
        {
            throw new RangeError(createErrorString(param1, param2));
        }// end function

        public static function createErrorString(param1:Property, param2:Object) : String
        {
            return GlobalSettings.resourceStringFunction("badPropertyValue", [param1.name, param2.toString()]);
        }// end function

        public static function NewBooleanProperty(param1:String, param2:Boolean, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, sharedBooleanHandler, sharedInheritEnumHandler);
            return _loc_5;
        }// end function

        public static function NewStringProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, sharedStringHandler);
            return _loc_5;
        }// end function

        public static function NewUintProperty(param1:String, param2:uint, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, sharedUintHandler, sharedInheritEnumHandler);
            return _loc_5;
        }// end function

        public static function NewEnumStringProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>, ... args) : Property
        {
            args = new Property(param1, param2, param3, param4);
            args.addHandlers(sharedUndefinedHandler, new EnumPropertyHandler(args), sharedInheritEnumHandler);
            return args;
        }// end function

        public static function NewIntOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:int, param6:int, ... args) : Property
        {
            args = new Property(param1, param2, param3, param4);
            args.addHandlers(sharedUndefinedHandler, new EnumPropertyHandler(args), new IntPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return args;
        }// end function

        public static function NewUintOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, ... args) : Property
        {
            args = new Property(param1, param2, param3, param4);
            args.addHandlers(sharedUndefinedHandler, new EnumPropertyHandler(args), sharedUintHandler, sharedInheritEnumHandler);
            return args;
        }// end function

        public static function NewNumberProperty(param1:String, param2:Number, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number) : Property
        {
            var _loc_7:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, new NumberPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return _loc_7;
        }// end function

        public static function NewNumberOrPercentOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, param7:String, param8:String, ... args) : Property
        {
            args = new Property(param1, param2, param3, param4);
            args.addHandlers(sharedUndefinedHandler, new EnumPropertyHandler(args), new PercentPropertyHandler(param7, param8), new NumberPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return args;
        }// end function

        public static function NewNumberOrPercentProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, param7:String, param8:String) : Property
        {
            var _loc_9:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, new PercentPropertyHandler(param7, param8), new NumberPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return _loc_9;
        }// end function

        public static function NewNumberOrEnumProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:Number, param6:Number, ... args) : Property
        {
            args = new Property(param1, param2, param3, param4);
            args.addHandlers(sharedUndefinedHandler, new EnumPropertyHandler(args), new NumberPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return args;
        }// end function

        public static function NewTabStopsProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>) : Property
        {
            return new TabStopsProperty(param1, param2, param3, param4);
        }// end function

        public static function NewSpacingLimitProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>, param5:String, param6:String) : Property
        {
            var _loc_7:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(sharedUndefinedHandler, new SpacingLimitPropertyHandler(param5, param6), sharedInheritEnumHandler);
            return _loc_7;
        }// end function

        public static function NewTextLayoutFormatProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, undefinedValue, param3, param4);
            new Property(param1, undefinedValue, param3, param4).addHandlers(sharedUndefinedHandler, sharedTextLayoutFormatHandler, sharedInheritEnumHandler);
            return _loc_5;
        }// end function

        public static function NewListMarkerFormatProperty(param1:String, param2:Object, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, undefinedValue, param3, param4);
            new Property(param1, undefinedValue, param3, param4).addHandlers(sharedUndefinedHandler, sharedListMarkerFormatHandler, sharedInheritEnumHandler);
            return _loc_5;
        }// end function

        public static function defaultConcatHelper(param1, param2)
        {
            return param1 === undefined || param1 == FormatValue.INHERIT ? (param2) : (param1);
        }// end function

        public static function defaultsAllHelper(param1:Object, param2:Object) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in param1)
            {
                
                param2[_loc_3.name] = _loc_3.defaultValue;
            }
            return;
        }// end function

        public static function equalAllHelper(param1:Object, param2:Object, param3:Object) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param2 == param3)
            {
                return true;
            }
            if (param2 == null || param3 == null)
            {
                return false;
            }
            for each (_loc_4 in param1)
            {
                
                _loc_5 = _loc_4.name;
                if (!_loc_4.equalHelper(param2[_loc_5], param3[_loc_5]))
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function extractInCategory(param1:Class, param2:Object, param3:Object, param4:String, param5:Boolean = true) : Object
        {
            var _loc_7:* = null;
            var _loc_6:* = null;
            for each (_loc_7 in param2)
            {
                
                if (param3[_loc_7.name] == null)
                {
                    continue;
                }
                if (param5)
                {
                    if (_loc_7.category != param4)
                    {
                        continue;
                    }
                }
                else if (_loc_7.categories.indexOf(param4) == -1)
                {
                    continue;
                }
                if (_loc_6 == null)
                {
                    _loc_6 = new param1;
                }
                _loc_6[_loc_7.name] = param3[_loc_7.name];
            }
            return _loc_6;
        }// end function

        public static function shallowCopy(param1:Object) : Object
        {
            var _loc_3:* = null;
            var _loc_2:* = new Object();
            for (_loc_3 in param1)
            {
                
                _loc_2[_loc_3] = param1[_loc_3];
            }
            return _loc_2;
        }// end function

        public static function shallowCopyInFilter(param1:Object, param2:Object) : Object
        {
            var _loc_4:* = null;
            var _loc_3:* = new Object();
            for (_loc_4 in param1)
            {
                
                if (param2.hasOwnProperty(_loc_4))
                {
                    _loc_3[_loc_4] = param1[_loc_4];
                }
            }
            return _loc_3;
        }// end function

        public static function shallowCopyNotInFilter(param1:Object, param2:Object) : Object
        {
            var _loc_4:* = null;
            var _loc_3:* = new Object();
            for (_loc_4 in param1)
            {
                
                if (!param2.hasOwnProperty(_loc_4))
                {
                    _loc_3[_loc_4] = param1[_loc_4];
                }
            }
            return _loc_3;
        }// end function

        private static function compareStylesLoop(param1:Object, param2:Object, param3:Object) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            for (_loc_4 in param1)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = param2[_loc_4];
                if (_loc_5 != _loc_6)
                {
                    if (!(_loc_5 is Array) || !(_loc_6 is Array) || _loc_5.length != _loc_6.length || !param3)
                    {
                        return false;
                    }
                    _loc_7 = param3[_loc_4];
                    if (!_loc_7 || !equalAllHelper(_loc_7.memberType.description, _loc_5, _loc_6))
                    {
                        return false;
                    }
                }
            }
            return true;
        }// end function

        public static function equalStyles(param1:Object, param2:Object, param3:Object) : Boolean
        {
            if (param1 == null)
            {
                param1 = nullStyleObject;
            }
            if (param2 == null)
            {
                param2 = nullStyleObject;
            }
            return compareStylesLoop(param1, param2, param3) && compareStylesLoop(param2, param1, param3);
        }// end function

        public static function toNumberIfPercent(param1:Object) : Number
        {
            if (!(param1 is String))
            {
                return NaN;
            }
            var _loc_2:* = String(param1);
            var _loc_3:* = _loc_2.length;
            return _loc_3 != 0 && _loc_2.charAt((_loc_3 - 1)) == "%" ? (parseFloat(_loc_2)) : (NaN);
        }// end function

        public static function createObjectWithPrototype(param1:Object) : Object
        {
            prototypeFactory.prototype = param1;
            return new prototypeFactory();
        }// end function

    }
}
