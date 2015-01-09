package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInvitationByNameMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6115;

        private var _isInitialized:Boolean = false;
        public var name:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6115);
        }

        public function initGuildInvitationByNameMessage(name:String=""):GuildInvitationByNameMessage
        {
            this.name = name;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.name = "";
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
            this.serializeAs_GuildInvitationByNameMessage(output);
        }

        public function serializeAs_GuildInvitationByNameMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.name);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInvitationByNameMessage(input);
        }

        public function deserializeAs_GuildInvitationByNameMessage(input:ICustomDataInput):void
        {
            this.name = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

