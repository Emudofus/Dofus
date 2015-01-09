package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightPlacementSwapPositionsCancelledMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6546;

        private var _isInitialized:Boolean = false;
        public var requestId:uint = 0;
        public var cancellerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6546);
        }

        public function initGameFightPlacementSwapPositionsCancelledMessage(requestId:uint=0, cancellerId:uint=0):GameFightPlacementSwapPositionsCancelledMessage
        {
            this.requestId = requestId;
            this.cancellerId = cancellerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.requestId = 0;
            this.cancellerId = 0;
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
            this.serializeAs_GameFightPlacementSwapPositionsCancelledMessage(output);
        }

        public function serializeAs_GameFightPlacementSwapPositionsCancelledMessage(output:ICustomDataOutput):void
        {
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element requestId.")));
            };
            output.writeInt(this.requestId);
            if (this.cancellerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cancellerId) + ") on element cancellerId.")));
            };
            output.writeVarInt(this.cancellerId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(input);
        }

        public function deserializeAs_GameFightPlacementSwapPositionsCancelledMessage(input:ICustomDataInput):void
        {
            this.requestId = input.readInt();
            if (this.requestId < 0)
            {
                throw (new Error((("Forbidden value (" + this.requestId) + ") on element of GameFightPlacementSwapPositionsCancelledMessage.requestId.")));
            };
            this.cancellerId = input.readVarUhInt();
            if (this.cancellerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.cancellerId) + ") on element of GameFightPlacementSwapPositionsCancelledMessage.cancellerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

