package com.ankamagames.atouin.types.events
{
   import flash.events.Event;
   
   public class RenderMapEvent extends Event
   {
      
      public function RenderMapEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, mapId:uint=0, renderId:uint=0) {
         super(type,bubbles,cancelable);
         this._mapId = mapId;
         this._renderId = renderId;
      }
      
      public static const GFX_LOADING_START:String = "GFX_LOADING_START";
      
      public static const GFX_LOADING_END:String = "GFX_LOADING_END";
      
      public static const MAP_RENDER_START:String = "MAP_RENDER_START";
      
      public static const MAP_RENDER_END:String = "MAP_RENDER_END";
      
      private var _mapId:uint;
      
      private var _renderId:uint;
      
      public function get mapId() : uint {
         return this._mapId;
      }
      
      public function get renderId() : uint {
         return this._renderId;
      }
   }
}
