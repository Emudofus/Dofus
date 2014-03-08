package flashx.textLayout.conversion
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.*;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.TabStopFormat;
   import flashx.textLayout.formats.Direction;
   import flashx.textLayout.formats.TextAlign;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flash.text.engine.TabAlignment;
   import flashx.textLayout.formats.TextDecoration;
   import flash.text.engine.FontPosture;
   import flash.text.engine.FontWeight;
   import flash.text.engine.Kerning;
   import flash.utils.getQualifiedClassName;
   
   use namespace tlf_internal;
   
   public class TextFieldHtmlExporter extends ConverterBase implements ITextExporter
   {
      
      public function TextFieldHtmlExporter() {
         super();
         if(!_config)
         {
            _config = new ImportExportConfiguration();
            _config.addIEInfo(null,DivElement,null,this.exportDiv);
            _config.addIEInfo(null,ParagraphElement,null,this.exportParagraph);
            _config.addIEInfo(null,LinkElement,null,this.exportLink);
            _config.addIEInfo(null,TCYElement,null,this.exportTCY);
            _config.addIEInfo(null,SubParagraphGroupElement,null,this.exportSPGE);
            _config.addIEInfo(null,SpanElement,null,this.exportSpan);
            _config.addIEInfo(null,InlineGraphicElement,null,this.exportImage);
            _config.addIEInfo(null,TabElement,null,this.exportTab);
            _config.addIEInfo(null,BreakElement,null,this.exportBreak);
            _config.addIEInfo(null,ListElement,null,this.exportList);
            _config.addIEInfo(null,ListItemElement,null,this.exportListItem);
         }
      }
      
      tlf_internal  static var _config:ImportExportConfiguration;
      
      tlf_internal  static function makeTaggedTypeName(param1:FlowElement, param2:String) : XML {
         if(param1.typeName == param1.defaultTypeName)
         {
            return new XML("<" + param2 + "/>");
         }
         return new XML("<" + param1.typeName.toUpperCase() + "/>");
      }
      
      tlf_internal  static function exportStyling(param1:FlowElement, param2:XML) : void {
         if(param1.id != null)
         {
            param2["id"] = param1.id;
         }
         if(param1.styleName != null)
         {
            param2["class"] = param1.styleName;
         }
      }
      
      tlf_internal  static const brRegEx:RegExp = new RegExp(" ");
      
      tlf_internal  static function getSpanTextReplacementXML(param1:String) : XML {
         return <BR/>;
      }
      
      tlf_internal  static function nest(param1:XML, param2:Object) : XML {
         param1.setChildren(param2);
         return param1;
      }
      
      public function export(param1:TextFlow, param2:String) : Object {
         var _loc3_:XML = this.exportToXML(param1);
         return param2 == ConversionType.STRING_TYPE?BaseTextLayoutExporter.convertXMLToString(_loc3_):_loc3_;
      }
      
      tlf_internal function exportToXML(param1:TextFlow) : XML {
         var _loc3_:XML = null;
         var _loc2_:XML = <HTML/>;
         if(param1.numChildren != 0)
         {
            if(param1.getChildAt(0).typeName != "BODY")
            {
               _loc3_ = <BODY/>;
               _loc2_.appendChild(_loc3_);
               this.exportChildren(param1,_loc3_);
            }
            else
            {
               this.exportChildren(param1,_loc2_);
            }
         }
         return _loc2_;
      }
      
      tlf_internal function exportChildren(param1:FlowGroupElement, param2:XML) : void {
         var _loc4_:FlowElement = null;
         var _loc3_:* = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            this.exportElement(_loc4_,param2);
            _loc3_++;
         }
      }
      
      tlf_internal function exportList(param1:ListElement, param2:XML) : void {
         var _loc3_:XML = null;
         var _loc4_:XML = null;
         if(param1.isNumberedList())
         {
            _loc3_ = <OL/>;
         }
         else
         {
            _loc3_ = <UL/>;
         }
         exportStyling(param1,_loc3_);
         this.exportChildren(param1,_loc3_);
         if(param1.typeName != param1.defaultTypeName)
         {
            _loc4_ = new XML("<" + param1.typeName + "/>");
            _loc4_.appendChild(_loc3_);
            param2.appendChild(_loc4_);
         }
         else
         {
            param2.appendChild(_loc3_);
         }
      }
      
      tlf_internal function exportListItem(param1:ListItemElement, param2:XML) : void {
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc3_:XML = <LI/>;
         exportStyling(param1,_loc3_);
         this.exportChildren(param1,_loc3_);
         var _loc4_:XMLList = _loc3_.children();
         if(_loc4_.length() == 1)
         {
            _loc5_ = _loc4_[0];
            if(_loc5_.name().localName == "P")
            {
               _loc6_ = _loc5_.children();
               if(_loc6_.length() == 1)
               {
                  _loc3_ = <LI/>;
                  _loc3_.appendChild(_loc6_[0]);
               }
            }
         }
         param2.appendChild(_loc3_);
      }
      
      tlf_internal function exportDiv(param1:DivElement, param2:XML) : void {
         var _loc3_:XML = makeTaggedTypeName(param1,"DIV");
         exportStyling(param1,_loc3_);
         this.exportChildren(param1,_loc3_);
         param2.appendChild(_loc3_);
      }
      
      tlf_internal function exportParagraph(param1:ParagraphElement, param2:XML) : void {
         var _loc3_:XML = makeTaggedTypeName(param1,"P");
         exportStyling(param1,_loc3_);
         var _loc4_:XML = this.exportFont(param1.computedFormat);
         this.exportSubParagraphChildren(param1,_loc4_);
         nest(_loc3_,_loc4_);
         param2.appendChild(this.exportParagraphFormat(_loc3_,param1));
      }
      
      tlf_internal function exportLink(param1:LinkElement, param2:XML) : void {
         var _loc3_:XML = <A/>;
         if(param1.href)
         {
            _loc3_.@HREF = param1.href;
         }
         if(param1.target)
         {
            _loc3_.@TARGET = param1.target;
         }
         else
         {
            _loc3_.@TARGET = "_blank";
         }
         this.exportSubParagraphElement(param1,_loc3_,param2);
      }
      
      tlf_internal function exportTCY(param1:TCYElement, param2:XML) : void {
         var _loc3_:XML = <TCY/>;
         this.exportSubParagraphElement(param1,_loc3_,param2);
      }
      
      tlf_internal function exportSPGE(param1:SubParagraphGroupElement, param2:XML) : void {
         var _loc3_:XML = param1.typeName != param1.defaultTypeName?new XML("<" + param1.typeName + "/>"):<SPAN/>;
         this.exportSubParagraphElement(param1,_loc3_,param2,false);
      }
      
      tlf_internal function exportSubParagraphElement(param1:SubParagraphGroupElementBase, param2:XML, param3:XML, param4:Boolean=true) : void {
         var _loc9_:XML = null;
         exportStyling(param1,param2);
         this.exportSubParagraphChildren(param1,param2);
         var _loc5_:ITextLayoutFormat = param1.computedFormat;
         var _loc6_:ITextLayoutFormat = param1.parent.computedFormat;
         var _loc7_:XML = this.exportFont(_loc5_,_loc6_);
         var _loc8_:XML = _loc7_?nest(_loc7_,param2):param2;
         if((param4) && !(param1.typeName == param1.defaultTypeName))
         {
            _loc9_ = new XML("<" + param1.typeName + "/>");
            _loc9_.appendChild(_loc8_);
            param3.appendChild(_loc9_);
         }
         else
         {
            param3.appendChild(_loc8_);
         }
      }
      
      tlf_internal function exportSpan(param1:SpanElement, param2:XML) : void {
         var _loc4_:Object = null;
         var _loc3_:XML = makeTaggedTypeName(param1,"SPAN");
         exportStyling(param1,_loc3_);
         BaseTextLayoutExporter.exportSpanText(_loc3_,param1,brRegEx,getSpanTextReplacementXML);
         if(param1.id == null && param1.styleName == null && param1.typeName == param1.defaultTypeName)
         {
            _loc4_ = _loc3_.children();
            if(_loc4_.length() == 1 && _loc4_[0].nodeKind() == "text")
            {
               _loc4_ = _loc3_.text()[0];
            }
            param2.appendChild(this.exportSpanFormat(_loc4_,param1));
         }
         else
         {
            param2.appendChild(this.exportSpanFormat(_loc3_,param1));
         }
      }
      
      tlf_internal function exportImage(param1:InlineGraphicElement, param2:XML) : void {
         var _loc4_:XML = null;
         var _loc3_:XML = <IMG/>;
         exportStyling(param1,_loc3_);
         if(param1.source)
         {
            _loc3_.@SRC = param1.source;
         }
         if(!(param1.width === undefined) && !(param1.width == FormatValue.AUTO))
         {
            _loc3_.@WIDTH = param1.width;
         }
         if(!(param1.height === undefined) && !(param1.height == FormatValue.AUTO))
         {
            _loc3_.@HEIGHT = param1.height;
         }
         if(param1.computedFloat != Float.NONE)
         {
            _loc3_.@ALIGN = param1.float;
         }
         if(param1.typeName != param1.defaultTypeName)
         {
            _loc4_ = new XML("<" + param1.typeName + "/>");
            _loc4_.appendChild(_loc3_);
            param2.appendChild(_loc4_);
         }
         else
         {
            param2.appendChild(_loc3_);
         }
      }
      
      tlf_internal function exportBreak(param1:BreakElement, param2:XML) : void {
         param2.appendChild(<BR/>);
      }
      
      tlf_internal function exportTab(param1:TabElement, param2:XML) : void {
         this.exportSpan(param1,param2);
      }
      
      tlf_internal function exportTextFormatAttribute(param1:XML, param2:String, param3:*) : XML {
         if(!param1)
         {
            param1 = <TEXTFORMAT/>;
         }
         param1[param2] = param3;
         return param1;
      }
      
      tlf_internal function exportParagraphFormat(param1:XML, param2:ParagraphElement) : XML {
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc7_:FlowLeafElement = null;
         var _loc8_:* = NaN;
         var _loc9_:String = null;
         var _loc10_:TabStopFormat = null;
         var _loc3_:ITextLayoutFormat = param2.computedFormat;
         switch(_loc3_.textAlign)
         {
            case TextAlign.START:
               _loc4_ = _loc3_.direction == Direction.LTR?TextAlign.LEFT:TextAlign.RIGHT;
               break;
            case TextAlign.END:
               _loc4_ = _loc3_.direction == Direction.LTR?TextAlign.RIGHT:TextAlign.LEFT;
               break;
            default:
               _loc4_ = _loc3_.textAlign;
         }
         param1.@ALIGN = _loc4_;
         if(_loc3_.paragraphStartIndent != 0)
         {
            _loc5_ = this.exportTextFormatAttribute(_loc5_,_loc3_.direction == Direction.LTR?"LEFTMARGIN":"RIGHTMARGIN",_loc3_.paragraphStartIndent);
         }
         if(_loc3_.paragraphEndIndent != 0)
         {
            _loc5_ = this.exportTextFormatAttribute(_loc5_,_loc3_.direction == Direction.LTR?"RIGHTMARGIN":"LEFTMARGIN",_loc3_.paragraphEndIndent);
         }
         if(_loc3_.textIndent != 0)
         {
            _loc5_ = this.exportTextFormatAttribute(_loc5_,"INDENT",_loc3_.textIndent);
         }
         if(_loc3_.leadingModel == LeadingModel.APPROXIMATE_TEXT_FIELD)
         {
            _loc7_ = param2.getFirstLeaf();
            if(_loc7_)
            {
               _loc8_ = TextLayoutFormat.lineHeightProperty.computeActualPropertyValue(_loc7_.computedFormat.lineHeight,_loc7_.getEffectiveFontSize());
               if(_loc8_ != 0)
               {
                  _loc5_ = this.exportTextFormatAttribute(_loc5_,"LEADING",_loc8_);
               }
            }
         }
         var _loc6_:Array = _loc3_.tabStops;
         if(_loc6_)
         {
            _loc9_ = "";
            for each (_loc10_ in _loc6_)
            {
               if(_loc10_.alignment != TabAlignment.START)
               {
                  break;
               }
               if(_loc9_.length)
               {
                  _loc9_ = _loc9_ + ", ";
               }
               _loc9_ = _loc9_ + _loc10_.position;
            }
            if(_loc9_.length)
            {
               _loc5_ = this.exportTextFormatAttribute(_loc5_,"TABSTOPS",_loc9_);
            }
         }
         return _loc5_?nest(_loc5_,param1):param1;
      }
      
      tlf_internal function exportSpanFormat(param1:Object, param2:SpanElement) : Object {
         var _loc3_:ITextLayoutFormat = param2.computedFormat;
         var _loc4_:Object = param1;
         if(_loc3_.textDecoration.toString() == TextDecoration.UNDERLINE)
         {
            _loc4_ = nest(<U/>,_loc4_);
         }
         if(_loc3_.fontStyle.toString() == FontPosture.ITALIC)
         {
            _loc4_ = nest(<I/>,_loc4_);
         }
         if(_loc3_.fontWeight.toString() == FontWeight.BOLD)
         {
            _loc4_ = nest(<B/>,_loc4_);
         }
         var _loc5_:FlowElement = param2.getParentByType(LinkElement);
         if(!_loc5_)
         {
            _loc5_ = param2.getParagraph();
         }
         var _loc6_:XML = this.exportFont(_loc3_,_loc5_.computedFormat);
         if(_loc6_)
         {
            _loc4_ = nest(_loc6_,_loc4_);
         }
         return _loc4_;
      }
      
      tlf_internal function exportFontAttribute(param1:XML, param2:String, param3:*) : XML {
         if(!param1)
         {
            param1 = <FONT/>;
         }
         param1[param2] = param3;
         return param1;
      }
      
      tlf_internal function exportFont(param1:ITextLayoutFormat, param2:ITextLayoutFormat=null) : XML {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         if(!param2 || !(param2.fontFamily == param1.fontFamily))
         {
            _loc3_ = this.exportFontAttribute(_loc3_,"FACE",param1.fontFamily);
         }
         if(!param2 || !(param2.fontSize == param1.fontSize))
         {
            _loc3_ = this.exportFontAttribute(_loc3_,"SIZE",param1.fontSize);
         }
         if(!param2 || !(param2.color == param1.color))
         {
            _loc4_ = param1.color.toString(16);
            while(_loc4_.length < 6)
            {
               _loc4_ = "0" + _loc4_;
            }
            _loc4_ = "#" + _loc4_;
            _loc3_ = this.exportFontAttribute(_loc3_,"COLOR",_loc4_);
         }
         if(!param2 || !(param2.trackingRight == param1.trackingRight))
         {
            _loc3_ = this.exportFontAttribute(_loc3_,"LETTERSPACING",param1.trackingRight);
         }
         if(!param2 || !(param2.kerning == param1.kerning))
         {
            _loc3_ = this.exportFontAttribute(_loc3_,"KERNING",param1.kerning == Kerning.OFF?"0":"1");
         }
         return _loc3_;
      }
      
      tlf_internal function exportElement(param1:FlowElement, param2:XML) : void {
         var _loc5_:XML = null;
         var _loc3_:String = getQualifiedClassName(param1);
         var _loc4_:FlowElementInfo = _config.lookupByClass(_loc3_);
         if(_loc4_)
         {
            _loc4_.exporter(param1,param2);
         }
         else
         {
            _loc5_ = new XML("<" + param1.typeName.toUpperCase() + "/>");
            this.exportChildren(param1 as FlowGroupElement,_loc5_);
            param2.appendChild(_loc5_);
         }
      }
      
      tlf_internal function exportSubParagraphChildren(param1:FlowGroupElement, param2:XML) : void {
         var _loc3_:* = 0;
         while(_loc3_ < param1.numChildren)
         {
            this.exportElement(param1.getChildAt(_loc3_),param2);
            _loc3_++;
         }
      }
   }
}
