package com.ankamagames.dofus.network.types.game.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ItemDurability extends Object implements INetworkType
    {
        public var durability:int = 0;
        public var durabilityMax:int = 0;
        public static const protocolId:uint = 168;

        public function ItemDurability()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 168;
        }// end function

        public function initItemDurability(param1:int = 0, param2:int = 0) : ItemDurability
        {
            this.durability = param1;
            this.durabilityMax = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.durability = 0;
            this.durabilityMax = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ItemDurability(param1);
            return;
        }// end function

        public function serializeAs_ItemDurability(param1:IDataOutput) : void
        {
            param1.writeShort(this.durability);
            param1.writeShort(this.durabilityMax);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ItemDurability(param1);
            return;
        }// end function

        public function deserializeAs_ItemDurability(param1:IDataInput) : void
        {
            this.durability = param1.readShort();
            this.durabilityMax = param1.readShort();
            return;
        }// end function

    }
}
