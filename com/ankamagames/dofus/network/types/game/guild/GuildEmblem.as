package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GuildEmblem extends Object implements INetworkType
   {
      
      public function GuildEmblem()
      {
         super();
      }
      
      public static const protocolId:uint = 87;
      
      public var symbolShape:uint = 0;
      
      public var symbolColor:int = 0;
      
      public var backgroundShape:uint = 0;
      
      public var backgroundColor:int = 0;
      
      public function getTypeId() : uint
      {
         return 87;
      }
      
      public function initGuildEmblem(param1:uint = 0, param2:int = 0, param3:uint = 0, param4:int = 0) : GuildEmblem
      {
         this.symbolShape = param1;
         this.symbolColor = param2;
         this.backgroundShape = param3;
         this.backgroundColor = param4;
         return this;
      }
      
      public function reset() : void
      {
         this.symbolShape = 0;
         this.symbolColor = 0;
         this.backgroundShape = 0;
         this.backgroundColor = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GuildEmblem(param1);
      }
      
      public function serializeAs_GuildEmblem(param1:ICustomDataOutput) : void
      {
         if(this.symbolShape < 0)
         {
            throw new Error("Forbidden value (" + this.symbolShape + ") on element symbolShape.");
         }
         else
         {
            param1.writeVarShort(this.symbolShape);
            param1.writeInt(this.symbolColor);
            if(this.backgroundShape < 0)
            {
               throw new Error("Forbidden value (" + this.backgroundShape + ") on element backgroundShape.");
            }
            else
            {
               param1.writeByte(this.backgroundShape);
               param1.writeInt(this.backgroundColor);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GuildEmblem(param1);
      }
      
      public function deserializeAs_GuildEmblem(param1:ICustomDataInput) : void
      {
         this.symbolShape = param1.readVarUhShort();
         if(this.symbolShape < 0)
         {
            throw new Error("Forbidden value (" + this.symbolShape + ") on element of GuildEmblem.symbolShape.");
         }
         else
         {
            this.symbolColor = param1.readInt();
            this.backgroundShape = param1.readByte();
            if(this.backgroundShape < 0)
            {
               throw new Error("Forbidden value (" + this.backgroundShape + ") on element of GuildEmblem.backgroundShape.");
            }
            else
            {
               this.backgroundColor = param1.readInt();
               return;
            }
         }
      }
   }
}
