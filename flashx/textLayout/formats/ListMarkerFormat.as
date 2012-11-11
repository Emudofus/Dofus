package flashx.textLayout.formats
{
    import __AS3__.vec.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class ListMarkerFormat extends TextLayoutFormat implements IListMarkerFormat
    {
        static const counterResetProperty:Property = createCounterResetProperty("counterReset", FormatValue.NONE, false, ListMarkerFormat.Vector.<String>([Category.LIST]));
        static const counterIncrementProperty:Property = createCounterResetProperty("counterIncrement", "ordered 1", false, ListMarkerFormat.Vector.<String>([Category.LIST]));
        static const beforeContentProperty:Property = Property.NewStringProperty("beforeContent", null, false, ListMarkerFormat.Vector.<String>([Category.LIST]));
        static const contentProperty:Property = createCounterContentProperty("content", "counter(ordered)", false, ListMarkerFormat.Vector.<String>([Category.LIST]));
        static const afterContentProperty:Property = Property.NewStringProperty("afterContent", null, false, ListMarkerFormat.Vector.<String>([Category.LIST]));
        static const suffixProperty:Property = Property.NewEnumStringProperty("suffix", Suffix.AUTO, false, ListMarkerFormat.Vector.<String>([Category.LIST]), Suffix.AUTO, Suffix.NONE);
        private static var _lmfDescription:Object = {counterReset:counterResetProperty, counterIncrement:counterIncrementProperty, beforeContent:beforeContentProperty, content:contentProperty, afterContent:afterContentProperty, suffix:suffixProperty};
        private static var _description:Object;

        public function ListMarkerFormat(param1:IListMarkerFormat = null)
        {
            super(param1);
            return;
        }// end function

        private function setLMFStyle(param1:Property, param2) : void
        {
            var _loc_3:* = param1.name;
            param2 = param1.setHelper(getStyle(_loc_3), param2);
            super.setStyleByName(_loc_3, param2);
            return;
        }// end function

        override public function setStyle(param1:String, param2) : void
        {
            var _loc_3:* = _lmfDescription[param1];
            if (_loc_3)
            {
                this.setLMFStyle(_loc_3, param2);
            }
            else
            {
                super.setStyle(param1, param2);
            }
            return;
        }// end function

        public function get counterReset()
        {
            return getStyle(counterResetProperty.name);
        }// end function

        public function set counterReset(param1)
        {
            this.setLMFStyle(counterResetProperty, param1);
            return;
        }// end function

        public function get counterIncrement()
        {
            return getStyle(counterIncrementProperty.name);
        }// end function

        public function set counterIncrement(param1)
        {
            this.setLMFStyle(counterIncrementProperty, param1);
            return;
        }// end function

        public function get content()
        {
            return getStyle(contentProperty.name);
        }// end function

        public function set content(param1)
        {
            this.setLMFStyle(contentProperty, param1);
            return;
        }// end function

        public function get beforeContent()
        {
            return getStyle(beforeContentProperty.name);
        }// end function

        public function set beforeContent(param1) : void
        {
            this.setLMFStyle(beforeContentProperty, param1);
            return;
        }// end function

        public function get afterContent()
        {
            return getStyle(afterContentProperty.name);
        }// end function

        public function set afterContent(param1) : void
        {
            this.setLMFStyle(afterContentProperty, param1);
            return;
        }// end function

        public function get suffix()
        {
            return getStyle(suffixProperty.name);
        }// end function

        public function set suffix(param1) : void
        {
            this.setLMFStyle(suffixProperty, param1);
            return;
        }// end function

        override public function copy(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            super.copy(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for (_loc_3 in _lmfDescription)
                {
                    
                    this[_loc_3] = _loc_2[_loc_3];
                }
            }
            return;
        }// end function

        override public function concat(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.concat(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for each (_loc_3 in _lmfDescription)
                {
                    
                    _loc_4 = _loc_3.name;
                    this.setLMFStyle(_loc_3, _loc_3.concatHelper(this[_loc_4], _loc_2[_loc_4]));
                }
            }
            return;
        }// end function

        override public function concatInheritOnly(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.concatInheritOnly(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for each (_loc_3 in _lmfDescription)
                {
                    
                    _loc_4 = _loc_3.name;
                    this.setLMFStyle(_loc_3, _loc_3.concatInheritOnlyHelper(this[_loc_4], _loc_2[_loc_4]));
                }
            }
            return;
        }// end function

        override public function apply(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            super.apply(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for each (_loc_3 in _lmfDescription)
                {
                    
                    _loc_4 = _loc_3.name;
                    _loc_5 = _loc_2[_loc_4];
                    if (_loc_5 !== undefined)
                    {
                        this[_loc_4] = _loc_5;
                    }
                }
            }
            return;
        }// end function

        override public function removeMatching(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.removeMatching(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for each (_loc_3 in _lmfDescription)
                {
                    
                    _loc_4 = _loc_3.name;
                    if (_loc_3.equalHelper(this[_loc_4], _loc_2[_loc_4]))
                    {
                        this[_loc_4] = undefined;
                    }
                }
            }
            return;
        }// end function

        override public function removeClashing(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.removeClashing(param1);
            var _loc_2:* = param1 as IListMarkerFormat;
            if (_loc_2)
            {
                for each (_loc_3 in _lmfDescription)
                {
                    
                    _loc_4 = _loc_3.name;
                    if (!_loc_3.equalHelper(this[_loc_4], _loc_2[_loc_4]))
                    {
                        this[_loc_4] = undefined;
                    }
                }
            }
            return;
        }// end function

        static function createCounterResetProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([FormatValue.NONE]), new CounterPropHandler(0));
            return _loc_5;
        }// end function

        static function createCounterIncrementProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([FormatValue.NONE]), new CounterPropHandler(1));
            return _loc_5;
        }// end function

        static function createCounterContentProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property
        {
            var _loc_5:* = new Property(param1, param2, param3, param4);
            new Property(param1, param2, param3, param4).addHandlers(Property.sharedUndefinedHandler, new EnumPropertyHandler([FormatValue.NONE]), new CounterContentHandler());
            return _loc_5;
        }// end function

        static function get description() : Object
        {
            var _loc_1:* = null;
            if (!_description)
            {
                _description = Property.createObjectWithPrototype(TextLayoutFormat.description);
                for (_loc_1 in _lmfDescription)
                {
                    
                    _description[_loc_1] = _lmfDescription[_loc_1];
                }
            }
            return _description;
        }// end function

        public static function createListMarkerFormat(param1:Object) : ListMarkerFormat
        {
            var _loc_4:* = null;
            var _loc_2:* = param1 as IListMarkerFormat;
            var _loc_3:* = new ListMarkerFormat(_loc_2);
            if (_loc_2 == null && param1)
            {
                for (_loc_4 in param1)
                {
                    
                    _loc_3.setStyle(_loc_4, param1[_loc_4]);
                }
            }
            return _loc_3;
        }// end function

        Property.sharedTextLayoutFormatHandler.converter = TextLayoutFormat.createTextLayoutFormat;
        Property.sharedListMarkerFormatHandler.converter = ListMarkerFormat.createListMarkerFormat;
    }
}
