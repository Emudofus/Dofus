package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameContextKickMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6081;

        private var _isInitialized:Boolean = false;
        public var targetId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6081);
        }

        public function initGameContextKickMessage(targetId:int=0):GameContextKickMessage
        {
            this.targetId = targetId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.targetId = 0;
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
            this.serializeAs_GameContextKickMessage(output);
        }

        public function serializeAs_GameContextKickMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.targetId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameContextKickMessage(input);
        }

        public function deserializeAs_GameContextKickMessage(input:ICustomDataInput):void
        {
            this.targetId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context

