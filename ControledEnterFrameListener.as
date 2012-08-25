package 
{

    class ControledEnterFrameListener extends Object
    {
        public var name:String;
        public var listener:Function;
        public var wantedGap:uint;
        public var overhead:uint;
        public var latestChange:uint;

        function ControledEnterFrameListener(param1:String, param2:Function, param3:uint, param4:uint)
        {
            this.name = param1;
            this.listener = param2;
            this.wantedGap = param3;
            this.latestChange = param4;
            return;
        }// end function

    }
}
