package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class EntityDispositionInformations implements INetworkType 
    {

        public static const protocolId:uint = 60;

        public var cellId:int = 0;
        public var direction:uint = 1;


        public function getTypeId():uint
        {
            return (60);
        }

        public function initEntityDispositionInformations(cellId:int=0, direction:uint=1):EntityDispositionInformations
        {
            this.cellId = cellId;
            this.direction = direction;
            return (this);
        }

        public function reset():void
        {
            this.cellId = 0;
            this.direction = 1;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_EntityDispositionInformations(output);
        }

        public function serializeAs_EntityDispositionInformations(output:ICustomDataOutput):void
        {
            if ((((this.cellId < -1)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element cellId.")));
            };
            output.writeShort(this.cellId);
            output.writeByte(this.direction);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_EntityDispositionInformations(input);
        }

        public function deserializeAs_EntityDispositionInformations(input:ICustomDataInput):void
        {
            this.cellId = input.readShort();
            if ((((this.cellId < -1)) || ((this.cellId > 559))))
            {
                throw (new Error((("Forbidden value (" + this.cellId) + ") on element of EntityDispositionInformations.cellId.")));
            };
            this.direction = input.readByte();
            if (this.direction < 0)
            {
                throw (new Error((("Forbidden value (" + this.direction) + ") on element of EntityDispositionInformations.direction.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

