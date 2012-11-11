package com.ankamagames.jerakine.logger.targets
{

    class LoggerHistoryElement extends Object
    {
        private var m_level:int;
        private var m_message:String;

        function LoggerHistoryElement(param1:int, param2:String)
        {
            this.m_level = param1;
            this.m_message = param2;
            return;
        }// end function

        public function get level() : int
        {
            return this.m_level;
        }// end function

        public function get message() : String
        {
            return this.m_message;
        }// end function

    }
}
