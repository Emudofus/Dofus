package com.ankamagames.berilia.types.event
{
    import flash.events.*;

    public class TemplateLoadedEvent extends Event
    {
        private var _templateUrl:String;
        public static const EVENT_TEMPLATE_LOADED:String = "onTemplateLoadedEvent";

        public function TemplateLoadedEvent(param1:String)
        {
            super(EVENT_TEMPLATE_LOADED, false, false);
            this._templateUrl = param1;
            return;
        }// end function

        public function get templateUrl() : String
        {
            return this._templateUrl;
        }// end function

    }
}
