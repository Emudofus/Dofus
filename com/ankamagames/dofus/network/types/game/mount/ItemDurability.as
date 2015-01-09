package com.ankamagames.dofus.network.types.game.mount
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ItemDurability implements INetworkType 
    {

        public static const protocolId:uint = 168;

        public var durability:int = 0;
        public var durabilityMax:int = 0;


        public function getTypeId():uint
        {
            return (168);
        }

        public function initItemDurability(durability:int=0, durabilityMax:int=0):ItemDurability
        {
            this.durability = durability;
            this.durabilityMax = durabilityMax;
            return (this);
        }

        public function reset():void
        {
            this.durability = 0;
            this.durabilityMax = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ItemDurability(output);
        }

        public function serializeAs_ItemDurability(output:ICustomDataOutput):void
        {
            output.writeShort(this.durability);
            output.writeShort(this.durabilityMax);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ItemDurability(input);
        }

        public function deserializeAs_ItemDurability(input:ICustomDataInput):void
        {
            this.durability = input.readShort();
            this.durabilityMax = input.readShort();
        }


    }
}//package com.ankamagames.dofus.network.types.game.mount

