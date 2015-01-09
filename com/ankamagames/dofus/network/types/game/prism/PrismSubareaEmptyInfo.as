package com.ankamagames.dofus.network.types.game.prism
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class PrismSubareaEmptyInfo implements INetworkType 
    {

        public static const protocolId:uint = 438;

        public var subAreaId:uint = 0;
        public var allianceId:uint = 0;


        public function getTypeId():uint
        {
            return (438);
        }

        public function initPrismSubareaEmptyInfo(subAreaId:uint=0, allianceId:uint=0):PrismSubareaEmptyInfo
        {
            this.subAreaId = subAreaId;
            this.allianceId = allianceId;
            return (this);
        }

        public function reset():void
        {
            this.subAreaId = 0;
            this.allianceId = 0;
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PrismSubareaEmptyInfo(output);
        }

        public function serializeAs_PrismSubareaEmptyInfo(output:IDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element allianceId.")));
            };
            output.writeInt(this.allianceId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PrismSubareaEmptyInfo(input);
        }

        public function deserializeAs_PrismSubareaEmptyInfo(input:IDataInput):void
        {
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismSubareaEmptyInfo.subAreaId.")));
            };
            this.allianceId = input.readInt();
            if (this.allianceId < 0)
            {
                throw (new Error((("Forbidden value (" + this.allianceId) + ") on element of PrismSubareaEmptyInfo.allianceId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.prism

