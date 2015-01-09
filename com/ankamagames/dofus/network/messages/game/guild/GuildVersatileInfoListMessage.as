package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.social.GuildVersatileInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildVersatileInfoListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6435;

        private var _isInitialized:Boolean = false;
        public var guilds:Vector.<GuildVersatileInformations>;

        public function GuildVersatileInfoListMessage()
        {
            this.guilds = new Vector.<GuildVersatileInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6435);
        }

        public function initGuildVersatileInfoListMessage(guilds:Vector.<GuildVersatileInformations>=null):GuildVersatileInfoListMessage
        {
            this.guilds = guilds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guilds = new Vector.<GuildVersatileInformations>();
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
            this.serializeAs_GuildVersatileInfoListMessage(output);
        }

        public function serializeAs_GuildVersatileInfoListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.guilds.length);
            var _i1:uint;
            while (_i1 < this.guilds.length)
            {
                output.writeShort((this.guilds[_i1] as GuildVersatileInformations).getTypeId());
                (this.guilds[_i1] as GuildVersatileInformations).serialize(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildVersatileInfoListMessage(input);
        }

        public function deserializeAs_GuildVersatileInfoListMessage(input:ICustomDataInput):void
        {
            var _id1:uint;
            var _item1:GuildVersatileInformations;
            var _guildsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _guildsLen)
            {
                _id1 = input.readUnsignedShort();
                _item1 = ProtocolTypeManager.getInstance(GuildVersatileInformations, _id1);
                _item1.deserialize(input);
                this.guilds.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

