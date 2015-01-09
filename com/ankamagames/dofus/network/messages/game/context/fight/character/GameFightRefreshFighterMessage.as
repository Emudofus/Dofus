package com.ankamagames.dofus.network.messages.game.context.fight.character
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class GameFightRefreshFighterMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6309;

        private var _isInitialized:Boolean = false;
        public var informations:GameContextActorInformations;

        public function GameFightRefreshFighterMessage()
        {
            this.informations = new GameContextActorInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6309);
        }

        public function initGameFightRefreshFighterMessage(informations:GameContextActorInformations=null):GameFightRefreshFighterMessage
        {
            this.informations = informations;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.informations = new GameContextActorInformations();
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
            this.serializeAs_GameFightRefreshFighterMessage(output);
        }

        public function serializeAs_GameFightRefreshFighterMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.informations.getTypeId());
            this.informations.serialize(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightRefreshFighterMessage(input);
        }

        public function deserializeAs_GameFightRefreshFighterMessage(input:ICustomDataInput):void
        {
            var _id1:uint = input.readUnsignedShort();
            this.informations = ProtocolTypeManager.getInstance(GameContextActorInformations, _id1);
            this.informations.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight.character

