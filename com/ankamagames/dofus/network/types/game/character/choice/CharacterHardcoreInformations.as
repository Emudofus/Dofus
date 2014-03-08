package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterHardcoreInformations extends CharacterBaseInformations implements INetworkType
   {
      
      public function CharacterHardcoreInformations() {
         super();
      }
      
      public static const protocolId:uint = 86;
      
      public var deathState:uint = 0;
      
      public var deathCount:uint = 0;
      
      public var deathMaxLevel:uint = 0;
      
      override public function getTypeId() : uint {
         return 86;
      }
      
      public function initCharacterHardcoreInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:int=0, param6:Boolean=false, param7:uint=0, param8:uint=0, param9:uint=0) : CharacterHardcoreInformations {
         super.initCharacterBaseInformations(param1,param2,param3,param4,param5,param6);
         this.deathState = param7;
         this.deathCount = param8;
         this.deathMaxLevel = param9;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.deathState = 0;
         this.deathCount = 0;
         this.deathMaxLevel = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterHardcoreInformations(param1);
      }
      
      public function serializeAs_CharacterHardcoreInformations(param1:IDataOutput) : void {
         super.serializeAs_CharacterBaseInformations(param1);
         param1.writeByte(this.deathState);
         if(this.deathCount < 0)
         {
            throw new Error("Forbidden value (" + this.deathCount + ") on element deathCount.");
         }
         else
         {
            param1.writeShort(this.deathCount);
            if(this.deathMaxLevel < 1 || this.deathMaxLevel > 200)
            {
               throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element deathMaxLevel.");
            }
            else
            {
               param1.writeByte(this.deathMaxLevel);
               return;
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterHardcoreInformations(param1);
      }
      
      public function deserializeAs_CharacterHardcoreInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.deathState = param1.readByte();
         if(this.deathState < 0)
         {
            throw new Error("Forbidden value (" + this.deathState + ") on element of CharacterHardcoreInformations.deathState.");
         }
         else
         {
            this.deathCount = param1.readShort();
            if(this.deathCount < 0)
            {
               throw new Error("Forbidden value (" + this.deathCount + ") on element of CharacterHardcoreInformations.deathCount.");
            }
            else
            {
               this.deathMaxLevel = param1.readUnsignedByte();
               if(this.deathMaxLevel < 1 || this.deathMaxLevel > 200)
               {
                  throw new Error("Forbidden value (" + this.deathMaxLevel + ") on element of CharacterHardcoreInformations.deathMaxLevel.");
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
