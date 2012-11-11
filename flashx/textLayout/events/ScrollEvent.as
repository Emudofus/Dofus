package flashx.textLayout.events
{
    import flash.events.*;

    public class ScrollEvent extends TextLayoutEvent
    {
        public var delta:Number;
        public var direction:String;

        public function ScrollEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Number = NaN)
        {
            super(param1, param2, param3);
            this.direction = param4;
            this.delta = param5;
            return;
        }// end function

        override public function clone() : Event
        {
            return new ScrollEvent(type, bubbles, cancelable, this.direction, this.delta);
        }// end function

    }
}
