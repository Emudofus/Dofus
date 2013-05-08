package com.ankamagames.dofus.network.types.game.guild.tax
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;


   public class TaxCollectorInformations extends Object implements INetworkType
   {
         

      public function TaxCollectorInformations() {
         this.additionalInfos=new AdditionalTaxCollectorInformations();
         this.look=new EntityLook();
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

      public var state:int = 0;

      public var look:EntityLook;

      public var kamas:uint = 0;

      public var experience:Number = 0;

      public var pods:uint = 0;

      public var itemsValue:uint = 0;

      public function getTypeId() : uint {
         return 167;
      }

      public function initTaxCollectorInformations(uniqueId:int=0, firtNameId:uint=0, lastNameId:uint=0, additionalInfos:AdditionalTaxCollectorInformations=null, worldX:int=0, worldY:int=0, subAreaId:uint=0, state:int=0, look:EntityLook=null, kamas:uint=0, experience:Number=0, pods:uint=0, itemsValue:uint=0) : TaxCollectorInformations {
         this.uniqueId=uniqueId;
         this.firtNameId=firtNameId;
         this.lastNameId=lastNameId;
         this.additionalInfos=additionalInfos;
         this.worldX=worldX;
         this.worldY=worldY;
         this.subAreaId=subAreaId;
         this.state=state;
         this.look=look;
         this.kamas=kamas;
         this.experience=experience;
         this.pods=pods;
         this.itemsValue=itemsValue;
         return this;
      }

      public function reset() : void {
         this.uniqueId=0;
         this.firtNameId=0;
         this.lastNameId=0;
         this.additionalInfos=new AdditionalTaxCollectorInformations();
         this.worldY=0;
         this.subAreaId=0;
         this.state=0;
         this.look=new EntityLook();
         this.experience=0;
         this.pods=0;
         this.itemsValue=0;
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TaxCollectorInformations(output);
      }

      public function serializeAs_TaxCollectorInformations(output:IDataOutput) : void {
         output.writeInt(this.uniqueId);
         if(this.firtNameId<0)
         {
            throw new Error("Forbidden value ("+this.firtNameId+") on element firtNameId.");
         }
         else
         {
            output.writeShort(this.firtNameId);
            if(this.lastNameId<0)
            {
               throw new Error("Forbidden value ("+this.lastNameId+") on element lastNameId.");
            }
            else
            {
               output.writeShort(this.lastNameId);
               this.additionalInfos.serializeAs_AdditionalTaxCollectorInformations(output);
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
                     if(this.subAreaId<0)
                     {
                        throw new Error("Forbidden value ("+this.subAreaId+") on element subAreaId.");
                     }
                     else
                     {
                        output.writeShort(this.subAreaId);
                        output.writeByte(this.state);
                        this.look.serializeAs_EntityLook(output);
                        if(this.kamas<0)
                        {
                           throw new Error("Forbidden value ("+this.kamas+") on element kamas.");
                        }
                        else
                        {
                           output.writeInt(this.kamas);
                           if(this.experience<0)
                           {
                              throw new Error("Forbidden value ("+this.experience+") on element experience.");
                           }
                           else
                           {
                              output.writeDouble(this.experience);
                              if(this.pods<0)
                              {
                                 throw new Error("Forbidden value ("+this.pods+") on element pods.");
                              }
                              else
                              {
                                 output.writeInt(this.pods);
                                 if(this.itemsValue<0)
                                 {
                                    throw new Error("Forbidden value ("+this.itemsValue+") on element itemsValue.");
                                 }
                                 else
                                 {
                                    output.writeInt(this.itemsValue);
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
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorInformations(input);
      }

      public function deserializeAs_TaxCollectorInformations(input:IDataInput) : void {
         this.uniqueId=input.readInt();
         this.firtNameId=input.readShort();
         if(this.firtNameId<0)
         {
            throw new Error("Forbidden value ("+this.firtNameId+") on element of TaxCollectorInformations.firtNameId.");
         }
         else
         {
            this.lastNameId=input.readShort();
            if(this.lastNameId<0)
            {
               throw new Error("Forbidden value ("+this.lastNameId+") on element of TaxCollectorInformations.lastNameId.");
            }
            else
            {
               this.additionalInfos=new AdditionalTaxCollectorInformations();
               this.additionalInfos.deserialize(input);
               this.worldX=input.readShort();
               if((this.worldX>-255)||(this.worldX<255))
               {
                  throw new Error("Forbidden value ("+this.worldX+") on element of TaxCollectorInformations.worldX.");
               }
               else
               {
                  this.worldY=input.readShort();
                  if((this.worldY>-255)||(this.worldY<255))
                  {
                     throw new Error("Forbidden value ("+this.worldY+") on element of TaxCollectorInformations.worldY.");
                  }
                  else
                  {
                     this.subAreaId=input.readShort();
                     if(this.subAreaId<0)
                     {
                        throw new Error("Forbidden value ("+this.subAreaId+") on element of TaxCollectorInformations.subAreaId.");
                     }
                     else
                     {
                        this.state=input.readByte();
                        this.look=new EntityLook();
                        this.look.deserialize(input);
                        this.kamas=input.readInt();
                        if(this.kamas<0)
                        {
                           throw new Error("Forbidden value ("+this.kamas+") on element of TaxCollectorInformations.kamas.");
                        }
                        else
                        {
                           this.experience=input.readDouble();
                           if(this.experience<0)
                           {
                              throw new Error("Forbidden value ("+this.experience+") on element of TaxCollectorInformations.experience.");
                           }
                           else
                           {
                              this.pods=input.readInt();
                              if(this.pods<0)
                              {
                                 throw new Error("Forbidden value ("+this.pods+") on element of TaxCollectorInformations.pods.");
                              }
                              else
                              {
                                 this.itemsValue=input.readInt();
                                 if(this.itemsValue<0)
                                 {
                                    throw new Error("Forbidden value ("+this.itemsValue+") on element of TaxCollectorInformations.itemsValue.");
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
            }
         }
      }
   }

}