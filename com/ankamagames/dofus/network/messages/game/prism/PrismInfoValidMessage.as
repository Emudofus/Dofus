package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.dofus.network.types.game.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismInfoValidMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;
        public static const protocolId:uint = 5858;

        public function PrismInfoValidMessage()
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5858;
        }// end function

        public function initPrismInfoValidMessage(param1:ProtectedEntityWaitingForHelpInfo = null) : PrismInfoValidMessage
        {
            this.waitingForHelpInfo = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
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
            this.serializeAs_PrismInfoValidMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismInfoValidMessage(param1:IDataOutput) : void
        {
            this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismInfoValidMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismInfoValidMessage(param1:IDataInput) : void
        {
            this.waitingForHelpInfo = new ProtectedEntityWaitingForHelpInfo();
            this.waitingForHelpInfo.deserialize(param1);
            return;
        }// end function

    }
}
