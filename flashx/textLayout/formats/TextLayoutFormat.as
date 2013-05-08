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
         

      public function TextLayoutFormat(initialValues:ITextLayoutFormat=null) {
         super();
         this.copy(initialValues);
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

      private static var _description:Object = {
                                                     color:colorProperty,
                                                     backgroundColor:backgroundColorProperty,
                                                     lineThrough:lineThroughProperty,
                                                     textAlpha:textAlphaProperty,
                                                     backgroundAlpha:backgroundAlphaProperty,
                                                     fontSize:fontSizeProperty,
                                                     baselineShift:baselineShiftProperty,
                                                     trackingLeft:trackingLeftProperty,
                                                     trackingRight:trackingRightProperty,
                                                     lineHeight:lineHeightProperty,
                                                     breakOpportunity:breakOpportunityProperty,
                                                     digitCase:digitCaseProperty,
                                                     digitWidth:digitWidthProperty,
                                                     dominantBaseline:dominantBaselineProperty,
                                                     kerning:kerningProperty,
                                                     ligatureLevel:ligatureLevelProperty,
                                                     alignmentBaseline:alignmentBaselineProperty,
                                                     locale:localeProperty,
                                                     typographicCase:typographicCaseProperty,
                                                     fontFamily:fontFamilyProperty,
                                                     textDecoration:textDecorationProperty,
                                                     fontWeight:fontWeightProperty,
                                                     fontStyle:fontStyleProperty,
                                                     whiteSpaceCollapse:whiteSpaceCollapseProperty,
                                                     renderingMode:renderingModeProperty,
                                                     cffHinting:cffHintingProperty,
                                                     fontLookup:fontLookupProperty,
                                                     textRotation:textRotationProperty,
                                                     textIndent:textIndentProperty,
                                                     paragraphStartIndent:paragraphStartIndentProperty,
                                                     paragraphEndIndent:paragraphEndIndentProperty,
                                                     paragraphSpaceBefore:paragraphSpaceBeforeProperty,
                                                     paragraphSpaceAfter:paragraphSpaceAfterProperty,
                                                     textAlign:textAlignProperty,
                                                     textAlignLast:textAlignLastProperty,
                                                     textJustify:textJustifyProperty,
                                                     justificationRule:justificationRuleProperty,
                                                     justificationStyle:justificationStyleProperty,
                                                     direction:directionProperty,
                                                     wordSpacing:wordSpacingProperty,
                                                     tabStops:tabStopsProperty,
                                                     leadingModel:leadingModelProperty,
                                                     columnGap:columnGapProperty,
                                                     paddingLeft:paddingLeftProperty,
                                                     paddingTop:paddingTopProperty,
                                                     paddingRight:paddingRightProperty,
                                                     paddingBottom:paddingBottomProperty,
                                                     columnCount:columnCountProperty,
                                                     columnWidth:columnWidthProperty,
                                                     firstBaselineOffset:firstBaselineOffsetProperty,
                                                     verticalAlign:verticalAlignProperty,
                                                     blockProgression:blockProgressionProperty,
                                                     lineBreak:lineBreakProperty,
                                                     listStyleType:listStyleTypeProperty,
                                                     listStylePosition:listStylePositionProperty,
                                                     listAutoPadding:listAutoPaddingProperty,
                                                     clearFloats:clearFloatsProperty,
                                                     styleName:styleNameProperty,
                                                     linkNormalFormat:linkNormalFormatProperty,
                                                     linkActiveFormat:linkActiveFormatProperty,
                                                     linkHoverFormat:linkHoverFormatProperty,
                                                     listMarkerFormat:listMarkerFormatProperty
                                                     };

      tlf_internal  static function get description() : Object {
         return _description;
      }

      private static var _emptyTextLayoutFormat:ITextLayoutFormat;

      tlf_internal  static function get emptyTextLayoutFormat() : ITextLayoutFormat {
         if(_emptyTextLayoutFormat==null)
         {
            _emptyTextLayoutFormat=new TextLayoutFormat();
         }
         return _emptyTextLayoutFormat;
      }

      private static const _emptyStyles:Object = new Object();

      public static function isEqual(p1:ITextLayoutFormat, p2:ITextLayoutFormat) : Boolean {
         var prop:Property = null;
         if(p1==null)
         {
            p1=emptyTextLayoutFormat;
         }
         if(p2==null)
         {
            p2=emptyTextLayoutFormat;
         }
         if(p1==p2)
         {
            return true;
         }
         var p1Holder:TextLayoutFormat = p1 as TextLayoutFormat;
         var p2Holder:TextLayoutFormat = p2 as TextLayoutFormat;
         if((p1Holder)&&(p2Holder))
         {
            return Property.equalStyles(p1Holder.getStyles(),p2Holder.getStyles(),TextLayoutFormat.description);
         }
         for each (prop in TextLayoutFormat.description)
         {
            if(!prop.equalHelper(p1[prop.name],p2[prop.name]))
            {
               return false;
            }
         }
         return true;
      }

      private static var _defaults:TextLayoutFormat;

      public static function get defaultFormat() : ITextLayoutFormat {
         if(_defaults==null)
         {
            _defaults=new TextLayoutFormat();
            Property.defaultsAllHelper(_description,_defaults);
         }
         return _defaults;
      }

      tlf_internal  static function resetModifiedNoninheritedStyles(stylesObject:Object) : void {
         if(stylesObject.backgroundColor!=TextLayoutFormat.backgroundColorProperty.defaultValue)
         {
            stylesObject.backgroundColor=TextLayoutFormat.backgroundColorProperty.defaultValue;
         }
         if(stylesObject.backgroundAlpha!=TextLayoutFormat.backgroundAlphaProperty.defaultValue)
         {
            stylesObject.backgroundAlpha=TextLayoutFormat.backgroundAlphaProperty.defaultValue;
         }
         if(stylesObject.columnGap!=TextLayoutFormat.columnGapProperty.defaultValue)
         {
            stylesObject.columnGap=TextLayoutFormat.columnGapProperty.defaultValue;
         }
         if(stylesObject.paddingLeft!=TextLayoutFormat.paddingLeftProperty.defaultValue)
         {
            stylesObject.paddingLeft=TextLayoutFormat.paddingLeftProperty.defaultValue;
         }
         if(stylesObject.paddingTop!=TextLayoutFormat.paddingTopProperty.defaultValue)
         {
            stylesObject.paddingTop=TextLayoutFormat.paddingTopProperty.defaultValue;
         }
         if(stylesObject.paddingRight!=TextLayoutFormat.paddingRightProperty.defaultValue)
         {
            stylesObject.paddingRight=TextLayoutFormat.paddingRightProperty.defaultValue;
         }
         if(stylesObject.paddingBottom!=TextLayoutFormat.paddingBottomProperty.defaultValue)
         {
            stylesObject.paddingBottom=TextLayoutFormat.paddingBottomProperty.defaultValue;
         }
         if(stylesObject.columnCount!=TextLayoutFormat.columnCountProperty.defaultValue)
         {
            stylesObject.columnCount=TextLayoutFormat.columnCountProperty.defaultValue;
         }
         if(stylesObject.columnWidth!=TextLayoutFormat.columnWidthProperty.defaultValue)
         {
            stylesObject.columnWidth=TextLayoutFormat.columnWidthProperty.defaultValue;
         }
         if(stylesObject.verticalAlign!=TextLayoutFormat.verticalAlignProperty.defaultValue)
         {
            stylesObject.verticalAlign=TextLayoutFormat.verticalAlignProperty.defaultValue;
         }
         if(stylesObject.lineBreak!=TextLayoutFormat.lineBreakProperty.defaultValue)
         {
            stylesObject.lineBreak=TextLayoutFormat.lineBreakProperty.defaultValue;
         }
         if(stylesObject.clearFloats!=TextLayoutFormat.clearFloatsProperty.defaultValue)
         {
            stylesObject.clearFloats=TextLayoutFormat.clearFloatsProperty.defaultValue;
         }
         if(stylesObject.styleName!=TextLayoutFormat.styleNameProperty.defaultValue)
         {
            stylesObject.styleName=TextLayoutFormat.styleNameProperty.defaultValue;
         }
      }

      public static function createTextLayoutFormat(initialValues:Object) : TextLayoutFormat {
         var key:String = null;
         var format:ITextLayoutFormat = initialValues as ITextLayoutFormat;
         var rslt:TextLayoutFormat = new TextLayoutFormat(format);
         if((format==null)&&(initialValues))
         {
            for (key in initialValues)
            {
               rslt.setStyle(key,initialValues[key]);
            }
         }
         return rslt;
      }

      private var _styles:Object;

      private var _sharedStyles:Boolean;

      private function writableStyles() : void {
         if(this._sharedStyles)
         {
            this._styles=this._styles==_emptyStyles?new Object():Property.createObjectWithPrototype(this._styles);
            this._sharedStyles=false;
         }
      }

      tlf_internal function getStyles() : Object {
         return this._styles==_emptyStyles?null:this._styles;
      }

      tlf_internal function setStyles(val:Object, shared:Boolean) : void {
         if(this._styles!=val)
         {
            this._styles=val;
            this._sharedStyles=shared;
         }
      }

      tlf_internal function clearStyles() : void {
         this._styles=_emptyStyles;
         this._sharedStyles=true;
      }

      public function get coreStyles() : Object {
         return this._styles==_emptyStyles?null:Property.shallowCopyInFilter(this._styles,description);
      }

      public function get userStyles() : Object {
         return this._styles==_emptyStyles?null:Property.shallowCopyNotInFilter(this._styles,description);
      }

      public function get styles() : Object {
         return this._styles==_emptyStyles?null:Property.shallowCopy(this._styles);
      }

      tlf_internal function setStyleByName(name:String, newValue:*) : void {
         this.writableStyles();
         if(newValue!==undefined)
         {
            this._styles[name]=newValue;
         }
         else
         {
            delete this._styles[[name]];
            if(this._styles[name]!==undefined)
            {
               this._styles=Property.shallowCopy(this._styles);
               delete this._styles[[name]];
            }
         }
      }

      private function setStyleByProperty(styleProp:Property, newValue:*) : void {
         var name:String = styleProp.name;
         var newValue:* = styleProp.setHelper(this._styles[name],newValue);
         this.setStyleByName(name,newValue);
      }

      public function setStyle(styleProp:String, newValue:*) : void {
         if(description.hasOwnProperty(styleProp))
         {
            this[styleProp]=newValue;
         }
         else
         {
            this.setStyleByName(styleProp,newValue);
         }
      }

      public function getStyle(styleProp:String) : * {
         return this._styles[styleProp];
      }

      public function copy(incoming:ITextLayoutFormat) : void {
         var prop:Property = null;
         var val:* = undefined;
         if(this==incoming)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            this._styles=holder._styles;
            this._sharedStyles=true;
            holder._sharedStyles=true;
            return;
         }
         this._styles=_emptyStyles;
         this._sharedStyles=true;
         if(incoming)
         {
            for each (prop in TextLayoutFormat.description)
            {
               val=incoming[prop.name];
               if(val!==undefined)
               {
                  this[prop.name]=val;
               }
            }
         }
      }

      public function concat(incoming:ITextLayoutFormat) : void {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:String = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles=holder._styles;
            for (key in holderStyles)
            {
               prop=description[key];
               if(prop)
               {
                  this.setStyleByProperty(prop,prop.concatHelper(this._styles[key],holderStyles[key]));
               }
               else
               {
                  this.setStyleByName(key,Property.defaultConcatHelper(this._styles[key],holderStyles[key]));
               }
            }
            return;
         }
         for each (prop in TextLayoutFormat.description)
         {
            this.setStyleByProperty(prop,prop.concatHelper(this._styles[prop.name],incoming[prop.name]));
         }
      }

      public function concatInheritOnly(incoming:ITextLayoutFormat) : void {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:String = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles=holder._styles;
            for (key in holderStyles)
            {
               prop=description[key];
               if(prop)
               {
                  this.setStyleByProperty(prop,prop.concatInheritOnlyHelper(this._styles[key],holderStyles[key]));
               }
               else
               {
                  this.setStyleByName(key,Property.defaultConcatHelper(this._styles[key],holderStyles[key]));
               }
            }
            return;
         }
         for each (prop in TextLayoutFormat.description)
         {
            this.setStyleByProperty(prop,prop.concatInheritOnlyHelper(this._styles[prop.name],incoming[prop.name]));
         }
      }

      public function apply(incoming:ITextLayoutFormat) : void {
         var val:* = undefined;
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:String = null;
         var name:String = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles=holder._styles;
            for (key in holderStyles)
            {
               val=holderStyles[key];
               if(val!==undefined)
               {
                  this.setStyle(key,val);
               }
            }
            return;
         }
         for each (prop in TextLayoutFormat.description)
         {
            name=prop.name;
            val=incoming[name];
            if(val!==undefined)
            {
               this.setStyle(name,val);
            }
         }
      }

      public function removeMatching(incoming:ITextLayoutFormat) : void {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:String = null;
         if(incoming==null)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles=holder._styles;
            for (key in holderStyles)
            {
               prop=description[key];
               if(prop)
               {
                  if(prop.equalHelper(this._styles[key],holderStyles[key]))
                  {
                     this[key]=undefined;
                  }
               }
               else
               {
                  if(this._styles[key]==holderStyles[key])
                  {
                     this.setStyle(key,undefined);
                  }
               }
            }
            return;
         }
         for each (prop in TextLayoutFormat.description)
         {
            if(prop.equalHelper(this._styles[prop.name],incoming[prop.name]))
            {
               this[prop.name]=undefined;
            }
         }
      }

      public function removeClashing(incoming:ITextLayoutFormat) : void {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:String = null;
         if(incoming==null)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles=holder._styles;
            for (key in holderStyles)
            {
               prop=description[key];
               if(prop)
               {
                  if(!prop.equalHelper(this._styles[key],holderStyles[key]))
                  {
                     this[key]=undefined;
                  }
               }
               else
               {
                  if(this._styles[key]!=holderStyles[key])
                  {
                     this.setStyle(key,undefined);
                  }
               }
            }
            return;
         }
         for each (prop in TextLayoutFormat.description)
         {
            if(!prop.equalHelper(this._styles[prop.name],incoming[prop.name]))
            {
               this[prop.name]=undefined;
            }
         }
      }

      public function get color() : * {
         return this._styles.color;
      }

      public function set color(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.colorProperty,value);
      }

      public function get backgroundColor() : * {
         return this._styles.backgroundColor;
      }

      public function set backgroundColor(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.backgroundColorProperty,value);
      }

      public function get lineThrough() : * {
         return this._styles.lineThrough;
      }

      public function set lineThrough(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineThroughProperty,value);
      }

      public function get textAlpha() : * {
         return this._styles.textAlpha;
      }

      public function set textAlpha(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlphaProperty,value);
      }

      public function get backgroundAlpha() : * {
         return this._styles.backgroundAlpha;
      }

      public function set backgroundAlpha(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.backgroundAlphaProperty,value);
      }

      public function get fontSize() : * {
         return this._styles.fontSize;
      }

      public function set fontSize(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontSizeProperty,value);
      }

      public function get baselineShift() : * {
         return this._styles.baselineShift;
      }

      public function set baselineShift(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.baselineShiftProperty,value);
      }

      public function get trackingLeft() : * {
         return this._styles.trackingLeft;
      }

      public function set trackingLeft(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.trackingLeftProperty,value);
      }

      public function get trackingRight() : * {
         return this._styles.trackingRight;
      }

      public function set trackingRight(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.trackingRightProperty,value);
      }

      public function get lineHeight() : * {
         return this._styles.lineHeight;
      }

      public function set lineHeight(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineHeightProperty,value);
      }

      public function get breakOpportunity() : * {
         return this._styles.breakOpportunity;
      }

      public function set breakOpportunity(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.breakOpportunityProperty,value);
      }

      public function get digitCase() : * {
         return this._styles.digitCase;
      }

      public function set digitCase(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.digitCaseProperty,value);
      }

      public function get digitWidth() : * {
         return this._styles.digitWidth;
      }

      public function set digitWidth(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.digitWidthProperty,value);
      }

      public function get dominantBaseline() : * {
         return this._styles.dominantBaseline;
      }

      public function set dominantBaseline(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.dominantBaselineProperty,value);
      }

      public function get kerning() : * {
         return this._styles.kerning;
      }

      public function set kerning(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.kerningProperty,value);
      }

      public function get ligatureLevel() : * {
         return this._styles.ligatureLevel;
      }

      public function set ligatureLevel(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.ligatureLevelProperty,value);
      }

      public function get alignmentBaseline() : * {
         return this._styles.alignmentBaseline;
      }

      public function set alignmentBaseline(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.alignmentBaselineProperty,value);
      }

      public function get locale() : * {
         return this._styles.locale;
      }

      public function set locale(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.localeProperty,value);
      }

      public function get typographicCase() : * {
         return this._styles.typographicCase;
      }

      public function set typographicCase(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.typographicCaseProperty,value);
      }

      public function get fontFamily() : * {
         return this._styles.fontFamily;
      }

      public function set fontFamily(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontFamilyProperty,value);
      }

      public function get textDecoration() : * {
         return this._styles.textDecoration;
      }

      public function set textDecoration(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textDecorationProperty,value);
      }

      public function get fontWeight() : * {
         return this._styles.fontWeight;
      }

      public function set fontWeight(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontWeightProperty,value);
      }

      public function get fontStyle() : * {
         return this._styles.fontStyle;
      }

      public function set fontStyle(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontStyleProperty,value);
      }

      public function get whiteSpaceCollapse() : * {
         return this._styles.whiteSpaceCollapse;
      }

      public function set whiteSpaceCollapse(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.whiteSpaceCollapseProperty,value);
      }

      public function get renderingMode() : * {
         return this._styles.renderingMode;
      }

      public function set renderingMode(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.renderingModeProperty,value);
      }

      public function get cffHinting() : * {
         return this._styles.cffHinting;
      }

      public function set cffHinting(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.cffHintingProperty,value);
      }

      public function get fontLookup() : * {
         return this._styles.fontLookup;
      }

      public function set fontLookup(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.fontLookupProperty,value);
      }

      public function get textRotation() : * {
         return this._styles.textRotation;
      }

      public function set textRotation(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textRotationProperty,value);
      }

      public function get textIndent() : * {
         return this._styles.textIndent;
      }

      public function set textIndent(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textIndentProperty,value);
      }

      public function get paragraphStartIndent() : * {
         return this._styles.paragraphStartIndent;
      }

      public function set paragraphStartIndent(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphStartIndentProperty,value);
      }

      public function get paragraphEndIndent() : * {
         return this._styles.paragraphEndIndent;
      }

      public function set paragraphEndIndent(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphEndIndentProperty,value);
      }

      public function get paragraphSpaceBefore() : * {
         return this._styles.paragraphSpaceBefore;
      }

      public function set paragraphSpaceBefore(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceBeforeProperty,value);
      }

      public function get paragraphSpaceAfter() : * {
         return this._styles.paragraphSpaceAfter;
      }

      public function set paragraphSpaceAfter(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceAfterProperty,value);
      }

      public function get textAlign() : * {
         return this._styles.textAlign;
      }

      public function set textAlign(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlignProperty,value);
      }

      public function get textAlignLast() : * {
         return this._styles.textAlignLast;
      }

      public function set textAlignLast(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textAlignLastProperty,value);
      }

      public function get textJustify() : * {
         return this._styles.textJustify;
      }

      public function set textJustify(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.textJustifyProperty,value);
      }

      public function get justificationRule() : * {
         return this._styles.justificationRule;
      }

      public function set justificationRule(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.justificationRuleProperty,value);
      }

      public function get justificationStyle() : * {
         return this._styles.justificationStyle;
      }

      public function set justificationStyle(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.justificationStyleProperty,value);
      }

      public function get direction() : * {
         return this._styles.direction;
      }

      public function set direction(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.directionProperty,value);
      }

      public function get wordSpacing() : * {
         return this._styles.wordSpacing;
      }

      public function set wordSpacing(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.wordSpacingProperty,value);
      }

      public function get tabStops() : * {
         return this._styles.tabStops;
      }

      public function set tabStops(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.tabStopsProperty,value);
      }

      public function get leadingModel() : * {
         return this._styles.leadingModel;
      }

      public function set leadingModel(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.leadingModelProperty,value);
      }

      public function get columnGap() : * {
         return this._styles.columnGap;
      }

      public function set columnGap(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnGapProperty,value);
      }

      public function get paddingLeft() : * {
         return this._styles.paddingLeft;
      }

      public function set paddingLeft(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingLeftProperty,value);
      }

      public function get paddingTop() : * {
         return this._styles.paddingTop;
      }

      public function set paddingTop(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingTopProperty,value);
      }

      public function get paddingRight() : * {
         return this._styles.paddingRight;
      }

      public function set paddingRight(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingRightProperty,value);
      }

      public function get paddingBottom() : * {
         return this._styles.paddingBottom;
      }

      public function set paddingBottom(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.paddingBottomProperty,value);
      }

      public function get columnCount() : * {
         return this._styles.columnCount;
      }

      public function set columnCount(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnCountProperty,value);
      }

      public function get columnWidth() : * {
         return this._styles.columnWidth;
      }

      public function set columnWidth(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.columnWidthProperty,value);
      }

      public function get firstBaselineOffset() : * {
         return this._styles.firstBaselineOffset;
      }

      public function set firstBaselineOffset(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.firstBaselineOffsetProperty,value);
      }

      public function get verticalAlign() : * {
         return this._styles.verticalAlign;
      }

      public function set verticalAlign(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.verticalAlignProperty,value);
      }

      public function get blockProgression() : * {
         return this._styles.blockProgression;
      }

      public function set blockProgression(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.blockProgressionProperty,value);
      }

      public function get lineBreak() : * {
         return this._styles.lineBreak;
      }

      public function set lineBreak(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.lineBreakProperty,value);
      }

      public function get listStyleType() : * {
         return this._styles.listStyleType;
      }

      public function set listStyleType(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listStyleTypeProperty,value);
      }

      public function get listStylePosition() : * {
         return this._styles.listStylePosition;
      }

      public function set listStylePosition(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listStylePositionProperty,value);
      }

      public function get listAutoPadding() : * {
         return this._styles.listAutoPadding;
      }

      public function set listAutoPadding(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listAutoPaddingProperty,value);
      }

      public function get clearFloats() : * {
         return this._styles.clearFloats;
      }

      public function set clearFloats(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.clearFloatsProperty,value);
      }

      public function get styleName() : * {
         return this._styles.styleName;
      }

      public function set styleName(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.styleNameProperty,value);
      }

      public function get linkNormalFormat() : * {
         return this._styles.linkNormalFormat;
      }

      public function set linkNormalFormat(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkNormalFormatProperty,value);
      }

      public function get linkActiveFormat() : * {
         return this._styles.linkActiveFormat;
      }

      public function set linkActiveFormat(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkActiveFormatProperty,value);
      }

      public function get linkHoverFormat() : * {
         return this._styles.linkHoverFormat;
      }

      public function set linkHoverFormat(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.linkHoverFormatProperty,value);
      }

      public function get listMarkerFormat() : * {
         return this._styles.listMarkerFormat;
      }

      public function set listMarkerFormat(value:*) : void {
         this.setStyleByProperty(TextLayoutFormat.listMarkerFormatProperty,value);
      }
   }

}