package com.ankamagames.berilia.types.template
{

    public class TemplateVar extends Object
    {
        public var name:String;
        public var value:String;

        public function TemplateVar(param1:String)
        {
            this.name = param1;
            return;
        }// end function

        public function clone() : TemplateVar
        {
            var _loc_1:* = new TemplateVar(this.name);
            _loc_1.value = this.value;
            return _loc_1;
        }// end function

    }
}
