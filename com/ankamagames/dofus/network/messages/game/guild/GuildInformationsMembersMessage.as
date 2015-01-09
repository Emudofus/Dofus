package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GuildInformationsMembersMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5558;

        private var _isInitialized:Boolean = false;
        public var members:Vector.<GuildMember>;

        public function GuildInformationsMembersMessage()
        {
            this.members = new Vector.<GuildMember>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5558);
        }

        public function initGuildInformationsMembersMessage(members:Vector.<GuildMember>=null):GuildInformationsMembersMessage
        {
            this.members = members;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.members = new Vector.<GuildMember>();
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
            this.serializeAs_GuildInformationsMembersMessage(output);
        }

        public function serializeAs_GuildInformationsMembersMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.members.length);
            var _i1:uint;
            while (_i1 < this.members.length)
            {
                (this.members[_i1] as GuildMember).serializeAs_GuildMember(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInformationsMembersMessage(input);
        }

        public function deserializeAs_GuildInformationsMembersMessage(input:ICustomDataInput):void
        {
            var _item1:GuildMember;
            var _membersLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _membersLen)
            {
                _item1 = new GuildMember();
                _item1.deserialize(input);
                this.members.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

