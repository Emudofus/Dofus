package flashx.textLayout.events
{
   import flash.events.Event;
   
   public class TextLayoutEvent extends Event
   {
      
      public function TextLayoutEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const SCROLL:String = "scroll";
      
      override public function clone() : Event {
         return new TextLayoutEvent(type,bubbles,cancelable);
      }
   }
}
