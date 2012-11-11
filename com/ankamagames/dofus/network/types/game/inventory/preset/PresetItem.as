package com.ankamagames.dofus.network.types.game.inventory.preset
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PresetItem extends Object implements INetworkType
    {
        public var position:uint = 63;
        public var objGid:uint = 0;
        public var objUid:uint = 0;
        public static const protocolId:uint = 354;

        public function PresetItem()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 354;
        }// end function

        public function initPresetItem(param1:uint = 63, param2:uint = 0, param3:uint = 0) : PresetItem
        {
            this.position = param1;
            this.objGid = param2;
            this.objUid = param3;
            return this;
        }// end function

        public function reset() : void
        {
            this.position = 63;
            this.objGid = 0;
            this.objUid = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PresetItem(param1);
            return;
        }// end function

        public function serializeAs_PresetItem(param1:IDataOutput) : void
        {
            param1.writeByte(this.position);
            if (this.objGid < 0)
            {
                throw new Error("Forbidden value (" + this.objGid + ") on element objGid.");
            }
            param1.writeInt(this.objGid);
            if (this.objUid < 0)
            {
                throw new Error("Forbidden value (" + this.objUid + ") on element objUid.");
            }
            param1.writeInt(this.objUid);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PresetItem(param1);
            return;
        }// end function

        public function deserializeAs_PresetItem(param1:IDataInput) : void
        {
            this.position = param1.readUnsignedByte();
            if (this.position < 0 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of PresetItem.position.");
            }
            this.objGid = param1.readInt();
            if (this.objGid < 0)
            {
                throw new Error("Forbidden value (" + this.objGid + ") on element of PresetItem.objGid.");
            }
            this.objUid = param1.readInt();
            if (this.objUid < 0)
            {
                throw new Error("Forbidden value (" + this.objUid + ") on element of PresetItem.objUid.");
            }
            return;
        }// end function

    }
}
