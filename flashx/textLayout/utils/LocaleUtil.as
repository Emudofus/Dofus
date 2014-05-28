package flashx.textLayout.utils
{
   import flash.utils.Dictionary;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.JustificationRule;
   import flash.text.engine.JustificationStyle;
   import flashx.textLayout.formats.LeadingModel;
   import flash.text.engine.TextBaseline;
   
   use namespace tlf_internal;
   
   public final class LocaleUtil extends Object
   {
      
      public function LocaleUtil() {
         super();
      }
      
      private static var _localeSettings:Dictionary = null;
      
      private static var _lastLocaleKey:String = "";
      
      private static var _lastLocale:LocaleSettings = null;
      
      public static function justificationRule(param1:String) : String {
         var _loc2_:LocaleSettings = fetchLocaleSet(param1);
         return _loc2_.justificationRule;
      }
      
      public static function justificationStyle(param1:String) : String {
         var _loc2_:LocaleSettings = fetchLocaleSet(param1);
         return _loc2_.justificationStyle;
      }
      
      public static function leadingModel(param1:String) : String {
         var _loc2_:LocaleSettings = fetchLocaleSet(param1);
         return _loc2_.leadingModel;
      }
      
      public static function dominantBaseline(param1:String) : String {
         var _loc2_:LocaleSettings = fetchLocaleSet(param1);
         return _loc2_.dominantBaseline;
      }
      
      private static function addLocale(param1:String) : LocaleSettings {
         _localeSettings[param1] = new LocaleSettings();
         return _localeSettings[param1];
      }
      
      private static function initializeDefaultLocales() : void {
         _localeSettings = new Dictionary();
         var _loc1_:LocaleSettings = addLocale("en");
         _loc1_.justificationRule = JustificationRule.SPACE;
         _loc1_.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         _loc1_.leadingModel = LeadingModel.ROMAN_UP;
         _loc1_.dominantBaseline = TextBaseline.ROMAN;
         _loc1_ = addLocale("ja");
         _loc1_.justificationRule = JustificationRule.EAST_ASIAN;
         _loc1_.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         _loc1_.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
         _loc1_.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
         _loc1_ = addLocale("zh");
         _loc1_.justificationRule = JustificationRule.EAST_ASIAN;
         _loc1_.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         _loc1_.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
         _loc1_.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
      }
      
      private static function getLocale(param1:String) : LocaleSettings {
         var _loc2_:String = param1.toLowerCase().substr(0,2);
         var _loc3_:LocaleSettings = _localeSettings[_loc2_];
         return _loc3_ == null?_localeSettings["en"]:_loc3_;
      }
      
      private static function fetchLocaleSet(param1:String) : LocaleSettings {
         if(_localeSettings == null)
         {
            initializeDefaultLocales();
         }
         if(param1 == _lastLocaleKey)
         {
            return _lastLocale;
         }
         var _loc2_:LocaleSettings = getLocale(param1);
         _lastLocale = _loc2_;
         _lastLocaleKey = param1;
         return _loc2_;
      }
   }
}
import flashx.textLayout.formats.TextLayoutFormat;

class LocaleSettings extends Object
{
   
   function LocaleSettings() {
      super();
   }
   
   private var _justificationRule:String = null;
   
   private var _justificationStyle:String = null;
   
   private var _leadingModel:String = null;
   
   private var _dominantBaseline:String = null;
   
   public function get justificationRule() : String {
      return this._justificationRule;
   }
   
   public function set justificationRule(param1:String) : void {
      var _loc2_:Object = TextLayoutFormat.justificationRuleProperty.setHelper(this._justificationRule,param1);
      this._justificationRule = _loc2_ == null?null:_loc2_ as String;
   }
   
   public function get justificationStyle() : String {
      return this._justificationStyle;
   }
   
   public function set justificationStyle(param1:String) : void {
      var _loc2_:Object = TextLayoutFormat.justificationStyleProperty.setHelper(this._justificationStyle,param1);
      this._justificationStyle = _loc2_ == null?null:_loc2_ as String;
   }
   
   public function get leadingModel() : String {
      return this._leadingModel;
   }
   
   public function set leadingModel(param1:String) : void {
      var _loc2_:Object = TextLayoutFormat.leadingModelProperty.setHelper(this._leadingModel,param1);
      this._leadingModel = _loc2_ == null?null:_loc2_ as String;
   }
   
   public function get dominantBaseline() : String {
      return this._dominantBaseline;
   }
   
   public function set dominantBaseline(param1:String) : void {
      var _loc2_:Object = TextLayoutFormat.dominantBaselineProperty.setHelper(this._dominantBaseline,param1);
      this._dominantBaseline = _loc2_ == null?null:_loc2_ as String;
   }
}
