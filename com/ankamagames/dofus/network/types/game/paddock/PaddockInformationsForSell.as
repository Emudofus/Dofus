package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PaddockInformationsForSell extends Object implements INetworkType
   {
      
      public function PaddockInformationsForSell() {
         super();
      }
      
      public static const protocolId:uint = 222;
      
      public var guildOwner:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var nbMount:int = 0;
      
      public var nbObject:int = 0;
      
      public var price:uint = 0;
      
      public function getTypeId() : uint {
         return 222;
      }
      
      public function initPaddockInformationsForSell(guildOwner:String="", worldX:int=0, worldY:int=0, subAreaId:uint=0, nbMount:int=0, nbObject:int=0, price:uint=0) : PaddockInformationsForSell {
         this.guildOwner = guildOwner;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.nbMount = nbMount;
         this.nbObject = nbObject;
         this.price = price;
         return this;
      }
      
      public function reset() : void {
         this.guildOwner = "";
         this.worldX = 0;
         this.worldY = 0;
         this.subAreaId = 0;
         this.nbMount = 0;
         this.nbObject = 0;
         this.price = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PaddockInformationsForSell(output);
      }
      
      public function serializeAs_PaddockInformationsForSell(output:IDataOutput) : void {
         output.writeUTF(this.guildOwner);
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
               }
               else
               {
                  output.writeShort(this.subAreaId);
                  output.writeByte(this.nbMount);
                  output.writeByte(this.nbObject);
                  if(this.price < 0)
                  {
                     throw new Error("Forbidden value (" + this.price + ") on element price.");
                  }
                  else
                  {
                     output.writeInt(this.price);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PaddockInformationsForSell(input);
      }
      
      public function deserializeAs_PaddockInformationsForSell(input:IDataInput) : void {
         this.guildOwner = input.readUTF();
         this.worldX = input.readShort();
         if((this.worldX < -255) || (this.worldX > 255))
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockInformationsForSell.worldX.");
         }
         else
         {
            this.worldY = input.readShort();
            if((this.worldY < -255) || (this.worldY > 255))
            {
               throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockInformationsForSell.worldY.");
            }
            else
            {
               this.subAreaId = input.readShort();
               if(this.subAreaId < 0)
               {
                  throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockInformationsForSell.subAreaId.");
               }
               else
               {
                  this.nbMount = input.readByte();
                  this.nbObject = input.readByte();
                  this.price = input.readInt();
                  if(this.price < 0)
                  {
                     throw new Error("Forbidden value (" + this.price + ") on element of PaddockInformationsForSell.price.");
                  }
                  else
                  {
                     return;
                  }
               }
            }
         }
      }
   }
}
