package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceProgressEvent extends ResourceEvent
   {
      
      public function ResourceProgressEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const PROGRESS:String = "progress";
      
      public var uri:Uri;
      
      public var bytesLoaded:uint;
      
      public var bytesTotal:uint;
      
      override public function clone() : Event {
         var _loc1_:ResourceProgressEvent = new ResourceProgressEvent(type,bubbles,cancelable);
         _loc1_.uri = this.uri;
         _loc1_.bytesLoaded = this.bytesLoaded;
         _loc1_.bytesTotal = this.bytesTotal;
         return _loc1_;
      }
   }
}
