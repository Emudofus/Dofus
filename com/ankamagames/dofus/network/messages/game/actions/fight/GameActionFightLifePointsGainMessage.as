package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightLifePointsGainMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6311;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var delta:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6311);
        }

        public function initGameActionFightLifePointsGainMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, delta:uint=0):GameActionFightLifePointsGainMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.targetId = targetId;
            this.delta = delta;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.targetId = 0;
            this.delta = 0;
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
            this.serializeAs_GameActionFightLifePointsGainMessage(output);
        }

        public function serializeAs_GameActionFightLifePointsGainMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if (this.delta < 0)
            {
                throw (new Error((("Forbidden value (" + this.delta) + ") on element delta.")));
            };
            output.writeVarShort(this.delta);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightLifePointsGainMessage(input);
        }

        public function deserializeAs_GameActionFightLifePointsGainMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.delta = input.readVarUhShort();
            if (this.delta < 0)
            {
                throw (new Error((("Forbidden value (" + this.delta) + ") on element of GameActionFightLifePointsGainMessage.delta.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

