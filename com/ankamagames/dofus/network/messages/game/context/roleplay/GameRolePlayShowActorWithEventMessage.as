package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameRolePlayShowActorWithEventMessage extends GameRolePlayShowActorMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6407;

        private var _isInitialized:Boolean = false;
        public var actorEventId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6407);
        }

        public function initGameRolePlayShowActorWithEventMessage(informations:GameRolePlayActorInformations=null, actorEventId:uint=0):GameRolePlayShowActorWithEventMessage
        {
            super.initGameRolePlayShowActorMessage(informations);
            this.actorEventId = actorEventId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.actorEventId = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameRolePlayShowActorWithEventMessage(output);
        }

        public function serializeAs_GameRolePlayShowActorWithEventMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameRolePlayShowActorMessage(output);
            if (this.actorEventId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actorEventId) + ") on element actorEventId.")));
            };
            output.writeByte(this.actorEventId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayShowActorWithEventMessage(input);
        }

        public function deserializeAs_GameRolePlayShowActorWithEventMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.actorEventId = input.readByte();
            if (this.actorEventId < 0)
            {
                throw (new Error((("Forbidden value (" + this.actorEventId) + ") on element of GameRolePlayShowActorWithEventMessage.actorEventId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

