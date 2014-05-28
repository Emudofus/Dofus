package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class BasicCharactersListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicCharactersListMessage() {
         this.characters = new Vector.<CharacterBaseInformations>();
         super();
      }
      
      public static const protocolId:uint = 6475;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var characters:Vector.<CharacterBaseInformations>;
      
      override public function getMessageId() : uint {
         return 6475;
      }
      
      public function initBasicCharactersListMessage(characters:Vector.<CharacterBaseInformations> = null) : BasicCharactersListMessage {
         this.characters = characters;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characters = new Vector.<CharacterBaseInformations>();
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
         this.serializeAs_BasicCharactersListMessage(output);
      }
      
      public function serializeAs_BasicCharactersListMessage(output:IDataOutput) : void {
         output.writeShort(this.characters.length);
         var _i1:uint = 0;
         while(_i1 < this.characters.length)
         {
            output.writeShort((this.characters[_i1] as CharacterBaseInformations).getTypeId());
            (this.characters[_i1] as CharacterBaseInformations).serialize(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicCharactersListMessage(input);
      }
      
      public function deserializeAs_BasicCharactersListMessage(input:IDataInput) : void {
         var _id1:uint = 0;
         var _item1:CharacterBaseInformations = null;
         var _charactersLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _charactersLen)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(CharacterBaseInformations,_id1);
            _item1.deserialize(input);
            this.characters.push(_item1);
            _i1++;
         }
      }
   }
}
