package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceLoadedEvent extends ResourceEvent
   {
      
      public function ResourceLoadedEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const LOADED:String = "loaded";
      
      public var resource;
      
      public var resourceType:uint = 255;
      
      public var uri:Uri;
      
      override public function clone() : Event {
         var _loc1_:ResourceLoadedEvent = new ResourceLoadedEvent(type,bubbles,cancelable);
         _loc1_.resource = this.resource;
         _loc1_.resourceType = this.resourceType;
         _loc1_.uri = this.uri;
         return _loc1_;
      }
   }
}
