package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;


   public class CharactersListMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function CharactersListMessage() {
         this.characters=new Vector.<CharacterBaseInformations>();
         super();
      }

      public static const protocolId:uint = 151;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var hasStartupActions:Boolean = false;

      public var characters:Vector.<CharacterBaseInformations>;

      override public function getMessageId() : uint {
         return 151;
      }

      public function initCharactersListMessage(hasStartupActions:Boolean=false, characters:Vector.<CharacterBaseInformations>=null) : CharactersListMessage {
         this.hasStartupActions=hasStartupActions;
         this.characters=characters;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.hasStartupActions=false;
         this.characters=new Vector.<CharacterBaseInformations>();
         this._isInitialized=false;
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
         this.serializeAs_CharactersListMessage(output);
      }

      public function serializeAs_CharactersListMessage(output:IDataOutput) : void {
         output.writeBoolean(this.hasStartupActions);
         output.writeShort(this.characters.length);
         var _i2:uint = 0;
         while(_i2<this.characters.length)
         {
            output.writeShort((this.characters[_i2] as CharacterBaseInformations).getTypeId());
            (this.characters[_i2] as CharacterBaseInformations).serialize(output);
            _i2++;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharactersListMessage(input);
      }

      public function deserializeAs_CharactersListMessage(input:IDataInput) : void {
         var _id2:uint = 0;
         var _item2:CharacterBaseInformations = null;
         this.hasStartupActions=input.readBoolean();
         var _charactersLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2<_charactersLen)
         {
            _id2=input.readUnsignedShort();
            _item2=ProtocolTypeManager.getInstance(CharacterBaseInformations,_id2);
            _item2.deserialize(input);
            this.characters.push(_item2);
            _i2++;
         }
      }
   }

}