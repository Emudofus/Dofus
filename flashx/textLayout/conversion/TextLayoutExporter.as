package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.InlineGraphicElement;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.DivElement;
   import flashx.textLayout.elements.SubParagraphGroupElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.formats.ListMarkerFormat;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.formats.FormatValue;
   
   use namespace tlf_internal;
   
   class TextLayoutExporter extends BaseTextLayoutExporter
   {
      
      function TextLayoutExporter() {
         super(new Namespace("http://ns.adobe.com/textLayout/2008"),null,TextLayoutImporter.defaultConfiguration);
      }
      
      private static var _formatDescription:Object = TextLayoutFormat.description;
      
      private static const brTabRegEx:RegExp = new RegExp("[" + " " + "\t" + "]");
      
      public static function exportImage(param1:BaseTextLayoutExporter, param2:InlineGraphicElement) : XMLList {
         var _loc3_:XMLList = exportFlowElement(param1,param2);
         if(param2.height !== undefined)
         {
            _loc3_.@height = param2.height;
         }
         if(param2.width !== undefined)
         {
            _loc3_.@width = param2.width;
         }
         if(param2.source != null)
         {
            _loc3_.@source = param2.source;
         }
         if(param2.float != undefined)
         {
            _loc3_.@float = param2.float;
         }
         return _loc3_;
      }
      
      public static function exportLink(param1:BaseTextLayoutExporter, param2:LinkElement) : XMLList {
         var _loc3_:XMLList = exportFlowGroupElement(param1,param2);
         if(param2.href)
         {
            _loc3_.@href = param2.href;
         }
         if(param2.target)
         {
            _loc3_.@target = param2.target;
         }
         return _loc3_;
      }
      
      public static function exportDiv(param1:BaseTextLayoutExporter, param2:DivElement) : XMLList {
         return exportContainerFormattedElement(param1,param2);
      }
      
      public static function exportSPGE(param1:BaseTextLayoutExporter, param2:SubParagraphGroupElement) : XMLList {
         return exportFlowGroupElement(param1,param2);
      }
      
      public static function exportTCY(param1:BaseTextLayoutExporter, param2:TCYElement) : XMLList {
         return exportFlowGroupElement(param1,param2);
      }
      
      override protected function get spanTextReplacementRegex() : RegExp {
         return brTabRegEx;
      }
      
      override protected function getSpanTextReplacementXML(param1:String) : XML {
         var _loc2_:XML = null;
         if(param1 == " ")
         {
            _loc2_ = <br/>;
         }
         else
         {
            if(param1 == "\t")
            {
               _loc2_ = <tab/>;
            }
            else
            {
               return null;
            }
         }
         _loc2_.setNamespace(flowNS);
         return _loc2_;
      }
      
      tlf_internal function createStylesFromDescription(param1:Object, param2:Object, param3:Boolean, param4:Array) : Array {
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:Property = null;
         var _loc9_:XMLList = null;
         var _loc5_:Array = [];
         for (_loc6_ in param1)
         {
            _loc7_ = param1[_loc6_];
            if(!((param4) && !(param4.indexOf(_loc7_) == -1)))
            {
               _loc8_ = param2[_loc6_];
               if(!_loc8_)
               {
                  if(param3)
                  {
                     if(_loc7_ is String || (_loc7_.hasOwnProperty("toString")))
                     {
                        _loc5_.push(
                           {
                              "xmlName":_loc6_,
                              "xmlVal":_loc7_
                           });
                     }
                  }
               }
               else
               {
                  if(_loc7_ is TextLayoutFormat)
                  {
                     _loc9_ = this.exportObjectAsTextLayoutFormat(_loc6_,(_loc7_ as TextLayoutFormat).getStyles());
                     if(_loc9_)
                     {
                        _loc5_.push(
                           {
                              "xmlName":_loc6_,
                              "xmlVal":_loc9_
                           });
                     }
                  }
                  else
                  {
                     _loc5_.push(
                        {
                           "xmlName":_loc6_,
                           "xmlVal":_loc8_.toXMLString(_loc7_)
                        });
                  }
               }
            }
         }
         return _loc5_;
      }
      
      tlf_internal function exportObjectAsTextLayoutFormat(param1:String, param2:Object) : XMLList {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         if(param1 == LinkElement.LINK_NORMAL_FORMAT_NAME || param1 == LinkElement.LINK_ACTIVE_FORMAT_NAME || param1 == LinkElement.LINK_HOVER_FORMAT_NAME)
         {
            _loc3_ = "TextLayoutFormat";
            _loc4_ = TextLayoutFormat.description;
         }
         else
         {
            if(param1 == ListElement.LIST_MARKER_FORMAT_NAME)
            {
               _loc3_ = "ListMarkerFormat";
               _loc4_ = ListMarkerFormat.description;
            }
         }
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc5_:XML = new XML("<" + _loc3_ + "/>");
         _loc5_.setNamespace(flowNS);
         var _loc6_:Array = this.createStylesFromDescription(param2,_loc4_,true,null);
         exportStyles(XMLList(_loc5_),_loc6_);
         var _loc7_:XMLList = XMLList(new XML("<" + param1 + "/>"));
         _loc7_.appendChild(_loc5_);
         return _loc7_;
      }
      
      override protected function exportFlowElement(param1:FlowElement) : XMLList {
         var _loc4_:Array = null;
         var _loc2_:XMLList = super.exportFlowElement(param1);
         var _loc3_:Object = param1.styles;
         if(_loc3_)
         {
            delete _loc3_[[TextLayoutFormat.whiteSpaceCollapseProperty.name]];
            _loc4_ = this.createStylesFromDescription(_loc3_,this.formatDescription,true,param1.parent?null:[FormatValue.INHERIT]);
            exportStyles(_loc2_,_loc4_);
         }
         if(param1.id != null)
         {
            _loc2_["id"] = param1.id;
         }
         if(param1.typeName != param1.defaultTypeName)
         {
            _loc2_["typeName"] = param1.typeName;
         }
         return _loc2_;
      }
      
      override protected function get formatDescription() : Object {
         return _formatDescription;
      }
   }
}
