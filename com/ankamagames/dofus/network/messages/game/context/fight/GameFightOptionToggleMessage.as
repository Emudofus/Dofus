package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightOptionToggleMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 707;

        private var _isInitialized:Boolean = false;
        public var option:uint = 3;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (707);
        }

        public function initGameFightOptionToggleMessage(option:uint=3):GameFightOptionToggleMessage
        {
            this.option = option;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.option = 3;
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
            this.serializeAs_GameFightOptionToggleMessage(output);
        }

        public function serializeAs_GameFightOptionToggleMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.option);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightOptionToggleMessage(input);
        }

        public function deserializeAs_GameFightOptionToggleMessage(input:ICustomDataInput):void
        {
            this.option = input.readByte();
            if (this.option < 0)
            {
                throw (new Error((("Forbidden value (" + this.option) + ") on element of GameFightOptionToggleMessage.option.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

