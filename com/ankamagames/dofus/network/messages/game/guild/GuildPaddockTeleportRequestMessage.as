package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildPaddockTeleportRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5957;

        private var _isInitialized:Boolean = false;
        public var paddockId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5957);
        }

        public function initGuildPaddockTeleportRequestMessage(paddockId:int=0):GuildPaddockTeleportRequestMessage
        {
            this.paddockId = paddockId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paddockId = 0;
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
            this.serializeAs_GuildPaddockTeleportRequestMessage(output);
        }

        public function serializeAs_GuildPaddockTeleportRequestMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.paddockId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildPaddockTeleportRequestMessage(input);
        }

        public function deserializeAs_GuildPaddockTeleportRequestMessage(input:ICustomDataInput):void
        {
            this.paddockId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

