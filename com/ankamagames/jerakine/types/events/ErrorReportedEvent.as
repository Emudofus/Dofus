package com.ankamagames.jerakine.types.events
{
   import flash.events.Event;
   
   public class ErrorReportedEvent extends Event
   {
      
      public function ErrorReportedEvent(param1:Error, param2:String, param3:Boolean=true) {
         super(ERROR,false,false);
         this._error = param1;
         this._text = param2;
         this._showPopup = param3;
      }
      
      public static const ERROR:String = "ErrorReportedEvent";
      
      private var _error:Error;
      
      private var _text:String;
      
      private var _showPopup:Boolean;
      
      public function get error() : Error {
         return this._error;
      }
      
      public function get text() : String {
         return this._text;
      }
      
      public function get showPopup() : Boolean {
         return this._showPopup;
      }
      
      public function get errorType() : String {
         if(this.error == null)
         {
            return "";
         }
         var _loc1_:Array = this.error.toString().split(":");
         return _loc1_[0];
      }
   }
}
