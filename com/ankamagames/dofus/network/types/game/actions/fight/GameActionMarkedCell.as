package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameActionMarkedCell extends Object implements INetworkType
   {
      
      public function GameActionMarkedCell() {
         super();
      }
      
      public static const protocolId:uint = 85;
      
      public var cellId:uint = 0;
      
      public var zoneSize:int = 0;
      
      public var cellColor:int = 0;
      
      public var cellsType:int = 0;
      
      public function getTypeId() : uint {
         return 85;
      }
      
      public function initGameActionMarkedCell(cellId:uint = 0, zoneSize:int = 0, cellColor:int = 0, cellsType:int = 0) : GameActionMarkedCell {
         this.cellId = cellId;
         this.zoneSize = zoneSize;
         this.cellColor = cellColor;
         this.cellsType = cellsType;
         return this;
      }
      
      public function reset() : void {
         this.cellId = 0;
         this.zoneSize = 0;
         this.cellColor = 0;
         this.cellsType = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameActionMarkedCell(output);
      }
      
      public function serializeAs_GameActionMarkedCell(output:IDataOutput) : void {
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            output.writeByte(this.zoneSize);
            output.writeInt(this.cellColor);
            output.writeByte(this.cellsType);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionMarkedCell(input);
      }
      
      public function deserializeAs_GameActionMarkedCell(input:IDataInput) : void {
         this.cellId = input.readShort();
         if((this.cellId < 0) || (this.cellId > 559))
         {
            throw new Error("Forbidden value (" + this.cellId + ") on element of GameActionMarkedCell.cellId.");
         }
         else
         {
            this.zoneSize = input.readByte();
            this.cellColor = input.readInt();
            this.cellsType = input.readByte();
            return;
         }
      }
   }
}
