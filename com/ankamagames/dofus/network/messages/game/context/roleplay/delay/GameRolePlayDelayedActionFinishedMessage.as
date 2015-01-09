package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayDelayedActionFinishedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6150;

        private var _isInitialized:Boolean = false;
        public var delayedCharacterId:int = 0;
        public var delayTypeId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6150);
        }

        public function initGameRolePlayDelayedActionFinishedMessage(delayedCharacterId:int=0, delayTypeId:uint=0):GameRolePlayDelayedActionFinishedMessage
        {
            this.delayedCharacterId = delayedCharacterId;
            this.delayTypeId = delayTypeId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.delayedCharacterId = 0;
            this.delayTypeId = 0;
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
            this.serializeAs_GameRolePlayDelayedActionFinishedMessage(output);
        }

        public function serializeAs_GameRolePlayDelayedActionFinishedMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.delayedCharacterId);
            output.writeByte(this.delayTypeId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayDelayedActionFinishedMessage(input);
        }

        public function deserializeAs_GameRolePlayDelayedActionFinishedMessage(input:ICustomDataInput):void
        {
            this.delayedCharacterId = input.readInt();
            this.delayTypeId = input.readByte();
            if (this.delayTypeId < 0)
            {
                throw (new Error((("Forbidden value (" + this.delayTypeId) + ") on element of GameRolePlayDelayedActionFinishedMessage.delayTypeId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.delay

