package com.ankamagames.berilia.types.event
{
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.uiRender.*;
    import flash.events.*;

    public class UiRenderEvent extends Event
    {
        private var _secUiTarget:UiRootContainer;
        private var _uiRenderer:UiRenderer;
        public static var UIRenderComplete:String = "UIRenderComplete";
        public static var UIRenderFailed:String = "UIRenderFailed";

        public function UiRenderEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:UiRootContainer = null, param5:UiRenderer = null)
        {
            super(param1, param2, param3);
            this._secUiTarget = param4;
            this._uiRenderer = param5;
            return;
        }// end function

        public function get uiTarget() : UiRootContainer
        {
            return this._secUiTarget;
        }// end function

        public function get uiRenderer() : UiRenderer
        {
            return this._uiRenderer;
        }// end function

        override public function clone() : Event
        {
            return new UiRenderEvent(type, bubbles, cancelable, this.uiTarget, this.uiRenderer);
        }// end function

    }
}
