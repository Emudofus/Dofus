package com.ankamagames.berilia.components
{
    import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.ankamagames.jerakine.messages.Message;

    public class LinkedLabel extends Label 
    {

        private var _sUrl:String;
        private var _sTarget:String = "_blank";

        public function LinkedLabel()
        {
            buttonMode = true;
            mouseChildren = false;
        }

        public function get url():String
        {
            return (this._sUrl);
        }

        public function set url(value:String):void
        {
            this._sUrl = value;
        }

        public function get target():String
        {
            return (this._sTarget);
        }

        public function set target(value:String):void
        {
            this._sTarget = value;
        }

        [HideInFakeClass]
        override public function process(msg:Message):Boolean
        {
            switch (true)
            {
                case (msg is MouseClickMessage):
                    if (((((((msg as MouseClickMessage).target == this)) && (getUi()))) && (getUi().uiModule.trusted)))
                    {
                        navigateToURL(new URLRequest(this.url), this.target);
                        return (true);
                    };
            };
            return (false);
        }


    }
}//package com.ankamagames.berilia.components

