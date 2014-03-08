package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import __AS3__.vec.*;
   
   public class TaxCollectorInformations extends Object implements INetworkType
   {
      
      public function TaxCollectorInformations() {
         this.additionalInfos = new AdditionalTaxCollectorInformations();
         this.look = new EntityLook();
         this.complements = new Vector.<TaxCollectorComplementaryInformations>();
         super();
      }
      
      public static const protocolId:uint = 167;
      
      public var uniqueId:int = 0;
      
      public var firtNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var additionalInfos:AdditionalTaxCollectorInformations;
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var state:uint = 0;
      
      public var look:EntityLook;
      
      public var complements:Vector.<TaxCollectorComplementaryInformations>;
      
      public function getTypeId() : uint {
         return 167;
      }
      
      public function initTaxCollectorInformations(uniqueId:int=0, firtNameId:uint=0, lastNameId:uint=0, additionalInfos:AdditionalTaxCollectorInformations=null, worldX:int=0, worldY:int=0, subAreaId:uint=0, state:uint=0, look:EntityLook=null, complements:Vector.<TaxCollectorComplementaryInformations>=null) : TaxCollectorInformations {
         this.uniqueId = uniqueId;
         this.firtNameId = firtNameId;
         this.lastNameId = lastNameId;
         this.additionalInfos = additionalInfos;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.state = state;
         this.look = look;
         this.complements = complements;
         return this;
      }
      
      public function reset() : void {
         this.uniqueId = 0;
         this.firtNameId = 0;
         this.lastNameId = 0;
         this.additionalInfos = new AdditionalTaxCollectorInformations();
         this.worldY = 0;
         this.subAreaId = 0;
         this.state = 0;
         this.look = new EntityLook();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorInformations(output);
      }
      
      public function serializeAs_TaxCollectorInformations(output:IDataOutput) : void {
         output.writeInt(this.uniqueId);
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element firtNameId.");
         }
         else
         {
            output.writeShort(this.firtNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               output.writeShort(this.lastNameId);
               this.additionalInfos.serializeAs_AdditionalTaxCollectorInformations(output);
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
                        output.writeByte(this.state);
                        this.look.serializeAs_EntityLook(output);
                        output.writeShort(this.complements.length);
                        _i10 = 0;
                        while(_i10 < this.complements.length)
                        {
                           output.writeShort((this.complements[_i10] as TaxCollectorComplementaryInformations).getTypeId());
                           (this.complements[_i10] as TaxCollectorComplementaryInformations).serialize(output);
                           _i10++;
                        }
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorInformations(input);
      }
      
      public function deserializeAs_TaxCollectorInformations(input:IDataInput) : void {
         var _id10:uint = 0;
         var _item10:TaxCollectorComplementaryInformations = null;
         this.uniqueId = input.readInt();
         this.firtNameId = input.readShort();
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element of TaxCollectorInformations.firtNameId.");
         }
         else
         {
            this.lastNameId = input.readShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.additionalInfos = new AdditionalTaxCollectorInformations();
               this.additionalInfos.deserialize(input);
               this.worldX = input.readShort();
               if((this.worldX < -255) || (this.worldX > 255))
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorInformations.worldX.");
               }
               else
               {
                  this.worldY = input.readShort();
                  if((this.worldY < -255) || (this.worldY > 255))
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorInformations.worldY.");
                  }
                  else
                  {
                     this.subAreaId = input.readShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorInformations.subAreaId.");
                     }
                     else
                     {
                        this.state = input.readByte();
                        if(this.state < 0)
                        {
                           throw new Error("Forbidden value (" + this.state + ") on element of TaxCollectorInformations.state.");
                        }
                        else
                        {
                           this.look = new EntityLook();
                           this.look.deserialize(input);
                           _complementsLen = input.readUnsignedShort();
                           _i10 = 0;
                           while(_i10 < _complementsLen)
                           {
                              _id10 = input.readUnsignedShort();
                              _item10 = ProtocolTypeManager.getInstance(TaxCollectorComplementaryInformations,_id10);
                              _item10.deserialize(input);
                              this.complements.push(_item10);
                              _i10++;
                           }
                           return;
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
