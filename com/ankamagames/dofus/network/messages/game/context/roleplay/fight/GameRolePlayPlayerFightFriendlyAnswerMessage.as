package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayPlayerFightFriendlyAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5732;

        private var _isInitialized:Boolean = false;
        public var fightId:int = 0;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5732);
        }

        public function initGameRolePlayPlayerFightFriendlyAnswerMessage(fightId:int=0, accept:Boolean=false):GameRolePlayPlayerFightFriendlyAnswerMessage
        {
            this.fightId = fightId;
            this.accept = accept;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.fightId = 0;
            this.accept = false;
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
            this.serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(output);
        }

        public function serializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.fightId);
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(input);
        }

        public function deserializeAs_GameRolePlayPlayerFightFriendlyAnswerMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight

