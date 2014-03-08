package com.ankamagames.jerakine.logger.targets
{
   class LoggerHistoryElement extends Object
   {
      
      function LoggerHistoryElement(param1:int, param2:String) {
         super();
         this.m_level = param1;
         this.m_message = param2;
      }
      
      private var m_level:int;
      
      private var m_message:String;
      
      public function get level() : int {
         return this.m_level;
      }
      
      public function get message() : String {
         return this.m_message;
      }
   }
}
