package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractGameActionFightTargetedAbilityMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;
        public var destinationCellId:int = 0;
        public var critical:uint = 1;
        public var silentCast:Boolean = false;
        public static const protocolId:uint = 6118;

        public function AbstractGameActionFightTargetedAbilityMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6118;
        }// end function

        public function initAbstractGameActionFightTargetedAbilityMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 1, param6:Boolean = false) : AbstractGameActionFightTargetedAbilityMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.targetId = param3;
            this.destinationCellId = param4;
            this.critical = param5;
            this.silentCast = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.targetId = 0;
            this.destinationCellId = 0;
            this.critical = 1;
            this.silentCast = false;
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
            this.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
            return;
        }// end function

        public function serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeInt(this.targetId);
            if (this.destinationCellId < -1 || this.destinationCellId > 559)
            {
                throw new Error("Forbidden value (" + this.destinationCellId + ") on element destinationCellId.");
            }
            param1.writeShort(this.destinationCellId);
            param1.writeByte(this.critical);
            param1.writeBoolean(this.silentCast);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
            return;
        }// end function

        public function deserializeAs_AbstractGameActionFightTargetedAbilityMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.targetId = param1.readInt();
            this.destinationCellId = param1.readShort();
            if (this.destinationCellId < -1 || this.destinationCellId > 559)
            {
                throw new Error("Forbidden value (" + this.destinationCellId + ") on element of AbstractGameActionFightTargetedAbilityMessage.destinationCellId.");
            }
            this.critical = param1.readByte();
            if (this.critical < 0)
            {
                throw new Error("Forbidden value (" + this.critical + ") on element of AbstractGameActionFightTargetedAbilityMessage.critical.");
            }
            this.silentCast = param1.readBoolean();
            return;
        }// end function

    }
}
