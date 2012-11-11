package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameMapChangeOrientationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var orientation:ActorOrientation;
        public static const protocolId:uint = 946;

        public function GameMapChangeOrientationMessage()
        {
            this.orientation = new ActorOrientation();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 946;
        }// end function

        public function initGameMapChangeOrientationMessage(param1:ActorOrientation = null) : GameMapChangeOrientationMessage
        {
            this.orientation = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.orientation = new ActorOrientation();
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameMapChangeOrientationMessage(param1);
            return;
        }// end function

        public function serializeAs_GameMapChangeOrientationMessage(param1:IDataOutput) : void
        {
            this.orientation.serializeAs_ActorOrientation(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameMapChangeOrientationMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameMapChangeOrientationMessage(param1:IDataInput) : void
        {
            this.orientation = new ActorOrientation();
            this.orientation.deserialize(param1);
            return;
        }// end function

    }
}
