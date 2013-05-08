package flashx.textLayout.events
{
   import flash.events.Event;


   public class TextLayoutEvent extends Event
   {
         

      public function TextLayoutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
         super(type,bubbles,cancelable);
      }

      public static const SCROLL:String = "scroll";

      override public function clone() : Event {
         return new TextLayoutEvent(type,bubbles,cancelable);
      }
   }

}