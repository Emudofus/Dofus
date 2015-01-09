package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayAggressionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6073;

        private var _isInitialized:Boolean = false;
        public var attackerId:uint = 0;
        public var defenderId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6073);
        }

        public function initGameRolePlayAggressionMessage(attackerId:uint=0, defenderId:uint=0):GameRolePlayAggressionMessage
        {
            this.attackerId = attackerId;
            this.defenderId = defenderId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_GameRolePlayAggressionMessage(output);
        }

        public function serializeAs_GameRolePlayAggressionMessage(output:ICustomDataOutput):void
        {
            if (this.attackerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.attackerId) + ") on element attackerId.")));
            };
            output.writeVarInt(this.attackerId);
            if (this.defenderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.defenderId) + ") on element defenderId.")));
            };
            output.writeVarInt(this.defenderId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayAggressionMessage(input);
        }

        public function deserializeAs_GameRolePlayAggressionMessage(input:ICustomDataInput):void
        {
            this.attackerId = input.readVarUhInt();
            if (this.attackerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.attackerId) + ") on element of GameRolePlayAggressionMessage.attackerId.")));
            };
            this.defenderId = input.readVarUhInt();
            if (this.defenderId < 0)
            {
                throw (new Error((("Forbidden value (" + this.defenderId) + ") on element of GameRolePlayAggressionMessage.defenderId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight

