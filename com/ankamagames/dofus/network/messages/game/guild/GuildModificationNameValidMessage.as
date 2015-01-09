package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildModificationNameValidMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6327;

        private var _isInitialized:Boolean = false;
        public var guildName:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6327);
        }

        public function initGuildModificationNameValidMessage(guildName:String=""):GuildModificationNameValidMessage
        {
            this.guildName = guildName;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.guildName = "";
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
            this.serializeAs_GuildModificationNameValidMessage(output);
        }

        public function serializeAs_GuildModificationNameValidMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.guildName);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildModificationNameValidMessage(input);
        }

        public function deserializeAs_GuildModificationNameValidMessage(input:ICustomDataInput):void
        {
            this.guildName = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

