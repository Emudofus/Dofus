package com.ankamagames.berilia.components.messages
{
   import com.ankamagames.berilia.components.MapViewer;
   
   public class MapMoveMessage extends ComponentMessage
   {
      
      public function MapMoveMessage(param1:MapViewer) {
         super(param1);
      }
      
      private var _map:MapViewer;
   }
}
