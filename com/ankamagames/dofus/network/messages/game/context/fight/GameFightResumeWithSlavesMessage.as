package com.ankamagames.dofus.network.messages.game.context.fight
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightResumeSlaveInfo;
    import com.ankamagames.dofus.network.types.game.action.fight.FightDispellableEffectExtendedInformations;
    import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMark;
    import com.ankamagames.dofus.network.types.game.context.fight.GameFightSpellCooldown;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameFightResumeWithSlavesMessage extends GameFightResumeMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6215;

        private var _isInitialized:Boolean = false;
        public var slavesInfo:Vector.<GameFightResumeSlaveInfo>;

        public function GameFightResumeWithSlavesMessage()
        {
            this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6215);
        }

        public function initGameFightResumeWithSlavesMessage(effects:Vector.<FightDispellableEffectExtendedInformations>=null, marks:Vector.<GameActionMark>=null, gameTurn:uint=0, fightStart:uint=0, spellCooldowns:Vector.<GameFightSpellCooldown>=null, summonCount:uint=0, bombCount:uint=0, slavesInfo:Vector.<GameFightResumeSlaveInfo>=null):GameFightResumeWithSlavesMessage
        {
            super.initGameFightResumeMessage(effects, marks, gameTurn, fightStart, spellCooldowns, summonCount, bombCount);
            this.slavesInfo = slavesInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.slavesInfo = new Vector.<GameFightResumeSlaveInfo>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_GameFightResumeWithSlavesMessage(output);
        }

        public function serializeAs_GameFightResumeWithSlavesMessage(output:IDataOutput):void
        {
            super.serializeAs_GameFightResumeMessage(output);
            output.writeShort(this.slavesInfo.length);
            var _i1:uint;
            while (_i1 < this.slavesInfo.length)
            {
                (this.slavesInfo[_i1] as GameFightResumeSlaveInfo).serializeAs_GameFightResumeSlaveInfo(output);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GameFightResumeWithSlavesMessage(input);
        }

        public function deserializeAs_GameFightResumeWithSlavesMessage(input:IDataInput):void
        {
            var _item1:GameFightResumeSlaveInfo;
            super.deserialize(input);
            var _slavesInfoLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _slavesInfoLen)
            {
                _item1 = new GameFightResumeSlaveInfo();
                _item1.deserialize(input);
                this.slavesInfo.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.fight

