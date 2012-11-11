package com.ankamagames.dofus.network.types.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class VillageConquestPrismInformation extends Object implements INetworkType
    {
        public var areaId:uint = 0;
        public var areaAlignment:uint = 0;
        public var isEntered:Boolean = false;
        public var isInRoom:Boolean = false;
        public static const protocolId:uint = 379;

        public function VillageConquestPrismInformation()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 379;
        }// end function

        public function initVillageConquestPrismInformation(param1:uint = 0, param2:uint = 0, param3:Boolean = false, param4:Boolean = false) : VillageConquestPrismInformation
        {
            this.areaId = param1;
            this.areaAlignment = param2;
            this.isEntered = param3;
            this.isInRoom = param4;
            return this;
        }// end function

        public function reset() : void
        {
            this.areaId = 0;
            this.areaAlignment = 0;
            this.isEntered = false;
            this.isInRoom = false;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_VillageConquestPrismInformation(param1);
            return;
        }// end function

        public function serializeAs_VillageConquestPrismInformation(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.isEntered);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.isInRoom);
            param1.writeByte(_loc_2);
            if (this.areaId < 0)
            {
                throw new Error("Forbidden value (" + this.areaId + ") on element areaId.");
            }
            param1.writeShort(this.areaId);
            if (this.areaAlignment < 0)
            {
                throw new Error("Forbidden value (" + this.areaAlignment + ") on element areaAlignment.");
            }
            param1.writeByte(this.areaAlignment);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_VillageConquestPrismInformation(param1);
            return;
        }// end function

        public function deserializeAs_VillageConquestPrismInformation(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.isEntered = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.isInRoom = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.areaId = param1.readShort();
            if (this.areaId < 0)
            {
                throw new Error("Forbidden value (" + this.areaId + ") on element of VillageConquestPrismInformation.areaId.");
            }
            this.areaAlignment = param1.readByte();
            if (this.areaAlignment < 0)
            {
                throw new Error("Forbidden value (" + this.areaAlignment + ") on element of VillageConquestPrismInformation.areaAlignment.");
            }
            return;
        }// end function

    }
}
