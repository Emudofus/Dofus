package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class DocumentApi extends Object implements IApi
   {
      
      public function DocumentApi() {
         this._log = Log.getLogger(getQualifiedClassName(DocumentApi));
         super();
      }
      
      protected var _log:Logger;
      
      private var _module:UiModule;
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getDocument(param1:uint) : Object {
         return Document.getDocumentById(param1);
      }
      
      public function getType(param1:uint) : uint {
         return Document.getDocumentById(param1).typeId;
      }
   }
}
