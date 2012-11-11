package com.ankamagames.dofus.network.messages.game.character.stats
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class UpdateLifePointsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public static const protocolId:uint = 5658;

        public function UpdateLifePointsMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5658;
        }// end function

        public function initUpdateLifePointsMessage(param1:uint = 0, param2:uint = 0) : UpdateLifePointsMessage
        {
            this.lifePoints = param1;
            this.maxLifePoints = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_UpdateLifePointsMessage(param1);
            return;
        }// end function

        public function serializeAs_UpdateLifePointsMessage(param1:IDataOutput) : void
        {
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
            }
            param1.writeInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            param1.writeInt(this.maxLifePoints);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_UpdateLifePointsMessage(param1);
            return;
        }// end function

        public function deserializeAs_UpdateLifePointsMessage(param1:IDataInput) : void
        {
            this.lifePoints = param1.readInt();
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element of UpdateLifePointsMessage.lifePoints.");
            }
            this.maxLifePoints = param1.readInt();
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of UpdateLifePointsMessage.maxLifePoints.");
            }
            return;
        }// end function

    }
}
