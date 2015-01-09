package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightTurnStartMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 714;

        private var _isInitialized:Boolean = false;
        public var id:int = 0;
        public var waitTime:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (714);
        }

        public function initGameFightTurnStartMessage(id:int=0, waitTime:uint=0):GameFightTurnStartMessage
        {
            this.id = id;
            this.waitTime = waitTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
            this.waitTime = 0;
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
            this.serializeAs_GameFightTurnStartMessage(output);
        }

        public function serializeAs_GameFightTurnStartMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.id);
            if (this.waitTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.waitTime) + ") on element waitTime.")));
            };
            output.writeVarInt(this.waitTime);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightTurnStartMessage(input);
        }

        public function deserializeAs_GameFightTurnStartMessage(input:ICustomDataInput):void
        {
            this.id = input.readInt();
            this.waitTime = input.readVarUhInt();
            if (this.waitTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.waitTime) + ") on element of GameFightTurnStartMessage.waitTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

