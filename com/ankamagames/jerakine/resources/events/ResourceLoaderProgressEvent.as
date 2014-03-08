package com.ankamagames.jerakine.resources.events
{
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   
   public class ResourceLoaderProgressEvent extends ResourceEvent
   {
      
      public function ResourceLoaderProgressEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const LOADER_PROGRESS:String = "loaderProgress";
      
      public static const LOADER_COMPLETE:String = "loaderComplete";
      
      public var uri:Uri;
      
      public var filesLoaded:uint;
      
      public var filesTotal:uint;
      
      override public function clone() : Event {
         var _loc1_:ResourceLoaderProgressEvent = new ResourceLoaderProgressEvent(type,bubbles,cancelable);
         _loc1_.uri = this.uri;
         _loc1_.filesLoaded = this.filesLoaded;
         _loc1_.filesTotal = this.filesTotal;
         return _loc1_;
      }
   }
}
