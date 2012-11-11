package com.ankamagames.tiphon.display
{

    public class RasterizedFrameList extends Object
    {
        public var life:int;
        public var maxLife:int;
        public var death:int = 0;
        public var key:String;
        public var frameList:Array;

        public function RasterizedFrameList(param1:String, param2:int, param3:int = 40)
        {
            this.frameList = new Array();
            this.key = param1;
            this.life = param2;
            this.maxLife = param3;
            return;
        }// end function

    }
}
