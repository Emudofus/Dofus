package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightStartingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 700;

        private var _isInitialized:Boolean = false;
        public var fightType:uint = 0;
        public var attackerId:int = 0;
        public var defenderId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (700);
        }

        public function initGameFightStartingMessage(fightType:uint=0, attackerId:int=0, defenderId:int=0):GameFightStartingMessage
        {
            this.fightType = fightType;
            this.attackerId = attackerId;
            this.defenderId = defenderId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightType = 0;
            this.attackerId = 0;
            this.defenderId = 0;
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
            this.serializeAs_GameFightStartingMessage(output);
        }

        public function serializeAs_GameFightStartingMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.fightType);
            output.writeInt(this.attackerId);
            output.writeInt(this.defenderId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightStartingMessage(input);
        }

        public function deserializeAs_GameFightStartingMessage(input:ICustomDataInput):void
        {
            this.fightType = input.readByte();
            if (this.fightType < 0)
            {
                throw (new Error((("Forbidden value (" + this.fightType) + ") on element of GameFightStartingMessage.fightType.")));
            };
            this.attackerId = input.readInt();
            this.defenderId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

