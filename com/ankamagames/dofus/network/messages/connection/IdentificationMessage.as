package com.ankamagames.dofus.network.messages.connection
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.version.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class IdentificationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var version:VersionExtended;
        public var lang:String = "";
        public var login:String = "";
        public var credentials:Vector.<int>;
        public var serverId:int = 0;
        public var autoconnect:Boolean = false;
        public var useCertificate:Boolean = false;
        public var useLoginToken:Boolean = false;
        public static const protocolId:uint = 4;

        public function IdentificationMessage()
        {
            this.version = new VersionExtended();
            this.credentials = new Vector.<int>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 4;
        }// end function

        public function initIdentificationMessage(param1:VersionExtended = null, param2:String = "", param3:String = "", param4:Vector.<int> = null, param5:int = 0, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : IdentificationMessage
        {
            this.version = param1;
            this.lang = param2;
            this.login = param3;
            this.credentials = param4;
            this.serverId = param5;
            this.autoconnect = param6;
            this.useCertificate = param7;
            this.useLoginToken = param8;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.version = new VersionExtended();
            this.login = "";
            this.credentials = new Vector.<int>;
            this.serverId = 0;
            this.autoconnect = false;
            this.useCertificate = false;
            this.useLoginToken = false;
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
            this.serializeAs_IdentificationMessage(param1);
            return;
        }// end function

        public function serializeAs_IdentificationMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.autoconnect);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.useCertificate);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 2, this.useLoginToken);
            param1.writeByte(_loc_2);
            this.version.serializeAs_VersionExtended(param1);
            param1.writeUTF(this.lang);
            param1.writeUTF(this.login);
            param1.writeShort(this.credentials.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.credentials.length)
            {
                
                param1.writeByte(this.credentials[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeShort(this.serverId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IdentificationMessage(param1);
            return;
        }// end function

        public function deserializeAs_IdentificationMessage(param1:IDataInput) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = param1.readByte();
            this.autoconnect = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.useCertificate = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.useLoginToken = BooleanByteWrapper.getFlag(_loc_2, 2);
            this.version = new VersionExtended();
            this.version.deserialize(param1);
            this.lang = param1.readUTF();
            this.login = param1.readUTF();
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.readByte();
                this.credentials.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.serverId = param1.readShort();
            return;
        }// end function

    }
}
