package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightStateChangeMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var stateId:int = 0;
        public var active:Boolean = false;
        public static const protocolId:uint = 5569;

        public function GameActionFightStateChangeMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5569;
        }// end function

        public function initGameActionFightStateChangeMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = false) : GameActionFightStateChangeMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.targetId = param3;
            this.stateId = param4;
            this.active = param5;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.targetId = 0;
            this.stateId = 0;
            this.active = false;
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
            this.serializeAs_GameActionFightStateChangeMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightStateChangeMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeInt(this.targetId);
            param1.writeShort(this.stateId);
            param1.writeBoolean(this.active);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightStateChangeMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightStateChangeMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.targetId = param1.readInt();
            this.stateId = param1.readShort();
            this.active = param1.readBoolean();
            return;
        }// end function

    }
}
