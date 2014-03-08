package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.BreakElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TabElement;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.elements.ListItemElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.FlowGroupElement;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flash.utils.Dictionary;
   import flashx.textLayout.elements.GlobalSettings;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.TextLayoutVersion;
   
   use namespace tlf_internal;
   
   public class TextLayoutImporter extends BaseTextLayoutImporter implements ITextLayoutImporter
   {
      
      public function TextLayoutImporter() {
         super(new Namespace("flow","http://ns.adobe.com/textLayout/2008"),defaultConfiguration);
      }
      
      private static var _defaultConfiguration:ImportExportConfiguration;
      
      public static function get defaultConfiguration() : ImportExportConfiguration {
         if(!_defaultConfiguration)
         {
            _defaultConfiguration = new ImportExportConfiguration();
            _defaultConfiguration.addIEInfo("TextFlow",TextFlow,BaseTextLayoutImporter.parseTextFlow,BaseTextLayoutExporter.exportTextFlow);
            _defaultConfiguration.addIEInfo("br",BreakElement,BaseTextLayoutImporter.parseBreak,BaseTextLayoutExporter.exportFlowElement);
            _defaultConfiguration.addIEInfo("p",ParagraphElement,BaseTextLayoutImporter.parsePara,BaseTextLayoutExporter.exportParagraphFormattedElement);
            _defaultConfiguration.addIEInfo("span",SpanElement,BaseTextLayoutImporter.parseSpan,BaseTextLayoutExporter.exportSpan);
            _defaultConfiguration.addIEInfo("tab",TabElement,BaseTextLayoutImporter.parseTab,BaseTextLayoutExporter.exportFlowElement);
            _defaultConfiguration.addIEInfo("list",ListElement,BaseTextLayoutImporter.parseList,BaseTextLayoutExporter.exportList);
            _defaultConfiguration.addIEInfo("li",ListItemElement,BaseTextLayoutImporter.parseListItem,BaseTextLayoutExporter.exportListItem);
            _defaultConfiguration.addIEInfo("g",SubParagraphGroupElement,TextLayoutImporter.parseSPGE,TextLayoutExporter.exportSPGE);
            _defaultConfiguration.addIEInfo("tcy",TCYElement,TextLayoutImporter.parseTCY,TextLayoutExporter.exportTCY);
            _defaultConfiguration.addIEInfo("a",LinkElement,TextLayoutImporter.parseLink,TextLayoutExporter.exportLink);
            _defaultConfiguration.addIEInfo("div",DivElement,TextLayoutImporter.parseDivElement,TextLayoutExporter.exportDiv);
            _defaultConfiguration.addIEInfo("img",InlineGraphicElement,TextLayoutImporter.parseInlineGraphic,TextLayoutExporter.exportImage);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_NORMAL_FORMAT_NAME,null,TextLayoutImporter.parseLinkNormalFormat,null);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_ACTIVE_FORMAT_NAME,null,TextLayoutImporter.parseLinkActiveFormat,null);
            _defaultConfiguration.addIEInfo(LinkElement.LINK_HOVER_FORMAT_NAME,null,TextLayoutImporter.parseLinkHoverFormat,null);
            _defaultConfiguration.addIEInfo(ListElement.LIST_MARKER_FORMAT_NAME,null,TextLayoutImporter.parseListMarkerFormat,null);
         }
         return _defaultConfiguration;
      }
      
      public static function restoreDefaults() : void {
         _defaultConfiguration = null;
      }
      
      private static const _formatImporter:TLFormatImporter = new TLFormatImporter(TextLayoutFormat,TextLayoutFormat.description);
      
      private static const _idImporter:SingletonAttributeImporter = new SingletonAttributeImporter("id");
      
      private static const _typeNameImporter:SingletonAttributeImporter = new SingletonAttributeImporter("typeName");
      
      private static const _customFormatImporter:CustomFormatImporter = new CustomFormatImporter();
      
      private static const _flowElementFormatImporters:Array = [_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
      
      static const _linkDescription:Object = 
         {
            "href":Property.NewStringProperty("href",null,false,null),
            "target":Property.NewStringProperty("target",null,false,null)
         };
      
      private static const _linkFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary,_linkDescription);
      
      private static const _linkElementFormatImporters:Array = [_linkFormatImporter,_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
      
      private static const _imageDescription:Object = 
         {
            "height":InlineGraphicElement.heightPropertyDefinition,
            "width":InlineGraphicElement.widthPropertyDefinition,
            "source":Property.NewStringProperty("source",null,false,null),
            "float":Property.NewStringProperty("float",null,false,null),
            "rotation":InlineGraphicElement.rotationPropertyDefinition
         };
      
      private static const _ilgFormatImporter:TLFormatImporter = new TLFormatImporter(Dictionary,_imageDescription);
      
      private static const _ilgElementFormatImporters:Array = [_ilgFormatImporter,_formatImporter,_idImporter,_typeNameImporter,_customFormatImporter];
      
      public static function parseSPGE(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:SubParagraphGroupElement = TextLayoutImporter(param1).createSubParagraphGroupFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            param1.parseFlowGroupElementChildren(param2,_loc4_);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseTCY(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:TCYElement = TextLayoutImporter(param1).createTCYFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            param1.parseFlowGroupElementChildren(param2,_loc4_);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseLink(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:LinkElement = TextLayoutImporter(param1).createLinkFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            param1.parseFlowGroupElementChildren(param2,_loc4_);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(new SpanElement());
            }
         }
      }
      
      public static function parseLinkNormalFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         param3.linkNormalFormat = TextLayoutImporter(param1).createDictionaryFromXML(param2);
      }
      
      public static function parseLinkActiveFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         param3.linkActiveFormat = TextLayoutImporter(param1).createDictionaryFromXML(param2);
      }
      
      public static function parseLinkHoverFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         param3.linkHoverFormat = TextLayoutImporter(param1).createDictionaryFromXML(param2);
      }
      
      public static function parseListMarkerFormat(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         param3.listMarkerFormat = TextLayoutImporter(param1).createListMarkerFormatDictionaryFromXML(param2);
      }
      
      public static function parseDivElement(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:DivElement = TextLayoutImporter(param1).createDivFromXML(param2);
         if(param1.addChild(param3,_loc4_))
         {
            param1.parseFlowGroupElementChildren(param2,_loc4_);
            if(_loc4_.numChildren == 0)
            {
               _loc4_.addChild(new ParagraphElement());
            }
         }
      }
      
      public static function parseInlineGraphic(param1:BaseTextLayoutImporter, param2:XML, param3:FlowGroupElement) : void {
         var _loc4_:InlineGraphicElement = TextLayoutImporter(param1).createInlineGraphicFromXML(param2);
         param1.addChild(param3,_loc4_);
      }
      
      private var _imageSourceResolveFunction:Function;
      
      public function get imageSourceResolveFunction() : Function {
         return this._imageSourceResolveFunction;
      }
      
      public function set imageSourceResolveFunction(param1:Function) : void {
         this._imageSourceResolveFunction = param1;
      }
      
      override protected function parseContent(param1:XML) : TextFlow {
         var _loc2_:String = param1.name().localName;
         var _loc3_:XML = _loc2_ == "TextFlow"?param1:param1..TextFlow[0];
         if(!_loc3_)
         {
            reportError(GlobalSettings.resourceStringFunction("missingTextFlow"));
            return null;
         }
         if(!checkNamespace(_loc3_))
         {
            return null;
         }
         return parseTextFlow(this,_loc3_);
      }
      
      private function parseStandardFlowElementAttributes(param1:FlowElement, param2:XML, param3:Array=null) : void {
         var _loc5_:String = null;
         if(param3 == null)
         {
            param3 = _flowElementFormatImporters;
         }
         parseAttributes(param2,param3);
         var _loc4_:TextLayoutFormat = this.extractTextFormatAttributesHelper(param1.format,_formatImporter) as TextLayoutFormat;
         if(_loc4_)
         {
            param1.format = _loc4_;
         }
         if(_idImporter.result)
         {
            param1.id = _idImporter.result as String;
         }
         if(_typeNameImporter.result)
         {
            param1.typeName = _typeNameImporter.result as String;
         }
         if(_customFormatImporter.result)
         {
            for (_loc5_ in _customFormatImporter.result)
            {
               param1.setStyle(_loc5_,_customFormatImporter.result[_loc5_]);
            }
         }
      }
      
      override public function createTextFlowFromXML(param1:XML, param2:TextFlow=null) : TextFlow {
         var _loc4_:String = null;
         var _loc3_:TextFlow = null;
         if(!checkNamespace(param1))
         {
            return _loc3_;
         }
         if(param1.hasOwnProperty("@version"))
         {
            _loc4_ = param1["version"];
            if(_loc4_ == "2.0.0")
            {
               _importVersion = TextLayoutVersion.VERSION_2_0;
            }
            else
            {
               if(_loc4_ == "1.1.0" || _loc4_ == "1.0.0")
               {
                  _importVersion = TextLayoutVersion.VERSION_1_0;
               }
               else
               {
                  reportError(GlobalSettings.resourceStringFunction("unsupportedVersion",[param1["version"]]));
                  _importVersion = TextLayoutVersion.CURRENT_VERSION;
               }
            }
         }
         else
         {
            _importVersion = TextLayoutVersion.VERSION_1_0;
         }
         if(!_loc3_)
         {
            _loc3_ = new TextFlow(_textFlowConfiguration);
         }
         this.parseStandardFlowElementAttributes(_loc3_,param1);
         parseFlowGroupElementChildren(param1,_loc3_);
         _loc3_.normalize();
         _loc3_.applyWhiteSpaceCollapse(null);
         return _loc3_;
      }
      
      public function createDivFromXML(param1:XML) : DivElement {
         var _loc2_:DivElement = new DivElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      override public function createParagraphFromXML(param1:XML) : ParagraphElement {
         var _loc2_:ParagraphElement = new ParagraphElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      public function createSubParagraphGroupFromXML(param1:XML) : SubParagraphGroupElement {
         var _loc2_:SubParagraphGroupElement = new SubParagraphGroupElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      public function createTCYFromXML(param1:XML) : TCYElement {
         var _loc2_:TCYElement = new TCYElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      public function createLinkFromXML(param1:XML) : LinkElement {
         var _loc2_:LinkElement = new LinkElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1,_linkElementFormatImporters);
         if(_linkFormatImporter.result)
         {
            _loc2_.href = _linkFormatImporter.result["href"] as String;
            _loc2_.target = _linkFormatImporter.result["target"] as String;
         }
         return _loc2_;
      }
      
      override public function createSpanFromXML(param1:XML) : SpanElement {
         var _loc2_:SpanElement = new SpanElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      public function createInlineGraphicFromXML(param1:XML) : InlineGraphicElement {
         var _loc3_:String = null;
         var _loc2_:InlineGraphicElement = new InlineGraphicElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1,_ilgElementFormatImporters);
         if(_ilgFormatImporter.result)
         {
            _loc3_ = _ilgFormatImporter.result["source"];
            _loc2_.source = this._imageSourceResolveFunction != null?this._imageSourceResolveFunction(_loc3_):_loc3_;
            _loc2_.height = _ilgFormatImporter.result["height"];
            _loc2_.width = _ilgFormatImporter.result["width"];
            _loc2_.float = _ilgFormatImporter.result["float"];
         }
         return _loc2_;
      }
      
      override public function createListFromXML(param1:XML) : ListElement {
         var _loc2_:ListElement = new ListElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      override public function createListItemFromXML(param1:XML) : ListItemElement {
         var _loc2_:ListItemElement = new ListItemElement();
         this.parseStandardFlowElementAttributes(_loc2_,param1);
         return _loc2_;
      }
      
      public function extractTextFormatAttributesHelper(param1:Object, param2:TLFormatImporter) : Object {
         return extractAttributesHelper(param1,param2);
      }
      
      public function createDictionaryFromXML(param1:XML) : Dictionary {
         var _loc2_:Array = [_customFormatImporter];
         var _loc3_:XMLList = param1..TextLayoutFormat;
         if(_loc3_.length() != 1)
         {
            reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneTextLayoutFormat",[param1.name()]));
         }
         var _loc4_:XML = _loc3_.length() > 0?_loc3_[0]:param1;
         parseAttributes(_loc4_,_loc2_);
         return _customFormatImporter.result as Dictionary;
      }
      
      public function createListMarkerFormatDictionaryFromXML(param1:XML) : Dictionary {
         var _loc2_:Array = [_customFormatImporter];
         var _loc3_:XMLList = param1..ListMarkerFormat;
         if(_loc3_.length() != 1)
         {
            reportError(GlobalSettings.resourceStringFunction("expectedExactlyOneListMarkerFormat",[param1.name()]));
         }
         var _loc4_:XML = _loc3_.length() > 0?_loc3_[0]:param1;
         parseAttributes(_loc4_,_loc2_);
         return _customFormatImporter.result as Dictionary;
      }
   }
}
