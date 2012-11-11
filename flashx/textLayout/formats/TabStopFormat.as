package flashx.textLayout.formats
{
    import flash.text.engine.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class TabStopFormat extends Object implements ITabStopFormat
    {
        private var _position:Object;
        private var _alignment:Object;
        private var _decimalAlignmentToken:Object;
        public static const positionProperty:Property = Property.NewNumberProperty("position", 0, false, TabStopFormat.Vector.<String>([Category.TABSTOP]), 0, 10000);
        public static const alignmentProperty:Property = Property.NewEnumStringProperty("alignment", TabAlignment.START, false, TabStopFormat.Vector.<String>([Category.TABSTOP]), TabAlignment.START, TabAlignment.CENTER, TabAlignment.END, TabAlignment.DECIMAL);
        public static const decimalAlignmentTokenProperty:Property = Property.NewStringProperty("decimalAlignmentToken", null, false, TabStopFormat.Vector.<String>([Category.TABSTOP]));
        private static var _description:Object = {position:positionProperty, alignment:alignmentProperty, decimalAlignmentToken:decimalAlignmentTokenProperty};
        private static var _emptyTabStopFormat:ITabStopFormat;
        private static var _defaults:TabStopFormat;

        public function TabStopFormat(param1:ITabStopFormat = null)
        {
            if (param1)
            {
                this.apply(param1);
            }
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return this[param1];
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            this[param1] = param2;
            return;
        }// end function

        public function get position()
        {
            return this._position;
        }// end function

        public function set position(param1) : void
        {
            this._position = positionProperty.setHelper(this._position, param1);
            return;
        }// end function

        public function get alignment()
        {
            return this._alignment;
        }// end function

        public function set alignment(param1) : void
        {
            this._alignment = alignmentProperty.setHelper(this._alignment, param1);
            return;
        }// end function

        public function get decimalAlignmentToken()
        {
            return this._decimalAlignmentToken;
        }// end function

        public function set decimalAlignmentToken(param1) : void
        {
            this._decimalAlignmentToken = decimalAlignmentTokenProperty.setHelper(this._decimalAlignmentToken, param1);
            return;
        }// end function

        public function copy(param1:ITabStopFormat) : void
        {
            if (param1 == null)
            {
                param1 = emptyTabStopFormat;
            }
            this.position = param1.position;
            this.alignment = param1.alignment;
            this.decimalAlignmentToken = param1.decimalAlignmentToken;
            return;
        }// end function

        public function concat(param1:ITabStopFormat) : void
        {
            this.position = positionProperty.concatHelper(this.position, param1.position);
            this.alignment = alignmentProperty.concatHelper(this.alignment, param1.alignment);
            this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatHelper(this.decimalAlignmentToken, param1.decimalAlignmentToken);
            return;
        }// end function

        public function concatInheritOnly(param1:ITabStopFormat) : void
        {
            this.position = positionProperty.concatInheritOnlyHelper(this.position, param1.position);
            this.alignment = alignmentProperty.concatInheritOnlyHelper(this.alignment, param1.alignment);
            this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatInheritOnlyHelper(this.decimalAlignmentToken, param1.decimalAlignmentToken);
            return;
        }// end function

        public function apply(param1:ITabStopFormat) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = param1.position;
            _loc_2 = param1.position;
            if (_loc_3 !== undefined)
            {
                this.position = _loc_2;
            }
            var _loc_3:* = param1.alignment;
            _loc_2 = param1.alignment;
            if (_loc_3 !== undefined)
            {
                this.alignment = _loc_2;
            }
            var _loc_3:* = param1.decimalAlignmentToken;
            _loc_2 = param1.decimalAlignmentToken;
            if (_loc_3 !== undefined)
            {
                this.decimalAlignmentToken = _loc_2;
            }
            return;
        }// end function

        public function removeMatching(param1:ITabStopFormat) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (positionProperty.equalHelper(this.position, param1.position))
            {
                this.position = undefined;
            }
            if (alignmentProperty.equalHelper(this.alignment, param1.alignment))
            {
                this.alignment = undefined;
            }
            if (decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken, param1.decimalAlignmentToken))
            {
                this.decimalAlignmentToken = undefined;
            }
            return;
        }// end function

        public function removeClashing(param1:ITabStopFormat) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (!positionProperty.equalHelper(this.position, param1.position))
            {
                this.position = undefined;
            }
            if (!alignmentProperty.equalHelper(this.alignment, param1.alignment))
            {
                this.alignment = undefined;
            }
            if (!decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken, param1.decimalAlignmentToken))
            {
                this.decimalAlignmentToken = undefined;
            }
            return;
        }// end function

        static function get description() : Object
        {
            return _description;
        }// end function

        static function get emptyTabStopFormat() : ITabStopFormat
        {
            if (_emptyTabStopFormat == null)
            {
                _emptyTabStopFormat = new TabStopFormat;
            }
            return _emptyTabStopFormat;
        }// end function

        public static function isEqual(param1:ITabStopFormat, param2:ITabStopFormat) : Boolean
        {
            if (param1 == null)
            {
                param1 = emptyTabStopFormat;
            }
            if (param2 == null)
            {
                param2 = emptyTabStopFormat;
            }
            if (param1 == param2)
            {
                return true;
            }
            if (!positionProperty.equalHelper(param1.position, param2.position))
            {
                return false;
            }
            if (!alignmentProperty.equalHelper(param1.alignment, param2.alignment))
            {
                return false;
            }
            if (!decimalAlignmentTokenProperty.equalHelper(param1.decimalAlignmentToken, param2.decimalAlignmentToken))
            {
                return false;
            }
            return true;
        }// end function

        public static function get defaultFormat() : ITabStopFormat
        {
            if (_defaults == null)
            {
                _defaults = new TabStopFormat;
                Property.defaultsAllHelper(_description, _defaults);
            }
            return _defaults;
        }// end function

    }
}
