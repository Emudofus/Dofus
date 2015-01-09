package com.ankamagames.atouin.messages
{
    public class CellClickMessage extends CellInteractionMessage 
    {

        public function CellClickMessage(cellId:uint=0, mapId:uint=0)
        {
            this.cellId = cellId;
            this.id = mapId;
        }

    }
}//package com.ankamagames.atouin.messages

