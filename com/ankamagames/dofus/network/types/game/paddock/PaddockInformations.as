package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PaddockInformations implements INetworkType 
    {

        public static const protocolId:uint = 132;

        public var maxOutdoorMount:uint = 0;
        public var maxItems:uint = 0;


        public function getTypeId():uint
        {
            return (132);
        }

        public function initPaddockInformations(maxOutdoorMount:uint=0, maxItems:uint=0):PaddockInformations
        {
            this.maxOutdoorMount = maxOutdoorMount;
            this.maxItems = maxItems;
            return (this);
        }

        public function reset():void
        {
            this.maxOutdoorMount = 0;
            this.maxItems = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PaddockInformations(output);
        }

        public function serializeAs_PaddockInformations(output:ICustomDataOutput):void
        {
            if (this.maxOutdoorMount < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxOutdoorMount) + ") on element maxOutdoorMount.")));
            };
            output.writeVarShort(this.maxOutdoorMount);
            if (this.maxItems < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxItems) + ") on element maxItems.")));
            };
            output.writeVarShort(this.maxItems);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockInformations(input);
        }

        public function deserializeAs_PaddockInformations(input:ICustomDataInput):void
        {
            this.maxOutdoorMount = input.readVarUhShort();
            if (this.maxOutdoorMount < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxOutdoorMount) + ") on element of PaddockInformations.maxOutdoorMount.")));
            };
            this.maxItems = input.readVarUhShort();
            if (this.maxItems < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxItems) + ") on element of PaddockInformations.maxItems.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.paddock

