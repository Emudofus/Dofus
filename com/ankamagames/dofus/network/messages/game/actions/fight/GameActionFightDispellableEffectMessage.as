package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.messages.game.actions.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightDispellableEffectMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var effect:AbstractFightDispellableEffect;
        public static const protocolId:uint = 6070;

        public function GameActionFightDispellableEffectMessage()
        {
            this.effect = new AbstractFightDispellableEffect();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6070;
        }// end function

        public function initGameActionFightDispellableEffectMessage(param1:uint = 0, param2:int = 0, param3:AbstractFightDispellableEffect = null) : GameActionFightDispellableEffectMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.effect = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.effect = new AbstractFightDispellableEffect();
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
            this.serializeAs_GameActionFightDispellableEffectMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightDispellableEffectMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeShort(this.effect.getTypeId());
            this.effect.serialize(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightDispellableEffectMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightDispellableEffectMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            this.effect = ProtocolTypeManager.getInstance(AbstractFightDispellableEffect, _loc_2);
            this.effect.deserialize(param1);
            return;
        }// end function

    }
}
