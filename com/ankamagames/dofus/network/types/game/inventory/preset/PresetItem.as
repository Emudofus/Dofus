package com.ankamagames.dofus.network.types.game.inventory.preset
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PresetItem implements INetworkType 
    {

        public static const protocolId:uint = 354;

        public var position:uint = 63;
        public var objGid:uint = 0;
        public var objUid:uint = 0;


        public function getTypeId():uint
        {
            return (354);
        }

        public function initPresetItem(position:uint=63, objGid:uint=0, objUid:uint=0):PresetItem
        {
            this.position = position;
            this.objGid = objGid;
            this.objUid = objUid;
            return (this);
        }

        public function reset():void
        {
            this.position = 63;
            this.objGid = 0;
            this.objUid = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PresetItem(output);
        }

        public function serializeAs_PresetItem(output:ICustomDataOutput):void
        {
            output.writeByte(this.position);
            if (this.objGid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objGid) + ") on element objGid.")));
            };
            output.writeVarShort(this.objGid);
            if (this.objUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objUid) + ") on element objUid.")));
            };
            output.writeVarInt(this.objUid);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PresetItem(input);
        }

        public function deserializeAs_PresetItem(input:ICustomDataInput):void
        {
            this.position = input.readUnsignedByte();
            if ((((this.position < 0)) || ((this.position > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.position) + ") on element of PresetItem.position.")));
            };
            this.objGid = input.readVarUhShort();
            if (this.objGid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objGid) + ") on element of PresetItem.objGid.")));
            };
            this.objUid = input.readVarUhInt();
            if (this.objUid < 0)
            {
                throw (new Error((("Forbidden value (" + this.objUid) + ") on element of PresetItem.objUid.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.inventory.preset

