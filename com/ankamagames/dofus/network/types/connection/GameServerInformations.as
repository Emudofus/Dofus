package com.ankamagames.dofus.network.types.connection
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameServerInformations extends Object implements INetworkType
   {
      
      public function GameServerInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 25;
      
      public var id:uint = 0;
      
      public var status:uint = 1;
      
      public var completion:uint = 0;
      
      public var isSelectable:Boolean = false;
      
      public var charactersCount:uint = 0;
      
      public var date:Number = 0;
      
      public function getTypeId() : uint
      {
         return 25;
      }
      
      public function initGameServerInformations(param1:uint = 0, param2:uint = 1, param3:uint = 0, param4:Boolean = false, param5:uint = 0, param6:Number = 0) : GameServerInformations
      {
         this.id = param1;
         this.status = param2;
         this.completion = param3;
         this.isSelectable = param4;
         this.charactersCount = param5;
         this.date = param6;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.status = 1;
         this.completion = 0;
         this.isSelectable = false;
         this.charactersCount = 0;
         this.date = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameServerInformations(param1);
      }
      
      public function serializeAs_GameServerInformations(param1:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 65535)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeShort(this.id);
            param1.writeByte(this.status);
            param1.writeByte(this.completion);
            param1.writeBoolean(this.isSelectable);
            if(this.charactersCount < 0)
            {
               throw new Error("Forbidden value (" + this.charactersCount + ") on element charactersCount.");
            }
            else
            {
               param1.writeByte(this.charactersCount);
               if(this.date < -9.007199254740992E15 || this.date > 9.007199254740992E15)
               {
                  throw new Error("Forbidden value (" + this.date + ") on element date.");
               }
               else
               {
                  param1.writeDouble(this.date);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameServerInformations(param1);
      }
      
      public function deserializeAs_GameServerInformations(param1:ICustomDataInput) : void
      {
         this.id = param1.readUnsignedShort();
         if(this.id < 0 || this.id > 65535)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameServerInformations.id.");
         }
         else
         {
            this.status = param1.readByte();
            if(this.status < 0)
            {
               throw new Error("Forbidden value (" + this.status + ") on element of GameServerInformations.status.");
            }
            else
            {
               this.completion = param1.readByte();
               if(this.completion < 0)
               {
                  throw new Error("Forbidden value (" + this.completion + ") on element of GameServerInformations.completion.");
               }
               else
               {
                  this.isSelectable = param1.readBoolean();
                  this.charactersCount = param1.readByte();
                  if(this.charactersCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.charactersCount + ") on element of GameServerInformations.charactersCount.");
                  }
                  else
                  {
                     this.date = param1.readDouble();
                     if(this.date < -9.007199254740992E15 || this.date > 9.007199254740992E15)
                     {
                        throw new Error("Forbidden value (" + this.date + ") on element of GameServerInformations.date.");
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
