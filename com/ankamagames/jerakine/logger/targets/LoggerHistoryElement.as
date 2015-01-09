package com.ankamagames.jerakine.logger.targets
{
    class LoggerHistoryElement 
    {

        private var m_level:int;
        private var m_message:String;

        public function LoggerHistoryElement(level:int, message:String)
        {
            this.m_level = level;
            this.m_message = message;
        }

        public function get level():int
        {
            return (this.m_level);
        }

        public function get message():String
        {
            return (this.m_message);
        }


    }
}//package com.ankamagames.jerakine.logger.targets

