package flashx.textLayout.utils
{
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.formats.*;

    final public class LocaleUtil extends Object
    {
        private static var _localeSettings:Dictionary = null;
        private static var _lastLocaleKey:String = "";
        private static var _lastLocale:LocaleSettings = null;

        public function LocaleUtil()
        {
            return;
        }// end function

        public static function justificationRule(param1:String) : String
        {
            var _loc_2:* = fetchLocaleSet(param1);
            return _loc_2.justificationRule;
        }// end function

        public static function justificationStyle(param1:String) : String
        {
            var _loc_2:* = fetchLocaleSet(param1);
            return _loc_2.justificationStyle;
        }// end function

        public static function leadingModel(param1:String) : String
        {
            var _loc_2:* = fetchLocaleSet(param1);
            return _loc_2.leadingModel;
        }// end function

        public static function dominantBaseline(param1:String) : String
        {
            var _loc_2:* = fetchLocaleSet(param1);
            return _loc_2.dominantBaseline;
        }// end function

        private static function addLocale(param1:String) : LocaleSettings
        {
            _localeSettings[param1] = new LocaleSettings();
            return _localeSettings[param1];
        }// end function

        private static function initializeDefaultLocales() : void
        {
            _localeSettings = new Dictionary();
            var _loc_1:* = addLocale("en");
            _loc_1.justificationRule = JustificationRule.SPACE;
            _loc_1.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
            _loc_1.leadingModel = LeadingModel.ROMAN_UP;
            _loc_1.dominantBaseline = TextBaseline.ROMAN;
            _loc_1 = addLocale("ja");
            _loc_1.justificationRule = JustificationRule.EAST_ASIAN;
            _loc_1.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
            _loc_1.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
            _loc_1.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
            _loc_1 = addLocale("zh");
            _loc_1.justificationRule = JustificationRule.EAST_ASIAN;
            _loc_1.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
            _loc_1.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
            _loc_1.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
            return;
        }// end function

        private static function getLocale(param1:String) : LocaleSettings
        {
            var _loc_2:* = param1.toLowerCase().substr(0, 2);
            var _loc_3:* = _localeSettings[_loc_2];
            return _loc_3 == null ? (_localeSettings["en"]) : (_loc_3);
        }// end function

        private static function fetchLocaleSet(param1:String) : LocaleSettings
        {
            if (_localeSettings == null)
            {
                initializeDefaultLocales();
            }
            if (param1 == _lastLocaleKey)
            {
                return _lastLocale;
            }
            var _loc_2:* = getLocale(param1);
            _lastLocale = _loc_2;
            _lastLocaleKey = param1;
            return _loc_2;
        }// end function

    }
}

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.formats.*;

class LocaleSettings extends Object
{
    private var _justificationRule:String = null;
    private var _justificationStyle:String = null;
    private var _leadingModel:String = null;
    private var _dominantBaseline:String = null;

    function LocaleSettings()
    {
        return;
    }// end function

    public function get justificationRule() : String
    {
        return this._justificationRule;
    }// end function

    public function set justificationRule(param1:String) : void
    {
        var _loc_2:* = TextLayoutFormat.justificationRuleProperty.setHelper(this._justificationRule, param1);
        this._justificationRule = _loc_2 == null ? (null) : (_loc_2 as String);
        return;
    }// end function

    public function get justificationStyle() : String
    {
        return this._justificationStyle;
    }// end function

    public function set justificationStyle(param1:String) : void
    {
        var _loc_2:* = TextLayoutFormat.justificationStyleProperty.setHelper(this._justificationStyle, param1);
        this._justificationStyle = _loc_2 == null ? (null) : (_loc_2 as String);
        return;
    }// end function

    public function get leadingModel() : String
    {
        return this._leadingModel;
    }// end function

    public function set leadingModel(param1:String) : void
    {
        var _loc_2:* = TextLayoutFormat.leadingModelProperty.setHelper(this._leadingModel, param1);
        this._leadingModel = _loc_2 == null ? (null) : (_loc_2 as String);
        return;
    }// end function

    public function get dominantBaseline() : String
    {
        return this._dominantBaseline;
    }// end function

    public function set dominantBaseline(param1:String) : void
    {
        var _loc_2:* = TextLayoutFormat.dominantBaselineProperty.setHelper(this._dominantBaseline, param1);
        this._dominantBaseline = _loc_2 == null ? (null) : (_loc_2 as String);
        return;
    }// end function

}

