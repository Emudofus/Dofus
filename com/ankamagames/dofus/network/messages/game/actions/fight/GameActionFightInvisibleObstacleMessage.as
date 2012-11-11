package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightInvisibleObstacleMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sourceSpellId:uint = 0;
        public static const protocolId:uint = 5820;

        public function GameActionFightInvisibleObstacleMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5820;
        }// end function

        public function initGameActionFightInvisibleObstacleMessage(param1:uint = 0, param2:int = 0, param3:uint = 0) : GameActionFightInvisibleObstacleMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.sourceSpellId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.sourceSpellId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameActionFightInvisibleObstacleMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightInvisibleObstacleMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            if (this.sourceSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.sourceSpellId + ") on element sourceSpellId.");
            }
            param1.writeInt(this.sourceSpellId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightInvisibleObstacleMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightInvisibleObstacleMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.sourceSpellId = param1.readInt();
            if (this.sourceSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.sourceSpellId + ") on element of GameActionFightInvisibleObstacleMessage.sourceSpellId.");
            }
            return;
        }// end function

    }
}
