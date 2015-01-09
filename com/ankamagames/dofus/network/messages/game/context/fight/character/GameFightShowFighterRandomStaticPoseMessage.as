package com.ankamagames.dofus.network.messages.game.context.fight.character
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameFightShowFighterRandomStaticPoseMessage extends GameFightShowFighterMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6218;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6218);
        }

        public function initGameFightShowFighterRandomStaticPoseMessage(informations:GameFightFighterInformations=null):GameFightShowFighterRandomStaticPoseMessage
        {
            super.initGameFightShowFighterMessage(informations);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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
            this.serializeAs_GameFightShowFighterRandomStaticPoseMessage(output);
        }

        public function serializeAs_GameFightShowFighterRandomStaticPoseMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GameFightShowFighterMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameFightShowFighterRandomStaticPoseMessage(input);
        }

        public function deserializeAs_GameFightShowFighterRandomStaticPoseMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight.character

