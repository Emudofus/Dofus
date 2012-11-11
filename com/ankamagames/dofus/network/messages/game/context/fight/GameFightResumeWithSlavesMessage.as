package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightResumeWithSlavesMessage extends GameFightResumeMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var slavesInfo:Vector.<GameFightResumeSlaveInfo>;
        public static const protocolId:uint = 6215;

        public function GameFightResumeWithSlavesMessage()
        {
            this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6215;
        }// end function

        public function initGameFightResumeWithSlavesMessage(param1:Vector.<FightDispellableEffectExtendedInformations> = null, param2:Vector.<GameActionMark> = null, param3:uint = 0, param4:Vector.<GameFightSpellCooldown> = null, param5:uint = 0, param6:uint = 0, param7:Vector.<GameFightResumeSlaveInfo> = null) : GameFightResumeWithSlavesMessage
        {
            super.initGameFightResumeMessage(param1, param2, param3, param4, param5, param6);
            this.slavesInfo = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>;
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
            this.serializeAs_GameFightResumeWithSlavesMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightResumeWithSlavesMessage(param1:IDataOutput) : void
        {
            super.serializeAs_GameFightResumeMessage(param1);
            param1.writeShort(this.slavesInfo.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.slavesInfo.length)
            {
                
                (this.slavesInfo[_loc_2] as GameFightResumeSlaveInfo).serializeAs_GameFightResumeSlaveInfo(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightResumeWithSlavesMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightResumeWithSlavesMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new GameFightResumeSlaveInfo();
                _loc_4.deserialize(param1);
                this.slavesInfo.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
