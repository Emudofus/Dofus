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
      
      public function XmlPreProcessor(xDoc:XMLDocument) {
         super();
         this._xDoc = xDoc;
      }
      
      protected static const _log:Logger;
      
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
         var i:uint = 0;
         while(i < this._aImportFile.length)
         {
            TemplateManager.getInstance().register(this._aImportFile[i]);
            i++;
         }
      }
      
      private function matchImport(node:XMLNode) : void {
         var currNode:XMLNode = null;
         if(node == null)
         {
            return;
         }
         var i:uint = 0;
         while(i < node.childNodes.length)
         {
            currNode = node.childNodes[i];
            if(currNode.nodeName == XmlTagsEnum.TAG_IMPORT)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL] == null)
               {
                  _log.warn("Attribute \'" + XmlAttributesEnum.ATTRIBUTE_URL + "\' is missing in " + XmlTagsEnum.TAG_IMPORT + " tag.");
               }
               else
               {
                  this._aImportFile.push(LangManager.getInstance().replaceKey(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL]));
               }
               currNode.removeNode();
               i--;
            }
            else if(currNode != null)
            {
               this.matchImport(currNode);
            }
            
            i++;
         }
      }
      
      private function replaceTemplateCall(node:XMLNode) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onTemplateLoaded(e:TemplateLoadedEvent) : void {
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
