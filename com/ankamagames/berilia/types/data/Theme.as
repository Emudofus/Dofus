package com.ankamagames.berilia.types.data
{
    public class Theme 
    {

        public var name:String;
        public var description:String;
        public var previewUri:String;
        public var fileName:String;

        public function Theme(fileName:String, name:String, description:String="", previewUri:String="")
        {
            this.name = name;
            this.description = description;
            this.previewUri = previewUri;
            this.fileName = fileName;
        }

    }
}//package com.ankamagames.berilia.types.data

