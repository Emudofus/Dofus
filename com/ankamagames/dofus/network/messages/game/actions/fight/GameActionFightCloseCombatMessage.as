package com.ankamagames.dofus.network.messages.game.actions.fight
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionFightCloseCombatMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var weaponGenericId:uint = 0;
        public static const protocolId:uint = 6116;

        public function GameActionFightCloseCombatMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6116;
        }// end function

        public function initGameActionFightCloseCombatMessage(param1:uint = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 1, param6:Boolean = false, param7:uint = 0) : GameActionFightCloseCombatMessage
        {
            super.initAbstractGameActionFightTargetedAbilityMessage(param1, param2, param3, param4, param5, param6);
            this.weaponGenericId = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.weaponGenericId = 0;
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
            this.serializeAs_GameActionFightCloseCombatMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionFightCloseCombatMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
            if (this.weaponGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.weaponGenericId + ") on element weaponGenericId.");
            }
            param1.writeInt(this.weaponGenericId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionFightCloseCombatMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionFightCloseCombatMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.weaponGenericId = param1.readInt();
            if (this.weaponGenericId < 0)
            {
                throw new Error("Forbidden value (" + this.weaponGenericId + ") on element of GameActionFightCloseCombatMessage.weaponGenericId.");
            }
            return;
        }// end function

    }
}
