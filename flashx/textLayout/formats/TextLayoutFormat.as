package flashx.textLayout.formats
{
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.BreakOpportunity;
   import flash.text.engine.DigitCase;
   import flash.text.engine.DigitWidth;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.Kerning;
   import flash.text.engine.LigatureLevel;
   import flash.text.engine.FontWeight;
   import flash.text.engine.FontPosture;
   import flash.text.engine.RenderingMode;
   import flash.text.engine.CFFHinting;
   import flash.text.engine.FontLookup;
   import flash.text.engine.TextRotation;
   import flash.text.engine.JustificationStyle;
   
   use namespace tlf_internal;
   
   public class TextLayoutFormat extends Object implements ITextLayoutFormat
   {
      
      public function TextLayoutFormat(param1:ITextLayoutFormat=null) {
         super();
         this.copy(param1);
      }
      
      public static const colorProperty:Property = Property.NewUintProperty("color",0,true,Vector.<String>([Category.CHARACTER]));
      
      public static const backgroundColorProperty:Property = Property.NewUintOrEnumProperty("backgroundColor",BackgroundColor.TRANSPARENT,false,Vector.<String>([Category.CHARACTER]),BackgroundColor.TRANSPARENT);
      
      public static const lineThroughProperty:Property = Property.NewBooleanProperty("lineThrough",false,true,Vector.<String>([Category.CHARACTER]));
      
      public static const textAlphaProperty:Property = Property.NewNumberProperty("textAlpha",1,true,Vector.<String>([Category.CHARACTER]),0,1);
      
      public static const backgroundAlphaProperty:Property = Property.NewNumberProperty("backgroundAlpha",1,false,Vector.<String>([Category.CHARACTER]),0,1);
      
      public static const fontSizeProperty:Property = Property.NewNumberProperty("fontSize",12,true,Vector.<String>([Category.CHARACTER]),1,720);
      
      public static const baselineShiftProperty:Property = Property.NewNumberOrPercentOrEnumProperty("baselineShift",0.0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%",BaselineShift.SUPERSCRIPT,BaselineShift.SUBSCRIPT);
      
      public static const trackingLeftProperty:Property = Property.NewNumberOrPercentProperty("trackingLeft",0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%");
      
      public static const trackingRightProperty:Property = Property.NewNumberOrPercentProperty("trackingRight",0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%");
      
      public static const lineHeightProperty:Property = Property.NewNumberOrPercentProperty("lineHeight","120%",true,Vector.<String>([Category.CHARACTER]),-720,720,"-1000%","1000%");
      
      public static const breakOpportunityProperty:Property = Property.NewEnumStringProperty("breakOpportunity",BreakOpportunity.AUTO,true,Vector.<String>([Category.CHARACTER]),BreakOpportunity.ALL,BreakOpportunity.ANY,BreakOpportunity.AUTO,BreakOpportunity.NONE);
      
      public static const digitCaseProperty:Property = Property.NewEnumStringProperty("digitCase",DigitCase.DEFAULT,true,Vector.<String>([Category.CHARACTER]),DigitCase.DEFAULT,DigitCase.LINING,DigitCase.OLD_STYLE);
      
      public static const digitWidthProperty:Property = Property.NewEnumStringProperty("digitWidth",DigitWidth.DEFAULT,true,Vector.<String>([Category.CHARACTER]),DigitWidth.DEFAULT,DigitWidth.PROPORTIONAL,DigitWidth.TABULAR);
      
      public static const dominantBaselineProperty:Property = Property.NewEnumStringProperty("dominantBaseline",FormatValue.AUTO,true,Vector.<String>([Category.CHARACTER]),FormatValue.AUTO,TextBaseline.ROMAN,TextBaseline.ASCENT,TextBaseline.DESCENT,TextBaseline.IDEOGRAPHIC_TOP,TextBaseline.IDEOGRAPHIC_CENTER,TextBaseline.IDEOGRAPHIC_BOTTOM);
      
      public static const kerningProperty:Property = Property.NewEnumStringProperty("kerning",Kerning.AUTO,true,Vector.<String>([Category.CHARACTER]),Kerning.ON,Kerning.OFF,Kerning.AUTO);
      
      public static const ligatureLevelProperty:Property = Property.NewEnumStringProperty("ligatureLevel",LigatureLevel.COMMON,true,Vector.<String>([Category.CHARACTER]),LigatureLevel.MINIMUM,LigatureLevel.COMMON,LigatureLevel.UNCOMMON,LigatureLevel.EXOTIC);
      
      public static const alignmentBaselineProperty:Property = Property.NewEnumStringProperty("alignmentBaseline",TextBaseline.USE_DOMINANT_BASELINE,true,Vector.<String>([Category.CHARACTER]),TextBaseline.ROMAN,TextBaseline.ASCENT,TextBaseline.DESCENT,TextBaseline.IDEOGRAPHIC_TOP,TextBaseline.IDEOGRAPHIC_CENTER,TextBaseline.IDEOGRAPHIC_BOTTOM,TextBaseline.USE_DOMINANT_BASELINE);
      
      public static const localeProperty:Property = Property.NewStringProperty("locale","en",true,Vector.<String>([Category.CHARACTER,Category.PARAGRAPH]));
      
      public static const typographicCaseProperty:Property = Property.NewEnumStringProperty("typographicCase",TLFTypographicCase.DEFAULT,true,Vector.<String>([Category.CHARACTER]),TLFTypographicCase.DEFAULT,TLFTypographicCase.CAPS_TO_SMALL_CAPS,TLFTypographicCase.UPPERCASE,TLFTypographicCase.LOWERCASE,TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS);
      
      public static const fontFamilyProperty:Property = Property.NewStringProperty("fontFamily","Arial",true,Vector.<String>([Category.CHARACTER]));
      
      public static const textDecorationProperty:Property = Property.NewEnumStringProperty("textDecoration",TextDecoration.NONE,true,Vector.<String>([Category.CHARACTER]),TextDecoration.NONE,TextDecoration.UNDERLINE);
      
      public static const fontWeightProperty:Property = Property.NewEnumStringProperty("fontWeight",FontWeight.NORMAL,true,Vector.<String>([Category.CHARACTER]),FontWeight.NORMAL,FontWeight.BOLD);
      
      public static const fontStyleProperty:Property = Property.NewEnumStringProperty("fontStyle",FontPosture.NORMAL,true,Vector.<String>([Category.CHARACTER]),FontPosture.NORMAL,FontPosture.ITALIC);
      
      public static const whiteSpaceCollapseProperty:Property = Property.NewEnumStringProperty("whiteSpaceCollapse",WhiteSpaceCollapse.COLLAPSE,true,Vector.<String>([Category.CHARACTER]),WhiteSpaceCollapse.PRESERVE,WhiteSpaceCollapse.COLLAPSE);
      
      public static const renderingModeProperty:Property = Property.NewEnumStringProperty("renderingMode",RenderingMode.CFF,true,Vector.<String>([Category.CHARACTER]),RenderingMode.NORMAL,RenderingMode.CFF);
      
      public static const cffHintingProperty:Property = Property.NewEnumStringProperty("cffHinting",CFFHinting.HORIZONTAL_STEM,true,Vector.<String>([Category.CHARACTER]),CFFHinting.NONE,CFFHinting.HORIZONTAL_STEM);
      
      public static const fontLookupProperty:Property = Property.NewEnumStringProperty("fontLookup",FontLookup.DEVICE,true,Vector.<String>([Category.CHARACTER]),FontLookup.DEVICE,FontLookup.EMBEDDED_CFF);
      
      public static const textRotationProperty:Property = Property.NewEnumStringProperty("textRotation",TextRotation.AUTO,true,Vector.<String>([Category.CHARACTER]),TextRotation.ROTATE_0,TextRotation.ROTATE_180,TextRotation.ROTATE_270,TextRotation.ROTATE_90,TextRotation.AUTO);
      
      public static const textIndentProperty:Property = Property.NewNumberProperty("textIndent",0,true,Vector.<String>([Category.PARAGRAPH]),-8000,8000);
      
      public static const paragraphStartIndentProperty:Property = Property.NewNumberProperty("paragraphStartIndent",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
      
      public static const paragraphEndIndentProperty:Property = Property.NewNumberProperty("paragraphEndIndent",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
      
      public static const paragraphSpaceBeforeProperty:Property = Property.NewNumberProperty("paragraphSpaceBefore",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
      
      public static const paragraphSpaceAfterProperty:Property = Property.NewNumberProperty("paragraphSpaceAfter",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
      
      public static const textAlignProperty:Property = Property.NewEnumStringProperty("textAlign",TextAlign.START,true,Vector.<String>([Category.PARAGRAPH]),TextAlign.LEFT,TextAlign.RIGHT,TextAlign.CENTER,TextAlign.JUSTIFY,TextAlign.START,TextAlign.END);
      
      public static const textAlignLastProperty:Property = Property.NewEnumStringProperty("textAlignLast",TextAlign.START,true,Vector.<String>([Category.PARAGRAPH]),TextAlign.LEFT,TextAlign.RIGHT,TextAlign.CENTER,TextAlign.JUSTIFY,TextAlign.START,TextAlign.END);
      
      public static const textJustifyProperty:Property = Property.NewEnumStringProperty("textJustify",TextJustify.INTER_WORD,true,Vector.<String>([Category.PARAGRAPH]),TextJustify.INTER_WORD,TextJustify.DISTRIBUTE);
      
      public static const justificationRuleProperty:Property = Property.NewEnumStringProperty("justificationRule",FormatValue.AUTO,true,Vector.<String>([Category.PARAGRAPH]),JustificationRule.EAST_ASIAN,JustificationRule.SPACE,FormatValue.AUTO);
      
      public static const justificationStyleProperty:Property = Property.NewEnumStringProperty("justificationStyle",FormatValue.AUTO,true,Vector.<String>([Category.PARAGRAPH]),JustificationStyle.PRIORITIZE_LEAST_ADJUSTMENT,JustificationStyle.PUSH_IN_KINSOKU,JustificationStyle.PUSH_OUT_ONLY,FormatValue.AUTO);
      
      public static const directionProperty:Property = Property.NewEnumStringProperty("direction",Direction.LTR,true,Vector.<String>([Category.PARAGRAPH]),Direction.LTR,Direction.RTL);
      
      public static const wordSpacingProperty:Property = Property.NewSpacingLimitProperty("wordSpacing","100%, 50%, 150%",true,Vector.<String>([Category.PARAGRAPH]),"-1000%","1000%");
      
      public static const tabStopsProperty:Property = Property.NewTabStopsProperty("tabStops",null,true,Vector.<String>([Category.PARAGRAPH]));
      
      public static const leadingModelProperty:Property = Property.NewEnumStringProperty("leadingModel",LeadingModel.AUTO,true,Vector.<String>([Category.PARAGRAPH]),LeadingModel.ROMAN_UP,LeadingModel.IDEOGRAPHIC_TOP_UP,LeadingModel.IDEOGRAPHIC_CENTER_UP,LeadingModel.IDEOGRAPHIC_TOP_DOWN,LeadingModel.IDEOGRAPHIC_CENTER_DOWN,LeadingModel.APPROXIMATE_TEXT_FIELD,LeadingModel.ASCENT_DESCENT_UP,LeadingModel.BOX,LeadingModel.AUTO);
      
      public static const columnGapProperty:Property = Property.NewNumberProperty("columnGap",20,false,Vector.<String>([Category.CONTAINER]),0,1000);
      
      public static const paddingLeftProperty:Property = Property.NewNumberOrEnumProperty("paddingLeft",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
      
      public static const paddingTopProperty:Property = Property.NewNumberOrEnumProperty("paddingTop",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
      
      public static const paddingRightProperty:Property = Property.NewNumberOrEnumProperty("paddingRight",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
      
      public static const paddingBottomProperty:Property = Property.NewNumberOrEnumProperty("paddingBottom",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
      
      public static const columnCountProperty:Property = Property.NewIntOrEnumProperty("columnCount",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER]),1,50,FormatValue.AUTO);
      
      public static const columnWidthProperty:Property = Property.NewNumberOrEnumProperty("columnWidth",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER]),0,8000,FormatValue.AUTO);
      
      public static const firstBaselineOffsetProperty:Property = Property.NewNumberOrEnumProperty("firstBaselineOffset",BaselineOffset.AUTO,true,Vector.<String>([Category.CONTAINER]),0,1000,BaselineOffset.AUTO,BaselineOffset.ASCENT,BaselineOffset.LINE_HEIGHT);
      
      public static const verticalAlignProperty:Property = Property.NewEnumStringProperty("verticalAlign",VerticalAlign.TOP,false,Vector.<String>([Category.CONTAINER]),VerticalAlign.TOP,VerticalAlign.MIDDLE,VerticalAlign.BOTTOM,VerticalAlign.JUSTIFY);
      
      public static const blockProgressionProperty:Property = Property.NewEnumStringProperty("blockProgression",BlockProgression.TB,true,Vector.<String>([Category.CONTAINER]),BlockProgression.RL,BlockProgression.TB);
      
      public static const lineBreakProperty:Property = Property.NewEnumStringProperty("lineBreak",LineBreak.TO_FIT,false,Vector.<String>([Category.CONTAINER]),LineBreak.EXPLICIT,LineBreak.TO_FIT);
      
      public static const listStyleTypeProperty:Property = Property.NewEnumStringProperty("listStyleType",ListStyleType.DISC,true,Vector.<String>([Category.LIST]),ListStyleType.UPPER_ALPHA,ListStyleType.LOWER_ALPHA,ListStyleType.UPPER_ROMAN,ListStyleType.LOWER_ROMAN,ListStyleType.NONE,ListStyleType.DISC,ListStyleType.CIRCLE,ListStyleType.SQUARE,ListStyleType.BOX,ListStyleType.CHECK,ListStyleType.DIAMOND,ListStyleType.HYPHEN,ListStyleType.ARABIC_INDIC,ListStyleType.BENGALI,ListStyleType.DECIMAL,ListStyleType.DECIMAL_LEADING_ZERO,ListStyleType.DEVANAGARI,ListStyleType.GUJARATI,ListStyleType.GURMUKHI,ListStyleType.KANNADA,ListStyleType.PERSIAN,ListStyleType.THAI,ListStyleType.URDU,ListStyleType.CJK_EARTHLY_BRANCH,ListStyleType.CJK_HEAVENLY_STEM,ListStyleType.HANGUL,ListStyleType.HANGUL_CONSTANT,ListStyleType.HIRAGANA,ListStyleType.HIRAGANA_IROHA,ListStyleType.KATAKANA,ListStyleType.KATAKANA_IROHA,ListStyleType.LOWER_ALPHA,ListStyleType.LOWER_GREEK,ListStyleType.LOWER_LATIN,ListStyleType.UPPER_ALPHA,ListStyleType.UPPER_GREEK,ListStyleType.UPPER_LATIN);
      
      public static const listStylePositionProperty:Property = Property.NewEnumStringProperty("listStylePosition",ListStylePosition.OUTSIDE,true,Vector.<String>([Category.LIST]),ListStylePosition.INSIDE,ListStylePosition.OUTSIDE);
      
      public static const listAutoPaddingProperty:Property = Property.NewNumberProperty("listAutoPadding",40,true,Vector.<String>([Category.CONTAINER]),-1000,1000);
      
      public static const clearFloatsProperty:Property = Property.NewEnumStringProperty("clearFloats",ClearFloats.NONE,false,Vector.<String>([Category.PARAGRAPH]),ClearFloats.START,ClearFloats.END,ClearFloats.LEFT,ClearFloats.RIGHT,ClearFloats.BOTH,ClearFloats.NONE);
      
      public static const styleNameProperty:Property = Property.NewStringProperty("styleName",null,false,Vector.<String>([Category.STYLE]));
      
      public static const linkNormalFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkNormalFormat",null,true,Vector.<String>([Category.STYLE]));
      
      public static const linkActiveFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkActiveFormat",null,true,Vector.<String>([Category.STYLE]));
      
      public static const linkHoverFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkHoverFormat",null,true,Vector.<String>([Category.STYLE]));
      
      public static const listMarkerFormatProperty:Property = Property.NewListMarkerFormatProperty("listMarkerFormat",null,true,Vector.<String>([Category.STYLE]));
      
      private static var _description:Object = 
         {
            "color":colorProperty,
            "backgroundColor":backgroundColorProperty,
            "lineThrough":lineThroughProperty,
            "textAlpha":textAlphaProperty,
            "backgroundAlpha":backgroundAlphaProperty,
            "fontSize":fontSizeProperty,
            "baselineShift":baselineShiftProperty,
            "trackingLeft":trackingLeftProperty,
            "trackingRight":trackingRightProperty,
            "lineHeight":lineHeightProperty,
            "breakOpportunity":breakOpportunityProperty,
            "digitCase":digitCaseProperty,
            "digitWidth":digitWidthProperty,
            "dominantBaseline":dominantBaselineProperty,
            "kerning":kerningProperty,
            "ligatureLevel":ligatureLevelProperty,
            "alignmentBaseline":alignmentBaselineProperty,
            "locale":localeProperty,
            "typographicCase":typographicCaseProperty,
            "fontFamily":fontFamilyProperty,
            "textDecoration":textDecorationProperty,
            "fontWeight":fontWeightProperty,
            "fontStyle":fontStyleProperty,
            "whiteSpaceCollapse":whiteSpaceCollapseProperty,
            "renderingMode":renderingModeProperty,
            "cffHinting":cffHintingProperty,
            "fontLookup":fontLookupProperty,
            "textRotation":textRotationProperty,
            "textIndent":textIndentProperty,
            "paragraphStartIndent":paragraphStartIndentProperty,
            "paragraphEndIndent":paragraphEndIndentProperty,
            "paragraphSpaceBefore":paragraphSpaceBeforeProperty,
            "paragraphSpaceAfter":paragraphSpaceAfterProperty,
            "textAlign":textAlignProperty,
            "textAlignLast":textAlignLastProperty,
            "textJustify":textJustifyProperty,
            "justificationRule":justificationRuleProperty,
            "justificationStyle":justificationStyleProperty,
            "direction":directionProperty,
            "wordSpacing":wordSpacingProperty,
            "tabStops":tabStopsProperty,
            "leadingModel":leadingModelProperty,
            "columnGap":columnGapProperty,
            "paddingLeft":paddingLeftProperty,
            "paddingTop":paddingTopProperty,
            "paddingRight":paddingRightProperty,
            "paddingBottom":paddingBottomProperty,
            "columnCount":columnCountProperty,
            "columnWidth":columnWidthProperty,
            "firstBaselineOffset":firstBaselineOffsetProperty,
            "verticalAlign":verticalAlignProperty,
            "blockProgression":blockProgressionProperty,
            "lineBreak":lineBreakProperty,
            "listStyleType":listStyleTypeProperty,
            "listStylePosition":listStylePositionProperty,
            "listAutoPadding":listAutoPaddingProperty,
            "clearFloats":clearFloatsProperty,
            "styleName":styleNameProperty,
            "linkNormalFormat":linkNormalFormatProperty,
            "linkActiveFormat":linkActiveFormatProperty,
            "linkHoverFormat":linkHoverFormatProperty,
            "listMarkerFormat":listMarkerFormatProperty
         };
      
      tlf_internal  static function get description() : Object {
         return _description;
      }
      
      private static var _emptyTextLayoutFormat:ITextLayoutFormat;
      
      tlf_internal  static function get emptyTextLayoutFormat() : ITextLayoutFormat {
         if(_emptyTextLayoutFormat == null)
         {
            _emptyTextLayoutFormat = new TextLayoutFormat();
         }
         return _emptyTextLayoutFormat;
      }
      
      private static const _emptyStyles:Object = new Object();
      
      public static function isEqual(param1:ITextLayoutFormat, param2:ITextLayoutFormat) : Boolean {
         var _loc5_:Property = null;
         if(param1 == null)
         {
            param1 = emptyTextLayoutFormat;
         }
         if(param2 == null)
         {
            param2 = emptyTextLayoutFormat;
         }
         if(param1 == param2)
         {
            return true;
         }
         var _loc3_:TextLayoutFormat = param1 as TextLayoutFormat;
         var _loc4_:TextLayoutFormat = param2 as TextLayoutFormat;
         if((_loc3_) && (_loc4_))
         {
            return Property.equalStyles(_loc3_.getStyles(),_loc4_.getStyles(),TextLayoutFormat.description);
         }
         for each (_loc5_ in TextLayoutFormat.description)
         {
            if(!_loc5_.equalHelper(param1[_loc5_.name],param2[_loc5_.name]))
            {
               return false;
            }
         }
         return true;
      }
      
      private static var _defaults:TextLayoutFormat;
      
      public static function get defaultFormat() : ITextLayoutFormat {
         if(_defaults == null)
         {
            _defaults = new TextLayoutFormat();
            Property.defaultsAllHelper(_description,_defaults);
         }
         return _defaults;
      }
      
      tlf_internal  static function resetModifiedNoninheritedStyles(param1:Object) : void {
         if(param1.backgroundColor != TextLayoutFormat.backgroundColorProperty.defaultValue)
         {
            param1.backgroundColor = TextLayoutFormat.backgroundColorProperty.defaultValue;
         }
         if(param1.backgroundAlpha != TextLayoutFormat.backgroundAlphaProperty.defaultValue)
         {
            param1.backgroundAlpha = TextLayoutFormat.backgroundAlphaProperty.defaultValue;
         }
         if(param1.columnGap != TextLayoutFormat.columnGapProperty.defaultValue)
         {
            param1.columnGap = TextLayoutFormat.columnGapProperty.defaultValue;
         }
         if(param1.paddingLeft != TextLayoutFormat.paddingLeftProperty.defaultValue)
         {
            param1.paddingLeft = TextLayoutFormat.paddingLeftProperty.defaultValue;
         }
         if(param1.paddingTop != TextLayoutFormat.paddingTopProperty.defaultValue)
         {
            param1.paddingTop = TextLayoutFormat.paddingTopProperty.defaultValue;
         }
         if(param1.paddingRight != TextLayoutFormat.paddingRightProperty.defaultValue)
         {
            param1.paddingRight = TextLayoutFormat.paddingRightProperty.defaultValue;
         }
         if(param1.paddingBottom != TextLayoutFormat.paddingBottomProperty.defaultValue)
         {
            param1.paddingBottom = TextLayoutFormat.paddingBottomProperty.defaultValue;
         }
         if(param1.columnCount != TextLayoutFormat.columnCountProperty.defaultValue)
         {
            param1.columnCount = TextLayoutFormat.columnCountProperty.defaultValue;
         }
         if(param1.columnWidth != TextLayoutFormat.columnWidthProperty.defaultValue)
         {
            param1.columnWidth = TextLayoutFormat.columnWidthProperty.defaultValue;
         }
         if(param1.verticalAlign != TextLayoutFormat.verticalAlignProperty.defaultValue)
         {
            param1.verticalAlign = TextLayoutFormat.verticalAlignProperty.defaultValue;
         }
         if(param1.lineBreak != TextLayoutFormat.lineBreakProperty.defaultValue)
         {
            param1.lineBreak = TextLayoutFormat.lineBreakProperty.defaultValue;
         }
         if(param1.clearFloats != TextLayoutFormat.clearFloatsProperty.defaultValue)
         {
            param1.clearFloats = TextLayoutFormat.clearFloatsProperty.defaultValue;
         }
         if(param1.styleName != TextLayoutFormat.styleNameProperty.defaultValue)
         {
            param1.styleName = TextLayoutFormat.styleNameProperty.defaultValue;
         }
      }
      
      public static function createTextLayoutFormat(param1:Object) : TextLayoutFormat {
         var _loc4_:String = null;
         var _loc2_:ITextLayoutFormat = param1 as ITextLayoutFormat;
         var _loc3_:TextLayoutFormat = new TextLayoutFormat(_loc2_);
         if(_loc2_ == null && (param1))
         {
            for (_loc4_ in param1)
            {
               _loc3_.setStyle(_loc4_,param1[_loc4_]);
            }
         }
         return _loc3_;
      }
      
      private var _styles:Object;
      
      private var _sharedStyles:Boolean;
      
      private function writableStyles() : void {
         if(this._sharedStyles)
         {
            this._styles = this._styles == _emptyStyles?new Object():Property.createObjectWithPrototype(this._styles);
            this._sharedStyles = false;
         }
      }
      
      tlf_internal function getStyles() : Object {
         return this._styles == _emptyStyles?null:this._styles;
      }
      
      tlf_internal function setStyles(param1:Object, param2:Boolean) : void {
         if(this._styles != param1)
         {
            this._styles = param1;
            this._sharedStyles = param2;
         }
      }
      
      tlf_internal function clearStyles() : void {
         this._styles = _emptyStyles;
         this._sharedStyles = true;
      }
      
      public function get coreStyles() : Object {
         return this._styles == _emptyStyles?null:Property.shallowCopyInFilter(this._styles,description);
      }
      
      public function get userStyles() : Object {
         return this._styles == _emptyStyles?null:Property.shallowCopyNotInFilter(this._styles,description);
      }
      
      public function get styles() : Object {
         return this._styles == _emptyStyles?null:Property.shallowCopy(this._styles);
      }
      
      tlf_internal function setStyleByName(param1:String, param2:*) : void {
         this.writableStyles();
         if(param2 !== undefined)
         {
            this._styles[param1] = param2;
         }
         else
         {
            delete this._styles[[param1]];
            if(this._styles[param1] !== undefined)
            {
               this._styles = Property.shallowCopy(this._styles);
               delete this._styles[[param1]];
            }
         }
      }
      
      private function setStyleByProperty(param1:Property, param2:*) : void {
         var _loc3_:String = param1.name;
         var param2:* = param1.setHelper(this._styles[_loc3_],param2);
         this.setStyleByName(_loc3_,param2);
      }
      
      public function setStyle(param1:String, param2:*) : void {
         if(description.hasOwnProperty(param1))
         {
            this[param1] = param2;
         }
         else
         {
            this.setStyleByName(param1,param2);
         }
      }
      
      public function getStyle(param1:String) : * {
         return this._styles[param1];
      }
      
      public function copy(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:* = undefined;
         if(this == param1)
         {
            return;
         }
         var _loc2_:TextLayoutFormat = param1 as TextLayoutFormat;
         if(_loc2_)
         {
            this._styles = _loc2_._styles;
            this._sharedStyles = true;
            _loc2_._sharedStyles = true;
            return;
         }
         this._styles = _emptyStyles;
         this._sharedStyles = true;
         if(param1)
         {
            for each (_loc3_ in TextLayoutFormat.description)
            {
               _loc4_ = param1[_loc3_.name];
               if(_loc4_ !== undefined)
               {
                  this[_loc3_.name] = _loc4_;
               }
            }
         }
      }
      
      public function concat(param1:ITextLayoutFormat) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function concatInheritOnly(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc2_:TextLayoutFormat = param1 as TextLayoutFormat;
         if(_loc2_)
         {
            _loc4_ = _loc2_._styles;
            for (_loc5_ in _loc4_)
            {
               _loc3_ = description[_loc5_];
               if(_loc3_)
               {
                  this.setStyleByProperty(_loc3_,_loc3_.concatInheritOnlyHelper(this._styles[_loc5_],_loc4_[_loc5_]));
               }
               else
               {
                  this.setStyleByName(_loc5_,Property.defaultConcatHelper(this._styles[_loc5_],_loc4_[_loc5_]));
               }
            }
            return;
         }
         for each (_loc3_ in TextLayoutFormat.description)
         {
            this.setStyleByProperty(_loc3_,_loc3_.concatInheritOnlyHelper(this._styles[_loc3_.name],param1[_loc3_.name]));
         }
      }
      
      public function apply(param1:ITextLayoutFormat) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function removeMatching(param1:ITextLayoutFormat) : void {
         var _loc2_:Property = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:TextLayoutFormat = param1 as TextLayoutFormat;
         if(_loc3_)
         {
            _loc4_ = _loc3_._styles;
            for (_loc5_ in _loc4_)
            {
               _loc2_ = description[_loc5_];
               if(_loc2_)
               {
                  if(_loc2_.equalHelper(this._styles[_loc5_],_loc4_[_loc5_]))
                  {
                     this[_loc5_] = undefined;
                  }
               }
               else
               {
                  if(this._styles[_loc5_] == _loc4_[_loc5_])
                  {
                     this.setStyle(_loc5_,undefined);
                  }
               }
            }
            return;
         }
         for each (_loc2_ in TextLayoutFormat.description)
         {
            if(_loc2_.equalHelper(this._styles[_loc2_.name],param1[_loc2_.name]))
            {
               this[_loc2_.name] = undefined;
            }
         }
      }
      
      public function removeClashing(param1:ITextLayoutFormat) : void {
         var _loc2_:Property = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:TextLayoutFormat = param1 as TextLayoutFormat;
         if(_loc3_)
         {
            _loc4_ = _loc3_._styles;
            for (_loc5_ in _loc4_)
            {
               _loc2_ = description[_loc5_];
               if(_loc2_)
               {
                  if(!_loc2_.equalHelper(this._styles[_loc5_],_loc4_[_loc5_]))
                  {
                     this[_loc5_] = undefined;
                  }
               }
               else
               {
                  if(this._styles[_loc5_] != _loc4_[_loc5_])
                  {
                     this.setStyle(_loc5_,undefined);
                  }
               }
            }
            return;
         }
         for each (_loc2_ in TextLayoutFormat.description)
         {
            if(!_loc2_.equalHelper(this._styles[_loc2_.name],param1[_loc2_.name]))
            {
               this[_loc2_.name] = undefined;
            }
         }
      }
      
      public function get color() : * {
         return this._styles.color;
      }
      
      public function set color(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.colorProperty,param1);
      }
      
      public function get backgroundColor() : * {
         return this._styles.backgroundColor;
      }
      
      public function set backgroundColor(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.backgroundColorProperty,param1);
      }
      
      public function get lineThrough() : * {
         return this._styles.lineThrough;
      }
      
      public function set lineThrough(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineThroughProperty,param1);
      }
      
      public function get textAlpha() : * {
         return this._styles.textAlpha;
      }
      
      public function set textAlpha(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlphaProperty,param1);
      }
      
      public function get backgroundAlpha() : * {
         return this._styles.backgroundAlpha;
      }
      
      public function set backgroundAlpha(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.backgroundAlphaProperty,param1);
      }
      
      public function get fontSize() : * {
         return this._styles.fontSize;
      }
      
      public function set fontSize(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontSizeProperty,param1);
      }
      
      public function get baselineShift() : * {
         return this._styles.baselineShift;
      }
      
      public function set baselineShift(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.baselineShiftProperty,param1);
      }
      
      public function get trackingLeft() : * {
         return this._styles.trackingLeft;
      }
      
      public function set trackingLeft(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.trackingLeftProperty,param1);
      }
      
      public function get trackingRight() : * {
         return this._styles.trackingRight;
      }
      
      public function set trackingRight(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.trackingRightProperty,param1);
      }
      
      public function get lineHeight() : * {
         return this._styles.lineHeight;
      }
      
      public function set lineHeight(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineHeightProperty,param1);
      }
      
      public function get breakOpportunity() : * {
         return this._styles.breakOpportunity;
      }
      
      public function set breakOpportunity(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.breakOpportunityProperty,param1);
      }
      
      public function get digitCase() : * {
         return this._styles.digitCase;
      }
      
      public function set digitCase(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.digitCaseProperty,param1);
      }
      
      public function get digitWidth() : * {
         return this._styles.digitWidth;
      }
      
      public function set digitWidth(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.digitWidthProperty,param1);
      }
      
      public function get dominantBaseline() : * {
         return this._styles.dominantBaseline;
      }
      
      public function set dominantBaseline(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.dominantBaselineProperty,param1);
      }
      
      public function get kerning() : * {
         return this._styles.kerning;
      }
      
      public function set kerning(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.kerningProperty,param1);
      }
      
      public function get ligatureLevel() : * {
         return this._styles.ligatureLevel;
      }
      
      public function set ligatureLevel(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.ligatureLevelProperty,param1);
      }
      
      public function get alignmentBaseline() : * {
         return this._styles.alignmentBaseline;
      }
      
      public function set alignmentBaseline(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.alignmentBaselineProperty,param1);
      }
      
      public function get locale() : * {
         return this._styles.locale;
      }
      
      public function set locale(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.localeProperty,param1);
      }
      
      public function get typographicCase() : * {
         return this._styles.typographicCase;
      }
      
      public function set typographicCase(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.typographicCaseProperty,param1);
      }
      
      public function get fontFamily() : * {
         return this._styles.fontFamily;
      }
      
      public function set fontFamily(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontFamilyProperty,param1);
      }
      
      public function get textDecoration() : * {
         return this._styles.textDecoration;
      }
      
      public function set textDecoration(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textDecorationProperty,param1);
      }
      
      public function get fontWeight() : * {
         return this._styles.fontWeight;
      }
      
      public function set fontWeight(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontWeightProperty,param1);
      }
      
      public function get fontStyle() : * {
         return this._styles.fontStyle;
      }
      
      public function set fontStyle(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontStyleProperty,param1);
      }
      
      public function get whiteSpaceCollapse() : * {
         return this._styles.whiteSpaceCollapse;
      }
      
      public function set whiteSpaceCollapse(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.whiteSpaceCollapseProperty,param1);
      }
      
      public function get renderingMode() : * {
         return this._styles.renderingMode;
      }
      
      public function set renderingMode(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.renderingModeProperty,param1);
      }
      
      public function get cffHinting() : * {
         return this._styles.cffHinting;
      }
      
      public function set cffHinting(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.cffHintingProperty,param1);
      }
      
      public function get fontLookup() : * {
         return this._styles.fontLookup;
      }
      
      public function set fontLookup(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontLookupProperty,param1);
      }
      
      public function get textRotation() : * {
         return this._styles.textRotation;
      }
      
      public function set textRotation(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textRotationProperty,param1);
      }
      
      public function get textIndent() : * {
         return this._styles.textIndent;
      }
      
      public function set textIndent(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textIndentProperty,param1);
      }
      
      public function get paragraphStartIndent() : * {
         return this._styles.paragraphStartIndent;
      }
      
      public function set paragraphStartIndent(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphStartIndentProperty,param1);
      }
      
      public function get paragraphEndIndent() : * {
         return this._styles.paragraphEndIndent;
      }
      
      public function set paragraphEndIndent(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphEndIndentProperty,param1);
      }
      
      public function get paragraphSpaceBefore() : * {
         return this._styles.paragraphSpaceBefore;
      }
      
      public function set paragraphSpaceBefore(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceBeforeProperty,param1);
      }
      
      public function get paragraphSpaceAfter() : * {
         return this._styles.paragraphSpaceAfter;
      }
      
      public function set paragraphSpaceAfter(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceAfterProperty,param1);
      }
      
      public function get textAlign() : * {
         return this._styles.textAlign;
      }
      
      public function set textAlign(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlignProperty,param1);
      }
      
      public function get textAlignLast() : * {
         return this._styles.textAlignLast;
      }
      
      public function set textAlignLast(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlignLastProperty,param1);
      }
      
      public function get textJustify() : * {
         return this._styles.textJustify;
      }
      
      public function set textJustify(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textJustifyProperty,param1);
      }
      
      public function get justificationRule() : * {
         return this._styles.justificationRule;
      }
      
      public function set justificationRule(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.justificationRuleProperty,param1);
      }
      
      public function get justificationStyle() : * {
         return this._styles.justificationStyle;
      }
      
      public function set justificationStyle(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.justificationStyleProperty,param1);
      }
      
      public function get direction() : * {
         return this._styles.direction;
      }
      
      public function set direction(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.directionProperty,param1);
      }
      
      public function get wordSpacing() : * {
         return this._styles.wordSpacing;
      }
      
      public function set wordSpacing(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.wordSpacingProperty,param1);
      }
      
      public function get tabStops() : * {
         return this._styles.tabStops;
      }
      
      public function set tabStops(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.tabStopsProperty,param1);
      }
      
      public function get leadingModel() : * {
         return this._styles.leadingModel;
      }
      
      public function set leadingModel(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.leadingModelProperty,param1);
      }
      
      public function get columnGap() : * {
         return this._styles.columnGap;
      }
      
      public function set columnGap(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnGapProperty,param1);
      }
      
      public function get paddingLeft() : * {
         return this._styles.paddingLeft;
      }
      
      public function set paddingLeft(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingLeftProperty,param1);
      }
      
      public function get paddingTop() : * {
         return this._styles.paddingTop;
      }
      
      public function set paddingTop(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingTopProperty,param1);
      }
      
      public function get paddingRight() : * {
         return this._styles.paddingRight;
      }
      
      public function set paddingRight(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingRightProperty,param1);
      }
      
      public function get paddingBottom() : * {
         return this._styles.paddingBottom;
      }
      
      public function set paddingBottom(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingBottomProperty,param1);
      }
      
      public function get columnCount() : * {
         return this._styles.columnCount;
      }
      
      public function set columnCount(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnCountProperty,param1);
      }
      
      public function get columnWidth() : * {
         return this._styles.columnWidth;
      }
      
      public function set columnWidth(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnWidthProperty,param1);
      }
      
      public function get firstBaselineOffset() : * {
         return this._styles.firstBaselineOffset;
      }
      
      public function set firstBaselineOffset(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.firstBaselineOffsetProperty,param1);
      }
      
      public function get verticalAlign() : * {
         return this._styles.verticalAlign;
      }
      
      public function set verticalAlign(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.verticalAlignProperty,param1);
      }
      
      public function get blockProgression() : * {
         return this._styles.blockProgression;
      }
      
      public function set blockProgression(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.blockProgressionProperty,param1);
      }
      
      public function get lineBreak() : * {
         return this._styles.lineBreak;
      }
      
      public function set lineBreak(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineBreakProperty,param1);
      }
      
      public function get listStyleType() : * {
         return this._styles.listStyleType;
      }
      
      public function set listStyleType(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listStyleTypeProperty,param1);
      }
      
      public function get listStylePosition() : * {
         return this._styles.listStylePosition;
      }
      
      public function set listStylePosition(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listStylePositionProperty,param1);
      }
      
      public function get listAutoPadding() : * {
         return this._styles.listAutoPadding;
      }
      
      public function set listAutoPadding(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listAutoPaddingProperty,param1);
      }
      
      public function get clearFloats() : * {
         return this._styles.clearFloats;
      }
      
      public function set clearFloats(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.clearFloatsProperty,param1);
      }
      
      public function get styleName() : * {
         return this._styles.styleName;
      }
      
      public function set styleName(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.styleNameProperty,param1);
      }
      
      public function get linkNormalFormat() : * {
         return this._styles.linkNormalFormat;
      }
      
      public function set linkNormalFormat(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkNormalFormatProperty,param1);
      }
      
      public function get linkActiveFormat() : * {
         return this._styles.linkActiveFormat;
      }
      
      public function set linkActiveFormat(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkActiveFormatProperty,param1);
      }
      
      public function get linkHoverFormat() : * {
         return this._styles.linkHoverFormat;
      }
      
      public function set linkHoverFormat(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkHoverFormatProperty,param1);
      }
      
      public function get listMarkerFormat() : * {
         return this._styles.listMarkerFormat;
      }
      
      public function set listMarkerFormat(param1:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listMarkerFormatProperty,param1);
      }
   }
}
