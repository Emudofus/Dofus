package com.ankamagames.berilia.types.tooltip
{
    import flash.events.*;

    public class TooltipChunk extends EventDispatcher
    {
        private var _content:String;

        public function TooltipChunk(param1:String)
        {
            this._content = param1;
            return;
        }// end function

        public function processContent(param1:Object) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = this._content;
            for (_loc_3 in param1)
            {
                
                _loc_2 = _loc_2.split("#" + _loc_3).join(param1[_loc_3]);
            }
            return _loc_2;
        }// end function

        public function get content() : String
        {
            return this._content;
        }// end function

    }
}
