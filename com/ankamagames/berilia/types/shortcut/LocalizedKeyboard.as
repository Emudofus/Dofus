package com.ankamagames.berilia.types.shortcut
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class LocalizedKeyboard extends Object
   {
      
      public function LocalizedKeyboard(param1:Uri, param2:String, param3:String) {
         super();
         this._uri = param1;
         this._locale = param2;
         this._description = param3;
      }
      
      private var _uri:Uri;
      
      private var _locale:String;
      
      private var _description:String;
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function get locale() : String {
         return this._locale;
      }
      
      public function get description() : String {
         return this._description;
      }
   }
}
