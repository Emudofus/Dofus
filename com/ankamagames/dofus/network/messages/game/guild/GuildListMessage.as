package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6413;

        private var _isInitialized:Boolean = false;
        public var guilds:Vector.<GuildInformations>;

        public function GuildListMessage()
        {
            this.guilds = new Vector.<GuildInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6413);
        }

        public function initGuildListMessage(guilds:Vector.<GuildInformations>=null):GuildListMessage
        {
            this.guilds = guilds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guilds = new Vector.<GuildInformations>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildListMessage(output);
        }

        public function serializeAs_GuildListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.guilds.length);
            var _i1:uint;
            while (_i1 < this.guilds.length)
            {
                (this.guilds[_i1] as GuildInformations).serializeAs_GuildInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildListMessage(input);
        }

        public function deserializeAs_GuildListMessage(input:ICustomDataInput):void
        {
            var _item1:GuildInformations;
            var _guildsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _guildsLen)
            {
                _item1 = new GuildInformations();
                _item1.deserialize(input);
                this.guilds.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

