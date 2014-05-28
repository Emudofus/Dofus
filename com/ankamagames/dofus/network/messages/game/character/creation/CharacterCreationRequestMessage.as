package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   
   public class CharacterCreationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterCreationRequestMessage() {
         this.colors = new Vector.<int>(5,true);
         super();
      }
      
      public static const protocolId:uint = 160;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var name:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var colors:Vector.<int>;
      
      public var cosmeticId:uint = 0;
      
      override public function getMessageId() : uint {
         return 160;
      }
      
      public function initCharacterCreationRequestMessage(name:String = "", breed:int = 0, sex:Boolean = false, colors:Vector.<int> = null, cosmeticId:uint = 0) : CharacterCreationRequestMessage {
         this.name = name;
         this.breed = breed;
         this.sex = sex;
         this.colors = colors;
         this.cosmeticId = cosmeticId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.name = "";
         this.breed = 0;
         this.sex = false;
         this.colors = new Vector.<int>(5,true);
         this.cosmeticId = 0;
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
         this.serializeAs_CharacterCreationRequestMessage(output);
      }
      
      public function serializeAs_CharacterCreationRequestMessage(output:IDataOutput) : void {
         output.writeUTF(this.name);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         var _i4:uint = 0;
         while(_i4 < 5)
         {
            output.writeInt(this.colors[_i4]);
            _i4++;
         }
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            output.writeInt(this.cosmeticId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterCreationRequestMessage(input);
      }
      
      public function deserializeAs_CharacterCreationRequestMessage(input:IDataInput) : void {
         this.name = input.readUTF();
         this.breed = input.readByte();
         if((this.breed < PlayableBreedEnum.Feca) || (this.breed > PlayableBreedEnum.Steamer))
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of CharacterCreationRequestMessage.breed.");
         }
         else
         {
            this.sex = input.readBoolean();
            _i4 = 0;
            while(_i4 < 5)
            {
               this.colors[_i4] = input.readInt();
               _i4++;
            }
            this.cosmeticId = input.readInt();
            if(this.cosmeticId < 0)
            {
               throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterCreationRequestMessage.cosmeticId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
