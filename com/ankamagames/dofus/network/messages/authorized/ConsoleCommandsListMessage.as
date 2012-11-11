package com.ankamagames.dofus.network.messages.authorized
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ConsoleCommandsListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var aliases:Vector.<String>;
        public var arguments:Vector.<String>;
        public var descriptions:Vector.<String>;
        public static const protocolId:uint = 6127;

        public function ConsoleCommandsListMessage()
        {
            this.aliases = new Vector.<String>;
            this.arguments = new Vector.<String>;
            this.descriptions = new Vector.<String>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6127;
        }// end function

        public function initConsoleCommandsListMessage(param1:Vector.<String> = null, param2:Vector.<String> = null, param3:Vector.<String> = null) : ConsoleCommandsListMessage
        {
            this.aliases = param1;
            this.arguments = param2;
            this.descriptions = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.aliases = new Vector.<String>;
            this.arguments = new Vector.<String>;
            this.descriptions = new Vector.<String>;
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
            this.serializeAs_ConsoleCommandsListMessage(param1);
            return;
        }// end function

        public function serializeAs_ConsoleCommandsListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.aliases.length);
            arguments = 0;
            while (arguments < this.aliases.length)
            {
                
                param1.writeUTF(this.aliases[arguments]);
                arguments = arguments + 1;
            }
            param1.writeShort(arguments.length);
            var _loc_4:* = 0;
            while (_loc_4 < arguments.length)
            {
                
                param1.writeUTF(arguments[_loc_4]);
                _loc_4 = _loc_4 + 1;
            }
            param1.writeShort(this.descriptions.length);
            var _loc_5:* = 0;
            while (_loc_5 < this.descriptions.length)
            {
                
                param1.writeUTF(this.descriptions[_loc_5]);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ConsoleCommandsListMessage(param1);
            return;
        }// end function

        public function deserializeAs_ConsoleCommandsListMessage(param1:IDataInput) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            arguments = param1.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < arguments)
            {
                
                _loc_9 = param1.readUTF();
                this.aliases.push(_loc_9);
                _loc_4 = _loc_4 + 1;
            }
            var _loc_5:* = param1.readUnsignedShort();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_10 = param1.readUTF();
                arguments.push(_loc_10);
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = param1.readUnsignedShort();
            var _loc_8:* = 0;
            while (_loc_8 < _loc_7)
            {
                
                _loc_11 = param1.readUTF();
                this.descriptions.push(_loc_11);
                _loc_8 = _loc_8 + 1;
            }
            return;
        }// end function

    }
}
