package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightSynchronizeMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var fighters:Vector.<GameFightFighterInformations>;
        public static const protocolId:uint = 5921;

        public function GameFightSynchronizeMessage()
        {
            this.fighters = new Vector.<GameFightFighterInformations>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5921;
        }// end function

        public function initGameFightSynchronizeMessage(param1:Vector.<GameFightFighterInformations> = null) : GameFightSynchronizeMessage
        {
            this.fighters = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.fighters = new Vector.<GameFightFighterInformations>;
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
            this.serializeAs_GameFightSynchronizeMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightSynchronizeMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.fighters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.fighters.length)
            {
                
                param1.writeShort((this.fighters[_loc_2] as GameFightFighterInformations).getTypeId());
                (this.fighters[_loc_2] as GameFightFighterInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightSynchronizeMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightSynchronizeMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:GameFightFighterInformations = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(GameFightFighterInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.fighters.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
