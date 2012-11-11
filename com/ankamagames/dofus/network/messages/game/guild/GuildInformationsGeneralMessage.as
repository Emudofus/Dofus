package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class GuildInformationsGeneralMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var enabled:Boolean = false;
        public var abandonnedPaddock:Boolean = false;
        public var level:uint = 0;
        public var expLevelFloor:Number = 0;
        public var experience:Number = 0;
        public var expNextLevelFloor:Number = 0;
        public var creationDate:uint = 0;
        public static const protocolId:uint = 5557;

        public function GuildInformationsGeneralMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5557;
        }// end function

        public function initGuildInformationsGeneralMessage(param1:Boolean = false, param2:Boolean = false, param3:uint = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:uint = 0) : GuildInformationsGeneralMessage
        {
            this.enabled = param1;
            this.abandonnedPaddock = param2;
            this.level = param3;
            this.expLevelFloor = param4;
            this.experience = param5;
            this.expNextLevelFloor = param6;
            this.creationDate = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.enabled = false;
            this.abandonnedPaddock = false;
            this.level = 0;
            this.expLevelFloor = 0;
            this.experience = 0;
            this.expNextLevelFloor = 0;
            this.creationDate = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GuildInformationsGeneralMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInformationsGeneralMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.enabled);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.abandonnedPaddock);
            param1.writeByte(_loc_2);
            if (this.level < 0 || this.level > 255)
            {
                throw new Error("Forbidden value (" + this.level + ") on element level.");
            }
            param1.writeByte(this.level);
            if (this.expLevelFloor < 0)
            {
                throw new Error("Forbidden value (" + this.expLevelFloor + ") on element expLevelFloor.");
            }
            param1.writeDouble(this.expLevelFloor);
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element experience.");
            }
            param1.writeDouble(this.experience);
            if (this.expNextLevelFloor < 0)
            {
                throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element expNextLevelFloor.");
            }
            param1.writeDouble(this.expNextLevelFloor);
            if (this.creationDate < 0)
            {
                throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
            }
            param1.writeInt(this.creationDate);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInformationsGeneralMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInformationsGeneralMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.enabled = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.abandonnedPaddock = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.level = param1.readUnsignedByte();
            if (this.level < 0 || this.level > 255)
            {
                throw new Error("Forbidden value (" + this.level + ") on element of GuildInformationsGeneralMessage.level.");
            }
            this.expLevelFloor = param1.readDouble();
            if (this.expLevelFloor < 0)
            {
                throw new Error("Forbidden value (" + this.expLevelFloor + ") on element of GuildInformationsGeneralMessage.expLevelFloor.");
            }
            this.experience = param1.readDouble();
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element of GuildInformationsGeneralMessage.experience.");
            }
            this.expNextLevelFloor = param1.readDouble();
            if (this.expNextLevelFloor < 0)
            {
                throw new Error("Forbidden value (" + this.expNextLevelFloor + ") on element of GuildInformationsGeneralMessage.expNextLevelFloor.");
            }
            this.creationDate = param1.readInt();
            if (this.creationDate < 0)
            {
                throw new Error("Forbidden value (" + this.creationDate + ") on element of GuildInformationsGeneralMessage.creationDate.");
            }
            return;
        }// end function

    }
}
