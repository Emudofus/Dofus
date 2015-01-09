package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildPaddockRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5955;

        private var _isInitialized:Boolean = false;
        public var paddockId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5955);
        }

        public function initGuildPaddockRemovedMessage(paddockId:int=0):GuildPaddockRemovedMessage
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
            this.serializeAs_GuildPaddockRemovedMessage(output);
        }

        public function serializeAs_GuildPaddockRemovedMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.paddockId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildPaddockRemovedMessage(input);
        }

        public function deserializeAs_GuildPaddockRemovedMessage(input:ICustomDataInput):void
        {
            this.paddockId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

