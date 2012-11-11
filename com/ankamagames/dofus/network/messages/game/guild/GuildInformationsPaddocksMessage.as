package com.ankamagames.dofus.network.messages.game.guild
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GuildInformationsPaddocksMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nbPaddockMax:uint = 0;
        public var paddocksInformations:Vector.<PaddockContentInformations>;
        public static const protocolId:uint = 5959;

        public function GuildInformationsPaddocksMessage()
        {
            this.paddocksInformations = new Vector.<PaddockContentInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5959;
        }// end function

        public function initGuildInformationsPaddocksMessage(param1:uint = 0, param2:Vector.<PaddockContentInformations> = null) : GuildInformationsPaddocksMessage
        {
            this.nbPaddockMax = param1;
            this.paddocksInformations = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.nbPaddockMax = 0;
            this.paddocksInformations = new Vector.<PaddockContentInformations>;
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
            this.serializeAs_GuildInformationsPaddocksMessage(param1);
            return;
        }// end function

        public function serializeAs_GuildInformationsPaddocksMessage(param1:IDataOutput) : void
        {
            if (this.nbPaddockMax < 0)
            {
                throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element nbPaddockMax.");
            }
            param1.writeByte(this.nbPaddockMax);
            param1.writeShort(this.paddocksInformations.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.paddocksInformations.length)
            {
                
                (this.paddocksInformations[_loc_2] as PaddockContentInformations).serializeAs_PaddockContentInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GuildInformationsPaddocksMessage(param1);
            return;
        }// end function

        public function deserializeAs_GuildInformationsPaddocksMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.nbPaddockMax = param1.readByte();
            if (this.nbPaddockMax < 0)
            {
                throw new Error("Forbidden value (" + this.nbPaddockMax + ") on element of GuildInformationsPaddocksMessage.nbPaddockMax.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new PaddockContentInformations();
                _loc_4.deserialize(param1);
                this.paddocksInformations.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
