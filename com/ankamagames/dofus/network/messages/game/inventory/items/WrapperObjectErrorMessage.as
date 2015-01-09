package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class WrapperObjectErrorMessage extends SymbioticObjectErrorMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6529;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6529);
        }

        public function initWrapperObjectErrorMessage(reason:int=0, errorCode:int=0):WrapperObjectErrorMessage
        {
            super.initSymbioticObjectErrorMessage(reason, errorCode);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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
            this.serializeAs_WrapperObjectErrorMessage(output);
        }

        public function serializeAs_WrapperObjectErrorMessage(output:IDataOutput):void
        {
            super.serializeAs_SymbioticObjectErrorMessage(output);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_WrapperObjectErrorMessage(input);
        }

        public function deserializeAs_WrapperObjectErrorMessage(input:IDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

