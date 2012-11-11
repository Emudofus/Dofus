package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightModifyEffectsDurationMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var delta:int = 0;
        public static const protocolId:uint = 6304;

        public function GameActionFightModifyEffectsDurationMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6304;
        }// end function

        public function initGameActionFightModifyEffectsDurationMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0) : GameActionFightModifyEffectsDurationMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.targetId = param3;
            this.delta = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.targetId = 0;
            this.delta = 0;
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
            this.serializeAs_GameActionFightModifyEffectsDurationMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightModifyEffectsDurationMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeInt(this.targetId);
            param1.writeShort(this.delta);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightModifyEffectsDurationMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightModifyEffectsDurationMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.targetId = param1.readInt();
            this.delta = param1.readShort();
            return;
        }// end function

    }
}
