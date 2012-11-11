package com.ankamagames.berilia.types.data
{

    public class Theme extends Object
    {
        public var name:String;
        public var description:String;
        public var previewUri:String;
        public var fileName:String;

        public function Theme(param1:String, param2:String, param3:String = "", param4:String = "")
        {
            this.name = param2;
            this.description = param3;
            this.previewUri = param4;
            this.fileName = param1;
            return;
        }// end function

    }
}
