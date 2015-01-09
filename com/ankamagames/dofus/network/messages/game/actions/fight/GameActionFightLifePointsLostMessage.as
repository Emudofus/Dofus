package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.AbstractGameActionMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightLifePointsLostMessage extends AbstractGameActionMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6312;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var loss:uint = 0;
        public var permanentDamages:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6312);
        }

        public function initGameActionFightLifePointsLostMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, loss:uint=0, permanentDamages:uint=0):GameActionFightLifePointsLostMessage
        {
            super.initAbstractGameActionMessage(actionId, sourceId);
            this.targetId = targetId;
            this.loss = loss;
            this.permanentDamages = permanentDamages;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.targetId = 0;
            this.loss = 0;
            this.permanentDamages = 0;
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
            this.serializeAs_GameActionFightLifePointsLostMessage(output);
        }

        public function serializeAs_GameActionFightLifePointsLostMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_AbstractGameActionMessage(output);
            output.writeInt(this.targetId);
            if (this.loss < 0)
            {
                throw (new Error((("Forbidden value (" + this.loss) + ") on element loss.")));
            };
            output.writeVarShort(this.loss);
            if (this.permanentDamages < 0)
            {
                throw (new Error((("Forbidden value (" + this.permanentDamages) + ") on element permanentDamages.")));
            };
            output.writeVarShort(this.permanentDamages);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightLifePointsLostMessage(input);
        }

        public function deserializeAs_GameActionFightLifePointsLostMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.targetId = input.readInt();
            this.loss = input.readVarUhShort();
            if (this.loss < 0)
            {
                throw (new Error((("Forbidden value (" + this.loss) + ") on element of GameActionFightLifePointsLostMessage.loss.")));
            };
            this.permanentDamages = input.readVarUhShort();
            if (this.permanentDamages < 0)
            {
                throw (new Error((("Forbidden value (" + this.permanentDamages) + ") on element of GameActionFightLifePointsLostMessage.permanentDamages.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

