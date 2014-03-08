package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   
   public class ModuleRessourceLoadFailedMessage extends Object implements Message
   {
      
      public function ModuleRessourceLoadFailedMessage(param1:String, param2:Uri, param3:Boolean=true) {
         super();
         this._moduleName = param1;
         this._uri = param2;
         this._isImportant = param3;
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
