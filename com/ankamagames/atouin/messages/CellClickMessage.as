package com.ankamagames.atouin.messages
{
   public class CellClickMessage extends CellInteractionMessage
   {
      
      public function CellClickMessage(param1:uint=0, param2:uint=0) {
         super();
         this.cellId = param1;
         this.id = param2;
      }
   }
}
