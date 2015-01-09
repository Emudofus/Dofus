package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightLeaveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 721;

        private var _isInitialized:Boolean = false;
        public var charId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (721);
        }

        public function initGameFightLeaveMessage(charId:int=0):GameFightLeaveMessage
        {
            this.charId = charId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.charId = 0;
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
            this.serializeAs_GameFightLeaveMessage(output);
        }

        public function serializeAs_GameFightLeaveMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.charId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightLeaveMessage(input);
        }

        public function deserializeAs_GameFightLeaveMessage(input:ICustomDataInput):void
        {
            this.charId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

