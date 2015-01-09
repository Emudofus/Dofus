package com.ankamagames.berilia.types.tooltip
{
    import flash.events.EventDispatcher;

    public class TooltipChunk extends EventDispatcher 
    {

        private var _content:String;

        public function TooltipChunk(content:String)
        {
            this._content = content;
        }

        public function processContent(params:Object):String
        {
            var i:String;
            var content:String = this._content;
            for (i in params)
            {
                content = content.split(("#" + i)).join(params[i]);
            };
            return (content);
        }

        public function get content():String
        {
            return (this._content);
        }


    }
}//package com.ankamagames.berilia.types.tooltip

