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

      tlf_internal  static const _fontDescription:Object = {
                                                                 color:TextLayoutFormat.colorProperty,
                                                                 trackingRight:TextLayoutFormat.trackingRightProperty,
                                                                 fontFamily:TextLayoutFormat.fontFamilyProperty
                                                                 };

      tlf_internal  static const _fontMiscDescription:Object = {
                                                                     size:Property.NewStringProperty("size",null,false,null),
                                                                     kerning:Property.NewStringProperty("kerning",null,false,null)
                                                                     };

      tlf_internal  static const _textFormatDescription:Object = {
                                                                       paragraphStartIndent:TextLayoutFormat.paragraphStartIndentProperty,
                                                                       paragraphEndIndent:TextLayoutFormat.paragraphEndIndentProperty,
                                                                       textIndent:TextLayoutFormat.textIndentProperty,
                                                                       lineHeight:TextLayoutFormat.lineHeightProperty,
                                                                       tabStops:TextLayoutFormat.tabStopsProperty
                                                                       };

      tlf_internal  static const _textFormatMiscDescription:Object = {blockIndent:Property.NewStringProperty("blockIndent",null,false,null)};

      tlf_internal  static const _paragraphFormatDescription:Object = {textAlign:TextLayoutFormat.textAlignProperty};

      tlf_internal  static const _linkHrefDescription:Object = {href:Property.NewStringProperty("href",null,false,null)};

      tlf_internal  static const _linkTargetDescription:Object = {target:Property.NewStringProperty("target",null,false,null)};

      tlf_internal  static const _imageDescription:Object = {
                                                                  height:InlineGraphicElement.heightPropertyDefinition,
                                                                  width:InlineGraphicElement.widthPropertyDefinition
                                                                  };

      tlf_internal  static const _imageMiscDescription:Object = {
                                                                      src:Property.NewStringProperty("src",null,false,null),
                                                                      align:Property.NewStringProperty("align",null,false,null)
                                                                      };

      tlf_internal  static const _classAndIdDescription:Object = {id:Property.NewStringProperty("ID",null,false,null)};

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
            _htmlImporterConfig=new ImportExportConfiguration();
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
         if(_classAndIdDescription["CLASS"]===undefined)
         {
            _classAndIdDescription["CLASS"]=Property.NewStringProperty("CLASS",null,false,null);
            _paragraphFormatImporter=new HtmlCustomParaFormatImporter(TextLayoutFormat,_paragraphFormatDescription);
            _textFormatImporter=new TextFormatImporter(TextLayoutFormat,_textFormatDescription);
            _fontImporter=new FontImporter(TextLayoutFormat,_fontDescription);
            _fontMiscImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_fontMiscDescription);
            _textFormatMiscImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_textFormatMiscDescription);
            _linkHrefImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_linkHrefDescription,false);
            _linkTargetImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_linkTargetDescription);
            _ilgFormatImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_imageDescription);
            _ilgMiscFormatImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_imageMiscDescription,false);
            _classAndIdImporter=new CaseInsensitiveTLFFormatImporter(Dictionary,_classAndIdDescription);
         }
      }

      public static function parseListItem(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var list:ListElement = null;
         if(!(parent is ListElement))
         {
            list=importer.createListFromXML(null);
            importer.addChild(parent,list);
            parent=list;
         }
         var listItem:ListItemElement = importer.createListItemFromXML(xmlToParse);
         if(importer.addChild(parent,listItem))
         {
            importer.parseFlowGroupElementChildren(xmlToParse,listItem);
            if(listItem.numChildren==0)
            {
               listItem.addChild(new ParagraphElement());
            }
         }
      }

      public static function parsePara(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var fontFormattingElement:XML = null;
         var paraElem:ParagraphElement = importer.createParagraphFromXML(xmlToParse);
         if(importer.addChild(parent,paraElem))
         {
            fontFormattingElement=getSingleFontChild(xmlToParse);
            parseChildrenUnderNewActiveFormat(importer,fontFormattingElement?fontFormattingElement:xmlToParse,paraElem,_activeFormat,null);
            if(paraElem.numChildren==0)
            {
               paraElem.addChild(importer.createImpliedSpan(""));
            }
         }
         replaceBreakElementsWithParaSplits(paraElem);
      }

      public static function parseDiv(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var elem:FlowGroupElement = null;
         if(parent.canOwnFlowElement(new DivElement()))
         {
            elem=importer.createDivFromXML(xmlToParse);
         }
         else
         {
            elem=importer.createSPGEFromXML(xmlToParse);
            elem.typeName="div";
         }
         importer.addChild(parent,elem);
         importer.parseFlowGroupElementChildren(xmlToParse,elem);
      }

      public static function parseHtmlElement(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newParent:FlowGroupElement = null;
         if(importer.preserveHTMLElement)
         {
            if(!(parent is TextFlow))
            {
               newParent=(parent is ParagraphElement)||(parent is SubParagraphGroupElementBase)?new SubParagraphGroupElement():new DivElement();
               parent.addChild(newParent);
               parent=newParent;
            }
            importer.parseAttributes(xmlToParse,[_classAndIdImporter]);
            parent.typeName="html";
            parent.styleName=_classAndIdImporter.getFormatValue("CLASS");
            parent.id=_classAndIdImporter.getFormatValue("ID");
         }
         importer.parseFlowGroupElementChildren(xmlToParse,parent,null,true);
      }

      public static function parseBody(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newParent:FlowGroupElement = null;
         if(importer.preserveBodyElement)
         {
            newParent=(parent is ParagraphElement)||(parent is SubParagraphGroupElementBase)?new SubParagraphGroupElement():new DivElement();
            parent.addChild(newParent);
            parent=newParent;
            importer.parseAttributes(xmlToParse,[_classAndIdImporter]);
            parent.typeName="body";
            parent.styleName=_classAndIdImporter.getFormatValue("CLASS");
            parent.id=_classAndIdImporter.getFormatValue("ID");
         }
         importer.parseFlowGroupElementChildren(xmlToParse,parent,null,true);
      }

      private static function getSingleFontChild(xmlToParse:XML) : XML {
         var child:XML = null;
         var children:XMLList = xmlToParse.children();
         if(children.length()==1)
         {
            child=children[0];
            if(child.name().localName.toUpperCase()=="FONT")
            {
               return child;
            }
         }
         return null;
      }

      public static function parseLink(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var linkElem:LinkElement = importer.createLinkFromXML(xmlToParse);
         if(importer.addChild(parent,linkElem))
         {
            parseChildrenUnderNewActiveFormat(importer,xmlToParse,linkElem,_activeFormat,null);
         }
      }

      tlf_internal  static function extractSimpleSpanText(xmlToParse:XML) : String {
         var child:XML = null;
         var elemName:String = null;
         var elemList:XMLList = xmlToParse[0].children();
         if(elemList.length()==0)
         {
            return "";
         }
         if(elemList.length()!=1)
         {
            return null;
         }
         if(!(elemList hasNext _loc6_))
         {
         }
         else
         {
            child=nextValue(_loc6_,_loc7_);
         }
         elemName=child.name()?child.name().localName:null;
         if(elemName!=null)
         {
            return null;
         }
         var rslt:String = child.toString();
         return rslt?rslt:"";
      }

      public static function parseSpan(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var spge:SubParagraphGroupElement = null;
         importer.parseAttributes(xmlToParse,[_classAndIdImporter]);
         var classFormatValue:* = _classAndIdImporter.getFormatValue("CLASS");
         var idFormatValue:* = _classAndIdImporter.getFormatValue("ID");
         var simpleSpanText:String = extractSimpleSpanText(xmlToParse);
         if(simpleSpanText==null)
         {
            if((!(classFormatValue===undefined))||(!(idFormatValue===undefined))||(!TextLayoutFormat.isEqual(_activeFormat,TextLayoutFormat.emptyTextLayoutFormat)))
            {
               spge=new SubParagraphGroupElement();
               spge.format=_activeFormat;
               spge.styleName=classFormatValue;
               spge.id=idFormatValue;
               spge.typeName="span";
               importer.addChild(parent,spge);
               parent=spge;
            }
            parseChildrenUnderNewActiveFormat(importer,xmlToParse,parent,_activeFormat,null);
            return;
         }
         var span:SpanElement = new SpanElement();
         span.format=_activeFormat;
         span.styleName=classFormatValue;
         span.id=idFormatValue;
         span.text=simpleSpanText;
         importer.addChild(parent,span);
      }

      public static function parseInlineGraphic(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var ilg:InlineGraphicElement = importer.createInlineGraphicFromXML(xmlToParse);
         importer.addChild(parent,ilg);
      }

      public static function parseFont(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newFormat:ITextLayoutFormat = importer.parseFontAttributes(xmlToParse);
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer,xmlToParse,parent,newFormat);
      }

      public static function parseTextFormat(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var blockIndentVal:* = NaN;
         var format:TextLayoutFormat = null;
         var formatImporters:Array = [_textFormatImporter,_textFormatMiscImporter];
         importer.parseAttributes(xmlToParse,formatImporters);
         var newFormat:TextLayoutFormat = new TextLayoutFormat(_textFormatImporter.result as ITextLayoutFormat);
         var blockIndent:* = _textFormatMiscImporter.getFormatValue("BLOCKINDENT");
         if(blockIndent!==undefined)
         {
            blockIndent=TextLayoutFormat.paragraphStartIndentProperty.setHelper(undefined,blockIndent);
            if(blockIndent!==undefined)
            {
               blockIndentVal=Number(blockIndent);
               newFormat.paragraphStartIndent=newFormat.paragraphStartIndent===undefined?blockIndentVal:newFormat.paragraphStartIndent+blockIndentVal;
            }
         }
         var saveLineHeight:* = _activeFormat.lineHeight;
         if(parent is ParagraphElement)
         {
            if(parent.numChildren==0)
            {
               format=new TextLayoutFormat(parent.format);
               format.apply(newFormat);
               if(format.lineHeight!==undefined)
               {
                  format.leadingModel=LeadingModel.APPROXIMATE_TEXT_FIELD;
               }
               parent.format=format;
               newFormat.clearStyles();
            }
            else
            {
               if(newFormat.lineHeight!==undefined)
               {
                  _activeFormat.lineHeight=newFormat.lineHeight;
               }
            }
         }
         parseChildrenUnderNewActiveFormat(importer,xmlToParse,parent,_activeParaFormat,newFormat,true);
         _activeFormat.lineHeight=saveLineHeight;
      }

      public static function parseBold(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newFormat:TextLayoutFormat = new TextLayoutFormat();
         newFormat.fontWeight=FontWeight.BOLD;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer,xmlToParse,parent,newFormat);
      }

      public static function parseItalic(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newFormat:TextLayoutFormat = new TextLayoutFormat();
         newFormat.fontStyle=FontPosture.ITALIC;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer,xmlToParse,parent,newFormat);
      }

      public static function parseStrikeThrough(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newFormat:TextLayoutFormat = new TextLayoutFormat();
         newFormat.lineThrough=true;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer,xmlToParse,parent,newFormat);
      }

      public static function parseUnderline(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newFormat:TextLayoutFormat = new TextLayoutFormat();
         newFormat.textDecoration=TextDecoration.UNDERLINE;
         parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer,xmlToParse,parent,newFormat);
      }

      protected static function parseChildrenUnderNewActiveFormatWithImpliedParaFormat(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement, newFormat:ITextLayoutFormat) : void {
         var oldActiveImpliedParaFormat:TextLayoutFormat = _activeImpliedParaFormat;
         if(_activeImpliedParaFormat==null)
         {
            _activeImpliedParaFormat=new TextLayoutFormat(_activeFormat);
         }
         parseChildrenUnderNewActiveFormat(importer,xmlToParse,parent,_activeFormat,newFormat,true);
         _activeImpliedParaFormat=oldActiveImpliedParaFormat;
      }

      protected static function parseChildrenUnderNewActiveFormat(importer:TextFieldHtmlImporter, xmlToParse:XML, parent:FlowGroupElement, currFormat:TextLayoutFormat, newFormat:ITextLayoutFormat, chainedParent:Boolean=false) : void {
         var beforeCount:int = 0;
         var span:SpanElement = null;
         var restoreBaseFontSize:Number = importer._baseFontSize;
         var restoreStyles:Object = Property.shallowCopy(currFormat.getStyles());
         if(newFormat)
         {
            if(newFormat.fontSize!==undefined)
            {
               importer._baseFontSize=newFormat.fontSize;
            }
            currFormat.apply(newFormat);
         }
         else
         {
            currFormat.clearStyles();
         }
         beforeCount=parent.numChildren;
         importer.parseFlowGroupElementChildren(xmlToParse,parent,null,chainedParent);
         if(beforeCount==parent.numChildren)
         {
            span=importer.createImpliedSpan("");
            importer.addChild(parent,span);
         }
         currFormat.setStyles(restoreStyles,false);
         importer._baseFontSize=restoreBaseFontSize;
      }

      protected static function replaceBreakElementsWithParaSplits(para:ParagraphElement) : void {
         var paraArray:Array = null;
         var paraIndex:* = 0;
         var paraParent:FlowGroupElement = null;
         var elem:FlowLeafElement = para.getFirstLeaf();
         while(elem)
         {
            if(!(elem is BreakElement))
            {
               elem=elem.getNextLeaf(para);
            }
            else
            {
               if(!paraArray)
               {
                  paraArray=[para];
                  paraParent=para.parent;
                  paraIndex=paraParent.getChildIndex(para);
                  paraParent.removeChildAt(paraIndex);
               }
               para=para.splitAtPosition(elem.getAbsoluteStart()+elem.textLength) as ParagraphElement;
               paraArray.push(para);
               elem.parent.removeChild(elem);
               elem=para.getFirstLeaf();
            }
         }
         if(paraArray)
         {
            paraParent.replaceChildren(paraIndex,paraIndex,paraArray);
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

      public function set imageSourceResolveFunction(resolver:Function) : void {
         this._imageSourceResolveFunction=resolver;
      }

      public function get preserveBodyElement() : Boolean {
         return this._preserveBodyElement;
      }

      public function set preserveBodyElement(value:Boolean) : void {
         this._preserveBodyElement=value;
      }

      public function get preserveHTMLElement() : Boolean {
         return this._importHtmlElement;
      }

      public function set preserveHTMLElement(value:Boolean) : void {
         this._importHtmlElement=value;
      }

      override protected function importFromString(source:String) : TextFlow {
         var textFlow:TextFlow = null;
         var xml:XML = this.toXML(source);
         if(xml)
         {
            textFlow=this.importFromXML(xml);
            if(Configuration.playerEnablesArgoFeatures)
            {
               System["disposeXML"](xml);
            }
         }
         return textFlow;
      }

      override protected function importFromXML(xmlSource:XML) : TextFlow {
         var textFlow:TextFlow = new TextFlow(_textFlowConfiguration);
         if(this.preserveHTMLElement)
         {
            textFlow.typeName="html";
         }
         this._baseFontSize=textFlow.fontSize===undefined?12:textFlow.fontSize;
         this.parseObject(xmlSource.name().localName,xmlSource,textFlow);
         resetImpliedPara();
         textFlow.normalize();
         textFlow.applyWhiteSpaceCollapse(null);
         return textFlow;
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
            _activeFormat=_activeImpliedParaFormat;
         }
         rslt=super.createImpliedParagraph();
         _activeFormat=savedActiveFormat;
      }

      override public function createParagraphFromXML(xmlToParse:XML) : ParagraphElement {
         var paraElem:ParagraphElement = new ParagraphElement();
         var formatImporters:Array = [_paragraphFormatImporter,_classAndIdImporter];
         parseAttributes(xmlToParse,formatImporters);
         var paragraphFormat:TextLayoutFormat = new TextLayoutFormat(_paragraphFormatImporter.result as ITextLayoutFormat);
         if(_activeParaFormat)
         {
            paragraphFormat.apply(_activeParaFormat);
         }
         if(_activeFormat)
         {
            paragraphFormat.apply(_activeFormat);
         }
         var fontFormattingElement:XML = getSingleFontChild(xmlToParse);
         if(fontFormattingElement)
         {
            paragraphFormat.apply(this.parseFontAttributes(fontFormattingElement));
         }
         if(paragraphFormat.lineHeight!==undefined)
         {
            paragraphFormat.leadingModel=LeadingModel.APPROXIMATE_TEXT_FIELD;
         }
         paraElem.format=paragraphFormat;
         paraElem.styleName=_classAndIdImporter.getFormatValue("CLASS");
         paraElem.id=_classAndIdImporter.getFormatValue("ID");
         return paraElem;
      }

      override public function createListFromXML(xmlToParse:XML) : ListElement {
         parseAttributes(xmlToParse,[_classAndIdImporter]);
         var list:ListElement = new ListElement();
         list.paddingLeft=36;
         var name:String = xmlToParse?xmlToParse.name().localName:null;
         list.listStyleType=name=="OL"?ListStyleType.DECIMAL:ListStyleType.DISC;
         var lmf:ListMarkerFormat = new ListMarkerFormat();
         lmf.paragraphEndIndent=14;
         list.listMarkerFormat=lmf;
         list.styleName=_classAndIdImporter.getFormatValue("CLASS");
         list.id=_classAndIdImporter.getFormatValue("ID");
         return list;
      }

      override public function createListItemFromXML(xmlToParse:XML) : ListItemElement {
         parseAttributes(xmlToParse,[_classAndIdImporter]);
         var listItem:ListItemElement = new ListItemElement();
         listItem.styleName=_classAndIdImporter.getFormatValue("CLASS");
         listItem.id=_classAndIdImporter.getFormatValue("ID");
         return listItem;
      }

      public function createDivFromXML(xmlToParse:XML) : DivElement {
         parseAttributes(xmlToParse,[_classAndIdImporter]);
         var divElement:DivElement = new DivElement();
         divElement.styleName=_classAndIdImporter.getFormatValue("CLASS");
         divElement.id=_classAndIdImporter.getFormatValue("ID");
         return divElement;
      }

      public function createSPGEFromXML(xmlToParse:XML) : SubParagraphGroupElement {
         parseAttributes(xmlToParse,[_classAndIdImporter]);
         var spge:SubParagraphGroupElement = new SubParagraphGroupElement();
         spge.styleName=_classAndIdImporter.getFormatValue("CLASS");
         spge.id=_classAndIdImporter.getFormatValue("ID");
         return spge;
      }

      override protected function onResetImpliedPara(para:ParagraphElement) : void {
         replaceBreakElementsWithParaSplits(para);
      }

      private function createLinkFromXML(xmlToParse:XML) : LinkElement {
         var linkElem:LinkElement = new LinkElement();
         var formatImporters:Array = [_linkHrefImporter,_linkTargetImporter,_classAndIdImporter];
         parseAttributes(xmlToParse,formatImporters);
         linkElem.href=_linkHrefImporter.getFormatValue("HREF");
         linkElem.target=_linkTargetImporter.getFormatValue("TARGET");
         if(!linkElem.target)
         {
            linkElem.target="_self";
         }
         linkElem.format=_activeFormat;
         linkElem.styleName=_classAndIdImporter.getFormatValue("CLASS");
         linkElem.id=_classAndIdImporter.getFormatValue("ID");
         return linkElem;
      }

      override public function createImpliedSpan(text:String) : SpanElement {
         var span:SpanElement = super.createImpliedSpan(text);
         span.format=_activeFormat;
         return span;
      }

      protected function createInlineGraphicFromXML(xmlToParse:XML) : InlineGraphicElement {
         var imgElem:InlineGraphicElement = new InlineGraphicElement();
         var formatImporters:Array = [_ilgFormatImporter,_ilgMiscFormatImporter,_classAndIdImporter];
         parseAttributes(xmlToParse,formatImporters);
         var source:String = _ilgMiscFormatImporter.getFormatValue("SRC");
         imgElem.source=!(this._imageSourceResolveFunction==null)?this._imageSourceResolveFunction(source):source;
         imgElem.height=InlineGraphicElement.heightPropertyDefinition.setHelper(imgElem.height,_ilgFormatImporter.getFormatValue("HEIGHT"));
         imgElem.width=InlineGraphicElement.heightPropertyDefinition.setHelper(imgElem.width,_ilgFormatImporter.getFormatValue("WIDTH"));
         var floatVal:String = _ilgMiscFormatImporter.getFormatValue("ALIGN");
         if((floatVal==Float.LEFT)||(floatVal==Float.RIGHT))
         {
            imgElem.float=floatVal;
         }
         imgElem.format=_activeFormat;
         imgElem.id=_classAndIdImporter.getFormatValue("ID");
         imgElem.styleName=_classAndIdImporter.getFormatValue("CLASS");
         return imgElem;
      }

      override public function createTabFromXML(xmlToParse:XML) : TabElement {
         return null;
      }

      protected function parseFontAttributes(xmlToParse:XML) : ITextLayoutFormat {
         var kerningVal:* = NaN;
         var sizeVal:* = NaN;
         var formatImporters:Array = [_fontImporter,_fontMiscImporter];
         parseAttributes(xmlToParse,formatImporters);
         var newFormat:TextLayoutFormat = new TextLayoutFormat(_fontImporter.result as ITextLayoutFormat);
         var kerning:String = _fontMiscImporter.getFormatValue("KERNING");
         if(kerning)
         {
            kerningVal=Number(kerning);
            newFormat.kerning=kerningVal==0?Kerning.OFF:Kerning.AUTO;
         }
         var size:String = _fontMiscImporter.getFormatValue("SIZE");
         if(size)
         {
            sizeVal=TextLayoutFormat.fontSizeProperty.setHelper(NaN,size);
            if(!isNaN(sizeVal))
            {
               if(size.search(new RegExp("\\s*(-|\\+)"))!=-1)
               {
                  sizeVal=sizeVal+this._baseFontSize;
               }
               newFormat.fontSize=sizeVal;
            }
         }
         return newFormat;
      }

      override protected function handleUnknownAttribute(elementName:String, propertyName:String) : void {
         
      }

      override protected function handleUnknownElement(name:String, xmlToParse:XML, parent:FlowGroupElement) : void {
         var newParent:FlowGroupElement = null;
         var addedChild:FlowElement = null;
         parseAttributes(xmlToParse,[_classAndIdImporter]);
         var classFormatValue:* = _classAndIdImporter.getFormatValue("CLASS");
         var idFormatValue:* = _classAndIdImporter.getFormatValue("ID");
         if((!(classFormatValue===undefined))||(!(idFormatValue===undefined))||(!TextLayoutFormat.isEqual(_activeFormat,TextLayoutFormat.emptyTextLayoutFormat))||(parent is ListElement))
         {
            newParent=(parent is ParagraphElement)||(parent is SubParagraphGroupElementBase)?new SubParagraphGroupElement():new DivElement();
            addChild(parent,newParent);
            newParent.format=_activeFormat;
            newParent.typeName=name.toLowerCase();
            newParent.styleName=classFormatValue;
            newParent.id=idFormatValue;
            parseChildrenUnderNewActiveFormat(this,xmlToParse,newParent,_activeFormat,null);
            return;
         }
         var befNumChildren:int = parent.numChildren;
         parseFlowGroupElementChildren(xmlToParse,parent,null,true);
         if(befNumChildren==parent.numChildren)
         {
            return;
         }
         if(befNumChildren+1==parent.numChildren)
         {
            addedChild=parent.getChildAt(befNumChildren);
            if((addedChild.id==null)&&(addedChild.styleName==null)&&(addedChild.typeName==addedChild.defaultTypeName))
            {
               addedChild.typeName=name.toLowerCase();
               return;
            }
         }
         newParent=(parent is ParagraphElement)||(parent is SubParagraphGroupElementBase)?new SubParagraphGroupElement():new DivElement();
         newParent.typeName=name.toLowerCase();
         newParent.replaceChildren(0,0,parent.mxmlChildren.slice(befNumChildren));
         addChild(parent,newParent);
      }

      override tlf_internal function parseObject(name:String, xmlToParse:XML, parent:FlowGroupElement, exceptionElements:Object=null) : void {
         super.parseObject(name.toUpperCase(),xmlToParse,parent,exceptionElements);
      }

      override protected function checkNamespace(xmlToParse:XML) : Boolean {
         return true;
      }

      protected function toXML(source:String) : XML {
         var xml:XML = null;
         var originalSettings:Object = XML.settings();
         XML.ignoreProcessingInstructions=false;
         XML.ignoreWhitespace=false;
         xml=this.toXMLInternal(source);
         XML.setSettings(originalSettings);
      }

      protected function toXMLInternal(source:String) : XML {
         var openElemName:String = null;
         var result:Object = null;
         var tag:String = null;
         var hasStartModifier:* = false;
         var name:String = null;
         var attrs:String = null;
         var hasEndModifier:* = false;
         var innerResult:Object = null;
         var attrName:String = null;
         var val:String = null;
         var startChar:String = null;
         var openElem:XML = null;
         var source:String = source.replace(stripRegex,"");
         var root:XML = <HTML/>;
         var currElem:XML = root;
         var lastIndex:int = tagRegex.lastIndex=0;
         do
         {
            result=tagRegex.exec(source);
            if(!result)
            {
               this.appendTextChild(currElem,source.substring(lastIndex));
            }
            else
            {
               if(result.index!=lastIndex)
               {
                  this.appendTextChild(currElem,source.substring(lastIndex,result.index));
               }
               tag=result[0];
               hasStartModifier=result[1]=="/";
               name=result[2].toUpperCase();
               attrs=result[3];
               hasEndModifier=result[4]=="/";
               if(!hasStartModifier)
               {
                  if((name=="P")&&(currElem.name().localName=="P"))
                  {
                     currElem=currElem.parent();
                  }
                  tag="<"+name;
                  do
                  {
                     innerResult=attrRegex.exec(attrs);
                     if(!innerResult)
                     {
                        tag=tag+"/>";
                        currElem.appendChild(new XML(tag));
                        if((!hasEndModifier)&&(!this.doesStartTagCloseElement(name)))
                        {
                           currElem=currElem.children()[currElem.children().length()-1];
                        }
                     }
                     else
                     {
                        attrName=innerResult[1].toUpperCase();
                        tag=tag+(" "+attrName+"=");
                        val=innerResult[2]?innerResult[2]:attrName;
                        startChar=val.charAt(0);
                        tag=tag+((startChar=="\'")||(startChar=="\"")?val:"\""+val+"\"");
                        continue;
                     }
                  }
                  while(true);
               }
               else
               {
                  if((hasEndModifier)||(attrs.length))
                  {
                     reportError(GlobalSettings.resourceStringFunction("malformedTag",[tag]));
                  }
                  else
                  {
                     openElem=currElem;
                     do
                     {
                        openElemName=openElem.name().localName;
                        openElem=openElem.parent();
                        if(openElemName==name)
                        {
                           currElem=openElem;
                        }
                        else
                        {
                           if(!openElem)
                           {
                           }
                           else
                           {
                              continue;
                           }
                        }
                     }
                     while(true);
                  }
               }
               lastIndex=tagRegex.lastIndex;
               if(lastIndex==source.length)
               {
               }
               else
               {
                  if(!(currElem))
                  {
                  }
                  else
                  {
                     continue;
                  }
               }
            }
            return root;
         }
         while(true);
      }

      protected function doesStartTagCloseElement(tagName:String) : Boolean {
         switch(tagName)
         {
            case "BR":
            case "IMG":
               return true;
            default:
               return false;
         }
      }

      protected function appendTextChild(parent:XML, text:String) : void {
         var xml:XML = null;
         var parentIsSpan:Boolean = parent.localName()=="SPAN";
         var elemName:String = parentIsSpan?"DUMMY":"SPAN";
         var xmlText:String = "<"+elemName+">"+text+"</"+elemName+">";
         try
         {
            xml=new XML(xmlText);
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
         

      function CaseInsensitiveTLFFormatImporter(classType:Class, description:Object, convertValuesToLowerCase:Boolean=true) {
         var prop:Object = null;
         this._convertValuesToLowerCase=convertValuesToLowerCase;
         var lowerCaseDescription:Object = new Object();
         for (prop in description)
         {
            lowerCaseDescription[prop.toUpperCase()]=description[prop];
         }
         super(classType,lowerCaseDescription);
      }



      private var _convertValuesToLowerCase:Boolean;

      override public function importOneFormat(key:String, val:String) : Boolean {
         return super.importOneFormat(key.toUpperCase(),this._convertValuesToLowerCase?val.toLowerCase():val);
      }

      public function getFormatValue(key:String) : * {
         return result?result[key.toUpperCase()]:undefined;
      }
   }


   import flashx.textLayout.conversion.TLFormatImporter;


   class HtmlCustomParaFormatImporter extends TLFormatImporter
   {
         

      function HtmlCustomParaFormatImporter(classType:Class, description:Object) {
         super(classType,description);
      }



      override public function importOneFormat(key:String, val:String) : Boolean {
         var key:String = key.toUpperCase();
         if(key=="ALIGN")
         {
            key="textAlign";
         }
         return super.importOneFormat(key,val.toLowerCase());
      }
   }


   import flashx.textLayout.conversion.TLFormatImporter;


   class TextFormatImporter extends TLFormatImporter
   {
         

      function TextFormatImporter(classType:Class, description:Object) {
         super(classType,description);
      }



      override public function importOneFormat(key:String, val:String) : Boolean {
         var key:String = key.toUpperCase();
         if(key=="LEFTMARGIN")
         {
            key="paragraphStartIndent";
         }
         else
         {
            if(key=="RIGHTMARGIN")
            {
               key="paragraphEndIndent";
            }
            else
            {
               if(key=="INDENT")
               {
                  key="textIndent";
               }
               else
               {
                  if(key=="LEADING")
                  {
                     key="lineHeight";
                  }
                  else
                  {
                     if(key=="TABSTOPS")
                     {
                        key="tabStops";
                        val=val.replace(new RegExp(",","g")," ");
                     }
                  }
               }
            }
         }
         return super.importOneFormat(key,val);
      }
   }


   import flashx.textLayout.conversion.TLFormatImporter;


   class FontImporter extends TLFormatImporter
   {
         

      function FontImporter(classType:Class, description:Object) {
         super(classType,description);
      }



      override public function importOneFormat(key:String, val:String) : Boolean {
         var key:String = key.toUpperCase();
         if(key=="LETTERSPACING")
         {
            key="trackingRight";
         }
         else
         {
            if(key=="FACE")
            {
               key="fontFamily";
            }
            else
            {
               if(key=="COLOR")
               {
                  key="color";
               }
            }
         }
         return super.importOneFormat(key,val);
      }
   }
