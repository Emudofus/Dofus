package com.ankamagames.dofus.network.messages.connection
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.connection.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ServersListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var servers:Vector.<GameServerInformations>;
        public static const protocolId:uint = 30;

        public function ServersListMessage()
        {
            this.servers = new Vector.<GameServerInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 30;
        }// end function

        public function initServersListMessage(param1:Vector.<GameServerInformations> = null) : ServersListMessage
        {
            this.servers = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.servers = new Vector.<GameServerInformations>;
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
            this.serializeAs_ServersListMessage(param1);
            return;
        }// end function

        public function serializeAs_ServersListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.servers.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.servers.length)
            {
                
                (this.servers[_loc_2] as GameServerInformations).serializeAs_GameServerInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ServersListMessage(param1);
            return;
        }// end function

        public function deserializeAs_ServersListMessage(param1:IDataInput) : void
        {
            var _loc_4:GameServerInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new GameServerInformations();
                _loc_4.deserialize(param1);
                this.servers.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
