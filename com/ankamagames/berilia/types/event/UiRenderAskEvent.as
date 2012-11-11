package com.ankamagames.berilia.types.event
{
    import com.ankamagames.berilia.types.data.*;
    import flash.events.*;

    public class UiRenderAskEvent extends Event
    {
        private var _uiData:UiData;
        private var _name:String;
        public static const UI_RENDER_ASK:String = "UiRenderAsk";

        public function UiRenderAskEvent(param1:String, param2:UiData)
        {
            super(UI_RENDER_ASK, false, false);
            this._uiData = param2;
            this._name = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get uiData() : UiData
        {
            return this._uiData;
        }// end function

    }
}
