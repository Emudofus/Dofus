package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.version.VersionExtended;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
    import __AS3__.vec.*;

    [Trusted]
    public class IdentificationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 4;

        private var _isInitialized:Boolean = false;
        public var version:VersionExtended;
        public var lang:String = "";
        public var credentials:Vector.<int>;
        public var serverId:int = 0;
        public var autoconnect:Boolean = false;
        public var useCertificate:Boolean = false;
        public var useLoginToken:Boolean = false;
        public var sessionOptionalSalt:Number = 0;

        public function IdentificationMessage()
        {
            this.version = new VersionExtended();
            this.credentials = new Vector.<int>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (4);
        }

        public function initIdentificationMessage(version:VersionExtended=null, lang:String="", credentials:Vector.<int>=null, serverId:int=0, autoconnect:Boolean=false, useCertificate:Boolean=false, useLoginToken:Boolean=false, sessionOptionalSalt:Number=0):IdentificationMessage
        {
            this.version = version;
            this.lang = lang;
            this.credentials = credentials;
            this.serverId = serverId;
            this.autoconnect = autoconnect;
            this.useCertificate = useCertificate;
            this.useLoginToken = useLoginToken;
            this.sessionOptionalSalt = sessionOptionalSalt;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.version = new VersionExtended();
            this.credentials = new Vector.<int>();
            this.serverId = 0;
            this.autoconnect = false;
            this.useCertificate = false;
            this.useLoginToken = false;
            this.sessionOptionalSalt = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_IdentificationMessage(output);
        }

        public function serializeAs_IdentificationMessage(output:IDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.autoconnect);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.useCertificate);
            _box0 = BooleanByteWrapper.setFlag(_box0, 2, this.useLoginToken);
            output.writeByte(_box0);
            this.version.serializeAs_VersionExtended(output);
            output.writeUTF(this.lang);
            output.writeShort(this.credentials.length);
            var _i3:uint;
            while (_i3 < this.credentials.length)
            {
                output.writeByte(this.credentials[_i3]);
                _i3++;
            };
            output.writeShort(this.serverId);
            if ((((this.sessionOptionalSalt < -9007199254740992)) || ((this.sessionOptionalSalt > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.sessionOptionalSalt) + ") on element sessionOptionalSalt.")));
            };
            output.writeDouble(this.sessionOptionalSalt);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_IdentificationMessage(input);
        }

        public function deserializeAs_IdentificationMessage(input:IDataInput):void
        {
            var _val3:int;
            var _box0:uint = input.readByte();
            this.autoconnect = BooleanByteWrapper.getFlag(_box0, 0);
            this.useCertificate = BooleanByteWrapper.getFlag(_box0, 1);
            this.useLoginToken = BooleanByteWrapper.getFlag(_box0, 2);
            this.version = new VersionExtended();
            this.version.deserialize(input);
            this.lang = input.readUTF();
            var _credentialsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _credentialsLen)
            {
                _val3 = input.readByte();
                this.credentials.push(_val3);
                _i3++;
            };
            this.serverId = input.readShort();
            this.sessionOptionalSalt = input.readDouble();
            if ((((this.sessionOptionalSalt < -9007199254740992)) || ((this.sessionOptionalSalt > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.sessionOptionalSalt) + ") on element of IdentificationMessage.sessionOptionalSalt.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

