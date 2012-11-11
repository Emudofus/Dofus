package flashx.textLayout.events
{
    import flash.events.*;

    public class TextLayoutEvent extends Event
    {
        public static const SCROLL:String = "scroll";

        public function TextLayoutEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TextLayoutEvent(type, bubbles, cancelable);
        }// end function

    }
}
