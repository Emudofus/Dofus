package com.ankamagames.jerakine.messages
{
   public class LangFileLoadedMessage extends Object implements Message
   {
      
      public function LangFileLoadedMessage(param1:String, param2:Boolean, param3:String) {
         super();
         this._sFile = param1;
         this._bSuccess = param2;
         this._sUrlProvider = param3;
      }
      
      private var _sFile:String;
      
      private var _bSuccess:Boolean;
      
      private var _sUrlProvider:String;
      
      public function get urlProvider() : String {
         return this._sUrlProvider;
      }
      
      public function get file() : String {
         return this._sFile;
      }
      
      public function get success() : Boolean {
         return this._bSuccess;
      }
   }
}
