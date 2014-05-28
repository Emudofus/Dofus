package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class UiXmlParsedMessage extends Object implements Message
   {
      
      public function UiXmlParsedMessage(url:String) {
         super();
         this._url = url;
      }
      
      private var _url:String;
      
      public function get url() : String {
         return this._url;
      }
   }
}
