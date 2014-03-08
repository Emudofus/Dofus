package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   
   public class ModuleRessourceLoadFailedMessage extends Object implements Message
   {
      
      public function ModuleRessourceLoadFailedMessage(moduleName:String, uri:Uri, isImportant:Boolean=true) {
         super();
         this._moduleName = moduleName;
         this._uri = uri;
         this._isImportant = isImportant;
      }
      
      private var _moduleName:String;
      
      private var _uri:Uri;
      
      private var _isImportant:Boolean;
      
      public function get moduleName() : String {
         return this._moduleName;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get isImportant() : Boolean {
         return this._isImportant;
      }
   }
}
