package com.ankamagames.atouin.types.events
{
    import flash.events.*;

    public class RenderMapEvent extends Event
    {
        private var _mapId:uint;
        private var _renderId:uint;
        public static const GFX_LOADING_START:String = "GFX_LOADING_START";
        public static const GFX_LOADING_END:String = "GFX_LOADING_END";
        public static const MAP_RENDER_START:String = "MAP_RENDER_START";
        public static const MAP_RENDER_END:String = "MAP_RENDER_END";

        public function RenderMapEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0)
        {
            super(param1, param2, param3);
            this._mapId = param4;
            this._renderId = param5;
            return;
        }// end function

        public function get mapId() : uint
        {
            return this._mapId;
        }// end function

        public function get renderId() : uint
        {
            return this._renderId;
        }// end function

    }
}
