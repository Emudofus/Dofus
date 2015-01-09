package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class GameRolePlayShowActorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 0x1600;

        private var _isInitialized:Boolean = false;
        public var informations:GameRolePlayActorInformations;

        public function GameRolePlayShowActorMessage()
        {
            this.informations = new GameRolePlayActorInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (0x1600);
        }

        public function initGameRolePlayShowActorMessage(informations:GameRolePlayActorInformations=null):GameRolePlayShowActorMessage
        {
            this.informations = informations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.informations = new GameRolePlayActorInformations();
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
            this.serializeAs_GameRolePlayShowActorMessage(output);
        }

        public function serializeAs_GameRolePlayShowActorMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.informations.getTypeId());
            this.informations.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameRolePlayShowActorMessage(input);
        }

        public function deserializeAs_GameRolePlayShowActorMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.informations = ProtocolTypeManager.getInstance(GameRolePlayActorInformations, _id1);
            this.informations.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay

