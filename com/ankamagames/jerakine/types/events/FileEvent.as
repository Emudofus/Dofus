package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   
   public class FileEvent extends Event
   {
      
      public function FileEvent(param1:String, param2:String, param3:Boolean) {
         super(param1,bubbles,cancelable);
         this._sFile = param2;
         this._bSuccess = param3;
      }
      
      public static const ERROR:String = "FILE_ERROR_EVENT";
      
      private var _sFile:String;
      
      private var _bSuccess:Boolean;
      
      public function get file() : String {
         return this._sFile;
      }
      
      public function get success() : Boolean {
         return this._bSuccess;
      }
   }
}
