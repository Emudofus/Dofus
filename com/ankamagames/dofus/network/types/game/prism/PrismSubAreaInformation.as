package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class PrismSubAreaInformation extends Object implements INetworkType
   {
         

      public function PrismSubAreaInformation() {
         super();
      }

      public static const protocolId:uint = 142;

      public var worldX:int = 0;

      public var worldY:int = 0;

      public var mapId:int = 0;

      public var subAreaId:uint = 0;

      public var alignment:uint = 0;

      public var isInFight:Boolean = false;

      public var isFightable:Boolean = false;

      public function getTypeId() : uint {
         return 142;
      }

      public function initPrismSubAreaInformation(worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, alignment:uint=0, isInFight:Boolean=false, isFightable:Boolean=false) : PrismSubAreaInformation {
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.subAreaId=subAreaId;
         this.alignment=alignment;
         this.isInFight=isInFight;
         this.isFightable=isFightable;
         return this;
      }

      public function reset() : void {
         this.worldX=0;
         this.worldY=0;
         this.mapId=0;
         this.subAreaId=0;
         this.alignment=0;
         this.isInFight=false;
         this.isFightable=false;
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PrismSubAreaInformation(output);
      }

      public function serializeAs_PrismSubAreaInformation(output:IDataOutput) : void {
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeInt(this.mapId);
               if(this.subAreaId<0)
               {
                  throw new Error("Forbidden value ("+this.subAreaId+") on element subAreaId.");
               }
               else
               {
                  output.writeShort(this.subAreaId);
                  if(this.alignment<0)
                  {
                     throw new Error("Forbidden value ("+this.alignment+") on element alignment.");
                  }
                  else
                  {
                     output.writeByte(this.alignment);
                     output.writeBoolean(this.isInFight);
                     output.writeBoolean(this.isFightable);
                     return;
                  }
               }
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismSubAreaInformation(input);
      }

      public function deserializeAs_PrismSubAreaInformation(input:IDataInput) : void {
         this.worldX=input.readShort();
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element of PrismSubAreaInformation.worldX.");
         }
         else
         {
            this.worldY=input.readShort();
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element of PrismSubAreaInformation.worldY.");
            }
            else
            {
               this.mapId=input.readInt();
               this.subAreaId=input.readShort();
               if(this.subAreaId<0)
               {
                  throw new Error("Forbidden value ("+this.subAreaId+") on element of PrismSubAreaInformation.subAreaId.");
               }
               else
               {
                  this.alignment=input.readByte();
                  if(this.alignment<0)
                  {
                     throw new Error("Forbidden value ("+this.alignment+") on element of PrismSubAreaInformation.alignment.");
                  }
                  else
                  {
                     this.isInFight=input.readBoolean();
                     this.isFightable=input.readBoolean();
                     return;
                  }
               }
            }
         }
      }
   }

}