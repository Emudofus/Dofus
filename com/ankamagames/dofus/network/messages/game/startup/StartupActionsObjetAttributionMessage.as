package com.ankamagames.dofus.network.messages.game.startup
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class StartupActionsObjetAttributionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var characterId:uint = 0;
        public static const protocolId:uint = 1303;

        public function StartupActionsObjetAttributionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1303;
        }// end function

        public function initStartupActionsObjetAttributionMessage(param1:uint = 0, param2:uint = 0) : StartupActionsObjetAttributionMessage
        {
            this.actionId = param1;
            this.characterId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.actionId = 0;
            this.characterId = 0;
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
            this.serializeAs_StartupActionsObjetAttributionMessage(param1);
            return;
        }// end function

        public function serializeAs_StartupActionsObjetAttributionMessage(param1:IDataOutput) : void
        {
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
            }
            param1.writeInt(this.actionId);
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
            }
            param1.writeInt(this.characterId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StartupActionsObjetAttributionMessage(param1);
            return;
        }// end function

        public function deserializeAs_StartupActionsObjetAttributionMessage(param1:IDataInput) : void
        {
            this.actionId = param1.readInt();
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element of StartupActionsObjetAttributionMessage.actionId.");
            }
            this.characterId = param1.readInt();
            if (this.characterId < 0)
            {
                throw new Error("Forbidden value (" + this.characterId + ") on element of StartupActionsObjetAttributionMessage.characterId.");
            }
            return;
        }// end function

    }
}
