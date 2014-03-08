package com.ankamagames.berilia.uiRender
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLDocument;
   import com.ankamagames.berilia.managers.TemplateManager;
   import com.ankamagames.berilia.types.event.TemplateLoadedEvent;
   import com.ankamagames.berilia.types.event.PreProcessEndEvent;
   import flash.xml.XMLNode;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.berilia.types.template.TemplateParam;
   
   public class XmlPreProcessor extends EventDispatcher
   {
      
      public function XmlPreProcessor(param1:XMLDocument) {
         super();
         this._xDoc = param1;
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlPreProcessor));
      
      private var _xDoc:XMLDocument;
      
      private var _bMustBeRendered:Boolean = true;
      
      private var _aImportFile:Array;
      
      public function get importedFiles() : int {
         return this._aImportFile.length;
      }
      
      public function processTemplate() : void {
         this._aImportFile = new Array();
         TemplateManager.getInstance().addEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
         this.matchImport(this._xDoc.firstChild);
         if(!this._aImportFile.length)
         {
            dispatchEvent(new PreProcessEndEvent(this));
            TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._aImportFile.length)
         {
            TemplateManager.getInstance().register(this._aImportFile[_loc1_]);
            _loc1_++;
         }
      }
      
      private function matchImport(param1:XMLNode) : void {
         var _loc2_:XMLNode = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.childNodes.length)
         {
            _loc2_ = param1.childNodes[_loc3_];
            if(_loc2_.nodeName == XmlTagsEnum.TAG_IMPORT)
            {
               if(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_URL] == null)
               {
                  _log.warn("Attribute \'" + XmlAttributesEnum.ATTRIBUTE_URL + "\' is missing in " + XmlTagsEnum.TAG_IMPORT + " tag.");
               }
               else
               {
                  this._aImportFile.push(LangManager.getInstance().replaceKey(_loc2_.attributes[XmlAttributesEnum.ATTRIBUTE_URL]));
               }
               _loc2_.removeNode();
               _loc3_--;
            }
            else
            {
               if(_loc2_ != null)
               {
                  this.matchImport(_loc2_);
               }
            }
            _loc3_++;
         }
      }
      
      private function replaceTemplateCall(param1:XMLNode) : Boolean {
         var _loc2_:XMLNode = null;
         var _loc3_:XMLNode = null;
         var _loc4_:XMLNode = null;
         var _loc5_:XMLNode = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc14_:* = false;
         var _loc15_:String = null;
         var _loc16_:XMLNode = null;
         var _loc6_:* = false;
         var _loc13_:uint = 0;
         while(_loc13_ < param1.childNodes.length)
         {
            _loc2_ = param1.childNodes[_loc13_];
            _loc14_ = false;
            _loc7_ = 0;
            while(_loc7_ < this._aImportFile.length)
            {
               _loc10_ = this._aImportFile[_loc7_].split("/");
               _loc11_ = _loc10_[_loc10_.length-1];
               if(_loc11_.toUpperCase() == (_loc2_.nodeName + ".xml").toUpperCase())
               {
                  _loc12_ = new Array();
                  for (_loc8_ in _loc2_.attributes)
                  {
                     _loc12_[_loc8_] = new TemplateParam(_loc8_,_loc2_.attributes[_loc8_]);
                  }
                  _loc9_ = 0;
                  while(_loc9_ < _loc2_.childNodes.length)
                  {
                     _loc3_ = _loc2_.childNodes[_loc9_];
                     _loc15_ = "";
                     for each (_loc16_ in _loc3_.childNodes)
                     {
                        _loc15_ = _loc15_ + _loc16_;
                     }
                     _loc12_[_loc3_.nodeName] = new TemplateParam(_loc3_.nodeName,_loc15_);
                     _loc9_++;
                  }
                  _loc4_ = TemplateManager.getInstance().getTemplate(_loc11_).makeTemplate(_loc12_);
                  _loc9_ = 0;
                  while(_loc9_ < _loc4_.firstChild.childNodes.length)
                  {
                     _loc5_ = _loc4_.firstChild.childNodes[_loc9_].cloneNode(true);
                     _loc2_.parentNode.insertBefore(_loc5_,_loc2_);
                     _loc9_++;
                  }
                  _loc2_.removeNode();
                  _loc6_ = _loc14_ = true;
               }
               _loc7_++;
            }
            if(!_loc14_)
            {
               _loc6_ = (this.replaceTemplateCall(_loc2_)) || (_loc6_);
            }
            _loc13_++;
         }
         return _loc6_;
      }
      
      private function onTemplateLoaded(param1:TemplateLoadedEvent) : void {
         if((TemplateManager.getInstance().areLoaded(this._aImportFile)) && (this._bMustBeRendered))
         {
            this._bMustBeRendered = this.replaceTemplateCall(this._xDoc.firstChild);
            if(this._bMustBeRendered)
            {
               this.processTemplate();
            }
            else
            {
               dispatchEvent(new PreProcessEndEvent(this));
               TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
            }
         }
      }
   }
}
