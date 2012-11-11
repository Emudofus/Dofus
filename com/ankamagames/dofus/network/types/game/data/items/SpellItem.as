package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SpellItem extends Item implements INetworkType
    {
        public var position:uint = 0;
        public var spellId:int = 0;
        public var spellLevel:int = 0;
        public static const protocolId:uint = 49;

        public function SpellItem()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 49;
        }// end function

        public function initSpellItem(param1:uint = 0, param2:int = 0, param3:int = 0) : SpellItem
        {
            this.position = param1;
            this.spellId = param2;
            this.spellLevel = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            this.position = 0;
            this.spellId = 0;
            this.spellLevel = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SpellItem(param1);
            return;
        }// end function

        public function serializeAs_SpellItem(param1:IDataOutput) : void
        {
            super.serializeAs_Item(param1);
            if (this.position < 63 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element position.");
            }
            param1.writeByte(this.position);
            param1.writeInt(this.spellId);
            if (this.spellLevel < 1 || this.spellLevel > 6)
            {
                throw new Error("Forbidden value (" + this.spellLevel + ") on element spellLevel.");
            }
            param1.writeByte(this.spellLevel);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SpellItem(param1);
            return;
        }// end function

        public function deserializeAs_SpellItem(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.position = param1.readUnsignedByte();
            if (this.position < 63 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of SpellItem.position.");
            }
            this.spellId = param1.readInt();
            this.spellLevel = param1.readByte();
            if (this.spellLevel < 1 || this.spellLevel > 6)
            {
                throw new Error("Forbidden value (" + this.spellLevel + ") on element of SpellItem.spellLevel.");
            }
            return;
        }// end function

    }
}
