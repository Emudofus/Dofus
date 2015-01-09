package com.ankamagames.dofus.network.types.game.actions.fight
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class GameActionMark implements INetworkType 
    {

        public static const protocolId:uint = 351;

        public var markAuthorId:int = 0;
        public var markTeamId:uint = 2;
        public var markSpellId:uint = 0;
        public var markSpellLevel:uint = 0;
        public var markId:int = 0;
        public var markType:int = 0;
        public var markimpactCell:int = 0;
        public var cells:Vector.<GameActionMarkedCell>;
        public var active:Boolean = false;

        public function GameActionMark()
        {
            this.cells = new Vector.<GameActionMarkedCell>();
            super();
        }

        public function getTypeId():uint
        {
            return (351);
        }

        public function initGameActionMark(markAuthorId:int=0, markTeamId:uint=2, markSpellId:uint=0, markSpellLevel:uint=0, markId:int=0, markType:int=0, markimpactCell:int=0, cells:Vector.<GameActionMarkedCell>=null, active:Boolean=false):GameActionMark
        {
            this.markAuthorId = markAuthorId;
            this.markTeamId = markTeamId;
            this.markSpellId = markSpellId;
            this.markSpellLevel = markSpellLevel;
            this.markId = markId;
            this.markType = markType;
            this.markimpactCell = markimpactCell;
            this.cells = cells;
            this.active = active;
            return (this);
        }

        public function reset():void
        {
            this.markAuthorId = 0;
            this.markTeamId = 2;
            this.markSpellId = 0;
            this.markSpellLevel = 0;
            this.markId = 0;
            this.markType = 0;
            this.markimpactCell = 0;
            this.cells = new Vector.<GameActionMarkedCell>();
            this.active = false;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GameActionMark(output);
        }

        public function serializeAs_GameActionMark(output:ICustomDataOutput):void
        {
            output.writeInt(this.markAuthorId);
            output.writeByte(this.markTeamId);
            if (this.markSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.markSpellId) + ") on element markSpellId.")));
            };
            output.writeInt(this.markSpellId);
            if ((((this.markSpellLevel < 1)) || ((this.markSpellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.markSpellLevel) + ") on element markSpellLevel.")));
            };
            output.writeByte(this.markSpellLevel);
            output.writeShort(this.markId);
            output.writeByte(this.markType);
            if ((((this.markimpactCell < -1)) || ((this.markimpactCell > 559))))
            {
                throw (new Error((("Forbidden value (" + this.markimpactCell) + ") on element markimpactCell.")));
            };
            output.writeShort(this.markimpactCell);
            output.writeShort(this.cells.length);
            var _i8:uint;
            while (_i8 < this.cells.length)
            {
                (this.cells[_i8] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(output);
                _i8++;
            };
            output.writeBoolean(this.active);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameActionMark(input);
        }

        public function deserializeAs_GameActionMark(input:ICustomDataInput):void
        {
            var _item8:GameActionMarkedCell;
            this.markAuthorId = input.readInt();
            this.markTeamId = input.readByte();
            if (this.markTeamId < 0)
            {
                throw (new Error((("Forbidden value (" + this.markTeamId) + ") on element of GameActionMark.markTeamId.")));
            };
            this.markSpellId = input.readInt();
            if (this.markSpellId < 0)
            {
                throw (new Error((("Forbidden value (" + this.markSpellId) + ") on element of GameActionMark.markSpellId.")));
            };
            this.markSpellLevel = input.readByte();
            if ((((this.markSpellLevel < 1)) || ((this.markSpellLevel > 6))))
            {
                throw (new Error((("Forbidden value (" + this.markSpellLevel) + ") on element of GameActionMark.markSpellLevel.")));
            };
            this.markId = input.readShort();
            this.markType = input.readByte();
            this.markimpactCell = input.readShort();
            if ((((this.markimpactCell < -1)) || ((this.markimpactCell > 559))))
            {
                throw (new Error((("Forbidden value (" + this.markimpactCell) + ") on element of GameActionMark.markimpactCell.")));
            };
            var _cellsLen:uint = input.readUnsignedShort();
            var _i8:uint;
            while (_i8 < _cellsLen)
            {
                _item8 = new GameActionMarkedCell();
                _item8.deserialize(input);
                this.cells.push(_item8);
                _i8++;
            };
            this.active = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.game.actions.fight

