package com.ankamagames.berilia.types.event
{
    import flash.events.*;

    public class UiUnloadEvent extends Event
    {
        private var _name:String;
        public static const UNLOAD_UI_STARTED:String = "unloadUiStarted";
        public static const UNLOAD_UI_COMPLETE:String = "unloadUiComplete";

        public function UiUnloadEvent(param1:String, param2:String)
        {
            super(param1, false, false);
            this._name = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

    }
}
