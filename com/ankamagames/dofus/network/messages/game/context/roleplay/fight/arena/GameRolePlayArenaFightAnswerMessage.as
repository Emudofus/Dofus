package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayArenaFightAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6279;

        private var _isInitialized:Boolean = false;
        public var fightId:int = 0;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6279);
        }

        public function initGameRolePlayArenaFightAnswerMessage(fightId:int=0, accept:Boolean=false):GameRolePlayArenaFightAnswerMessage
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
            this.serializeAs_GameRolePlayArenaFightAnswerMessage(output);
        }

        public function serializeAs_GameRolePlayArenaFightAnswerMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.fightId);
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayArenaFightAnswerMessage(input);
        }

        public function deserializeAs_GameRolePlayArenaFightAnswerMessage(input:ICustomDataInput):void
        {
            this.fightId = input.readInt();
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena

