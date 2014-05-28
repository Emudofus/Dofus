package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GuildEmblem extends Object implements INetworkType
   {
      
      public function GuildEmblem() {
         super();
      }
      
      public static const protocolId:uint = 87;
      
      public var symbolShape:int = 0;
      
      public var symbolColor:int = 0;
      
      public var backgroundShape:int = 0;
      
      public var backgroundColor:int = 0;
      
      public function getTypeId() : uint {
         return 87;
      }
      
      public function initGuildEmblem(symbolShape:int = 0, symbolColor:int = 0, backgroundShape:int = 0, backgroundColor:int = 0) : GuildEmblem {
         this.symbolShape = symbolShape;
         this.symbolColor = symbolColor;
         this.backgroundShape = backgroundShape;
         this.backgroundColor = backgroundColor;
         return this;
      }
      
      public function reset() : void {
         this.symbolShape = 0;
         this.symbolColor = 0;
         this.backgroundShape = 0;
         this.backgroundColor = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GuildEmblem(output);
      }
      
      public function serializeAs_GuildEmblem(output:IDataOutput) : void {
         output.writeShort(this.symbolShape);
         output.writeInt(this.symbolColor);
         output.writeShort(this.backgroundShape);
         output.writeInt(this.backgroundColor);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildEmblem(input);
      }
      
      public function deserializeAs_GuildEmblem(input:IDataInput) : void {
         this.symbolShape = input.readShort();
         this.symbolColor = input.readInt();
         this.backgroundShape = input.readShort();
         this.backgroundColor = input.readInt();
      }
   }
}
