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
      
      public function initCharacterExperienceGainMessage(experienceCharacter:Number=0, experienceMount:Number=0, experienceGuild:Number=0, experienceIncarnation:Number=0) : CharacterExperienceGainMessage {
         this.experienceCharacter = experienceCharacter;
         this.experienceMount = experienceMount;
         this.experienceGuild = experienceGuild;
         this.experienceIncarnation = experienceIncarnation;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterExperienceGainMessage(output);
      }
      
      public function serializeAs_CharacterExperienceGainMessage(output:IDataOutput) : void {
         if(this.experienceCharacter < 0)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element experienceCharacter.");
         }
         else
         {
            output.writeDouble(this.experienceCharacter);
            if(this.experienceMount < 0)
            {
               throw new Error("Forbidden value (" + this.experienceMount + ") on element experienceMount.");
            }
            else
            {
               output.writeDouble(this.experienceMount);
               if(this.experienceGuild < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceGuild + ") on element experienceGuild.");
               }
               else
               {
                  output.writeDouble(this.experienceGuild);
                  if(this.experienceIncarnation < 0)
                  {
                     throw new Error("Forbidden value (" + this.experienceIncarnation + ") on element experienceIncarnation.");
                  }
                  else
                  {
                     output.writeDouble(this.experienceIncarnation);
                     return;
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterExperienceGainMessage(input);
      }
      
      public function deserializeAs_CharacterExperienceGainMessage(input:IDataInput) : void {
         this.experienceCharacter = input.readDouble();
         if(this.experienceCharacter < 0)
         {
            throw new Error("Forbidden value (" + this.experienceCharacter + ") on element of CharacterExperienceGainMessage.experienceCharacter.");
         }
         else
         {
            this.experienceMount = input.readDouble();
            if(this.experienceMount < 0)
            {
               throw new Error("Forbidden value (" + this.experienceMount + ") on element of CharacterExperienceGainMessage.experienceMount.");
            }
            else
            {
               this.experienceGuild = input.readDouble();
               if(this.experienceGuild < 0)
               {
                  throw new Error("Forbidden value (" + this.experienceGuild + ") on element of CharacterExperienceGainMessage.experienceGuild.");
               }
               else
               {
                  this.experienceIncarnation = input.readDouble();
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
