package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceErrorEvent extends ResourceEvent
   {
      
      public function ResourceErrorEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const ERROR:String = "error";
      
      public var uri:Uri;
      
      public var errorMsg:String;
      
      public var errorCode:uint;
      
      override public function clone() : Event {
         var _loc1_:ResourceErrorEvent = new ResourceErrorEvent(type,bubbles,cancelable);
         _loc1_.uri = this.uri;
         _loc1_.errorMsg = this.errorMsg;
         _loc1_.errorCode = this.errorCode;
         return _loc1_;
      }
   }
}
