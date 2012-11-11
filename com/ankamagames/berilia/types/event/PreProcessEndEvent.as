package com.ankamagames.berilia.types.event
{
    import com.ankamagames.berilia.uiRender.*;
    import flash.events.*;

    public class PreProcessEndEvent extends Event
    {
        private var _preprocessor:XmlPreProcessor;
        public static const PRE_PROCESS_END:String = "pre_process_end";

        public function PreProcessEndEvent(param1:XmlPreProcessor)
        {
            super(PRE_PROCESS_END, false, false);
            this._preprocessor = param1;
            return;
        }// end function

        public function get preprocessor() : XmlPreProcessor
        {
            return this._preprocessor;
        }// end function

    }
}
