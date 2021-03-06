﻿package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameActionFightLifeAndShieldPointsLostMessage extends GameActionFightLifePointsLostMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6310;

        private var _isInitialized:Boolean = false;
        public var shieldLoss:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6310);
        }

        public function initGameActionFightLifeAndShieldPointsLostMessage(actionId:uint=0, sourceId:int=0, targetId:int=0, loss:uint=0, permanentDamages:uint=0, shieldLoss:uint=0):GameActionFightLifeAndShieldPointsLostMessage
        {
            super.initGameActionFightLifePointsLostMessage(actionId, sourceId, targetId, loss, permanentDamages);
            this.shieldLoss = shieldLoss;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.shieldLoss = 0;
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
            this.serializeAs_GameActionFightLifeAndShieldPointsLostMessage(output);
        }

        public function serializeAs_GameActionFightLifeAndShieldPointsLostMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameActionFightLifePointsLostMessage(output);
            if (this.shieldLoss < 0)
            {
                throw (new Error((("Forbidden value (" + this.shieldLoss) + ") on element shieldLoss.")));
            };
            output.writeVarShort(this.shieldLoss);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(input);
        }

        public function deserializeAs_GameActionFightLifeAndShieldPointsLostMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.shieldLoss = input.readVarUhShort();
            if (this.shieldLoss < 0)
            {
                throw (new Error((("Forbidden value (" + this.shieldLoss) + ") on element of GameActionFightLifeAndShieldPointsLostMessage.shieldLoss.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.actions.fight

