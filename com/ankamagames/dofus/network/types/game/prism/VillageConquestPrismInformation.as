package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;


   public class VillageConquestPrismInformation extends Object implements INetworkType
   {
         

      public function VillageConquestPrismInformation() {
         super();
      }

      public static const protocolId:uint = 379;

      public var areaId:uint = 0;

      public var areaAlignment:uint = 0;

      public var isEntered:Boolean = false;

      public var isInRoom:Boolean = false;

      public function getTypeId() : uint {
         return 379;
      }

      public function initVillageConquestPrismInformation(areaId:uint=0, areaAlignment:uint=0, isEntered:Boolean=false, isInRoom:Boolean=false) : VillageConquestPrismInformation {
         this.areaId=areaId;
         this.areaAlignment=areaAlignment;
         this.isEntered=isEntered;
         this.isInRoom=isInRoom;
         return this;
      }

      public function reset() : void {
         this.areaId=0;
         this.areaAlignment=0;
         this.isEntered=false;
         this.isInRoom=false;
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_VillageConquestPrismInformation(output);
      }

      public function serializeAs_VillageConquestPrismInformation(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0=BooleanByteWrapper.setFlag(_box0,0,this.isEntered);
         _box0=BooleanByteWrapper.setFlag(_box0,1,this.isInRoom);
         output.writeByte(_box0);
         if(this.areaId<0)
         {
            throw new Error("Forbidden value ("+this.areaId+") on element areaId.");
         }
         else
         {
            output.writeShort(this.areaId);
            if(this.areaAlignment<0)
            {
               throw new Error("Forbidden value ("+this.areaAlignment+") on element areaAlignment.");
            }
            else
            {
               output.writeByte(this.areaAlignment);
               return;
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_VillageConquestPrismInformation(input);
      }

      public function deserializeAs_VillageConquestPrismInformation(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.isEntered=BooleanByteWrapper.getFlag(_box0,0);
         this.isInRoom=BooleanByteWrapper.getFlag(_box0,1);
         this.areaId=input.readShort();
         if(this.areaId<0)
         {
            throw new Error("Forbidden value ("+this.areaId+") on element of VillageConquestPrismInformation.areaId.");
         }
         else
         {
            this.areaAlignment=input.readByte();
            if(this.areaAlignment<0)
            {
               throw new Error("Forbidden value ("+this.areaAlignment+") on element of VillageConquestPrismInformation.areaAlignment.");
            }
            else
            {
               return;
            }
         }
      }
   }

}