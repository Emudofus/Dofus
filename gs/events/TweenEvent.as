package gs.events
{
   import flash.events.Event;


   public class TweenEvent extends Event
   {
         

      public function TweenEvent($type:String, $info:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=false) {
         super($type,$bubbles,$cancelable);
         this.info=$info;
      }

      public static const version:Number = 0.9;

      public static const START:String = "start";

      public static const UPDATE:String = "update";

      public static const COMPLETE:String = "complete";

      public var info:Object;

      override public function clone() : Event {
         return new TweenEvent(this.type,this.info,this.bubbles,this.cancelable);
      }
   }

}