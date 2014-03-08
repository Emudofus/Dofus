package com.ankamagames.dofus.misc.utils.mapeditor
{
   import flash.events.Event;
   
   public class MapEditorDataEvent extends Event
   {
      
      public function MapEditorDataEvent(param1:String, param2:MapEditorMessage) {
         super(param1,false,false);
         this.data = param2;
      }
      
      public static const NEW_DATA:String = "MapEditorDataEvent_NEW_DATA";
      
      public var data:MapEditorMessage;
   }
}
