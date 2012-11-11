package com.ankamagames.dofus.network.messages.game.context.fight.character
{
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightShowFighterRandomStaticPoseMessage extends GameFightShowFighterMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 6218;

        public function GameFightShowFighterRandomStaticPoseMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6218;
        }// end function

        public function initGameFightShowFighterRandomStaticPoseMessage(param1:GameFightFighterInformations = null) : GameFightShowFighterRandomStaticPoseMessage
        {
            super.initGameFightShowFighterMessage(param1);
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameFightShowFighterRandomStaticPoseMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightShowFighterRandomStaticPoseMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightShowFighterMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightShowFighterRandomStaticPoseMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightShowFighterRandomStaticPoseMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
