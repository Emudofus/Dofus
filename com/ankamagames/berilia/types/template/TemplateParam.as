package com.ankamagames.berilia.types.template
{

    public class TemplateParam extends Object
    {
        public var name:String;
        public var value:String;
        public var defaultValue:String;

        public function TemplateParam(param1:String, param2:String = null)
        {
            this.name = param1;
            this.value = param2;
            return;
        }// end function

    }
}
