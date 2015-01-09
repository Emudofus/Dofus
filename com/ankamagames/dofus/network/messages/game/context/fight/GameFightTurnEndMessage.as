package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightTurnEndMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 719;

        private var _isInitialized:Boolean = false;
        public var id:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (719);
        }

        public function initGameFightTurnEndMessage(id:int=0):GameFightTurnEndMessage
        {
            this.id = id;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.id = 0;
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
            this.serializeAs_GameFightTurnEndMessage(output);
        }

        public function serializeAs_GameFightTurnEndMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.id);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightTurnEndMessage(input);
        }

        public function deserializeAs_GameFightTurnEndMessage(input:ICustomDataInput):void
        {
            this.id = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

