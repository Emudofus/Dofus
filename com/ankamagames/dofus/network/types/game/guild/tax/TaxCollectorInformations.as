package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
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
      
      public function initTaxCollectorInformations(param1:int=0, param2:uint=0, param3:uint=0, param4:AdditionalTaxCollectorInformations=null, param5:int=0, param6:int=0, param7:uint=0, param8:uint=0, param9:EntityLook=null, param10:Vector.<TaxCollectorComplementaryInformations>=null) : TaxCollectorInformations {
         this.uniqueId = param1;
         this.firtNameId = param2;
         this.lastNameId = param3;
         this.additionalInfos = param4;
         this.worldX = param5;
         this.worldY = param6;
         this.subAreaId = param7;
         this.state = param8;
         this.look = param9;
         this.complements = param10;
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
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_TaxCollectorInformations(param1);
      }
      
      public function serializeAs_TaxCollectorInformations(param1:IDataOutput) : void {
         param1.writeInt(this.uniqueId);
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element firtNameId.");
         }
         else
         {
            param1.writeShort(this.firtNameId);
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            else
            {
               param1.writeShort(this.lastNameId);
               this.additionalInfos.serializeAs_AdditionalTaxCollectorInformations(param1);
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
               }
               else
               {
                  param1.writeShort(this.worldX);
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
                  }
                  else
                  {
                     param1.writeShort(this.worldY);
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
                     }
                     else
                     {
                        param1.writeShort(this.subAreaId);
                        param1.writeByte(this.state);
                        this.look.serializeAs_EntityLook(param1);
                        param1.writeShort(this.complements.length);
                        _loc2_ = 0;
                        while(_loc2_ < this.complements.length)
                        {
                           param1.writeShort((this.complements[_loc2_] as TaxCollectorComplementaryInformations).getTypeId());
                           (this.complements[_loc2_] as TaxCollectorComplementaryInformations).serialize(param1);
                           _loc2_++;
                        }
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorInformations(param1);
      }
      
      public function deserializeAs_TaxCollectorInformations(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:TaxCollectorComplementaryInformations = null;
         this.uniqueId = param1.readInt();
         this.firtNameId = param1.readShort();
         if(this.firtNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firtNameId + ") on element of TaxCollectorInformations.firtNameId.");
         }
         else
         {
            this.lastNameId = param1.readShort();
            if(this.lastNameId < 0)
            {
               throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.additionalInfos = new AdditionalTaxCollectorInformations();
               this.additionalInfos.deserialize(param1);
               this.worldX = param1.readShort();
               if(this.worldX < -255 || this.worldX > 255)
               {
                  throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorInformations.worldX.");
               }
               else
               {
                  this.worldY = param1.readShort();
                  if(this.worldY < -255 || this.worldY > 255)
                  {
                     throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorInformations.worldY.");
                  }
                  else
                  {
                     this.subAreaId = param1.readShort();
                     if(this.subAreaId < 0)
                     {
                        throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorInformations.subAreaId.");
                     }
                     else
                     {
                        this.state = param1.readByte();
                        if(this.state < 0)
                        {
                           throw new Error("Forbidden value (" + this.state + ") on element of TaxCollectorInformations.state.");
                        }
                        else
                        {
                           this.look = new EntityLook();
                           this.look.deserialize(param1);
                           _loc2_ = param1.readUnsignedShort();
                           _loc3_ = 0;
                           while(_loc3_ < _loc2_)
                           {
                              _loc4_ = param1.readUnsignedShort();
                              _loc5_ = ProtocolTypeManager.getInstance(TaxCollectorComplementaryInformations,_loc4_);
                              _loc5_.deserialize(param1);
                              this.complements.push(_loc5_);
                              _loc3_++;
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
