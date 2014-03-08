package flashx.textLayout.conversion
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.property.Property;
   import flash.utils.Dictionary;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.SubParagraphGroupElementBase;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.LeadingModel;
   import flash.text.engine.FontWeight;
   import flash.text.engine.FontPosture;
   import flashx.textLayout.formats.TextDecoration;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.Configuration;
   import flash.system.System;
   import flashx.textLayout.formats.ListStyleType;
   import flashx.textLayout.formats.ListMarkerFormat;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.elements.TabElement;
   import flash.text.engine.Kerning;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.GlobalSettings;
   
   use namespace tlf_internal;
   
   public class TextFieldHtmlImporter extends BaseTextLayoutImporter implements IHTMLImporter
   {
      
      public function TextFieldHtmlImporter() {
         createConfig();
         super(null,_htmlImporterConfig);
      }
      
      tlf_internal  static const _fontDescription:Object = 
         {
            "color":TextLayoutFormat.colorProperty,
            "trackingRight":TextLayoutFormat.trackingRightProperty,
            "fontFamily":TextLayoutFormat.fontFamilyProperty
         };
      
      tlf_internal  static const _fontMiscDescription:Object = 
         {
            "size":Property.NewStringProperty("size",null,false,null),
            "kerning":Property.NewStringProperty("kerning",null,false,null)
         };
      
      tlf_internal  static const _textFormatDescription:Object = 
         {
            "paragraphStartIndent":TextLayoutFormat.paragraphStartIndentProperty,
            "paragraphEndIndent":TextLayoutFormat.paragraphEndIndentProperty,
            "textIndent":TextLayoutFormat.textIndentProperty,
            "lineHeight":TextLayoutFormat.lineHeightProperty,
            "tabStops":TextLayoutFormat.tabStopsProperty
         };
      
      tlf_internal  static const _textFormatMiscDescription:Object = {"blockIndent":Property.NewStringProperty("blockIndent",null,false,null)};
      
      tlf_internal  static const _paragraphFormatDescription:Object = {"textAlign":TextLayoutFormat.textAlignProperty};
      
      tlf_internal  static const _linkHrefDescription:Object = {"href":Property.NewStringProperty("href",null,false,null)};
      
      tlf_internal  static const _linkTargetDescription:Object = {"target":Property.NewStringProperty("target",null,false,null)};
      
      tlf_internal  static const _imageDescription:Object = 
         {
            "height":InlineGraphicElement.heightPropertyDefinition,
            "width":InlineGraphicElement.widthPropertyDefinition
         };
      
      tlf_internal  static const _imageMiscDescription:Object = 
         {
            "src":Property.NewStringProperty("src",null,false,null),
            "align":Property.NewStringProperty("align",null,false,null)
         };
      
      tlf_internal  static const _classAndIdDescription:Object = {"id":Property.NewStringProperty("ID",null,false,null)};
      
      tlf_internal  static var _fontImporter:FontImporter;
      
      tlf_internal  static var _fontMiscImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _textFormatImporter:TextFormatImporter;
      
      tlf_internal  static var _textFormatMiscImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _paragraphFormatImporter:HtmlCustomParaFormatImporter;
      
      tlf_internal  static var _linkHrefImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _linkTargetImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _ilgFormatImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _ilgMiscFormatImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _classAndIdImporter:CaseInsensitiveTLFFormatImporter;
      
      tlf_internal  static var _activeFormat:TextLayoutFormat = new TextLayoutFormat();
      
      tlf_internal  static var _activeParaFormat:TextLayoutFormat = new TextLayoutFormat();
      
      tlf_internal  static var _activeImpliedParaFormat:TextLayoutFormat = null;
      
      tlf_internal  static var _htmlImporterConfig:ImportExportConfiguration;
      
      tlf_internal  static function createConfig() : void {
         if(!_htmlImporterConfig)
         {
            _htmlImporterConfig = new ImportExportConfiguration();
            _htmlImporterConfig.addIEInfo("BR",BreakElement,BaseTextLayoutImporter.parseBreak,null);
            _htmlImporterConfig.addIEInfo("P",ParagraphElement,TextFieldHtmlImporter.parsePara,null);
            _htmlImporterConfig.addIEInfo("SPAN",SpanElement,TextFieldHtmlImporter.parseSpan,null);
            _htmlImporterConfig.addIEInfo("A",LinkElement,TextFieldHtmlImporter.parseLink,null);
            _htmlImporterConfig.addIEInfo("IMG",InlineGraphicElement,TextFieldHtmlImporter.parseInlineGraphic,null);
            _htmlImporterConfig.addIEInfo("DIV",DivElement,TextFieldHtmlImporter.parseDiv,null);
            _htmlImporterConfig.addIEInfo("HTML",null,TextFieldHtmlImporter.parseHtmlElement,null);
            _htmlImporterConfig.addIEInfo("BODY",null,TextFieldHtmlImporter.parseBody,null);
            _htmlImporterConfig.addIEInfo("FONT",null,TextFieldHtmlImporter.parseFont,null);
            _htmlImporterConfig.addIEInfo("TEXTFORMAT",null,TextFieldHtmlImporter.parseTextFormat,null);
            _htmlImporterConfig.addIEInfo("U",null,TextFieldHtmlImporter.parseUnderline,null);
            _htmlImporterConfig.addIEInfo("I",null,TextFieldHtmlImporter.parseItalic,null);
            _htmlImporterConfig.addIEInfo("B",null,TextFieldHtmlImporter.parseBold,null);
            _htmlImporterConfig.addIEInfo("S",null,TextFieldHtmlImporter.parseStrikeThrough,null);
            _htmlImporterConfig.addIEInfo("UL",null,BaseTextLayoutImporter.parseList,null);
            _htmlImporterConfig.addIEInfo("OL",null,BaseTextLayoutImporter.parseList,null);
            _htmlImporterConfig.addIEInfo("LI",null,TextFieldHtmlImporter.parseListItem,null);
         }
         if(_classAndIdDescription["CLASS"] === undefined)
         {
            _classAndIdDescription["CLASS"] = Property.NewStringProperty("CLASS",null,false,null);
            _paragraphFormatImporter = new HtmlCustomParaFormatImporter(TextLayoutFormat,_paragraphFormatDescription);
            _textFormatImporter = new TextFormatImporter(TextLayoutFormat,_textFormatDescription);
            _fontImporter = new FontImporter(TextLayoutFormat,_fontDescription);
            _fontMiscImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_fontMiscDescription);
            _textFormatMiscImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_textFormatMiscDescription);
            _linkHrefImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_linkHrefDescription,false);
            _linkTargetImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_linkTargetDescription);
            _ilgFormatImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_imageDescription);
            _ilgMiscFormatImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_imageMiscDescription,false);
            _classAndIdImporter = new CaseInsensitiveTLFFormatImporter(Dictionary,_classAndIdDescription);
         }
      }
      
      public static function parseListItem(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc5_:ListElement = null;
         if(!(param3 is ListElement))
         {
            _loc5_ = param1.createListFromXML(null);
            param1.addChild(param3,_loc5_);
            param3 = _loc5_;
         }
         var _loc4_:ListItemElement = param1.createListItemFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            param1.parseFlowGroupElementChildren(param2,_loc4_);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(new ParagraphElement());
            }
         }
      }
      
      public static function parsePara(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc5_:XML = null;
         var _loc4_:ParagraphElement = param1.createParagraphFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            _loc5_ = getSingleFontChild(param2);
            parseChildrenUnderNewActiveFormat(param1,_loc5_?_loc5_:param2,_loc4_,_activeFormat,null);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(param1.createImpliedSpan(""));
            }
         }
         replaceBreakElementsWithParaSplits(_loc4_);
      }
      
      public static function parseDiv(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:FlowGroupElement = null;
         if(param3.canOwnFlowElement(new DivElement()))
         {
            _loc4_ = param1.createDivFromXML(param2);
         }
         else
         {
            _loc4_ = param1.createSPGEFromXML(param2);
            _loc4_.typeName = "div";
         }
         param1.addChild(param3,_loc4_);
         param1.parseFlowGroupElementChildren(param2,_loc4_);
      }
      
      public static function parseHtmlElement(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:FlowGroupElement = null;
         if(param1.preserveHTMLElement)
         {
            if(!(param3 is TextFlow))
            {
               _loc4_ = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase?new SubParagraphGroupElement():new DivElement();
               param3.addChild(_loc4_);
               param3 = _loc4_;
            }
            param1.parseAttributes(param2,[_classAndIdImporter]);
            param3.typeName = "html";
            param3.styleName = _classAndIdImporter.getFormatValue("CLASS");
            param3.id = _classAndIdImporter.getFormatValue("ID");
         }
         param1.parseFlowGroupElementChildren(param2,param3,null,true);
      }
      
      public static function parseBody(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:FlowGroupElement = null;
         if(param1.preserveBodyElement)
         {
            _loc4_ = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase?new SubParagraphGroupElement():new DivElement();
            param3.addChild(_loc4_);
            param3 = _loc4_;
            param1.parseAttributes(param2,[_classAndIdImporter]);
            param3.typeName = "body";
            param3.styleName = _classAndIdImporter.getFormatValue("CLASS");
            param3.id = _classAndIdImporter.getFormatValue("ID");
         }
         param1.parseFlowGroupElementChildren(param2,param3,null,true);
      }
      
      private static function getSingleFontChild(param1:XML) : XML {
         var _loc3_:XML = null;
         var _loc2_:XMLList = param1.children();
         if(_loc2_.length() == 1)
         {
            _loc3_ = _loc2_[0];
            if(_loc3_.name().localName.toUpperCase() == "FONT")
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function parseLink(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:LinkElement = param1.createLinkFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            parseChildrenUnderNewActiveFormat(param1,param2,_loc4_,_activeFormat,null);
         }
      }
      
      tlf_internal  static function extractSimpleSpanText(param1:XML) : String {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc2_:XMLList = param1[0].children();
         if(_loc2_.length() == 0)
         {
            return "";
         }
         if(_loc2_.length() != 1)
         {
            return null;
         }
         for each (_loc3_ in _loc2_)
         {
            _loc4_ = _loc3_.name()?_loc3_.name().localName:null;
            if(_loc4_ != null)
            {
               return null;
            }
            _loc5_ = _loc3_.toString();
            return _loc5_?_loc5_:"";
         }
      }
      
      public static function parseSpan(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc8_:SubParagraphGroupElement = null;
         param1.parseAttributes(param2,[_classAndIdImporter]);
         var _loc4_:* = _classAndIdImporter.getFormatValue("CLASS");
         var _loc5_:* = _classAndIdImporter.getFormatValue("ID");
         var _loc6_:String = extractSimpleSpanText(param2);
         if(_loc6_ == null)
         {
            if(!(_loc4_ === undefined) || !(_loc5_ === undefined) || !TextLayoutFormat.isEqual(_activeFormat,TextLayoutFormat.emptyTextLayoutFormat))
            {
               _loc8_ = new SubParagraphGroupElement();
               _loc8_.format = _activeFormat;
               _loc8_.styleName = _loc4_;
               _loc8_.id = _loc5_;
               _loc8_.typeName = "span";
               param1.addChild(param3,_loc8_);
               param3 = _loc8_;
            }
            parseChildrenUnderNewActiveFormat(param1,param2,param3,_activeFormat,null);
            return;
         }
         var _loc7_:SpanElement = new SpanElement();
         _loc7_.format = _activeFormat;
         _loc7_.styleName = _loc4_;
         _loc7_.id = _loc5_;
         _loc7_.text = _loc6_;
         param1.addChild(param3,_loc7_);
      }
      
      public static function parseInlineGraphic(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:InlineGraphicElement = param1.createInlineGraphicFromXML(param2);
         param1.addChild(param3,_loc4_);
      }
      
      public static function parseFont(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:ITextLayoutFormat = param1.parseFontAttributes(param2);
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1,param2,param3,_loc4_);
      }
      
      public static function parseTextFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc8_:* = NaN;
         var _loc9_:TextLayoutFormat = null;
         var _loc4_:Array = [_textFormatImporter,_textFormatMiscImporter];
         param1.parseAttributes(param2,_loc4_);
         var _loc5_:TextLayoutFormat = new TextLayoutFormat(_textFormatImporter.result as ITextLayoutFormat);
         var _loc6_:* = _textFormatMiscImporter.getFormatValue("BLOCKINDENT");
         if(_loc6_ !== undefined)
         {
            _loc6_ = TextLayoutFormat.paragraphStartIndentProperty.setHelper(undefined,_loc6_);
            if(_loc6_ !== undefined)
            {
               _loc8_ = Number(_loc6_);
               _loc5_.paragraphStartIndent = _loc5_.paragraphStartIndent === undefined?_loc8_:_loc5_.paragraphStartIndent + _loc8_;
            }
         }
         var _loc7_:* = _activeFormat.lineHeight;
         if(param3 is ParagraphElement)
         {
            if(param3.numChildren == 0)
            {
               _loc9_ = new TextLayoutFormat(param3.format);
               _loc9_.apply(_loc5_);
               if(_loc9_.lineHeight !== undefined)
               {
                  _loc9_.leadingModel = LeadingModel.APPROXIMATE_TEXT_FIELD;
               }
               param3.format = _loc9_;
               _loc5_.clearStyles();
            }
            else
            {
               if(_loc5_.lineHeight !== undefined)
               {
                  _activeFormat.lineHeight = _loc5_.lineHeight;
               }
            }
         }
         parseChildrenUnderNewActiveFormat(param1,param2,param3,_activeParaFormat,_loc5_,true);
         _activeFormat.lineHeight = _loc7_;
      }
      
      public static function parseBold(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:TextLayoutFormat = new TextLayoutFormat();
         _loc4_.fontWeight = FontWeight.BOLD;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1,param2,param3,_loc4_);
      }
      
      public static function parseItalic(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:TextLayoutFormat = new TextLayoutFormat();
         _loc4_.fontStyle = FontPosture.ITALIC;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1,param2,param3,_loc4_);
      }
      
      public static function parseStrikeThrough(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:TextLayoutFormat = new TextLayoutFormat();
         _loc4_.lineThrough = true;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1,param2,param3,_loc4_);
      }
      
      public static function parseUnderline(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:TextLayoutFormat = new TextLayoutFormat();
         _loc4_.textDecoration = TextDecoration.UNDERLINE;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1,param2,param3,_loc4_);
      }
      
      protected static function parseChildrenUnderNewActiveFormatWithImpliedParaFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement, param4:ITextLayoutFormat) : void {
         var importer:TextFieldHtmlImporter = param1;
         var xmlToParse:XML = param2;
         var parent:FlowGroupElement = param3;
         var newFormat:ITextLayoutFormat = param4;
         var oldActiveImpliedParaFormat:TextLayoutFormat = _activeImpliedParaFormat;
         if(_activeImpliedParaFormat == null)
         {
            _activeImpliedParaFormat = new TextLayoutFormat(_activeFormat);
         }
         parseChildrenUnderNewActiveFormat(importer,xmlToParse,parent,_activeFormat,newFormat,true);
      }
      
      protected static function parseChildrenUnderNewActiveFormat(param1:TextFieldHtmlImporter, param2:XML, param3:FlowGroupElement, param4:TextLayoutFormat, param5:ITextLayoutFormat, param6:Boolean=false) : void {
         var beforeCount:int = 0;
         var span:SpanElement = null;
         var importer:TextFieldHtmlImporter = param1;
         var xmlToParse:XML = param2;
         var parent:FlowGroupElement = param3;
         var currFormat:TextLayoutFormat = param4;
         var newFormat:ITextLayoutFormat = param5;
         var chainedParent:Boolean = param6;
         var restoreBaseFontSize:Number = importer._baseFontSize;
         var restoreStyles:Object = Property.shallowCopy(currFormat.getStyles());
         if(newFormat)
         {
            if(newFormat.fontSize !== undefined)
            {
               importer._baseFontSize = newFormat.fontSize;
            }
            currFormat.apply(newFormat);
         }
         else
         {
            currFormat.clearStyles();
         }
         beforeCount = parent.numChildren;
         importer.parseFlowGroupElementChildren(xmlToParse,parent,null,chainedParent);
         if(beforeCount == parent.numChildren)
         {
            span = importer.createImpliedSpan("");
            importer.addChild(parent,span);
         }
      }
      
      protected static function replaceBreakElementsWithParaSplits(param1:ParagraphElement) : void {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         var _loc4_:FlowGroupElement = null;
         var _loc5_:FlowLeafElement = param1.getFirstLeaf();
         while(_loc5_)
         {
            if(!(_loc5_ is BreakElement))
            {
               _loc5_ = _loc5_.getNextLeaf(param1);
            }
            else
            {
               if(!_loc2_)
               {
                  _loc2_ = [param1];
                  _loc4_ = param1.parent;
                  _loc3_ = _loc4_.getChildIndex(param1);
                  _loc4_.removeChildAt(_loc3_);
               }
               param1 = param1.splitAtPosition(_loc5_.getAbsoluteStart() + _loc5_.textLength) as ParagraphElement;
               _loc2_.push(param1);
               _loc5_.parent.removeChild(_loc5_);
               _loc5_ = param1.getFirstLeaf();
            }
         }
         if(_loc2_)
         {
            _loc4_.replaceChildren(_loc3_,_loc3_,_loc2_);
         }
      }
      
      tlf_internal  static const stripRegex:RegExp = new RegExp("<!--.*?-->|<\\?(\".*?\"|\'.*?\'|[^>\"\']+)*>|<!(\".*?\"|\'.*?\'|[^>\"\']+)*>","sg");
      
      tlf_internal  static const tagRegex:RegExp = new RegExp("<(\\/?)(\\w+)((?:\\s+\\w+(?:\\s*=\\s*(?:\".*?\"|\'.*?\'|[\\w\\.]+))?)*)\\s*(\\/?)>","sg");
      
      tlf_internal  static const attrRegex:RegExp = new RegExp("\\s+(\\w+)(?:\\s*=\\s*(\".*?\"|\'.*?\'|[\\w\\.]+))?","sg");
      
      tlf_internal  static const anyPrintChar:RegExp = new RegExp("[^\t\n\r ]","g");
      
      tlf_internal var _baseFontSize:Number;
      
      private var _imageSourceResolveFunction:Function;
      
      private var _preserveBodyElement:Boolean = false;
      
      private var _importHtmlElement:Boolean = false;
      
      public function get imageSourceResolveFunction() : Function {
         return this._imageSourceResolveFunction;
      }
      
      public function set imageSourceResolveFunction(param1:Function) : void {
         this._imageSourceResolveFunction = param1;
      }
      
      public function get preserveBodyElement() : Boolean {
         return this._preserveBodyElement;
      }
      
      public function set preserveBodyElement(param1:Boolean) : void {
         this._preserveBodyElement = param1;
      }
      
      public function get preserveHTMLElement() : Boolean {
         return this._importHtmlElement;
      }
      
      public function set preserveHTMLElement(param1:Boolean) : void {
         this._importHtmlElement = param1;
      }
      
      override protected function importFromString(param1:String) : TextFlow {
         var _loc2_:TextFlow = null;
         var _loc3_:XML = this.toXML(param1);
         if(_loc3_)
         {
            _loc2_ = this.importFromXML(_loc3_);
            if(Configuration.playerEnablesArgoFeatures)
            {
               System["disposeXML"](_loc3_);
            }
         }
         return _loc2_;
      }
      
      override protected function importFromXML(param1:XML) : TextFlow {
         var _loc2_:TextFlow = new TextFlow(_textFlowConfiguration);
         if(this.preserveHTMLElement)
         {
            _loc2_.typeName = "html";
         }
         this._baseFontSize = _loc2_.fontSize === undefined?12:_loc2_.fontSize;
         this.parseObject(param1.name().localName,param1,_loc2_);
         resetImpliedPara();
         _loc2_.normalize();
         _loc2_.applyWhiteSpaceCollapse(null);
         return _loc2_;
      }
      
      override tlf_internal function clear() : void {
         _activeParaFormat.clearStyles();
         _activeFormat.clearStyles();
         super.clear();
      }
      
      override tlf_internal function createImpliedParagraph() : ParagraphElement {
         var rslt:ParagraphElement = null;
         var savedActiveFormat:TextLayoutFormat = _activeFormat;
         if(_activeImpliedParaFormat)
         {
            _activeFormat = _activeImpliedParaFormat;
         }
         rslt = super.createImpliedParagraph();
      }
      
      override public function createParagraphFromXML(param1:XML) : ParagraphElement {
         var _loc2_:ParagraphElement = new ParagraphElement();
         var _loc3_:Array = [_paragraphFormatImporter,_classAndIdImporter];
         parseAttributes(param1,_loc3_);
         var _loc4_:TextLayoutFormat = new TextLayoutFormat(_paragraphFormatImporter.result as ITextLayoutFormat);
         if(_activeParaFormat)
         {
            _loc4_.apply(_activeParaFormat);
         }
         if(_activeFormat)
         {
            _loc4_.apply(_activeFormat);
         }
         var _loc5_:XML = getSingleFontChild(param1);
         if(_loc5_)
         {
            _loc4_.apply(this.parseFontAttributes(_loc5_));
         }
         if(_loc4_.lineHeight !== undefined)
         {
            _loc4_.leadingModel = LeadingModel.APPROXIMATE_TEXT_FIELD;
         }
         _loc2_.format = _loc4_;
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      override public function createListFromXML(param1:XML) : ListElement {
         parseAttributes(param1,[_classAndIdImporter]);
         var _loc2_:ListElement = new ListElement();
         _loc2_.paddingLeft = 36;
         var _loc3_:String = param1?param1.name().localName:null;
         _loc2_.listStyleType = _loc3_ == "OL"?ListStyleType.DECIMAL:ListStyleType.DISC;
         var _loc4_:ListMarkerFormat = new ListMarkerFormat();
         _loc4_.paragraphEndIndent = 14;
         _loc2_.listMarkerFormat = _loc4_;
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      override public function createListItemFromXML(param1:XML) : ListItemElement {
         parseAttributes(param1,[_classAndIdImporter]);
         var _loc2_:ListItemElement = new ListItemElement();
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      public function createDivFromXML(param1:XML) : DivElement {
         parseAttributes(param1,[_classAndIdImporter]);
         var _loc2_:DivElement = new DivElement();
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      public function createSPGEFromXML(param1:XML) : SubParagraphGroupElement {
         parseAttributes(param1,[_classAndIdImporter]);
         var _loc2_:SubParagraphGroupElement = new SubParagraphGroupElement();
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      override protected function onResetImpliedPara(param1:ParagraphElement) : void {
         replaceBreakElementsWithParaSplits(param1);
      }
      
      private function createLinkFromXML(param1:XML) : LinkElement {
         var _loc2_:LinkElement = new LinkElement();
         var _loc3_:Array = [_linkHrefImporter,_linkTargetImporter,_classAndIdImporter];
         parseAttributes(param1,_loc3_);
         _loc2_.href = _linkHrefImporter.getFormatValue("HREF");
         _loc2_.target = _linkTargetImporter.getFormatValue("TARGET");
         if(!_loc2_.target)
         {
            _loc2_.target = "_self";
         }
         _loc2_.format = _activeFormat;
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         return _loc2_;
      }
      
      override public function createImpliedSpan(param1:String) : SpanElement {
         var _loc2_:SpanElement = super.createImpliedSpan(param1);
         _loc2_.format = _activeFormat;
         return _loc2_;
      }
      
      protected function createInlineGraphicFromXML(param1:XML) : InlineGraphicElement {
         var _loc2_:InlineGraphicElement = new InlineGraphicElement();
         var _loc3_:Array = [_ilgFormatImporter,_ilgMiscFormatImporter,_classAndIdImporter];
         parseAttributes(param1,_loc3_);
         var _loc4_:String = _ilgMiscFormatImporter.getFormatValue("SRC");
         _loc2_.source = this._imageSourceResolveFunction != null?this._imageSourceResolveFunction(_loc4_):_loc4_;
         _loc2_.height = InlineGraphicElement.heightPropertyDefinition.setHelper(_loc2_.height,_ilgFormatImporter.getFormatValue("HEIGHT"));
         _loc2_.width = InlineGraphicElement.heightPropertyDefinition.setHelper(_loc2_.width,_ilgFormatImporter.getFormatValue("WIDTH"));
         var _loc5_:String = _ilgMiscFormatImporter.getFormatValue("ALIGN");
         if(_loc5_ == Float.LEFT || _loc5_ == Float.RIGHT)
         {
            _loc2_.float = _loc5_;
         }
         _loc2_.format = _activeFormat;
         _loc2_.id = _classAndIdImporter.getFormatValue("ID");
         _loc2_.styleName = _classAndIdImporter.getFormatValue("CLASS");
         return _loc2_;
      }
      
      override public function createTabFromXML(param1:XML) : TabElement {
         return null;
      }
      
      protected function parseFontAttributes(param1:XML) : ITextLayoutFormat {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc2_:Array = [_fontImporter,_fontMiscImporter];
         parseAttributes(param1,_loc2_);
         var _loc3_:TextLayoutFormat = new TextLayoutFormat(_fontImporter.result as ITextLayoutFormat);
         var _loc4_:String = _fontMiscImporter.getFormatValue("KERNING");
         if(_loc4_)
         {
            _loc6_ = Number(_loc4_);
            _loc3_.kerning = _loc6_ == 0?Kerning.OFF:Kerning.AUTO;
         }
         var _loc5_:String = _fontMiscImporter.getFormatValue("SIZE");
         if(_loc5_)
         {
            _loc7_ = TextLayoutFormat.fontSizeProperty.setHelper(NaN,_loc5_);
            if(!isNaN(_loc7_))
            {
               if(_loc5_.search(new RegExp("\\s*(-|\\+)")) != -1)
               {
                  _loc7_ = _loc7_ + this._baseFontSize;
               }
               _loc3_.fontSize = _loc7_;
            }
         }
         return _loc3_;
      }
      
      override protected function handleUnknownAttribute(param1:String, param2:String) : void {
      }
      
      override protected function handleUnknownElement(param1:String, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:FlowGroupElement = null;
         var _loc8_:FlowElement = null;
         parseAttributes(param2,[_classAndIdImporter]);
         var _loc5_:* = _classAndIdImporter.getFormatValue("CLASS");
         var _loc6_:* = _classAndIdImporter.getFormatValue("ID");
         if(!(_loc5_ === undefined) || !(_loc6_ === undefined) || !TextLayoutFormat.isEqual(_activeFormat,TextLayoutFormat.emptyTextLayoutFormat) || param3 is ListElement)
         {
            _loc4_ = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase?new SubParagraphGroupElement():new DivElement();
            addChild(param3,_loc4_);
            _loc4_.format = _activeFormat;
            _loc4_.typeName = param1.toLowerCase();
            _loc4_.styleName = _loc5_;
            _loc4_.id = _loc6_;
            parseChildrenUnderNewActiveFormat(this,param2,_loc4_,_activeFormat,null);
            return;
         }
         var _loc7_:int = param3.numChildren;
         parseFlowGroupElementChildren(param2,param3,null,true);
         if(_loc7_ == param3.numChildren)
         {
            return;
         }
         if(_loc7_ + 1 == param3.numChildren)
         {
            _loc8_ = param3.getChildAt(_loc7_);
            if(_loc8_.id == null && _loc8_.styleName == null && _loc8_.typeName == _loc8_.defaultTypeName)
            {
               _loc8_.typeName = param1.toLowerCase();
               return;
            }
         }
         _loc4_ = param3 is ParagraphElement || param3 is SubParagraphGroupElementBase?new SubParagraphGroupElement():new DivElement();
         _loc4_.typeName = param1.toLowerCase();
         _loc4_.replaceChildren(0,0,param3.mxmlChildren.slice(_loc7_));
         addChild(param3,_loc4_);
      }
      
      override tlf_internal function parseObject(param1:String, param2:XML, param3:FlowGroupElement, param4:Object=null) : void {
         super.parseObject(param1.toUpperCase(),param2,param3,param4);
      }
      
      override protected function checkNamespace(param1:XML) : Boolean {
         return true;
      }
      
      protected function toXML(param1:String) : XML {
         var xml:XML = null;
         var source:String = param1;
         var originalSettings:Object = XML.settings();
         XML.ignoreProcessingInstructions = false;
         XML.ignoreWhitespace = false;
         xml = this.toXMLInternal(source);
      }
      
      protected function toXMLInternal(param1:String) : XML {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:* = false;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:* = false;
         var _loc12_:Object = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:XML = null;
         var param1:String = param1.replace(stripRegex,"");
         var _loc2_:XML = <HTML/>;
         var _loc3_:XML = _loc2_;
         var _loc4_:int = tagRegex.lastIndex = 0;
         do
         {
               _loc6_ = tagRegex.exec(param1);
               if(!_loc6_)
               {
                  this.appendTextChild(_loc3_,param1.substring(_loc4_));
                  break;
               }
               if(_loc6_.index != _loc4_)
               {
                  this.appendTextChild(_loc3_,param1.substring(_loc4_,_loc6_.index));
               }
               _loc7_ = _loc6_[0];
               _loc8_ = _loc6_[1] == "/";
               _loc9_ = _loc6_[2].toUpperCase();
               _loc10_ = _loc6_[3];
               _loc11_ = _loc6_[4] == "/";
               if(!_loc8_)
               {
                  if(_loc9_ == "P" && _loc3_.name().localName == "P")
                  {
                     _loc3_ = _loc3_.parent();
                  }
                  _loc7_ = "<" + _loc9_;
                  while(true)
                  {
                     _loc12_ = attrRegex.exec(_loc10_);
                     if(!_loc12_)
                     {
                        break;
                     }
                     _loc13_ = _loc12_[1].toUpperCase();
                     _loc7_ = _loc7_ + (" " + _loc13_ + "=");
                     _loc14_ = _loc12_[2]?_loc12_[2]:_loc13_;
                     _loc15_ = _loc14_.charAt(0);
                     _loc7_ = _loc7_ + (_loc15_ == "\'" || _loc15_ == "\""?_loc14_:"\"" + _loc14_ + "\"");
                  }
                  _loc7_ = _loc7_ + "/>";
                  _loc3_.appendChild(new XML(_loc7_));
                  if(!_loc11_ && !this.doesStartTagCloseElement(_loc9_))
                  {
                     _loc3_ = _loc3_.children()[_loc3_.children().length()-1];
                  }
               }
               else
               {
                  if((_loc11_) || (_loc10_.length))
                  {
                     reportError(GlobalSettings.resourceStringFunction("malformedTag",[_loc7_]));
                  }
                  else
                  {
                     _loc16_ = _loc3_;
                     do
                     {
                           _loc5_ = _loc16_.name().localName;
                           _loc16_ = _loc16_.parent();
                           if(_loc5_ == _loc9_)
                           {
                              _loc3_ = _loc16_;
                              break;
                           }
                        }while(_loc16_);
                        
                     }
                  }
                  _loc4_ = tagRegex.lastIndex;
                  if(_loc4_ == param1.length)
                  {
                     break;
                  }
               }while(_loc3_);
               
               return _loc2_;
            }
            
            protected function doesStartTagCloseElement(param1:String) : Boolean {
               switch(param1)
               {
                  case "BR":
                  case "IMG":
                     return true;
                  default:
                     return false;
               }
            }
            
            protected function appendTextChild(param1:XML, param2:String) : void {
               var xml:XML = null;
               var parent:XML = param1;
               var text:String = param2;
               var parentIsSpan:Boolean = parent.localName() == "SPAN";
               var elemName:String = parentIsSpan?"DUMMY":"SPAN";
               var xmlText:String = "<" + elemName + ">" + text + "</" + elemName + ">";
               try
               {
                  xml = new XML(xmlText);
                  parent.appendChild(parentIsSpan?xml.children()[0]:xml);
               }
               catch(e:*)
               {
                  reportError(GlobalSettings.resourceStringFunction("malformedMarkup",[text]));
               }
            }
         }
      }
      import flashx.textLayout.conversion.TLFormatImporter;
      
      class CaseInsensitiveTLFFormatImporter extends TLFormatImporter
      {
         
         function CaseInsensitiveTLFFormatImporter(param1:Class, param2:Object, param3:Boolean=true) {
            var _loc5_:Object = null;
            this._convertValuesToLowerCase = param3;
            var _loc4_:Object = new Object();
            for (_loc5_ in param2)
            {
               _loc4_[_loc5_.toUpperCase()] = param2[_loc5_];
            }
            super(param1,_loc4_);
         }
         
         private var _convertValuesToLowerCase:Boolean;
         
         override public function importOneFormat(param1:String, param2:String) : Boolean {
            return super.importOneFormat(param1.toUpperCase(),this._convertValuesToLowerCase?param2.toLowerCase():param2);
         }
         
         public function getFormatValue(param1:String) : * {
            return result?result[param1.toUpperCase()]:undefined;
         }
      }
      import flashx.textLayout.conversion.TLFormatImporter;
      
      class HtmlCustomParaFormatImporter extends TLFormatImporter
      {
         
         function HtmlCustomParaFormatImporter(param1:Class, param2:Object) {
            super(param1,param2);
         }
         
         override public function importOneFormat(param1:String, param2:String) : Boolean {
            var param1:String = param1.toUpperCase();
            if(param1 == "ALIGN")
            {
               param1 = "textAlign";
            }
            return super.importOneFormat(param1,param2.toLowerCase());
         }
      }
      import flashx.textLayout.conversion.TLFormatImporter;
      
      class TextFormatImporter extends TLFormatImporter
      {
         
         function TextFormatImporter(param1:Class, param2:Object) {
            super(param1,param2);
         }
         
         override public function importOneFormat(param1:String, param2:String) : Boolean {
            var param1:String = param1.toUpperCase();
            if(param1 == "LEFTMARGIN")
            {
               param1 = "paragraphStartIndent";
            }
            else
            {
               if(param1 == "RIGHTMARGIN")
               {
                  param1 = "paragraphEndIndent";
               }
               else
               {
                  if(param1 == "INDENT")
                  {
                     param1 = "textIndent";
                  }
                  else
                  {
                     if(param1 == "LEADING")
                     {
                        param1 = "lineHeight";
                     }
                     else
                     {
                        if(param1 == "TABSTOPS")
                        {
                           param1 = "tabStops";
                           param2 = param2.replace(new RegExp(",","g")," ");
                        }
                     }
                  }
               }
            }
            return super.importOneFormat(param1,param2);
         }
      }
      import flashx.textLayout.conversion.TLFormatImporter;
      
      class FontImporter extends TLFormatImporter
      {
         
         function FontImporter(param1:Class, param2:Object) {
            super(param1,param2);
         }
         
         override public function importOneFormat(param1:String, param2:String) : Boolean {
            var param1:String = param1.toUpperCase();
            if(param1 == "LETTERSPACING")
            {
               param1 = "trackingRight";
            }
            else
            {
               if(param1 == "FACE")
               {
                  param1 = "fontFamily";
               }
               else
               {
                  if(param1 == "COLOR")
                  {
                     param1 = "color";
                  }
               }
            }
            return super.importOneFormat(param1,param2);
         }
      }
