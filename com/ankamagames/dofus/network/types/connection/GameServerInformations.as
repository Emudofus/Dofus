package com.ankamagames.dofus.network.types.connection
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameServerInformations extends Object implements INetworkType
   {
      
      public function GameServerInformations() {
         super();
      }
      
      public static const protocolId:uint = 25;
      
      public var id:uint = 0;
      
      public var status:uint = 1;
      
      public var completion:uint = 0;
      
      public var isSelectable:Boolean = false;
      
      public var charactersCount:uint = 0;
      
      public var date:Number = 0;
      
      public function getTypeId() : uint {
         return 25;
      }
      
      public function initGameServerInformations(id:uint=0, status:uint=1, completion:uint=0, isSelectable:Boolean=false, charactersCount:uint=0, date:Number=0) : GameServerInformations {
         this.id = id;
         this.status = status;
         this.completion = completion;
         this.isSelectable = isSelectable;
         this.charactersCount = charactersCount;
         this.date = date;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.status = 1;
         this.completion = 0;
         this.isSelectable = false;
         this.charactersCount = 0;
         this.date = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameServerInformations(output);
      }
      
      public function serializeAs_GameServerInformations(output:IDataOutput) : void {
         if((this.id < 0) || (this.id > 65535))
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeShort(this.id);
            output.writeByte(this.status);
            output.writeByte(this.completion);
            output.writeBoolean(this.isSelectable);
            if(this.charactersCount < 0)
            {
               throw new Error("Forbidden value (" + this.charactersCount + ") on element charactersCount.");
            }
            else
            {
               output.writeByte(this.charactersCount);
               output.writeDouble(this.date);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameServerInformations(input);
      }
      
      public function deserializeAs_GameServerInformations(input:IDataInput) : void {
         this.id = input.readUnsignedShort();
         if((this.id < 0) || (this.id > 65535))
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameServerInformations.id.");
         }
         else
         {
            this.status = input.readByte();
            if(this.status < 0)
            {
               throw new Error("Forbidden value (" + this.status + ") on element of GameServerInformations.status.");
            }
            else
            {
               this.completion = input.readByte();
               if(this.completion < 0)
               {
                  throw new Error("Forbidden value (" + this.completion + ") on element of GameServerInformations.completion.");
               }
               else
               {
                  this.isSelectable = input.readBoolean();
                  this.charactersCount = input.readByte();
                  if(this.charactersCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.charactersCount + ") on element of GameServerInformations.charactersCount.");
                  }
                  else
                  {
                     this.date = input.readDouble();
                     return;
                  }
               }
            }
         }
      }
   }
}
