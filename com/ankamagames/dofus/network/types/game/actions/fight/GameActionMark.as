package com.ankamagames.dofus.network.types.game.actions.fight
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionMark extends Object implements INetworkType
    {
        public var markAuthorId:int = 0;
        public var markSpellId:uint = 0;
        public var markId:int = 0;
        public var markType:int = 0;
        public var cells:Vector.<GameActionMarkedCell>;
        public static const protocolId:uint = 351;

        public function GameActionMark()
        {
            this.cells = new Vector.<GameActionMarkedCell>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 351;
        }// end function

        public function initGameActionMark(param1:int = 0, param2:uint = 0, param3:int = 0, param4:int = 0, param5:Vector.<GameActionMarkedCell> = null) : GameActionMark
        {
            this.markAuthorId = param1;
            this.markSpellId = param2;
            this.markId = param3;
            this.markType = param4;
            this.cells = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.markAuthorId = 0;
            this.markSpellId = 0;
            this.markId = 0;
            this.markType = 0;
            this.cells = new Vector.<GameActionMarkedCell>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_GameActionMark(param1);
            return;
        }// end function

        public function serializeAs_GameActionMark(param1:IDataOutput) : void
        {
            param1.writeInt(this.markAuthorId);
            if (this.markSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.markSpellId + ") on element markSpellId.");
            }
            param1.writeInt(this.markSpellId);
            param1.writeShort(this.markId);
            param1.writeByte(this.markType);
            param1.writeShort(this.cells.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.cells.length)
            {
                
                (this.cells[_loc_2] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionMark(param1);
            return;
        }// end function

        public function deserializeAs_GameActionMark(param1:IDataInput) : void
        {
            var _loc_4:GameActionMarkedCell = null;
            this.markAuthorId = param1.readInt();
            this.markSpellId = param1.readInt();
            if (this.markSpellId < 0)
            {
                throw new Error("Forbidden value (" + this.markSpellId + ") on element of GameActionMark.markSpellId.");
            }
            this.markId = param1.readShort();
            this.markType = param1.readByte();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new GameActionMarkedCell();
                _loc_4.deserialize(param1);
                this.cells.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
