package 
{
    import flash.display.*;

    class WaitingUpdate extends Object
    {
        public var data:Object;
        public var index:Object;
        public var selected:Boolean;
        public var drawBackground:Boolean;
        public var dispObj:DisplayObject;

        function WaitingUpdate(param1, param2:uint, param3:DisplayObject, param4:Boolean, param5:Boolean)
        {
            this.data = param1;
            this.selected = param4;
            this.drawBackground = param5;
            this.dispObj = param3;
            this.index = param2;
            return;
        }// end function

    }
}
