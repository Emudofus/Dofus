package com.ankamagames.berilia.types.data
{

    public class TextTooltipInfo extends Object
    {
        public var content:String;
        public var css:String;
        public var cssClass:String;
        public var maxWidth:int;
        public var bgCornerRadius:int = 0;

        public function TextTooltipInfo(param1:String, param2:String = null, param3:String = null, param4:int = 400)
        {
            this.content = param1;
            this.css = param2;
            if (param3)
            {
                this.cssClass = param3;
            }
            else
            {
                this.cssClass = "text";
            }
            this.maxWidth = param4;
            return;
        }// end function

    }
}
