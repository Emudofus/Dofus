package com.ankamagames.berilia.types.event
{
    import com.ankamagames.berilia.types.uiDefinition.*;
    import flash.events.*;

    public class ParsorEvent extends Event
    {
        private var _uiDef:UiDefinition;

        public function ParsorEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:UiDefinition = null)
        {
            super(param1, param2, param3);
            this._uiDef = param4;
            return;
        }// end function

        public function get uiDefinition() : UiDefinition
        {
            return this._uiDef;
        }// end function

    }
}
