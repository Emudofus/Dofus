package com.ankamagames.dofus.network.types.game.interactive
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class StatedElement implements INetworkType 
    {

        public static const protocolId:uint = 108;

        public var elementId:uint = 0;
        public var elementCellId:uint = 0;
        public var elementState:uint = 0;


        public function getTypeId():uint
        {
            return (108);
        }

        public function initStatedElement(elementId:uint=0, elementCellId:uint=0, elementState:uint=0):StatedElement
        {
            this.elementId = elementId;
            this.elementCellId = elementCellId;
            this.elementState = elementState;
            return (this);
        }

        public function reset():void
        {
            this.elementId = 0;
            this.elementCellId = 0;
            this.elementState = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_StatedElement(output);
        }

        public function serializeAs_StatedElement(output:ICustomDataOutput):void
        {
            if (this.elementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementId) + ") on element elementId.")));
            };
            output.writeInt(this.elementId);
            if ((((this.elementCellId < 0)) || ((this.elementCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.elementCellId) + ") on element elementCellId.")));
            };
            output.writeVarShort(this.elementCellId);
            if (this.elementState < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementState) + ") on element elementState.")));
            };
            output.writeVarInt(this.elementState);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_StatedElement(input);
        }

        public function deserializeAs_StatedElement(input:ICustomDataInput):void
        {
            this.elementId = input.readInt();
            if (this.elementId < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementId) + ") on element of StatedElement.elementId.")));
            };
            this.elementCellId = input.readVarUhShort();
            if ((((this.elementCellId < 0)) || ((this.elementCellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.elementCellId) + ") on element of StatedElement.elementCellId.")));
            };
            this.elementState = input.readVarUhInt();
            if (this.elementState < 0)
            {
                throw (new Error((("Forbidden value (" + this.elementState) + ") on element of StatedElement.elementState.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.interactive

