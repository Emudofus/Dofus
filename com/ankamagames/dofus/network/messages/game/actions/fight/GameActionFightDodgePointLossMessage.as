package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightDodgePointLossMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5828;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var amount:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5828);
        }

        public function initGameActionFightDodgePointLossMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, amount:uint=0):GameActionFightDodgePointLossMessage
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
            this.serializeAs_GameActionFightDodgePointLossMessage(output);
        }

        public function serializeAs_GameActionFightDodgePointLossMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element amount.")));
            };
            output.writeVarShort(this.amount);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightDodgePointLossMessage(input);
        }

        public function deserializeAs_GameActionFightDodgePointLossMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.amount = input.readVarUhShort();
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element of GameActionFightDodgePointLossMessage.amount.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

