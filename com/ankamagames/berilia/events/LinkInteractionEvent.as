package com.ankamagames.berilia.events
{
   import flash.events.Event;
   
   public class LinkInteractionEvent extends Event
   {
      
      public function LinkInteractionEvent(param1:String, param2:String="") {
         this.text = param2;
         super(param1,false,false);
      }
      
      public static const ROLL_OVER:String = "RollOverLink";
      
      public static const ROLL_OUT:String = "RollOutLink";
      
      public var text:String;
   }
}
