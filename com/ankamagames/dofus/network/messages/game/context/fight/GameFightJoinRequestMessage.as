package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightJoinRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 701;

        private var _isInitialized:Boolean = false;
        public var fighterId:int = 0;
        public var fightId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (701);
        }

        public function initGameFightJoinRequestMessage(fighterId:int=0, fightId:int=0):GameFightJoinRequestMessage
        {
            this.fighterId = fighterId;
            this.fightId = fightId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fighterId = 0;
            this.fightId = 0;
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
            this.serializeAs_GameFightJoinRequestMessage(output);
        }

        public function serializeAs_GameFightJoinRequestMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.fighterId);
            output.writeInt(this.fightId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightJoinRequestMessage(input);
        }

        public function deserializeAs_GameFightJoinRequestMessage(input:ICustomDataInput):void
        {
            this.fighterId = input.readInt();
            this.fightId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

