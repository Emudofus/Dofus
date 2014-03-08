package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   
   public class EventListener extends Object
   {
      
      public function EventListener(pListener:IFLAEventHandler, pTypesEvents:String) {
         super();
         this.listener = pListener;
         this.typesEvents = pTypesEvents;
      }
      
      public var listener:IFLAEventHandler;
      
      public var typesEvents:String;
   }
}
