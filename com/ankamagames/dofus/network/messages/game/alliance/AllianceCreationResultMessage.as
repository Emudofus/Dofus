package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AllianceCreationResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6391;

        private var _isInitialized:Boolean = false;
        public var result:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6391);
        }

        public function initAllianceCreationResultMessage(result:uint=0):AllianceCreationResultMessage
        {
            this.result = result;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.result = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AllianceCreationResultMessage(output);
        }

        public function serializeAs_AllianceCreationResultMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.result);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AllianceCreationResultMessage(input);
        }

        public function deserializeAs_AllianceCreationResultMessage(input:ICustomDataInput):void
        {
            this.result = input.readByte();
            if (this.result < 0)
            {
                throw (new Error((("Forbidden value (" + this.result) + ") on element of AllianceCreationResultMessage.result.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

