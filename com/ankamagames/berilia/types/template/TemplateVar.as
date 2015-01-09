package com.ankamagames.berilia.types.template
{
    public class TemplateVar 
    {

        public var name:String;
        public var value:String;

        public function TemplateVar(varName:String)
        {
            this.name = varName;
        }

        public function clone():TemplateVar
        {
            var tmp:TemplateVar = new TemplateVar(this.name);
            tmp.value = this.value;
            return (tmp);
        }


    }
}//package com.ankamagames.berilia.types.template

