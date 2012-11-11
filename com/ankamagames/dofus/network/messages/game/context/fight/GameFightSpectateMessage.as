package com.ankamagames.dofus.network.messages.game.context.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.action.fight.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameFightSpectateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var effects:Vector.<FightDispellableEffectExtendedInformations>;
        public var marks:Vector.<GameActionMark>;
        public var gameTurn:uint = 0;
        public static const protocolId:uint = 6069;

        public function GameFightSpectateMessage()
        {
            this.effects = new Vector.<FightDispellableEffectExtendedInformations>;
            this.marks = new Vector.<GameActionMark>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6069;
        }// end function

        public function initGameFightSpectateMessage(param1:Vector.<FightDispellableEffectExtendedInformations> = null, param2:Vector.<GameActionMark> = null, param3:uint = 0) : GameFightSpectateMessage
        {
            this.effects = param1;
            this.marks = param2;
            this.gameTurn = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.effects = new Vector.<FightDispellableEffectExtendedInformations>;
            this.marks = new Vector.<GameActionMark>;
            this.gameTurn = 0;
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
            this.serializeAs_GameFightSpectateMessage(param1);
            return;
        }// end function

        public function serializeAs_GameFightSpectateMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.effects.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.effects.length)
            {
                
                (this.effects[_loc_2] as FightDispellableEffectExtendedInformations).serializeAs_FightDispellableEffectExtendedInformations(param1);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.marks.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.marks.length)
            {
                
                (this.marks[_loc_3] as GameActionMark).serializeAs_GameActionMark(param1);
                _loc_3 = _loc_3 + 1;
            }
            if (this.gameTurn < 0)
            {
                throw new Error("Forbidden value (" + this.gameTurn + ") on element gameTurn.");
            }
            param1.writeShort(this.gameTurn);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameFightSpectateMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameFightSpectateMessage(param1:IDataInput) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = new FightDispellableEffectExtendedInformations();
                _loc_6.deserialize(param1);
                this.effects.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = new GameActionMark();
                _loc_7.deserialize(param1);
                this.marks.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            this.gameTurn = param1.readShort();
            if (this.gameTurn < 0)
            {
                throw new Error("Forbidden value (" + this.gameTurn + ") on element of GameFightSpectateMessage.gameTurn.");
            }
            return;
        }// end function

    }
}
