package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class UiXmlParsedErrorMessage extends Object implements Message
   {
      
      public function UiXmlParsedErrorMessage(param1:String, param2:String) {
         super();
         this._url = param1;
         this._msg = param2;
      }
      
      private var _url:String;
      
      private var _msg:String;
      
      public function get url() : String {
         return this._url;
      }
      
      public function get msg() : String {
         return this._msg;
      }
   }
}
