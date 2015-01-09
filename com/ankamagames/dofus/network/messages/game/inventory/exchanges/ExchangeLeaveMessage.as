package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ExchangeLeaveMessage extends LeaveDialogMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5628;

        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5628);
        }

        public function initExchangeLeaveMessage(dialogType:uint=0, success:Boolean=false):ExchangeLeaveMessage
        {
            super.initLeaveDialogMessage(dialogType);
            this.success = success;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.success = false;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ExchangeLeaveMessage(output);
        }

        public function serializeAs_ExchangeLeaveMessage(output:IDataOutput):void
        {
            super.serializeAs_LeaveDialogMessage(output);
            output.writeBoolean(this.success);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeLeaveMessage(input);
        }

        public function deserializeAs_ExchangeLeaveMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.success = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

