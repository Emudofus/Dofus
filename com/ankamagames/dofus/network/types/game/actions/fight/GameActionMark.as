package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
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
      
      public function initGameActionMark(param1:int=0, param2:uint=0, param3:int=0, param4:int=0, param5:Vector.<GameActionMarkedCell>=null) : GameActionMark {
         this.markAuthorId = param1;
         this.markSpellId = param2;
         this.markId = param3;
         this.markType = param4;
         this.cells = param5;
         return this;
      }
      
      public function reset() : void {
         this.markAuthorId = 0;
         this.markSpellId = 0;
         this.markId = 0;
         this.markType = 0;
         this.cells = new Vector.<GameActionMarkedCell>();
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionMark(param1);
      }
      
      public function serializeAs_GameActionMark(param1:IDataOutput) : void {
         param1.writeInt(this.markAuthorId);
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element markSpellId.");
         }
         else
         {
            param1.writeInt(this.markSpellId);
            param1.writeShort(this.markId);
            param1.writeByte(this.markType);
            param1.writeShort(this.cells.length);
            _loc2_ = 0;
            while(_loc2_ < this.cells.length)
            {
               (this.cells[_loc2_] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionMark(param1);
      }
      
      public function deserializeAs_GameActionMark(param1:IDataInput) : void {
         var _loc4_:GameActionMarkedCell = null;
         this.markAuthorId = param1.readInt();
         this.markSpellId = param1.readInt();
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element of GameActionMark.markSpellId.");
         }
         else
         {
            this.markId = param1.readShort();
            this.markType = param1.readByte();
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = new GameActionMarkedCell();
               _loc4_.deserialize(param1);
               this.cells.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
