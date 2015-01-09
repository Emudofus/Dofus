package com.ankamagames.dofus.network.messages.authorized
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ConsoleCommandsListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6127;

        private var _isInitialized:Boolean = false;
        public var aliases:Vector.<String>;
        public var args:Vector.<String>;
        public var descriptions:Vector.<String>;

        public function ConsoleCommandsListMessage()
        {
            this.aliases = new Vector.<String>();
            this.args = new Vector.<String>();
            this.descriptions = new Vector.<String>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6127);
        }

        public function initConsoleCommandsListMessage(aliases:Vector.<String>=null, args:Vector.<String>=null, descriptions:Vector.<String>=null):ConsoleCommandsListMessage
        {
            this.aliases = aliases;
            this.args = args;
            this.descriptions = descriptions;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.aliases = new Vector.<String>();
            this.args = new Vector.<String>();
            this.descriptions = new Vector.<String>();
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
            this.serializeAs_ConsoleCommandsListMessage(output);
        }

        public function serializeAs_ConsoleCommandsListMessage(output:IDataOutput):void
        {
            output.writeShort(this.aliases.length);
            var _i1:uint;
            while (_i1 < this.aliases.length)
            {
                output.writeUTF(this.aliases[_i1]);
                _i1++;
            };
            output.writeShort(this.args.length);
            var _i2:uint;
            while (_i2 < this.args.length)
            {
                output.writeUTF(this.args[_i2]);
                _i2++;
            };
            output.writeShort(this.descriptions.length);
            var _i3:uint;
            while (_i3 < this.descriptions.length)
            {
                output.writeUTF(this.descriptions[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ConsoleCommandsListMessage(input);
        }

        public function deserializeAs_ConsoleCommandsListMessage(input:IDataInput):void
        {
            var _val1:String;
            var _val2:String;
            var _val3:String;
            var _aliasesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _aliasesLen)
            {
                _val1 = input.readUTF();
                this.aliases.push(_val1);
                _i1++;
            };
            var _argsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _argsLen)
            {
                _val2 = input.readUTF();
                this.args.push(_val2);
                _i2++;
            };
            var _descriptionsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _descriptionsLen)
            {
                _val3 = input.readUTF();
                this.descriptions.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.authorized

