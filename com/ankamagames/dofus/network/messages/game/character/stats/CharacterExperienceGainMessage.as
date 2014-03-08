package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterExperienceGainMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterExperienceGainMessage() {
         super();
      }
      
      public static const protocolId:uint = 6321;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var experienceCharacter:Number = 0;
      
      public var experienceMount:Number = 0;
      
      public var experienceGuild:Number = 0;
      
      public var experienceIncarnation:Number = 0;
      
      override public function getMessageId() : uint {
         return 6321;
      }
      
      public function initCharacterExperienceGainMessage(param1:Number=0, param2:Number=0, param3:Number=0, param4:Number=0) : CharacterExperienceGainMessage {
         this.experienceCharacter = param1;
         this.experienceMount = param2;
         this.experienceGuild = param3;
         this.experienceIncarnation = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.experienceCharacter = 0;
         this.experienceMount = 0;
         this.experienceGuild = 0;
         this.experienceIncarnation = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterExperienceGainMessage(param1);
      }
      
      public function serializeAs_CharacterExperienceGainMessage(param1:IDataOutput) : void {
         if(this.experienceCharacter < 0)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element experienceCharacter.");
         }
         else
         {
            param1.writeDouble(this.experienceCharacter);
            if(this.experienceMount < 0)
            {
               throw new Error("Forbidden value (" + this.experienceMount + ") on element experienceMount.");
            }
            else
            {
               param1.writeDouble(this.experienceMount);
               if(this.experienceGuild < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceGuild + ") on element experienceGuild.");
               }
               else
               {
                  param1.writeDouble(this.experienceGuild);
                  if(this.experienceIncarnation < 0)
                  {
                     throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element experienceIncarnation.");
                  }
                  else
                  {
                     param1.writeDouble(this.experienceIncarnation);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterExperienceGainMessage(param1);
      }
      
      public function deserializeAs_CharacterExperienceGainMessage(param1:IDataInput) : void {
         this.experienceCharacter = param1.readDouble();
         if(this.experienceCharacter < 0)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element of CharacterExperienceGainMessage.experienceCharacter.");
         }
         else
         {
            this.experienceMount = param1.readDouble();
            if(this.experienceMount < 0)
            {
               throw new Error("Forbidden value (" + this.experienceMount + ") on element of CharacterExperienceGainMessage.experienceMount.");
            }
            else
            {
               this.experienceGuild = param1.readDouble();
               if(this.experienceGuild < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceGuild + ") on element of CharacterExperienceGainMessage.experienceGuild.");
               }
               else
               {
                  this.experienceIncarnation = param1.readDouble();
                  if(this.experienceIncarnation < 0)
                  {
                     throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element of CharacterExperienceGainMessage.experienceIncarnation.");
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
