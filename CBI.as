package 
{

    class CBI extends Object
    {
        public var id:int;
        public var gfxId:int;
        public var breed:int;
        public var colors:Array;

        function CBI(param1:uint, param2:int, param3:int, param4:Array)
        {
            this.colors = new Array();
            this.id = param1;
            this.gfxId = param2;
            this.breed = param3;
            this.colors = param4;
            return;
        }// end function

    }
}
