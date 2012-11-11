package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameContextRefreshEntityLookMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:int = 0;
        public var look:EntityLook;
        public static const protocolId:uint = 5637;

        public function GameContextRefreshEntityLookMessage()
        {
            this.look = new EntityLook();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5637;
        }// end function

        public function initGameContextRefreshEntityLookMessage(param1:int = 0, param2:EntityLook = null) : GameContextRefreshEntityLookMessage
        {
            this.id = param1;
            this.look = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
            this.look = new EntityLook();
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
            this.serializeAs_GameContextRefreshEntityLookMessage(param1);
            return;
        }// end function

        public function serializeAs_GameContextRefreshEntityLookMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.id);
            this.look.serializeAs_EntityLook(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameContextRefreshEntityLookMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameContextRefreshEntityLookMessage(param1:IDataInput) : void
        {
            this.id = param1.readInt();
            this.look = new EntityLook();
            this.look.deserialize(param1);
            return;
        }// end function

    }
}
