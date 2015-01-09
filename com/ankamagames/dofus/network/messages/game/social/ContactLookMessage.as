package com.ankamagames.dofus.network.messages.game.social
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ContactLookMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5934;

        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var playerName:String = "";
        public var playerId:uint = 0;
        public var look:EntityLook;

        public function ContactLookMessage()
        {
            this.look = new EntityLook();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5934);
        }

        public function initContactLookMessage(requestId:uint=0, playerName:String="", playerId:uint=0, look:EntityLook=null):ContactLookMessage
        {
            this.requestId = requestId;
            this.playerName = playerName;
            this.playerId = playerId;
            this.look = look;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.requestId = 0;
            this.playerName = "";
            this.playerId = 0;
            this.look = new EntityLook();
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
            this.serializeAs_ContactLookMessage(output);
        }

        public function serializeAs_ContactLookMessage(output:ICustomDataOutput):void
        {
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element requestId.")));
            };
            output.writeVarInt(this.requestId);
            output.writeUTF(this.playerName);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
            this.look.serializeAs_EntityLook(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ContactLookMessage(input);
        }

        public function deserializeAs_ContactLookMessage(input:ICustomDataInput):void
        {
            this.requestId = input.readVarUhInt();
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element of ContactLookMessage.requestId.")));
            };
            this.playerName = input.readUTF();
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of ContactLookMessage.playerId.")));
            };
            this.look = new EntityLook();
            this.look.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.social

