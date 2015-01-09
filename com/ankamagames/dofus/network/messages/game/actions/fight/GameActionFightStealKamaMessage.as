package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightStealKamaMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5535;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var amount:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5535);
        }

        public function initGameActionFightStealKamaMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, amount:uint=0):GameActionFightStealKamaMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.targetId = targetId;
            this.amount = amount;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.targetId = 0;
            this.amount = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameActionFightStealKamaMessage(output);
        }

        public function serializeAs_GameActionFightStealKamaMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element amount.")));
            };
            output.writeVarInt(this.amount);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightStealKamaMessage(input);
        }

        public function deserializeAs_GameActionFightStealKamaMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.amount = input.readVarUhInt();
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element of GameActionFightStealKamaMessage.amount.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

