package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameActionMark extends Object implements INetworkType
   {
      
      public function GameActionMark() {
         this.cells = new Vector.<GameActionMarkedCell>();
         super();
      }
      
      public static const protocolId:uint = 351;
      
      public var markAuthorId:int = 0;
      
      public var markSpellId:uint = 0;
      
      public var markId:int = 0;
      
      public var markType:int = 0;
      
      public var cells:Vector.<GameActionMarkedCell>;
      
      public function getTypeId() : uint {
         return 351;
      }
      
      public function initGameActionMark(markAuthorId:int=0, markSpellId:uint=0, markId:int=0, markType:int=0, cells:Vector.<GameActionMarkedCell>=null) : GameActionMark {
         this.markAuthorId = markAuthorId;
         this.markSpellId = markSpellId;
         this.markId = markId;
         this.markType = markType;
         this.cells = cells;
         return this;
      }
      
      public function reset() : void {
         this.markAuthorId = 0;
         this.markSpellId = 0;
         this.markId = 0;
         this.markType = 0;
         this.cells = new Vector.<GameActionMarkedCell>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionMark(output);
      }
      
      public function serializeAs_GameActionMark(output:IDataOutput) : void {
         output.writeInt(this.markAuthorId);
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element markSpellId.");
         }
         else
         {
            output.writeInt(this.markSpellId);
            output.writeShort(this.markId);
            output.writeByte(this.markType);
            output.writeShort(this.cells.length);
            _i5 = 0;
            while(_i5 < this.cells.length)
            {
               (this.cells[_i5] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(output);
               _i5++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionMark(input);
      }
      
      public function deserializeAs_GameActionMark(input:IDataInput) : void {
         var _item5:GameActionMarkedCell = null;
         this.markAuthorId = input.readInt();
         this.markSpellId = input.readInt();
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element of GameActionMark.markSpellId.");
         }
         else
         {
            this.markId = input.readShort();
            this.markType = input.readByte();
            _cellsLen = input.readUnsignedShort();
            _i5 = 0;
            while(_i5 < _cellsLen)
            {
               _item5 = new GameActionMarkedCell();
               _item5.deserialize(input);
               this.cells.push(_item5);
               _i5++;
            }
            return;
         }
      }
   }
}
