package com.ankamagames.atouin.messages
{
   public class CellClickMessage extends CellInteractionMessage
   {
      
      public function CellClickMessage(cellId:uint=0, mapId:uint=0) {
         super();
         this.cellId = cellId;
         this.id = mapId;
      }
   }
}
